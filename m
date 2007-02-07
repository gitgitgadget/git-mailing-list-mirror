From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 7 Feb 2007 18:03:17 -0500
Message-ID: <20070207230317.GC1970@spearce.org>
References: <17866.20355.744025.133326@lisa.zopyra.com> <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org> <7vd54l60gg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 00:03:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEvp0-0003RN-R1
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 00:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161457AbXBGXDX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 18:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161472AbXBGXDX
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 18:03:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46224 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161457AbXBGXDW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 18:03:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEvoj-0003oi-UB; Wed, 07 Feb 2007 18:03:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D481820FBAE; Wed,  7 Feb 2007 18:03:17 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vd54l60gg.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38995>

Junio C Hamano <junkio@cox.net> wrote:
> 	$ git log -g?

	[git (build)]$ git log -g?
	fatal: unrecognized argument: -g?

I think its:

	[git (build)]$ git log -g ?
	commit 6506e156d99bd406661cd5d2e502db7c0960d716
	Reflog: HEAD@{0} (Shawn O. Pearce <spearce@spearce.org>)
	Reflog message: merge origin/master: Fast forward
	Author: Junio C Hamano <junkio@cox.net>
	...

at least with bash.  :-)

-- 
Shawn.
