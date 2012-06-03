From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix many comment typos
Date: Sun, 03 Jun 2012 14:30:44 -0700
Message-ID: <7vobp0xeuz.fsf@alter.siamese.dyndns.org>
References: <8762baf8do.fsf@rho.meyering.net>
 <7vmx4lz5bm.fsf@alter.siamese.dyndns.org> <87396ceuoy.fsf@rho.meyering.net>
 <4FCB4E0A.5080107@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jun 03 23:31:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbINz-0003qC-15
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 23:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772Ab2FCVar convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jun 2012 17:30:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731Ab2FCVar convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2012 17:30:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 952498295;
	Sun,  3 Jun 2012 17:30:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KfJDOKQZBW+v
	zvPQX3zIRGl8FTg=; b=Mkz9xpANLkbso7nI/8MXzOmv3ERB7/hVzDFOYhvFoRMF
	GxQ/ueSD8698oUhuZYum2tDSIOp4hbLk6nRvHFARdes8L+G5jWDL8VoGYtqPSulg
	a5fXiJjAH16W5Da3rWF31398GclM9/T3TOYHHVOXns6vS/TlXVSWQWtzisolTLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CVRl35
	tAfnRsI/MuiF5R44Xk+4xJTmm6mAyrJ0VTEZNE89Ual/BlsceGgqCQTRlBH/jGe7
	KfXGzC1jCiHXi9V2UbzRNFFQgkVlbQ7C0S+Cg1uWA93pNcAFu01aylL9WvDt0HU6
	peJkylJiLMVLkM4qT4+zwPh116LzDSSW7ci0U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D51E8294;
	Sun,  3 Jun 2012 17:30:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E543D8293; Sun,  3 Jun 2012
 17:30:45 -0400 (EDT)
In-Reply-To: <4FCB4E0A.5080107@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sun, 03 Jun 2012 13:44:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 613DD442-ADC3-11E1-AC0E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199103>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 03.06.2012 09:11, schrieb Jim Meyering:
>> Perhaps a more palatable change, here and in the other two places:
>> s/seeked/cg-seek'd/, i.e.,
>>
>> - * "git bisect" showed mysterious "won't bisect on seeked tree" err=
or message.
>> + * "git bisect" showed mysterious "won't bisect on cg-seek'd tree" =
error message.
>>
>> Then, if someone does this again, it will be more obvious that
>> it is not a typo.
>
> This change is only valid if the command "git bisect" at some point
> printed "won't bisect on cg-seek'd tree" instead of "won't bisect on
> seeked tree".

Yeah, that is how I should have spelled my original message; thanks
for clarifying.

> And even then, it doesn't make now sense to change
> already published release notes (Documentation/RelNotes/1.5.4.4.txt),
> after the fact.

If it makes it easier to touch older release notes at the same time
for a mechanical typocorrection procedure, whose primary purpose is
to fix the tip of the current tree, I wouldn't mind typofixes to
older release notes.

But we would need to be careful to avoid a mistake like this one.
=46ixing typo in the words I used to describe the changes is perfectly
fine and welcomed; changing the exact output string that was copied
from the implementation to show historical fact is not.

I have found Jim's patches always carefully crafted and thoughtfully
done in the past, especially with the disclosure of the mechanical
procedure that was used so that the result can easily be verified
independently; the first hunk that showed a change that was totally
against the care the procedure claimed to have taken stood up like a
sore thumb and that was the only reason I noticed it.

Thanks.
