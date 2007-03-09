From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] git-bundle: prevent overwriting existing bundles
Date: Thu, 8 Mar 2007 21:59:02 -0500
Message-ID: <20070309025902.GE32211@spearce.org>
References: <Pine.LNX.4.63.0703090348480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net,
	Mark Levedahl <mlevedahl@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 09 03:59:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPVK6-0007Fl-Mk
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 03:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbXCIC7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 21:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030859AbXCIC7K
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 21:59:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42998 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030500AbXCIC7J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 21:59:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPVJl-00059Q-5r; Thu, 08 Mar 2007 21:58:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2C88120FBAE; Thu,  8 Mar 2007 21:59:03 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703090348480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41783>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  	if (bundle_fd < 0)
> -		return error("Could not write to '%s'", path);
> +		return error("Could not create '%s'", path);

I hate to be a nit, but what about?

> +		return error("Could not create '%s': %s", path, strerror(errno));

-- 
Shawn.
