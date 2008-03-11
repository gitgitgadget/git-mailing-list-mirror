From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: commit 0? (or: create new empty branch)
Date: Tue, 11 Mar 2008 15:59:54 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111557130.3873@racer.site>
References: <20080311123004.GA27577@bit.office.eurotux.com> <alpine.LSU.1.00.0803111350550.3873@racer.site> <20080311144515.GB12258@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 16:01:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ5xv-0007G2-3f
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 16:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbYCKO7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 10:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbYCKO7w
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 10:59:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:34448 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751013AbYCKO7v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 10:59:51 -0400
Received: (qmail invoked by alias); 11 Mar 2008 14:59:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp023) with SMTP; 11 Mar 2008 15:59:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nzMV/k5TnZNcgcIHJs9I2x5tUdt/DxNtpcb7Oae
	NHjiVT1mPowYEE
X-X-Sender: gene099@racer.site
In-Reply-To: <20080311144515.GB12258@bit.office.eurotux.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76860>

Hi,

On Tue, 11 Mar 2008, Luciano Rocha wrote:

> On Tue, Mar 11, 2008 at 01:52:00PM +0100, Johannes Schindelin wrote:
> 
> > On Tue, 11 Mar 2008, Luciano Rocha wrote:
> > 
> > > I'd like to create a new branch, without any pre-existing data, for 
> > > purposes similar to git's html/man/.....
> > 
> > If there is nothing to branch from, there is nothing to branch from.
> > 
> > You might want to rename your branch (once you have something).
> > 
> > But then, I do not even understand why you bother.  You can always 
> > push to a branch of a different name, and have your principal branch 
> > being "master" locally.
> 
> It's not a matter of pushing/pulling. I'm referring to local branches 
> only.
> 
> I'd have no problems with the first branches. But when I wanted to 
> create the third, that shares no files with the others, I stumbled with 
> the problem of creating a clean branch. I really didn't want to create a 
> branch them do "git rm .".
> 
> Johannes's tricks did the thing. Thank you all.

My tricks?

I know, you do not have to reply, but you should have taken a bit more 
care there.

BTW the recommended way is really to go outside and push (slight variation 
on Hannes' 2nd method):

# create new repository
$ mkdir new-root && cd new-root && git init

# initialise master branch
$ vi <file> && git add <file> && git commit <file>

# push it into the original repository as a new branch
$ git push .. master:refs/heads/<new-branch>

Ciao,
Dscho
