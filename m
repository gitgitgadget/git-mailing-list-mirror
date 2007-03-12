From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Distignuish between commit id and key in commit cache
Date: Mon, 12 Mar 2007 17:05:40 -0400
Message-ID: <20070312210540.GA16513@spearce.org>
References: <20070312175115.10884.87646.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 22:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQril-00029z-VC
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 22:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbXCLVFq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 17:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752952AbXCLVFq
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 17:05:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54763 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949AbXCLVFp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 17:05:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQri1-0007Ab-KF; Mon, 12 Mar 2007 17:05:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0CA0120FBAE; Mon, 12 Mar 2007 17:05:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070312175115.10884.87646.stgit@lathund.dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42081>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> See WeakHashMap documentation. If the key is the same object
> as the objectid the keys can never be collected.

Thanks.  I have applied this in the middle of your other recent
series, tagged 0.2.1 and pushed it out to the usual locations.
The history view looks pretty nice...  and is reasonably quick too!

-- 
Shawn.
