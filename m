From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] On error, do not list all commands, but point to --help option.
Date: Sat, 20 Oct 2007 22:06:53 -0400
Message-ID: <20071021020653.GA14735@spearce.org>
References: <bqaujirk.fsf@blue.sea.net> <Pine.LNX.4.64.0710202126430.25221@racer.site> <odetifoh.fsf@blue.sea.net> <Pine.LNX.4.64.0710210001390.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 21 04:07:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjQDf-0003cy-Gx
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 04:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbXJUCHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 22:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbXJUCHA
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 22:07:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56554 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbXJUCG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 22:06:59 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IjQDE-0003PN-3r; Sat, 20 Oct 2007 22:06:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DCB2D20FBAE; Sat, 20 Oct 2007 22:06:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710210001390.25221@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61863>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > On Sat, 20 Oct 2007, Jari Aalto wrote:
> > >
> > >> - commented out call to list_common_cmds_help()
> 
> Well, I'm almost sure of the opposite.  One of the big results of the Git 
> Survey was that git is still not user-friendly enough.  Your patch would 
> only make this issue worse.

Actually I think Jari's patch helps for the reason originally
stated in the message (less output when you make a small typo).
Though I agree that the commented out code should just be removed.

I actually had to do `git config alias.upsh push` just to keep
myself from screaming every time I made a small typo and Git gave
me a screenful of "helpful reminders".

Hmm.  Lets see.

  "cvs foo":
    Big spew of commands.  Like "git foo".

  "svn foo":
    Unknown command: 'foo'
    Type 'svn help' for usage.

Both are considered to be more newbie friendly then Git.  So clearly
SVN's output of almost nothing is friendly.  And so is CVS'
big spew of frequently used commands.  Either way is apparently
newbie friendly.

Though I find SVN's message a little insulting, asking me to type.
I know I have to type the command, thanks.

-- 
Shawn.
