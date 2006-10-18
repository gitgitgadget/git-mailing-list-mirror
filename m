From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 18:05:10 -0400
Message-ID: <20061018220509.GH19194@spearce.org>
References: <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz> <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181510510.1971@xanadu.home> <20061018191834.GA18829@spearce.org> <Pine.LNX.4.64.0610181525410.1971@xanadu.home> <20061018204626.GA19194@spearce.org> <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org> <20061018213225.GD19194@spearce.org> <Pine.LNX.4.64.0610181449290.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 00:05:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJXO-0006kB-EE
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 00:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423068AbWJRWFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 18:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423069AbWJRWFT
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 18:05:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58789 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1423068AbWJRWFR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 18:05:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GaJXB-0007Q3-Qo; Wed, 18 Oct 2006 18:05:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3346420E42A; Wed, 18 Oct 2006 18:05:10 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610181449290.3962@g5.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29288>

Linus Torvalds <torvalds@osdl.org> wrote:
> So I don't object to mmap windows at all. I object to them only in the 
> context of "they would allow us to use deltas between two different packs"
> discussion ;)

Having mmap windows or not has no impact on using deltas between
packs.  We already map multiple packs at once.  We just don't do
delta resolution between them, for the reasons you have already
given.

The two are totally unrelated.  I apologize for somehow making
yourself (and others) think they are.

-- 
Shawn.
