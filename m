From: Junio C Hamano <gitster@pobox.com>
Subject: Re: v1.7.0-rc0 shows lots of "unable to find <sha1>" on git-stash
Date: Sun, 31 Jan 2010 11:21:11 -0800
Message-ID: <7vmxzudqs8.fsf@alter.siamese.dyndns.org>
References: <57518fd11001290712s2585e468o73b746b7ca27e1f1@mail.gmail.com>
 <7vzl3wiz59.fsf@alter.siamese.dyndns.org>
 <57518fd11001291646l5b0b581dm553689232b0910e8@mail.gmail.com>
 <4B642696.2070501@web.de>
 <57518fd11001300523xf7d931by254581c8494171af@mail.gmail.com>
 <4B643DEF.8010809@web.de>
 <57518fd11001300836v7f21a8a9qc09953d9091a4513@mail.gmail.com>
 <7v8wbfnyz9.fsf@alter.siamese.dyndns.org>
 <7vvdejmjaj.fsf@alter.siamese.dyndns.org>
 <57518fd11001311116t1bde882dub1dd3ca4af201b2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 20:21:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbfMN-0000kL-2P
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 20:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab0AaTVW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 14:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753428Ab0AaTVW
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 14:21:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab0AaTVV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jan 2010 14:21:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 466CA95362;
	Sun, 31 Jan 2010 14:21:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3UEbHQSUcckc
	z8IKkkX25biu7Rc=; b=etkz6BsZ0BZkveeLa97MmP00WXisJK9HnzvOAxk/jeky
	mjqJaUt42u3L9hpu//OM2oduTtKUy20rVPgsLtbdJnKT4fryl/T113BBQFCHy86p
	eZiFcYN3Vk0w4ETLIBkwrZa1YACwu83Ddt4l88JV1PAZTxeRwermgSbrJAu7o3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=t2DoTV
	W7qVNqNB0FdKpfMe7kkTNQbPZsfb/xAlS0IoUbC0dpkZCC74ElFoblGfjCwffrCD
	1XxSGkFfHqZRJvg0VbCL+uOiH8Hv1lF2Or9ZEl5Blx85MTsqOLVZye5kNZlB5G90
	6oz7/u10IXlzfk2I4zvZ2SZg89R3d/zv9o+8o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16F5995361;
	Sun, 31 Jan 2010 14:21:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E24395358; Sun, 31 Jan
 2010 14:21:13 -0500 (EST)
In-Reply-To: <57518fd11001311116t1bde882dub1dd3ca4af201b2e@mail.gmail.com>
 (Jonathan del Strother's message of "Sun\, 31 Jan 2010 19\:16\:53 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CE723656-0E9D-11DF-8137-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138551>

Jonathan del Strother <maillist@steelskies.com> writes:

>>> + =C2=A0 =C2=A0 strbuf_addf(&buf, "GIT_INDEX_FILE=3D");
>>
>> This should be:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addf(&buf, "GIT_INDEX_FILE");
>
> Sorry, I'm not sure I follow your amendment - it looks exactly like
> the patch you originally supplied?

Lack of the last "=3D" tells: "Instead of exporting GIT_INDEX_FILE with=
 an
empty string as its value, unexport it."
