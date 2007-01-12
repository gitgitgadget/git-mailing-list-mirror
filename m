From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] reflog-expire: brown paper bag fix.
Date: Thu, 11 Jan 2007 23:02:01 -0500
Message-ID: <20070112040200.GA24195@spearce.org>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net> <7vzm8ox5dn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 05:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5DcJ-0003St-O2
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 05:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbXALECI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 23:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbXALECH
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 23:02:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47888 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030445AbXALECG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 23:02:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5Dc4-0003Qr-Dx; Thu, 11 Jan 2007 23:01:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7C05820FBAE; Thu, 11 Jan 2007 23:02:01 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzm8ox5dn.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36657>

Junio C Hamano <junkio@cox.net> wrote:
> When --stale-fix is not passed, the code did not initialize the
> two commit objects properly.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
>  * If you see Segfault from "git gc", it would have left two
>    .lock files under .git/refs/ and .git/logs/refs; your
>    repository has not be corrupted with this.  Please remove the
>    two leftover .lock files by hand, apply this patch and
>    re-run.

Thanks for fixing this Junio.  I noticed it myself today and meant
to debug it, but haven't had a chance to do it yet.

-- 
Shawn.
