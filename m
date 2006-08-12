From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
Date: Sun, 13 Aug 2006 01:39:47 +0300
Message-ID: <20060812223947.GA13704@mellanox.co.il>
References: <7vr6zsywmq.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 00:38:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GC27C-0000Cp-0u
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 00:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWHLWhs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 18:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWHLWhs
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 18:37:48 -0400
Received: from mxl145v66.mxlogic.net ([208.65.145.66]:60332 "EHLO
	p02c11o143.mxlogic.net") by vger.kernel.org with ESMTP
	id S964888AbWHLWhr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Aug 2006 18:37:47 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o143.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id b385ed44.2584509360.10955.00-002.p02c11o143.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Sat, 12 Aug 2006 16:37:47 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 13 Aug 2006 01:43:47 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Sun, 13 Aug 2006 01:39:47 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr6zsywmq.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 12 Aug 2006 22:43:47.0937 (UTC) FILETIME=[C647CD10:01C6BE60]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25267>

Quoting r. Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> 
> > The following seems to fix this issue: simply scan the full
> > refspec list for each remote instead of breaking on the first match.
> > I had to touch the git-fetch.sh script as well as it is scanning
> > the remote list, too. Works for me.
> 
> Looks Ok, although I have to admit I just gave a cursory look.
> Thanks.
> 

Could this go into next then? 

-- 
MST
