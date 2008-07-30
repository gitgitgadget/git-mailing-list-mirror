From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Merging submodules (was Re: Feature suggestion: git-hist)
Date: Wed, 30 Jul 2008 18:26:48 +0200
Message-ID: <20080730182648.393cfccc@pc09.procura.nl>
References: <20080730133859.368bbd92@pc09.procura.nl>
	<20080730133334.GB31192@lars.home.noschinski.de>
	<20080730155835.71289eee@pc09.procura.nl>
	<FA2D570A-B2B1-4994-AA6A-9C0C55E69900@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Lars Noschinski <lars-2008-1@usenet.noschinski.de>,
	git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 18:27:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOEWp-0005jx-Iw
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 18:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbYG3Q0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 12:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbYG3Q0z
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 12:26:55 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:1813 "EHLO
	smtp-vbr11.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbYG3Q0y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 12:26:54 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6UGQmDQ093854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2008 18:26:49 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <FA2D570A-B2B1-4994-AA6A-9C0C55E69900@silverinsanity.com>
X-Mailer: Claws Mail 3.5.0cvs35 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90816>

On Wed, 30 Jul 2008 11:15:55 -0400, Brian Gernhardt
<benji@silverinsanity.com> wrote:

> 
> On Jul 30, 2008, at 9:58 AM, H.Merijn Brand wrote:
> 
> > One (very) big disadvantage of  SCCS  is that commits are on a per- 
> > file
> > basis, and only in a single directory. This drawback still haunts me  
> > in
> > git, as my first attempts to convert were successful in a single  
> > folder
> > and git cannot merge folders into a single project.
> >
> > Say I now have
> >
> > /work/src/project/.git
> > /work/src/project/module_a/.git
> > /work/src/project/module_b/.git
> > /work/src/project/module_c/.git
> >
> > Which are all converted repos from SCCS, I'd like to merge the three
> > module_# repos into the top level repo.
> 
> Following the example of Linus, the following is completely untested.
> 
> First you fetch all of the heads/tags/etc into the superproject with  
> commands like
> 
> git fetch module_a refs/heads/*:refs/remotes/module_a/*
> git fetch module_b refs/heads/*:refs/remotes/module_b/*
> git fetch module_c refs/heads/*:refs/remotes/module_c/*

All went well
 
> Then you do something like:
> 
> rm -rf module_{a,b,c}/.git # Do this in a test repository, obviously...
> git add module_a module_b module_c
> git commit # Needed because '-s ours' uses current HEAD, not index

So far so good.

> git merge --no-commit -s ours module_a/master module_b/master module_c/master

$ git merge --no-commit -s ours fnc/master i00f000/master
i99f000/master include/master l00m000/master l01f000/master l02f000/master l03f000/master l06f000/master l90z000/master leerpl/master mutbev/master prtabel/master rpt/master tabellen/master zoomen/master Automatic merge went well; stopped before committing as requested

> git commit --amend

$ git commit --amend
fatal: You are in the middle of a merge -- cannot amend.
$ git status
# On branch master
nothing to commit (working directory clean)

When I start git-gui, it still shows a long commit message:
Merge commit 'fnc/master'; commit 'i00f000/master'; commit 'i99f000/master'; commit 'include/master'; commit 'l00m000/master'; commit 'l01f000/master'; commit 'l02f000/master'; commit 'l03f000/master'; commit 'l06f000/master'; commit 'l90z000/master'; commit 'leerpl/master'; commit 'mutbev/master'; commit 'prtabel/master'; commit 'rpt/master'; commit 'tabellen/master'; commit 'zoomen/master'

All other areas are clear

> From this point on, the project repository has a merged history of  
> the sub-projects, and if anyone doesn't catch up and still makes a  
> commit on a subproject you can use "git merge -s subtree" to merge it  
> in anyway.
> 
> You may need to "git rm --cached" some files after the "git add" step  
> if your .gitignore files aren't perfect.

-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
