From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 20:58:39 -0500
Message-ID: <20070209015839.GG1556@spearce.org>
References: <17866.27739.701406.722074@lisa.zopyra.com> <Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org> <87fy9gz9vu.fsf@host94.eke.fi> <Pine.LNX.4.64.0702081321040.8424@woody.linux-foundation.org> <87bqk4z4qw.fsf@host94.eke.fi> <20070208221023.GB1091@spearce.org> <20070209014852.GA13207@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kalle Pokki <kalle.pokki@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 09 02:58:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFL2L-0008VB-KF
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 02:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946022AbXBIB6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 20:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946014AbXBIB6s
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 20:58:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44762 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946017AbXBIB6r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 20:58:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HFL1z-00048x-Ax; Thu, 08 Feb 2007 20:58:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 21A2F20FBAE; Thu,  8 Feb 2007 20:58:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070209014852.GA13207@thunk.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39147>

Theodore Tso <tytso@mit.edu> wrote:
> On Thu, Feb 08, 2007 at 05:10:23PM -0500, Shawn O. Pearce wrote:
> > 	git config alias.new "gitk --all --not ORIG_HEAD"
> > 
> > Would give you a new git subcommand:
> > 
> > 	git new
> > 
> > which shows all of the new stuff, on all branches, but doesn't show
> > your prior commit history.
> 
> Aliases don't seem to be working for me; I'm using git 1.5.0-rc4.  Am
> I doing something wrong?

Its not you.  The problem is 'gitk' is not an internal command,
nor is there a 'git-gitk'.  So we cannot execute it.  Instead we
are giving back a horrible error message.

Symlink git-gitk to gitk and it works.

Sorry about giving false hopes.  :-)

-- 
Shawn.
