From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Strange message during fetch "remote: /2) done/2) done"
Date: Fri, 23 Feb 2007 12:17:56 -0500
Message-ID: <20070223171756.GB26731@spearce.org>
References: <200702231814.07598.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 23 18:18:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKe3Z-0001AU-Sr
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 18:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156AbXBWRSA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 12:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933157AbXBWRSA
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 12:18:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53065 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933156AbXBWRSA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 12:18:00 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HKe3P-0004eS-2U; Fri, 23 Feb 2007 12:17:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E42F720FBAE; Fri, 23 Feb 2007 12:17:56 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200702231814.07598.jnareb@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40452>

Jakub Narebski <jnareb@gmail.com> wrote:
> I got the following strange message during "git fetch origin":
> 
>  Auto-following refs/tags/gitgui-0.6.0
>  Auto-following refs/tags/gitgui-0.6.1
>  remote: Generating pack...
>  remote: Done counting 2 objects.
>  remote: Deltifying 2 objects.
>  remote: /2) done/2) done
>  Unpacking 2 objects

I see that sometimes too.  I think its just a buffering problem
from the sideband channel.

-- 
Shawn.
