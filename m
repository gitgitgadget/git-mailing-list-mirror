From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 7 Feb 2007 19:05:30 -0500
Message-ID: <20070208000530.GA2469@spearce.org>
References: <17866.20355.744025.133326@lisa.zopyra.com> <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org> <7vd54l60gg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071525270.8424@woody.linux-foundation.org> <7vtzxx4k1c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071539390.8424@woody.linux-foundation.org> <Pine.LNX.4.63.0702080057140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 08 01:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEwnH-00027n-Br
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 01:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161483AbXBHAFk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 19:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161492AbXBHAFk
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 19:05:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48047 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161483AbXBHAFj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 19:05:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEwmw-0008Kw-A4; Wed, 07 Feb 2007 19:05:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8A17520FBAE; Wed,  7 Feb 2007 19:05:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702080057140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39010>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> P.S.: Sorry, Shawn, but I don't think that my version "won". It was 
> modeled after yours, but introduced flexibility to use reflog walking to 
> other revision walkers. So, I think of it as the "next" version of your 
> "git reflog show".

Don't be sorry. I think your -g reused more existing code than my
`git reflog show` did, and you had the time to follow through on it
when Junio was interested in a patch while I didn't.  It really did
win as the better solution for Git.  And that's all that matters. :-)

-- 
Shawn.
