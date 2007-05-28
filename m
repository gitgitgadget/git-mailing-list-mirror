From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form after-the-fact annotations on commits
Date: Mon, 28 May 2007 17:19:56 -0400
Message-ID: <20070528211956.GA7044@spearce.org>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org> <200705271608.02122.johan@herland.net> <alpine.LFD.0.98.0705272131370.26602@woody.linux-foundation.org> <200705281254.23297.johan@herland.net> <7vps4kbrtb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 28 23:20:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsmdS-0003wB-S1
	for gcvg-git@gmane.org; Mon, 28 May 2007 23:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbXE1VUG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 17:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbXE1VUG
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 17:20:06 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58549 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbXE1VUE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 17:20:04 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hsmd4-0007K4-AG; Mon, 28 May 2007 17:19:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A6A1C20FBAE; Mon, 28 May 2007 17:19:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vps4kbrtb.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48644>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn graciously names
> his tags in git-gui project "gitgui-0.7.1", to avoid tag name
> collisions with "v1.5.0" style tag names in git.git project, but
> we could have stored his v0.7.1 tag as refs/tags/gitgui/v0.7.1
> to differenciate the tag namespace (this needs an update to the
> "tag following" code in git-fetch with a new configuration).

Actually I use that same naming convention everywhere else except
in egit.  I've found it easier to have the "major project name"
prefixed in front of the version number as it sort of reminds me
of what I'm looking at...  yes, I get confused easily.  There are
far too many "v1.0.0", "v1.0.1" around...  ;-)

-- 
Shawn.
