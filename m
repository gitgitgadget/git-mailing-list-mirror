From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 01/17] perf: introduce performance tests for
 git-rebase
Date: Wed, 16 Mar 2016 16:59:09 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603161656130.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-2-git-send-email-pyokagan@gmail.com> <alpine.DEB.2.20.1603160855390.4690@virtualbox> <CACRoPnS=qg=a3xYKHyk-7E2HN5HhTimGirZcwL8hMa0xLY6KdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 16:59:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agDr4-0001p9-7z
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 16:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbcCPP7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 11:59:21 -0400
Received: from mout.gmx.net ([212.227.17.22]:63002 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbcCPP7U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 11:59:20 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Me8ws-1aSZNo3wy6-00PvvD; Wed, 16 Mar 2016 16:59:11
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACRoPnS=qg=a3xYKHyk-7E2HN5HhTimGirZcwL8hMa0xLY6KdA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:MIzEokNTnV0XpiWLgCppj+icmzLLvyNbCWayI7+7Bie923V/1qd
 L9NJyABxPn+RXOsJ0UIcD+qprMPsij72uZPNc6UH/t04DKluyjMJiP+/F8xvXGLnFlejhms
 LsbZHWe1NKtwMLG4bot61w0FWELXaFFuVehZ8SdlIHUPyNKlEj8jJPUTtN4bg6y/nrfQQNv
 2w3op+m5DUMtS2eKs8k7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6lxBJMdJzw8=:4/7G0P3t7R7JpA+qf4UC4U
 6cpO283dzbH3SL6eYrhV0rP0RHw47pJW7dBNzGOJeCVC5THI0i0J6E6AjP+cwlik4QPHszfwo
 eGAkkasjE4kdrWb/frtQ5WvHQ7dBlk2wLYpPPT9aMIIXzVD/eClOptIjGs2S5eoh4f16P4YUN
 QdtUubaw7zXZT1SldgsrR57xkKH7PuVFVej2S8o9xqeF5S66Hj+aOzBHx4SX2YNyD8pLscLA5
 GoMbEce0Lrxip73RdGG5MbZO6Mlt3r45UHNBQabFbFd7S4rj3rwkkPPrKBz9yU1NBa+Di6Z7C
 vdayNjrOv9apg2aQi5YpghuBZan+K9nD/EINsP3eJW5ml2aFURZqFxeF4ho9jQaFxQUVCwaGu
 2wmjsu/XkXMj372f5hfFRwQiDBtbZ0yNJiAO/spqRew+yndY6wI1E1cNidpOvJSV1zbuExKCO
 d9HeeMEgAROGlbfEN8KFmZWoZpoK0glVAeG+PCfYoYpgziyF3iWEUmAMtG1UviGBdHgr2yYNP
 Y01AE8uOcnK+R8pxjsDazuJ67GqCdU5QZXsg825fzaEYNr403FKBpi/d4oEkTtXAiH3byBriT
 V7zSFIqlOHp0sG4Xvl8WpYUE52l2Rr3ki8Ni0w+ps/8KMVA4yC8sdpZ1xtZZylC92acGN1AZb
 rYNB6pwrNy3EDDoQiZx8I28e5XVRtOHQyu20LrdvlkIZOm0x41pbG4f7p/ZS+v5ZlyPpLdTrO
 n1NQQsb6jzgyCs61ZhuQLUCwbuy9xmXvmYkpRSmmvyyzZaRgZ97piKSMlgKZtCZUc3BciLG7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288983>

Hi Paul,

On Wed, 16 Mar 2016, Paul Tan wrote:

> On Wed, Mar 16, 2016 at 3:58 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Sat, 12 Mar 2016, Paul Tan wrote:
> >
> >> diff --git a/t/perf/p3404-rebase-interactive.sh b/t/perf/p3404-rebase-interactive.sh
> >> new file mode 100755
> >> index 0000000..aaca105
> >> --- /dev/null
> >> +++ b/t/perf/p3404-rebase-interactive.sh
> >> @@ -0,0 +1,26 @@
> >>
> >> [...]
> >>
> >> +test_perf 'rebase -i --onto master^' '
> >> +     git checkout perf-topic-branch &&
> >> +     git reset --hard perf-topic-branch-initial &&
> >> +     GIT_SEQUENCE_EDITOR=: git rebase -i --onto master^ master
> >> +'
> >
> > This measures the performance of checkout && reset && rebase -i. Maybe we
> > should only test rebase -i?
> 
> test_perf runs the same script multiple times, so we need to reset
> --hard at least to undo the changes of the rebase.
> 
> I think we can remove the reset if we use rebase -f and rebase onto
> the same base, but -f was not implemented in this patch series.

Hrm. rebase -f just makes the reset an implicit part of the rebase, so it
seems we cannot perf *just* the rebase. We are stuck with perf'ing also
the reset. Sad.

> > Also, I would strongly recommend an extra test_commit after reset;
> > Otherwise you would only test the logic that verifies that it can simply
> > fast-forward instead of cherry-picking.
> 
> Or, we could use the -f flag, I think.

Yeah, we can do that, too.

Ciao,
Dscho
