From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 08:42:11 -0700
Message-ID: <7voc51g7xo.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
 <4D89D052.5030801@drmicha.warpmail.net>
 <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
 <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com>
 <4D89DCBE.3060400@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: demerphq <demerphq@gmail.com>, John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 16:42:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2QCi-0002gF-U5
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 16:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673Ab1CWPmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 11:42:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab1CWPma (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 11:42:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2536538A7;
	Wed, 23 Mar 2011 11:44:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J3KHoa3fbTR95pMIrq9hnr950sw=; b=qeIFV6
	X2scvj5xQL2kNcQL0Xh+sjRvIIA2j3kwmafPaAMyyPIQKc0KKDZT0XTKbAi9zZqs
	AdswWWsQjP6DTtBSFClGHmD/TrOVGzWL0Gua1NYIJpRatBS/5807gm++EW7tvyCp
	nrxWhcVbTwIeel/nSWA5QgjEjd3zu97NsEquE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FjIxs78Nz0ZEvOywVzIlaTKecteFsDqt
	AGEPlISabruS87Qu8sGqKbNloIw7hbEfxgivVDTHOUwG8GyB40TvcWPdEkK7IIXp
	lnjMsRi/2BJ9+U0Vj43Mved69DYwDrPkS+5sX3Zr7KsUlLyaX/MMAa7ZquGjsxc5
	tNErV4ErlWI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D6DF138A6;
	Wed, 23 Mar 2011 11:44:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CD9BD38A1; Wed, 23 Mar 2011
 11:43:54 -0400 (EDT)
In-Reply-To: <4D89DCBE.3060400@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 23 Mar 2011 12:42:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60A65332-5564-11E0-9323-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169844>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>>> What's wrong with --relative  or something?
>
> ??
>
> ls-files already lists files relative to cwd. What you need is a way to
> specify that you want all files, not just those beneath cwd.

Exactly.

>>> I've never liked magical strange notations.  ":" already has a meaning.
>> 
>> +1
>
> I think you've both been missing out on the discussions about
> --full-tree and refspec notation for that...

I like this answer.  Don't pay any much attention +1/-1 from people who
are clueless to the topic, but do pay attention to them as persons by
showing that there are things for them to read and learn if they want to
discuss the topic.  A URL or two to the recent thread may have been nicer.

> Of course ":" has a meaning. "git show HEAD:" lists all files at the
> top-level of the tree at HEAD. That is exactly why ":" has been
> suggested to denote the top-level for pathspecs also. Note that this is
> much more general than just an option for ls-files.

Talking about the "pathspec magic", I think in addition to "this is
relative to root", we at least would need "this is literal, don't apply
globbing" magic.  I am afraid that using ':' as the sole "magic for
from-root" as you advocate may turn out to be too short-sighted and would
hurt us in the future.

It may be more extensible if we used a common "magic introducer" at the
beginning, an character unlikely to collide with any pathspec existing
scripts and people use, and then have additional "what magic I want"
signature immediately following that introducer letter in these magic
filespecs.

Off the to of my head, "/" may be a perfect choice for "here is a magic"
introducer, as we never give absolute paths on the fiesystem from the root
to git [*1*].

Then, even when you are in a subdirectory somewhere, this:

    $ git ls-tree pu -- '/:*.h' "/!$path"

would list paths in the pu branch, limiting its output to any "*.h" header
file, and a path that matches exactly with whatever is in $path variable
without globbing within the current level.  The above uses ':' as "this is
relative to root" (your favorite, whose rationale being that HEAD:Makefile
names Makefile at the top) and '!' (randombly chosen without any rationale
other than being "NOT" and without any association with "glob", which make
it a bad choice of the letter) as "this is NOT a glob".

If we use ':' as the magic introducer, '::*.h" may be more logical if you
follow your "HEAD:Makefile names Makefile at the top" analogy; ':/' breaks
the analogy (the first colon is a general introducer and does not talk
anything about what kind of magic; the second letter should be what magic
it is about, and should use ':' from HEAD:Makefile analogy).

I personally think "//*.h" looks a lot more natural than either ':*.h' or
':/*.h' that have been suggested on the command line, so I am tempted to
suggest using '/' (the first slash in the example) as the magic introducer
and using '/' (the second) as the 'from-root' magic signature.


[Footnote]

*1* I am ignoring "--no-index" variants that are not strictly part of git
here, but I suspect this might also affect "git add /path/from/root" which
I think we should deal with somehow.
