From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Thu, 1 Feb 2007 14:13:23 -0500
Message-ID: <20070201191323.GA18608@spearce.org>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 01 20:13:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HChNf-0005aB-GC
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 20:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422946AbXBATNb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 14:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422950AbXBATNb
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 14:13:31 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39239 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422946AbXBATNa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 14:13:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HChN1-0007t2-6E; Thu, 01 Feb 2007 14:13:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E232D20FBAE; Thu,  1 Feb 2007 14:13:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38388>

Nicolas Pitre <nico@cam.org> wrote:
> The work in progress to enable separate reflog for HEAD will make it
> independent from reflog of any branch HEAD might be pointing to. In
> the mean time disallow HEAD@{...} until that work is completed. Otherwise
> people might get used to the current behavior which makes HEAD@{...} an
> alias for <current_branch>@{...} which won't be the case later.

I happen to really like the fact that HEAD@{...} is an alias for
<current_branch>@{...}.

But now that HEAD will soon be getting its own reflog, I guess I
better relearn how to type <current_branch>.  :-)

-- 
Shawn.
