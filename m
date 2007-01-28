From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/4] Teach git-describe to display distances from tags.
Date: Sun, 28 Jan 2007 02:24:49 -0500
Message-ID: <20070128072449.GA9781@spearce.org>
References: <a23c4e55ca5c09f742fa2a047e45613e7797e720.1169880681.git.spearce@spearce.org> <20070127065413.GC10380@spearce.org> <7v4pqcluum.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701271348330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 28 08:25:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB4PU-0001Ok-H4
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 08:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbXA1HY5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 02:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbXA1HY5
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 02:24:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54041 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299AbXA1HY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 02:24:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HB4PD-0004hl-8q; Sun, 28 Jan 2007 02:24:51 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3A93D20FBAE; Sun, 28 Jan 2007 02:24:50 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701271348330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38019>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sat, 27 Jan 2007, Junio C Hamano wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> > 
> > > The + format is much easier to read and understand than the - format 
> > > original proposed by Junio.
> > 
> > I tend to disagree (I do not claim + is _less_ easier to read, though).
> > 
> > They are of comparable readability, and I think plus breaks 
> > GIT-VERSION-GEN (the primary reason it replaces '-' to '.' is to work 
> > around RPM limitation IIRC, and I do not know what '+' does to RPM 
> > offhand).
> 
> Note that scripts using git-describe to name archives break also on 
> challenged file / operating systems. IIRC on DOS/FAT32 '+' has problems 
> with it.
> 
> > But I do not have a strong feeling either way.
> 
> Neither have I.

Me neither, actually.  The + just felt more right, as its literally
"that tag, plus n commits".

But if + is going to cause pain on operating systems that somehow
decided disallowing bytes other than NUL was OK and the right thing
to do, then maybe - is the safer choice here.

-- 
Shawn.
