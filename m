From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Allow non-fast-forward of remote tracking branches in default clone
Date: Thu, 28 Dec 2006 23:35:25 -0500
Message-ID: <20061229043525.GC12072@spearce.org>
References: <1167251519.2247.10.camel@dv> <7vfyb159dn.fsf@assigned-by-dhcp.cox.net> <1167341346.12660.17.camel@dv> <7vzm97tzbt.fsf@assigned-by-dhcp.cox.net> <7vk60btucu.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 05:35:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H09Sv-00013J-2P
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 05:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbWL2Ef3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 23:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753561AbWL2Ef3
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 23:35:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:61000 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbWL2Ef3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 23:35:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H09SD-0008UG-8N; Thu, 28 Dec 2006 23:34:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0929A20FB65; Thu, 28 Dec 2006 23:35:26 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk60btucu.fsf_-_@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35580>

Junio C Hamano <junkio@cox.net> wrote:
> This changes the default remote.origin.fetch configuration
> created by git-clone so that it allows non-fast-forward updates.

Ack'd, but only if '[PATCH 1/2] core.logallrefupdates: log remotes/
tracking branches.' is also applied.

I think both are worth applying.

-- 
Shawn.
