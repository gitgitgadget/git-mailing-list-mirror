From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Java Git (aka jgit) library switching license to BSD/EPL
Date: Fri, 9 May 2008 19:38:28 -0400
Message-ID: <20080509233828.GE29038@spearce.org>
References: <20080509021158.GA29038@spearce.org> <alpine.LFD.1.10.0805091214170.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Dave Watson <dwatson@mimvista.com>,
	Philippe Ombredanne <philippe@easyeclipse.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat May 10 01:40:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JucBo-00055E-75
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 01:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760378AbYEIXio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 19:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760371AbYEIXin
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 19:38:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60709 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760363AbYEIXik (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 19:38:40 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JucAN-00089S-VD; Fri, 09 May 2008 19:38:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7DE6420FBAE; Fri,  9 May 2008 19:38:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805091214170.23581@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81635>

Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 8 May 2008, Shawn O. Pearce wrote:
> 
> > Nico, Linus, Junio, Daniel, Dscho, et.al.:
> > 
> >   We would appreciate it if you could provide a statement saying
> >   you have no current copyright ownership interest in jgit, and that
> >   you do not currently own nor invented any patents related to the
> >   "Git technology" that this code might need to use to function as
> >   a Git implementation.
> 
> I do not have any such copyright nor patent claims for the jgit code.
> 
> As long as the C version remains the authoritative reference 
> implementation for protocol and data format,

I don't think anyone is going to argue with that.  Its very unlikey
that jgit would unseat C git as the Git implementation used by
everyone.  But I do hope that jgit grows more in popularity as more
people come to Git, especially Java users/developers.

> and any algorithmic 
> improvements made to the jgit source can be merged back into the C 
> version using the GPL, then I have no issue with the license used by 
> jgit either.

This shouldn't be a problem.  We're moving to a 3-clause BSD.  As I
understand it, anyone can take code under a 3-clause BSD license,
make a few changes, and release the modified version under the GPL,
and the original BSD project can't take those changes back in due
to the changes being licensed under the GPL.  From what I have
read this has happened several times in the Linux kernel with code
obtained from *BSD.

So long as someone is willing to port the improved algorithm across
langauges from Java->C, even if it is a direct translation, it can
still be included in C Git.

Thanks for the reply Nico (and everyone else), it is most appreciated.

-- 
Shawn.
