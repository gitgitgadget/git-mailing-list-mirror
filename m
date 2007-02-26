From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: RFC: Patch editing
Date: Mon, 26 Feb 2007 13:56:55 -0500
Message-ID: <20070226185655.GB2108@spearce.org>
References: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070226180314.GA2108@spearce.org> <Pine.LNX.4.63.0702261949560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 26 19:57:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLl1z-00050h-53
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 19:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbXBZS5A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 13:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbXBZS5A
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 13:57:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49850 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030452AbXBZS47 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 13:56:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HLl1l-0002ZJ-Sz; Mon, 26 Feb 2007 13:56:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A61E520FBAE; Mon, 26 Feb 2007 13:56:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702261949560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40643>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 26 Feb 2007, Shawn O. Pearce wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > Therefore, I wrote this extremely simple script to sort out the order of 
> > > commits, and possibly merging some. The script lets you edit the commit 
> > > list upon start (reordering it, or removing commits), and then works on 
> > > that list. It has three subcommands:
> > 
> > This simple tool rocks.  Thank you!  ;-)
> 
> I am undecided how to continue. Originally, I wanted to add an "--onto 
> <commit>" option, and maybe an "edit" subcommand, but since Junio made me 
> realize that it is more similar to git-rebase than I previously thought, 
> and that they should merge, possibly in the form of a builtin...

Yea - this is a lot like rebase.  I was also thinking that the -m
(merge mode) in rebase probably should be the only option offered.
I don't see why rebase should format-patch|am when we have the
whole commit available and merge-recursive does an excellent job
on tree level merges.

> But in order to merge the two, I have to learn about rebase's syntax first 
> ;-)

Its easier than it looks.  ;-)

-- 
Shawn.
