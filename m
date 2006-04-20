From: Shawn Pearce <spearce@spearce.org>
Subject: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 09:36:40 -0400
Message-ID: <20060420133640.GA31198@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 20 15:37:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWZL4-0006LY-CQ
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 15:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWDTNgv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 09:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWDTNgv
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 09:36:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45719 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750956AbWDTNgu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 09:36:50 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FWZKn-0006sl-Qf
	for git@vger.kernel.org; Thu, 20 Apr 2006 09:36:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3FBC320FBB4; Thu, 20 Apr 2006 09:36:40 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18969>

Apparently I have created a repository which v1.2.3 packs about 50%
smaller than 'next' does:

  v1.2.3 (tag):
   60M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

  1.2.3.gf3a4 (an older 'next'):
  128M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

  1.3.0.rc4.g8060 (a fairly recent 'next'):
  118M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

Repeated packing with 1.3.0.rc4.g8060 doesn't seem to change the
size of the pack file, its pretty consistent at 118M.

Given that disk is pretty cheap these days I'm not concerned about
the 2x increase but thought I'd let folks know that the packing
improvements in 1.3.0 seem to have taken a small step backwards
with regards to this particular dataset.

I can make the repository available if somebody wants to look at it.

-- 
Shawn.
