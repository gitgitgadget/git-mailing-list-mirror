From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GitStats] Bling bling or some statistics on the git.git
 repository
Date: Fri, 11 Jul 2008 23:10:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807112308170.8950@racer>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>  <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>  <alpine.DEB.1.00.0807112215050.8950@racer>  <alpine.DEB.1.00.0807112238350.8950@racer>  <alpine.DEB.1.00.0807112252250.8950@racer>
 <bd6139dc0807111505j36c42b6blec299d25d8c0ac9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>,
	David Symonds <dsymonds@gmail.com>
To: Sverre Rabbelier <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:11:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQpY-0006L0-UK
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 00:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207AbYGKWKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 18:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756187AbYGKWKK
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 18:10:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:41820 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756133AbYGKWKI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 18:10:08 -0400
Received: (qmail invoked by alias); 11 Jul 2008 22:10:07 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp002) with SMTP; 12 Jul 2008 00:10:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/KsBA0arrK+Pjm6ILFTi6r8PlgzH1L7QFHi6x0r6
	LqJ6J8XYe39gSv
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0807111505j36c42b6blec299d25d8c0ac9a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88188>

Hi,

On Sat, 12 Jul 2008, Sverre Rabbelier wrote:

> On Fri, Jul 11, 2008 at 11:55 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Fri, 11 Jul 2008, Johannes Schindelin wrote:
> >
> >> something else I just realized: you might want to use .mailmap, e.g. 
> >> to coalesce the changes of Shawn "O." Pearce correctly.
> >
> > Yet another thing: while it is true that git-gui is usually pulled in 
> > (with the subtree strategy), some parts were changed in git.git 
> > directly, so you will need to cope with the wholesale rename with 
> > every merge.
> 
> I think I understand the cause, but I'm not sure I understand the
> consequences? Will some files at some times appear to be located at
> /path/to/file.txt and at other times at /subdir/path/to/file.txt? If
> so, how could I possibly handle that? How do I know that when it says
> /path/to/file.txt it means /subdir/path/to/file.txt instead?
>
> > Besides, it is slightly distracting to see the file names differently 
> > from what they are in HEAD^{tree}.  But that may be just me.
> 
> Different how? In that it shows the contents of subdirs? For at least
> my repo this is a Very Good Thing (tm) as all my source-code is in a
> /src directory. If all changes to subdirs were aggregated I wouldn't
> get any useful metrics at all. Or am I misunderstanding the difference
> between the current output and that of HEAD^{tree}?

What I meant is this: you list "git-gui.sh", while I would have expected 
"git-gui/git-gui.sh".

So you might need to rename the keys of your aggregating dict (I haven't 
looked at the code, but suspect that's how you do it) with renaming 
commits (including the merge commits).

Ciao,
Dscho
