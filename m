From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fwd: Git 2.8.1 fails test 32 of t7300-clean.sh, breaks profile
 build
Date: Fri, 29 Apr 2016 14:58:24 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604291456230.9313@virtualbox>
References: <CAA6PgK7b=ithSYREV5axaE3fmRG5Vp06UtWiZXD-aJuZKfEVYA@mail.gmail.com> <CAA6PgK4of46eEJOJstnVvPvDFqU_OC5QVz9LWxyKgqHt9V5ySQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jan Keromnes <janx@linux.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 14:58:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw80A-0001P7-VS
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 14:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784AbcD2M6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 08:58:32 -0400
Received: from mout.gmx.net ([212.227.15.19]:60844 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753777AbcD2M6a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 08:58:30 -0400
Received: from virtualbox ([88.128.80.158]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LlV71-1bVk4D2To7-00bHZD; Fri, 29 Apr 2016 14:58:26
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAA6PgK4of46eEJOJstnVvPvDFqU_OC5QVz9LWxyKgqHt9V5ySQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:90kKJ5vF+T3NLbGKnOcETiwUCMi2WAKxJlkquA4H4+5rJ+Hg8Bo
 ZGFoV5EpfcTljkvbX04E4+7U+7f/w40AgM1hnGmZThiK+rKMBIKT9ZxhKA5EV61S2Mle3sW
 YRu98NkoN28lorHUdBRWKDPdQ8CeYOgFITTbQH5M2t+o8ST9C8a3uIeUTon5M/w5g2MC1aZ
 z9wA2q2MMs8bk7quwTRPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6V5onqjJXCg=:VwygncYW6CPcGdynVIFXnR
 3qu0fGEsQtNP1sI/1667NbzFb7P0CNmEWbfBgt/XR5Q6EgLb4CmEetpBaT2hiLTSm82y40WCt
 72X+/DnMAggdijie62mni39EYNy3d4QP5g2VoMeaTnoj0hy9yBzZlVdlmrOORYPUgwzPMrwk0
 RqmLddMqzf0ZwCxZmkUgw/38TE350rF0tJciNCT7QIxsTfJmy3fEXoSFYWcEJ63uupYSFw326
 Vz7e0z6JKRTRz4tQzYYmJzQ8qD4jOPDgSwUZ/eH88G3xlZHTYCpEQL/SO0zSXz0ooJDp6zpWq
 guBaaEiwG1UoStqiVd1b7IcL/3L8NDBt95DuIalBh7Cj6eqLQaxrDIfBdMqBsvZfH5JEW20gN
 0J7F2JAEu+WoKC8ig8W0hCCQCrJYsh/L05gsuuEAYVEcIsjzuBEKT+S1rDIswe3/umuQ7o+CP
 x40vSwHsOZ/2RL8Kv7oQxRuUixnkCRtGb3jC5kFGJ+87nrXKJ1wPGLJzstcLK5s761Xlo3qcI
 u7BTguMCg/UXgsX/SnRnm5G5OtD9nY9YCagRqbRwUL5EFkiW3OSeGu0+cGrlhjBsjoO5uYMmu
 E9EqQQeDTDLEPBLaEz2EDitQm8a/7HJuGX89yvLB5BehpRaMfj3GgB4Y6XWt6D/i5jT6cK0Jn
 rDNZr6okHeJtWOWa3zK9SL9bDtxXN+231Cbc4yG4bOhnEKvg4AFiUCIa24EfGB8TnFYyPcawC
 qXc3Kfk9rlVsriOxqvpnFI4RZk1XxiOKo/DpgZqO4nC5HXNtPc/hAp7XIlyEsvaMUu5AUPJ1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292994>

Hi Jan,

On Fri, 29 Apr 2016, Jan Keromnes wrote:

> I tried running a full profile build of Git 2.8.1, but it looks like
> test #32 in `t7300-clean.sh` fails:
> 
> Commands:
> 
> > curl https://www.kernel.org/pub/software/scm/git/git-2.8.1.tar.xz | tar xJ
> > cd git-2.8.1
> > make prefix=/usr profile-install install-man -j18
> 
> Logs of test-suite that fails:
> 
> *** t7300-clean.sh ***
> ok 1 - setup
> ok 2 - git clean with skip-worktree .gitignore
> ok 3 - git clean
> ok 4 - git clean src/
> ok 5 - git clean src/ src/
> ok 6 - git clean with prefix
> ok 7 - git clean with relative prefix
> ok 8 - git clean with absolute path
> ok 9 - git clean with out of work tree relative path
> ok 10 - git clean with out of work tree absolute path
> ok 11 - git clean -d with prefix and path
> ok 12 - git clean symbolic link
> ok 13 - git clean with wildcard
> ok 14 - git clean -n
> ok 15 - git clean -d
> ok 16 - git clean -d src/ examples/
> ok 17 - git clean -x
> ok 18 - git clean -d -x
> ok 19 - git clean -d -x with ignored tracked directory
> ok 20 - git clean -X
> ok 21 - git clean -d -X
> ok 22 - git clean -d -X with ignored tracked directory
> ok 23 - clean.requireForce defaults to true
> ok 24 - clean.requireForce
> ok 25 - clean.requireForce and -n
> ok 26 - clean.requireForce and -f
> ok 27 - core.excludesfile
> ok 28 # skip removal failure (missing SANITY)
> ok 29 - nested git work tree
> ok 30 - should clean things that almost look like git but are not
> ok 31 - should not clean submodules
> not ok 32 - should avoid cleaning possible submodules
> #
> #               rm -fr to_clean possible_sub1 &&
> #               mkdir to_clean possible_sub1 &&
> #               test_when_finished "rm -rf possible_sub*" &&
> #               echo "gitdir: foo" >possible_sub1/.git &&
> #               >possible_sub1/hello.world &&
> #               chmod 0 possible_sub1/.git &&
> #               >to_clean/should_clean.this &&
> #               git clean -f -d &&
> #               test_path_is_file possible_sub1/.git &&
> #               test_path_is_file possible_sub1/hello.world &&
> #               test_path_is_missing to_clean
> #

This log does not really help, in particular because your report does not
include vital information such as host OS, installed libraries, etc.

To debug further on your side (which is really the only logical thing to
do from here), have a look at this documentation:

	https://github.com/git-for-windows/git/wiki/Running-Git's-regression-tests#running-individual-tests

(even if it is on Git for Windows' wiki, you will find that the
suggestions apply to any development environment.)

Ciao,
Johannes
