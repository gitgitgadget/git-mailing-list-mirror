From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: Multiple pulls from the same branch in .git/remotes/origin
Date: Tue, 8 Aug 2006 00:05:45 +0300
Message-ID: <20060807210545.GC24206@mellanox.co.il>
References: <7vu04o1fwm.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 23:04:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GACGZ-000064-Jl
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 23:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWHGVEA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 17:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWHGVD7
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 17:03:59 -0400
Received: from mxl145v68.mxlogic.net ([208.65.145.68]:15258 "EHLO
	p02c11o145.mxlogic.net") by vger.kernel.org with ESMTP
	id S932371AbWHGVD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 17:03:58 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o145.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id ebaa7d44.2634312624.12262.00-001.p02c11o145.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 07 Aug 2006 15:03:58 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 8 Aug 2006 00:09:51 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Tue,  8 Aug 2006 00:05:45 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu04o1fwm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 07 Aug 2006 21:09:51.0859 (UTC) FILETIME=[D2D9CC30:01C6BA65]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25041>

Quoting r. Junio C Hamano <junkio@cox.net>:
> Subject: Re: Multiple pulls from the same branch in .git/remotes/origin
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> 
> >> It might not be too difficult to change it though.  This part of
> >> the code is relatively old and I do not remember the details
> >> offhand, other than I remember that the first time I saw it I
> >> had the same confused "Huh?  we do not let a ref fetched twice?"
> >> reaction ;-).
> >
> > At least, fix the error message?
> 
> That would touch the same vicinity of code so if I were to do
> that myself I would rather see if the restriction can be
> loosened properly first.

It seems that have to make path_match in connect.c return an array
of indexes for that to work. Right?

-- 
MST
