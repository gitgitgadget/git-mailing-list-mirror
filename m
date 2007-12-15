From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: One of my commits is missing
Date: Sat, 15 Dec 2007 17:29:26 -0500
Message-ID: <20071215222925.GM14735@spearce.org>
References: <47645232.7050502@vidanti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Luke Diamand <luke@vidanti.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 23:29:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3fW3-0007MZ-NI
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 23:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbXLOW33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 17:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbXLOW33
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 17:29:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49837 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbXLOW33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 17:29:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J3fVW-0003dg-KD; Sat, 15 Dec 2007 17:29:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 128D020FBAE; Sat, 15 Dec 2007 17:29:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47645232.7050502@vidanti.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68421>

Luke Diamand <luke@vidanti.com> wrote:
> 
> My last commit seems to have vanished, and I wonder if anyone knows 
> where it might have gone.
...
> Looking through my history I don't see any signs of errant git-reset's 
> so I'm baffled.


I'm baffled too.  Have a look at your HEAD reflog and see if you
can find it there (`git log -g`) as if you actually did in fact
create it with git-commit it should appear in that reflog for at
least the next 90 days (by default config anyway).

-- 
Shawn.
