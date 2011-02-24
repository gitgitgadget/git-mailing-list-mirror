From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Wed, 23 Feb 2011 16:57:47 -0800
Message-ID: <7vk4gq45bo.fsf@alter.siamese.dyndns.org>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
 <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 01:58:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsPWr-00053I-LZ
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 01:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576Ab1BXA54 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 19:57:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496Ab1BXA5z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 19:57:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D97D44D62;
	Wed, 23 Feb 2011 19:59:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=j0iBcsJsgaK8
	TvwRktCadL12+R8=; b=riTZzsa2deypTgJvoTlVJU5OgxTUAb56n/TX97S4dxWy
	O5jQfPkR85nZs5I5kpNnTuJy1aE9QfSzYbx+RWYQu+YVG/lKTrcxQ15m34fOc6wd
	NSMRQU80Ffu4B8OL2Q9wIwctJxSIzSfMcVCYEo/r0W1NkLOzooQKxJKM569Bqbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pT/oJh
	pJ7pjnMpVIC52h021AFVHzFG8rnQ113KycaCtleQL46OdFPPZCz3rA5UeLebuUeL
	/rAjc3nMuUPvz8R6C1YL6u7EanHbIkCxQxkg/V9llFo8H7h7Sd7VsfFLJJ1e0Wg0
	kNMfMLj9O4x9v+91Gfl8XQQiEfDJ4dOB8MSPo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B5D4D4D5E;
	Wed, 23 Feb 2011 19:59:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9C7864D5C; Wed, 23 Feb 2011
 19:59:03 -0500 (EST)
In-Reply-To: <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\, 24 Feb
 2011 01\:32\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 47C644C6-3FB1-11E0-B5E4-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167759>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> And then there's the issue that unlike the C patches these will not b=
e
> a no-op that'll be optimized away by the compiler. We'll be calling a=
n
> external program for displaying messages. While this is a trivial cos=
t
> on Unix (especially in the context we're using it, i.e. not in tight
> loops) it's more expensive on Windows.
>
> I don't see any way to deal with that short of implementing some
> pre-processor, but I think the cost is worth it, but others might
> disagree of course.

Count me one of the others then.  Don't we already preprocess our scrip=
ts
before installing anyway?

> Anyway, I can submit these patches (around 53) real soon, or wait
> until the current series settles. It's the same to me, which would yo=
u
> prefer?

One thing at a time is of course preferred.

I actually want to stagger the current 70+ patches into two batches.  H=
ave
the first handful, after polishing them really shiny, merged to master,
and possibly rebase topics that are only in 'pu' and that are not meant
for 'maint' on top of the result (so that they can use _() in newly add=
ed
messages), and then merge "mark strings in git-foo with _()" patches in=
=2E

I suspect it won't be the same to you.  At least, it shouldn't.

Other topics that fix real bugs or add features continue to trickle dow=
n
from 'next' to 'master' and you would need to re-roll what you have tod=
ay.
If you wait (or if we have you wait) for too long, the re-roll would
become just as unpleasant as my merging the i18n topic to 'pu'.

>     Warning: you are leaving 1 commit behind that are not connected t=
o
>     any of your branches:
>
> For the singular this should be "1 commit behind which is not
> corrected to any of your branches".

Heh, thanks.  I would think "s/ that are /, /" would fix it rather
nicely.

> ... but then
> again that would confuse the sort of users that need this the most.

That is exactly why I phrased it this way.
