From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Remove --allow-empty from the git-commit synopsis
Date: Wed, 07 Apr 2010 12:00:48 -0700
Message-ID: <7vfx37cckf.fsf@alter.siamese.dyndns.org>
References: <w2zfabb9a1e1004070829ob9da47e6oacf2703129be9107@mail.gmail.com>
 <1270661327-28078-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 21:01:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzaUq-00005W-01
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 21:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758207Ab0DGTA6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 15:00:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758200Ab0DGTA5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 15:00:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8292AA854E;
	Wed,  7 Apr 2010 15:00:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OTMu7+F5PVkn
	BpxYotNJKZlZzkw=; b=RLBvDm8yGqX5bMmphfxgwSw9bARhUwAlNvnHYAVWzZe+
	eoN2ZEbus1IY9bs4tviBqMFq+f6OmRt0ivXu5zf7CWhIqp2MS4tFtvs3n4RNztkj
	/w8yJxYMwSeoTZ7+q6lX2zYXCO+F4bOlQZCsWEyjb1/4SqInVSSRrZKDt1bVLFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jaeQxa
	TJigCHybZlEZi1MS/vUobAObyUyZtVOlMfReDfBpUiBGDcGmsC9A+RB2z1i13RzW
	2AojSC+GCh7AWpGhDTmQ7lvDs0IHnbseZ8gvtVsXC4DgmfoQx38iv77nhbbRrIQS
	wDxy3jMvGJVepcW0yMaXmc2RP3lhHWwbrus/Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 58545A854B;
	Wed,  7 Apr 2010 15:00:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4156A8548; Wed,  7 Apr
 2010 15:00:49 -0400 (EDT)
In-Reply-To: <1270661327-28078-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed\,  7 Apr
 2010 17\:28\:47 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E31DB108-4277-11DF-9914-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144270>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The --allow-empty option is too rarley used to warrant being displaye=
d
> in the SYNOPSIS. It should only be mentioned in the main body of the
> documentation like --porcelain.
>
> The issue was raised in the thread discussing the new
> --allow-empty-message option by Jeff King <peff@peff.net>:

If you mention what Peff said, it would be nice to Cc: him.

>     http://marc.info/?l=3Dgit&m=3D127039258902941
>     http://marc.info/?l=3Dgit&m=3D127054334121604

Please don't cite marc, especially when you refer to a thread or a patc=
h.
Their interface, even in the "raw" mode, does not give the message head=
ers
(presumably by design, in order to block e-mail address harvesters) tha=
t
makes it unusable to get patches out of for applying.

Giving a message-ID would be vendor neutral and a useful alternative
instead, like so:

    Message-ID: <20100406055530.GE3901@coredump.intra.peff.net>

Then people can paste it after "http://mid.gmane.org/" or feed it to th=
eir
favourite MUA.

>  Documentation/git-commit.txt |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.=
txt
> index 64fb458..ed2cd95 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -10,9 +10,8 @@ SYNOPSIS
>  [verse]
>  'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--=
dry-run]
>  	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--reset-author]
> -	   [--allow-empty] [--no-verify] [-e] [--author=3D<author>]
> -	   [--date=3D<date>] [--cleanup=3D<mode>] [--status | --no-status] =
[--]
> -	   [[-i | -o ]<file>...]
> +	   [--no-verify] [-e] [--author=3D<author>] [--date=3D<date>]
> +	   [--cleanup=3D<mode>] [--status | --no-status] [--] [[-i | -o ]<f=
ile>...]

I do not think Jeff was against having a complete listing in the
documentation.  Wasn't his suggestion about "git commit -h" output?
