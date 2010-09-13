From: "Tjernlund" <tjernlund@tjernlund.se>
Subject: RE: gitweb: please show tags file history browsing
Date: Mon, 13 Sep 2010 07:42:12 +0200
Message-ID: <001601cb5306$6a7d8030$3f788090$@se>
References: <000001cb51be$ed214dd0$c763e970$@se> <201009121719.32390.jnareb@gmail.com> <001201cb5295$5c055850$141008f0$@se> <201009122020.11556.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Jakub Narebski'" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 07:42:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov1oR-0000sT-H0
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 07:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495Ab0IMFm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 01:42:26 -0400
Received: from csmtp2.one.com ([91.198.169.22]:60619 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab0IMFmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 01:42:25 -0400
Received: from jockexp (84-217-13-162.tn.glocalnet.net [84.217.13.162])
	by csmtp2.one.com (Postfix) with ESMTPA id 51E2B3CA47D87;
	Mon, 13 Sep 2010 05:42:23 +0000 (UTC)
In-Reply-To: <201009122020.11556.jnareb@gmail.com>
X-Mailer: Microsoft Office Outlook 12.0
thread-index: ActSpymIiZ8u+cUEQ6uCyCS01XVJZwAXourg
Content-Language: sv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156070>

> -----Original Message-----
> From: Jakub Narebski [mailto:jnareb@gmail.com]
> Tjernlund wrote:
> >> On Sun, 12 Sep 2010, Tjernlund wrote:
> >>>> From: Jakub Narebski [mailto:jnareb@gmail.com]
> >>>> On Sun, 12 Sep 2010, Tjernlund wrote:
> >>>>>> From: Jakub Narebski [mailto:jnareb@gmail.com]
> 
> >>>>>> While it probably be possible to show tags in 'history' view, it would
> >>>>>> be not easy.  The problem is that 'history' view shows only commits
> >>>>>> that touch specified file or directory, and tagged commits usually do
> >>>>>> not touch those files (at least if one is using "bump version number"
> >>>>>> commits to tag them).
> >>>>>>
> >>>>>> So you would have:
> >>>>>> 1. Design where to show those tags - they would be between shown
> >>>>>>    commits.
> >>>>>> 2. Create code which shows some/all tags that are between commits in
> >>>>>>    the presence of nonlinear history, without affecting performance
> >>>>>>    too badly.
> >>>>>
> >>>>> Ah, that is too bad because I think it would really useful.
> >>>>> Image browsing a drivers history in the linux kernel. Then it would be
> >>>>> really nice to see what changes/bug fixes went into what release.
> >>>>
> >>>> First, you can help with the first issue even if you can't help with
> >>>> the coding itself.
> >>>
> >>> I like the gitk way of showing tags, won't that work in gitweb too?
> >>
> >> Err... "gitk" shows tags, but so does 'shortlog' and 'log' view in
> >> gitweb.  The 'history' view in gitweb doesn't show intermediate tags,
> >> but neither does "gitk -- <path>".
> >
> > I know, I just meant the yellow note with tag name in it, how tags
> > are displayed. When they are display is another matter :)
> 
> When those yellow notes with tag name are displayed beside commit
> subject it means that this commit is referenced by given tag (i.e.
> <this tag>^{commit} = <this commit>).
> 
> We have to distinguish situation where tag is between commits, and
> tag points to commit.

Why? I just want to know if a commit is included or not in the tag.
When a tag is formally between commits, just display the
tag with the commit line below.

 Jocke 
