From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: a few remaining issues...
Date: Fri, 5 Jan 2007 14:33:06 -0500
Message-ID: <20070105193306.GB8753@spearce.org>
References: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701051453520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 20:33:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2uod-00034t-As
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 20:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422670AbXAETdP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 14:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbXAETdP
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 14:33:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52832 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422670AbXAETdO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 14:33:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H2unn-0005tL-60; Fri, 05 Jan 2007 14:32:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5375C20FB65; Fri,  5 Jan 2007 14:33:06 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701051453520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36013>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 5 Jan 2007, Junio C Hamano wrote:
> 
> > * Reflogs.
> > 
> > 'git reflog show' needs to be done -- and preferrably in a way that does 
> > not add too much code.
> 
> I do not have time to follow up on my earlier attempts to teach git-log 
> about traversing reflogs instead of the commit parents. But Shawn had a 
> working proposal, didn't he?

Yes, but my proposal added a lot of code.  Junio's comment is that
he would prefer one that doesn't, such as by reusing as much of the
revision listing machinary as possible.  Which you had looked into
doing.

I myself am also severly lacking in time right now.  *if* I get
any more Git time in the next week its going to be to finish out
some patches on the bash-completion, so I can try to sneak them
into the v1.5.0 release (if possible).  Its unlikely I'll be able
to look at a `reflog show` anytime soon.

-- 
Shawn.
