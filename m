From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: can specify shas of commits to ignore on command 
 line
Date: Tue, 04 May 2010 22:19:57 -0700
Message-ID: <7vfx27kjr6.fsf@alter.siamese.dyndns.org>
References: <1272939687-17686-1-git-send-email-dgreid@gmail.com>
 <4BE0918C.9090204@lsrfire.ath.cx>
 <j2sfd211a421005041446ub9c2247ai484c2473df856b31@mail.gmail.com>
 <7vtyqnl19w.fsf@alter.siamese.dyndns.org>
 <z2lfd211a421005041608n1e302cbbt1bb628e9b51b3e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Dylan Reid <dgreid@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 07:20:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9X1w-0002qt-Fd
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 07:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907Ab0EEFUI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 May 2010 01:20:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423Ab0EEFUH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 May 2010 01:20:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FE87B0F93;
	Wed,  5 May 2010 01:20:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XpZDkv01enKz
	AxatH0wVjdeikKs=; b=FaU5ALnWE30b5E9kofpQNR0W9f4K23E8UAt+Y+Ee2EfA
	PMl9ADiyOaJcsfnHgeeMAxKX8ePCUn9YCRRp77sDmr5VqqhAvYGzMenecFOKbmqE
	NDwkvoV51KoBUs0u0E1HNVc9tScgKQyJgcWBOb99VuMnjXX8j80jpk84LT37GxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vYBTgG
	etqE7byugPr/xhyVQb2eYrq4cEBJh7/d/m1xMmJc6CX0U8HiDc++KKZPC+8/DkI1
	YaE5wcJMPHNKpuqe2A9xrn/amYPhnIWPEQa4QuEVlenGu8OZIviszRjbmhh7C9TT
	q0JoGneb/YDZ8/fUb5ueEOHimgv0Ovsz9TAS8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22F19B0F8D;
	Wed,  5 May 2010 01:20:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 642ADB0F8C; Wed,  5 May
 2010 01:19:58 -0400 (EDT)
In-Reply-To: <z2lfd211a421005041608n1e302cbbt1bb628e9b51b3e3@mail.gmail.com>
 (Dylan Reid's message of "Tue\, 4 May 2010 19\:08\:56 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DB42C542-5805-11DF-8A37-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146373>

Dylan Reid <dgreid@gmail.com> writes:

>> I am already confused. =C2=A0If the command must return C when you s=
ay "ignore
>> C" and C introduced a line you are interested in, then what is the p=
oint
>> of specifying commits to be ignored?
>>
>
> I was thinking that it would ignore changed lines, not added lines.  =
Make sense?

Not really.  I don't think you can distinguish "changed lines" and "add=
ed
lines" reliably.
