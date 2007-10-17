From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/6] more compact progress display
Date: Wed, 17 Oct 2007 02:37:27 -0400
Message-ID: <20071017063727.GX13801@spearce.org>
References: <1192586150-13743-1-git-send-email-nico@cam.org> <1192586150-13743-2-git-send-email-nico@cam.org> <4715ACE4.9080907@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 17 08:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii2XG-00086Z-El
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 08:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbXJQGhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 02:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753411AbXJQGhc
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 02:37:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59277 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbXJQGhb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 02:37:31 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ii2X2-0002vx-8W; Wed, 17 Oct 2007 02:37:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 568E420FBAE; Wed, 17 Oct 2007 02:37:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4715ACE4.9080907@viscovery.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61339>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Nicolas Pitre schrieb:
> >-		start_progress_delay(&progress, "Checking %u files out...",
> >-				     "", total, 50, 2);
> >+		start_progress_delay(&progress, "Checking files out",
> >+				     total, 50, 2);
> 
> While you are here, could you make that "Checking out files", please?

I'll amend it right now.  I'm finishing up building my nightly
update to git/spearce.git and this is about to go into next.
So... you just caught me in time to do an amend.  :-)

-- 
Shawn.
