From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 12:45:52 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801161244390.17650@racer.site>
References: <478D79BD.7060006@talkingspider.com> <vpq4pdeum3v.fsf@bauges.imag.fr> <alpine.LSU.1.00.0801161035380.17650@racer.site> <18317.60797.644829.539598@lisa.zopyra.com> <vpq4pderm7k.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>, Mike <fromlists@talkingspider.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jan 16 13:46:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF7ez-0007al-Oo
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 13:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbYAPMp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 07:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbYAPMp5
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 07:45:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:50801 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751379AbYAPMp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 07:45:56 -0500
Received: (qmail invoked by alias); 16 Jan 2008 12:45:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp022) with SMTP; 16 Jan 2008 13:45:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19RCwUPySdRzxUWAcRE2Du0FpNBJeT8rPlC3+cKhr
	1SZwCj5QTSZQ21
X-X-Sender: gene099@racer.site
In-Reply-To: <vpq4pderm7k.fsf@bauges.imag.fr>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70661>

Hi,

On Wed, 16 Jan 2008, Matthieu Moy wrote:

> Bill Lear <rael@zopyra.com> writes:
> 
> > On Wednesday, January 16, 2008 at 10:36:34 (+0000) Johannes Schindelin writes:
> >>Hi,
> >>
> >>On Wed, 16 Jan 2008, Matthieu Moy wrote:
> >>
> >>> Mike <fromlists@talkingspider.com> writes:
> >>> 
> >>> > I'm learning git and I'm really annoyed that the .git directory lives 
> >>> > in the same directory as my code.  I don't want it there for three 
> >>> > reasons:
> >>> 
> >>> The idea was discussed here, mostly under the name "gitlink".
> >>
> >>It goes by "git worktree"; has nothing to do with gitlink (which has 
> >>something to do with submodules).
> >
> > I think you mean to say there is a variable 'worktree' variable
> > available via the config variable 'core.worktree' or environment
> > variable GIT_WORK_TREE, or command-line option --work-tree that should
> > do the trick (no 'git worktree' command exists as far as I can see):
> 
> Yes, so you can use
> 
> $ git --work-tree . --git-dir /some/other/place <some-command>
> 
> But it's far from the user-friendlyness of a real lightweight checkout: 
> you need to provide the --work-tree and --git-dir options each time you 
> run git. And making an alias or using the environment variables are not 
> really an option if you have more than one repository or working tree to 
> deal with.

Well, the OP said he did not want _any_ file in the worktree.  So there's 
no way around specifying by hand everytime where the git directory should 
be.

I'm not saying I find the OP's restrictions sensible, but that's what he 
said.

Ciao,
Dscho
