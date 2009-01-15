From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 19:18:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151918320.3586@pacific.mpi-cbg.de>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net> <496F3C99.1040800@drmicha.warpmail.net> <20090115135518.GB10045@leksak.fem-net> <496F44AC.2060607@drmicha.warpmail.net> <alpine.DEB.1.00.0901151518520.3586@pacific.mpi-cbg.de>
 <496F4BF0.6020805@drmicha.warpmail.net> <alpine.DEB.1.00.0901151658060.3586@pacific.mpi-cbg.de> <496F6AC3.7050704@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 19:19:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNWoc-0000mA-Tv
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 19:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762612AbZAOSR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 13:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765267AbZAOSR5
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 13:17:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:50941 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765184AbZAOSRz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 13:17:55 -0500
Received: (qmail invoked by alias); 15 Jan 2009 18:17:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 15 Jan 2009 19:17:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PDX0eOh9PYRJp/IQ57Y/JqJ3yM1vXoZYzRnz76r
	w5omM38gbTUrLl
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <496F6AC3.7050704@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105862>

Hi,

On Thu, 15 Jan 2009, Michael J Gruber wrote:

> Johannes Schindelin venit, vidit, dixit 15.01.2009 17:04:
> ...
> >>> The more I think about it, I think it's possible I broke it with the 
> >>> introduction of the "noop".
> >> It certainly worked after the noop introduction before the r-i-p series, 
> >> but not any more after.
> > 
> > Umm... which rebase -i -p series do you mean?  "noop" was introduced 
> > pretty recently if my Alzheimered brain does not fool me.
> 
> This one introduced noop:
> 
> commit ff74126c03a8dfd04e7533573a5c420f2a7112ac
> Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Date:   Fri Oct 10 13:42:12 2008 +0200
> 
>     rebase -i: do not fail when there is no commit to cherry-pick
> 
> This is the bad one from bisect:
> 
> commit d80d6bc146232d81f1bb4bc58e5d89263fd228d4
> Author: Stephen Haberman <stephen@exigencecorp.com>
> Date:   Wed Oct 15 02:44:39 2008 -0500
> 
>     rebase-i-p: do not include non-first-parent commits touching UPSTREAM
> 
> It's the last one in a longer series. And that series is after the noop
> introduction.

Ohhh....

Thanks,
Dscho
