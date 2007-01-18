From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add --summary to git-format-patch by default
Date: Wed, 17 Jan 2007 20:04:40 -0500
Message-ID: <20070118010440.GA23124@spearce.org>
References: <7vk5zlqqum.fsf@assigned-by-dhcp.cox.net> <7vac0hqq33.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 02:04:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Li0-0003kB-6r
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 02:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbXARBEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 20:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbXARBEp
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 20:04:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55655 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbXARBEp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 20:04:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H7Lhg-0008Hl-As; Wed, 17 Jan 2007 20:04:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B3E9120FBAE; Wed, 17 Jan 2007 20:04:40 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac0hqq33.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37052>

Junio C Hamano <junkio@cox.net> wrote:
> This adds --summary output in addition to the --stat to the
> output from git-format-patch by default.
>    Opinions?

This is the right thing to do.  format-patch should default to
both --summary and --stat.

-- 
Shawn.
