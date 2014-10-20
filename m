From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2] core.filemode may need manual action
Date: Mon, 20 Oct 2014 09:54:55 -0700
Message-ID: <xmqq38ai4r6o.fsf@gitster.dls.corp.google.com>
References: <54418CA0.6050503@web.de>
	<xmqqr3y3r8lw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 20 18:55:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgGEZ-0008IQ-T4
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 18:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbaJTQy7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Oct 2014 12:54:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751109AbaJTQy6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2014 12:54:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FE3A15A18;
	Mon, 20 Oct 2014 12:54:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pVLYsUJP9+Cm
	SlVlj7QOmd4ByZo=; b=BkMn81R7wL1GiwvEjFRy0X42+IEZ44WWBPgmczXcfmYS
	abMCULINbbVoQofBdOGmT9a1ocRPIulmjNIGeUG+VCK3q2xqSUQXetgCMk7xmqsO
	nZ0AelKu8AjLlND7rMtMytwCb/hsIatD5P3HwFnZIy95h6RA+Ny6B7AJdBjM7TU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bE6PCB
	kv8ktewYeBcWxfhF4X2R9oIS2BnpCi/QxOdOOSHsA8/b/wqSQdHEWlHNKrGe/uNq
	KBEWrRVCBjuwJMvuFBbg4VF3TdJFzZrDflzZodoa2Jf7wouevnecziJkOBou8TH7
	/21W7DHYhq4bl6FWXgRjooySSUgV4B29e79hI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0757D15A17;
	Mon, 20 Oct 2014 12:54:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 732BC15A15;
	Mon, 20 Oct 2014 12:54:57 -0400 (EDT)
In-Reply-To: <xmqqr3y3r8lw.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 19 Oct 2014 15:35:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D28ECF94-5879-11E4-92FD-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> - The '+' at an otherwise empty line generates an empty line
>>   in html, so s/^$/+/
>
> I think the rule is actually that you cannot have multiple
> paragraphs in an enumerated list the same "headword double-colon and
> then indented paragraph" way, and need to unindent second and
> subsequent paragraphs, and have "+" before each of them, i.e.
>
>         .--------------------------------
>         |core.fileMode::
>         |	Here is my first paragraph.
>         |+
>         |Here is my second one.
>         .--------------------------------
>
> That is how the existing "The default is true, except..." paragraph
> is done, and I was hoping that you would notice it and follow that
> example.

I took your v2b and reformatted to follow the above; the result
should be queued on 'pu'.

Thanks.
