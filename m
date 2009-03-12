From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 14:02:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302>
References: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com>  <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de> <43d8ce650903120448x51220ba0k660be7706acba755@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-116081952-1236862942=:6335"
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 14:03:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhkZm-0004Zw-JF
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 14:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbZCLNC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 09:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754261AbZCLNC0
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 09:02:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:52554 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752563AbZCLNCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 09:02:25 -0400
Received: (qmail invoked by alias); 12 Mar 2009 13:02:22 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 12 Mar 2009 14:02:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18D3Cd+1b8DgFPW+AYRO0RXev0COIzjTxYZvKgp3N
	hODypsSIlknQgA
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <43d8ce650903120448x51220ba0k660be7706acba755@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113064>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-116081952-1236862942=:6335
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 12 Mar 2009, John Tapsell wrote:

> 2009/3/12 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> > On Thu, 12 Mar 2009, John Tapsell wrote:
> >
> >>   One of my collegues did:
> >>
> >> git checkout origin/somebranch
> >>
> >>   git complained that they need to specify the name with -b.  So they did:
> >>
> >> git checkout -b origin/somebranch origin/somebranch
> >
> > Yeah, a pilot error.  It should have been
> >
> >        $ git checkout -t origin/somebranch
> 
> Maybe the error message for "git checkout origin/somebranch"  should
> suggest:  git checkout -t origin/somebranch?
> 
> > I have to wonder, though, why "git checkout origin/somebranch" did not
> > detach your HEAD.
> 
> It did.  But that doesn't affect doing "git checkout -b
> origin/somebranch origin/somebranch"  afterwards.

So did the warning read something like this?

-- snip --
moving to "d36a18dc9cdf1dfce8632e42491b826387aa3230" which isn't a local 
branch
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
-- snap --

?

If so, why did you not follow the recipe

	$ git checkout -b somebranch

but something like

	$ git checkout -b origin/somebranch origin/somebranch

?

I do not think there is a way to tell the user more explicitely what to do 
without insulting the user's intelligence ;-)

> > I wonder why you did not just "git branch -m somebranch".
> 
> Because they didn't know what on earth was going on, and git was 
> spitting out errors everywhere, they were afraid git would crash.

Yeah, I know those reactions.  All of a sudden, people panic, destroying 
everything in the process.  Do tell them to calm down first of all.  
Unless you do something like "rm -rf .git" or "git branch -d", it is 
actually pretty hard to lose data with Git.

Ciao,
Dscho

--8323329-116081952-1236862942=:6335--
