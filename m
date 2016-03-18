From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 01/17] perf: introduce performance tests for
 git-rebase
Date: Fri, 18 Mar 2016 17:00:44 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603181659200.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-2-git-send-email-pyokagan@gmail.com> <alpine.DEB.2.20.1603160855390.4690@virtualbox> <CACRoPnS=qg=a3xYKHyk-7E2HN5HhTimGirZcwL8hMa0xLY6KdA@mail.gmail.com>
 <alpine.DEB.2.20.1603161656130.4690@virtualbox> <20160318110134.GA16750@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 17:01:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agwpp-0002NK-JH
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 17:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757570AbcCRQA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 12:00:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:58193 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbcCRQAz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 12:00:55 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LsCAp-1Zf3Kp0QV5-013zQO; Fri, 18 Mar 2016 17:00:48
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160318110134.GA16750@hank>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:6eY0799NWTsQA6NHOvfcZj9zNBchB+Q5pt1HGRlc4UQKFw7RKbf
 TcTsqtspVrNIH7AEtFURtizo688JbGcqI0Ju3ywoRDXI/KVByWI0uzwWmASbYlNbpDUH4Rv
 KRjcm+YtAH5w7alaaCy6KmhRl4blrbMmgyKcUwRcu8FMUkVhsAUSpES1SIKXoPCiWA2TaRt
 28BebqmnNBbjSnJLvWpIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qgBX/bSToUs=:Dpd3AgIRK3OjAOjnpswdx4
 D8hwmtFIdeRJoT2R2utMch5Ojf97ghWOiqMxv7H6vv3VgQOen1xumgxWVC1TdVywvU/v0EKnO
 7QF1/DaZb+7SEWzGo6PbsAl30IbGRdQCk7A/AnUWyjVLDB4mjYRk1sxrBMvtJCC3CBREsELEY
 2pCdOUPYXkDzwjMFfxCOO9GJoV0pV1pvClTYFWRHcJLKw8UxvE/6/daaH2oNo/ZgOIVqHa9id
 KZnh9MwYu+n1Bw4PHKsxiWs91WnXnIo2jy4deVX96lISNV0sGECX5Ll2t91mEmslUw1WELgwk
 SU2nHI86o7xDdtW0GQs1wXJ9HREIuh+dYyVryx/Sp6Whgh+cgBrGqSx4ni4UoGE6bAjCbrJ1P
 HUeX6bzl2JwMClYbLA3lJ7fJ4iQ5L5mNSf9I9lsFy8fYDdRE2AOCCC5TA1op8Dwh61WOra8wX
 7ZcFwzZ+4SyQynpz6lJR+KOPDTL1t5j8XdlPT34TngjpJI2pKlYd1PLc7oJKmZAvJge82ud8A
 /POYWubuZrsWLldyhd649vZG9Sq1Z98MixuA2JgmO2scqD+i2tAKd+2tSgAwAJaa47niSaqC1
 zjkr3WE19FU9rXtu1pOg9vyn6AANkh6sfb6tgbf263NCu9WzJ6tEQbHAARVNbNh9zi/DtZt9L
 dpI2mZu9DqvKms13CAOTgRrDXCzC8xKzSht+VRCVdQ95Y5a+1NkeL9RDs/fV+CmPqVD+BjlOW
 DTZ8T+0Pc8kw18Nojz7+2vx3lkeytTmnU1iFkP4xs12i5Y9qof2fwC4bHTK3hjyj/pz1+t1/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289229>

Hi Thomas,

On Fri, 18 Mar 2016, Thomas Gummerer wrote:

> On 03/16, Johannes Schindelin wrote:
> > 
> > On Wed, 16 Mar 2016, Paul Tan wrote:
> > 
> > > On Wed, Mar 16, 2016 at 3:58 PM, Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > On Sat, 12 Mar 2016, Paul Tan wrote:
> > > >
> > > >> diff --git a/t/perf/p3404-rebase-interactive.sh b/t/perf/p3404-rebase-interactive.sh
> > > >> new file mode 100755
> > > >> index 0000000..aaca105
> > > >> --- /dev/null
> > > >> +++ b/t/perf/p3404-rebase-interactive.sh
> > > >> @@ -0,0 +1,26 @@
> > > >>
> > > >> [...]
> > > >>
> > > >> +test_perf 'rebase -i --onto master^' '
> > > >> +     git checkout perf-topic-branch &&
> > > >> +     git reset --hard perf-topic-branch-initial &&
> > > >> +     GIT_SEQUENCE_EDITOR=: git rebase -i --onto master^ master
> > > >> +'
> > > >
> > > > This measures the performance of checkout && reset && rebase -i. Maybe we
> > > > should only test rebase -i?
> > > 
> > > test_perf runs the same script multiple times, so we need to reset
> > > --hard at least to undo the changes of the rebase.
> > > 
> > > I think we can remove the reset if we use rebase -f and rebase onto
> > > the same base, but -f was not implemented in this patch series.
> > 
> > Hrm. rebase -f just makes the reset an implicit part of the rebase, so it
> > seems we cannot perf *just* the rebase. We are stuck with perf'ing also
> > the reset. Sad.
> 
> I had the same problem back when I was working on index-v5 and posted
> a patch series.  The discussion about it is at [1].  Maybe it could be
> worth resurrecting?
> 
> [1] http://thread.gmane.org/gmane.comp.version-control.git/1379419842-32627-1-git-send-email-t.gummerer@gmail.com

Yes, I agree that something like that is needed. The proposed commit
message suggests that things get simpler, though, while I would contend
that timings get more accurate.

And I think you could simply move the test_start command, but that's just
from a *very* cursory reading of the patch.

Ciao,
Dscho
