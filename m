From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw: introduce the 'core.hideDotFiles' setting
Date: Sat, 7 May 2016 08:44:22 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605070801540.2963@virtualbox>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de> <xmqqr3dhhcd7.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1605061658580.2963@virtualbox> <xmqqh9eb5eo0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 08:45:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayvz4-00005t-JU
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 08:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbcEGGok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 02:44:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:49766 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbcEGGok (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 02:44:40 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LwJko-1biY3e1IFS-0186OF; Sat, 07 May 2016 08:44:20
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqh9eb5eo0.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:TxhAWkTGyFtjiVjh92aHIE83hsTo9X322cVkggDSiYN2yJaDYlc
 5CeIPS05uFIvE2yTxmbLD/nQTOG1Ofzuv3O8wT1P+6p5vQoi/9mRIQxiJTxKb0GZZovUmvh
 NRr+0d8JPAALMf5BBHtv5pbFa7ZFMnzUfudYQ9eA19UR/+OMoCcAO4NHWEvQGSPb1mAkZlq
 0lkvrn2Mj01Wrg6b/PV2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hy5ZW2CoDWQ=:pNm2SjpEAK5bvWq1gHSUro
 JciHImX9zKv/3eSi9bcbB5uCSWaHHKJkiwDhjV4OJjdSnBkqc5DUUv9j6y/4ZiA2XB18V7qnZ
 VbPS1vSFWleZWnWQMIMU8dseygUDDd8Dj8LOCeSEBKZTGglHf6SfzVF0wd5KciijjQDGjevoy
 0pXw52r4jbubi/6Ms5P0vyA0FdF0CkC4i7JEFWQal3m0CnFBRKh63UORq28lb7EM18r5Pxz4F
 HXtF5ohHB9pFvT2NNQyoFSOhg1gY4UvojK0TS4va/XuV1jH5S+trVXctP1m6YHeflgq3W2MQI
 ArkaQHlGTcbJMMBOZQdYZ0XKlIECQ20hkzBwXqQK31GQDEjgm4ZvbWPYl8ey7YG5LYkKUIXqv
 Ix+6XnF1u3u6YWA9xAfCHigrJ8aeYjwHRCK2uQoCPtlJL2y+QmS22oh8l/YTK/xsQS09v6Cnw
 dei0uPQQkCAanNlxqSlQPhz9+JFmKXkxEuexJlbiFHBCuWr5Hw81AWqtqcVIGwhfMxrXKv1qz
 yF8eJjwCTGw/HsMV+H69y625mcI/nCk6r3CBPyE+tv5dt0nl8ncnRBCpCbqC+FzZbyfaUxcKc
 pQlJ663zh0KQGerVzY6/e9wfVHZBZEUFl8kki4uRCccCdkfaxh9wSfQawszgl9FhD7bU2ih94
 BHgTGQtPJ39VH4Kqa9idKJR6cmdN2zWgH1uYfTIbJI8HsQC0gqTngn/EJesWFNr7iFVk2okxn
 nxbI9LBgL5xsabphWdMafAH1fnctBHoFb9qUs5BVatYPWts68E3q1z0px+jZe0bisvafCIy+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293882>

Hi Junio,

On Fri, 6 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I agree with the goal of the change, but I am having a hard time
> >> justifying this addition.  Primarily because I do not understand the
> >> need for this.
> >> 
> >> In order to be prepared to handle HIDE_DOTFILES_TRUE case,
> >> mingw_mkdir() needs to be taught about needs_hiding() and
> >> make_hidden() already.  Why isn't it sufficient to teach
> >> needs_hiding() to check with !strcmp(basename(path, ".git")) under
> >> HIDE_DOTFILES_DOTGITONLY?
> >
> > The reason was that I wanted to avoid to compare a name unnecessarily
> > when I already had a code path that knew perfectly well that a given
> > directory is the .git/ directory.
> >
> > I made the change. It was more painful than I expected, as two bugs
> > were uncovered, both introduced after the original patch by Erik.
> > ...
> > It worries me slightly that the new code is so different from the code
> > that was tried and tested through all those years (although admittedly
> > it is unlikely anybody ever ran with core.hideDotFiles = true, given
> > above findings). But I guess that cannot be helped. Not unless we
> > reintroduce those two bugs.
> 
> I have a huge preference for a code that has been production for
> years over a new code that would cook at most two weeks in 'next'.

I agree. However, it does not fill me with confidence that we did not
catch those two bugs earlier. Even one round of reviews (including a
partial rewrite) was better than all that time since the regressions were
introduced.

Besides, your innocuous remark that needs_hiding() could determine whether
we are looking at ".git" revealed a problem with the original design:
there can be .git *files*. Support for .git files was introduced in
February 2008, so it is my fault that I did not catch this in January
2010, when I added the "dotGitOnly" option.

I do not think that we can fix this design other than abandoning the
mark_as_git_dir() function.

> As I said, the part regarding the mark_as_git_dir() in the message
> you are responding to was me asking you to explain, not me objecting
> to the code.

I understood. My initial reaction was: it makes a total lot of sense to
simplify the patch by removing that global.

It was more painful than anticipated only because I did not expect any
bugs to be revealed in the process, certainly not hard-to-debug ones (I
had to patch submodule--helper's code to allow attaching a debugger at a
very specific point during t1013 so I could single-step through it, and it
took quite a couple of iterations to pinpoint the problem).

Even as it was painful, it was useful, too, though, as bugs were revealed
and squashed. And an additional test was introduced and unnecessary code
was dropped.

In the same vein, was wondering whether we want to hide those Windows-only
core config options behind a platform_core_config() which would then be
#define'd to point to mingw_core_config()?

> So given the knowledge that
> 
>  - I am not fundamentally opposed to having an extra call there; - in
>  fact, I suspect it may even be a good thing to have one; - I am not
>  entirely happy with the name mark_as_git_dir; and - the rewrite to lose
>  that call was more painful than anticipated.
> 
> would you still choose to lose the extra call and go with
> !stricmp(basename(path), ".git")?  The best approach for v2 might be to
> 
>  - Keep the two bugfixes that was uncovered during this exercise; - keep
>  the change to init_db() to add a call to mark_as_git_dir(); -
>  optionally, come up with a better name for that function; and - drop
>  the setting of configuration varaibles that was unnecessary.

Well, given that I learned that I cannot use basename() but have to
partially copy its code, the simpler solution *is* to abandon the
mark_as_git_dir() approach.

See v2 (my apologies for sending it only today, I encountered a bug in my
patch series sending script and was unable to fix it yesterday).

Ciao,
Dscho
