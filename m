From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: exporting the last N days of a repository
Date: Mon, 3 Nov 2008 07:51:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811030749470.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <93c3eada0810281801l29253e02g95c7a6851c4c4db3@mail.gmail.com>  <alpine.DEB.1.00.0810291610340.22125@pacific.mpi-cbg.de.mpi-cbg.de> <93c3eada0811021716y37ba999fkc2085b1060fbea2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 07:48:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwtEk-0008O1-31
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 07:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbYKCGoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 01:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbYKCGoI
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 01:44:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:42444 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751751AbYKCGoG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 01:44:06 -0500
Received: (qmail invoked by alias); 03 Nov 2008 06:44:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 03 Nov 2008 07:44:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Nh+ZHI9gNC01L0zXkAHUoW4Yfk2tdsTJcjK0tA9
	Dq766OUkakPRnr
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <93c3eada0811021716y37ba999fkc2085b1060fbea2d@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99904>

Hi,

On Mon, 3 Nov 2008, Geoff Russell wrote:

> On Thu, Oct 30, 2008 at 1:40 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 29 Oct 2008, Geoff Russell wrote:
> >
> >> I want to export "the last N days" of a repository to create a copy 
> >> which has an origin which is the state of the repository N days ago 
> >> and has all the history between then and now.
> >>
> >> Can fast-export do this?
> >
> > Yes.  See the --since=... option.
> 
> Sorry, I didn't explain what I want very well.  N days ago I had a 
> working directory in a state S with files F1,F2,F3,...  I want to dump 
> all the history before then so that this is my new starting point, so I 
> want to keep all changes since then.

Well, if you are interested in the history of your _local_ ref, then you 
should use reflogs:

	$ git log --since=HEAD@{10.days.ago}

Hth,
Dscho

P.S.: man git-reflog
