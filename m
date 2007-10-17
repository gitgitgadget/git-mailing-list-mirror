From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] gitweb: speed up project listing by limiting find depth
Date: Tue, 16 Oct 2007 21:35:06 -0400
Message-ID: <20071017013506.GM13801@spearce.org>
References: <1192583606-14893-1-git-send-email-git@vicaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pasky@suse.cz
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 03:35:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihxoi-0000e1-00
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 03:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761669AbXJQBfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 21:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755636AbXJQBfM
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 21:35:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50237 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbXJQBfK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 21:35:10 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhxoH-0004WG-4s; Tue, 16 Oct 2007 21:34:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B3C7C20FBCF; Tue, 16 Oct 2007 21:35:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1192583606-14893-1-git-send-email-git@vicaya.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61303>

Luke Lu <git@vicaya.com> wrote:
> Resubmit patch due to tab/space issue :)

Thanks, I have this locally from your prior version but already
had fixed the tab/space problem.

> +GITWEB_PROJECT_MAXDEPTH = 2007

Cute.  But does what I was asking for, which was to not change
behavior for existing users.  Most folks have a MAX_PATH around
1024-4096.  There's no sane way they would exceed 2000 nested
directories.

-- 
Shawn.
