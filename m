From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Opinions on bug fix organisation
Date: Wed, 16 May 2007 17:38:19 -0400
Message-ID: <20070516213819.GT3141@spearce.org>
References: <200705161138.30134.andyparkins@gmail.com> <7v1whgfybe.fsf@assigned-by-dhcp.cox.net> <200705162220.15417.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 23:38:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoRCY-0000vG-1g
	for gcvg-git@gmane.org; Wed, 16 May 2007 23:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbXEPViZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 17:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758918AbXEPViY
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 17:38:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38196 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860AbXEPViY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 17:38:24 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HoRCG-0000n7-Ec; Wed, 16 May 2007 17:38:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2127F20FBAE; Wed, 16 May 2007 17:38:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200705162220.15417.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47458>

Andy Parkins <andyparkins@gmail.com> wrote:
> What is your preference when, for example, you have already merged a 
> topic to next but then a bug fix appears?
> 
>  * -- * -- * -- M -- F         * -- * -- * -- M -- m (next)
>                /        or                   /    /
>     B -- * -- *                   B -- * -- * -- F (topic)
> 
> F is certainly most appropriate to be on the topic branch, but we create 
> a perhaps excessively verbose extra merge, m.

Look at the history of the next branch; the diagram on the right is
exactly what Junio does.  When topic finally graduates to master,
only F is merged to master, making master's own history not show
that "verbose extra merge" m.  Or M really for that matter, as
master gets its own M'.

-- 
Shawn.
