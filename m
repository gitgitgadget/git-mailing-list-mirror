From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: git log - filter missing changesets
Date: Thu, 17 Aug 2006 11:58:30 +0300
Message-ID: <20060817085830.GD2630@mellanox.co.il>
References: <7v7j17u4zw.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 10:59:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDdip-0007Sh-VA
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 10:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWHQI66 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 04:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWHQI66
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 04:58:58 -0400
Received: from mxl145v67.mxlogic.net ([208.65.145.67]:18312 "EHLO
	p02c11o144.mxlogic.net") by vger.kernel.org with ESMTP
	id S932355AbWHQI65 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 04:58:57 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o144.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id 1df24e44.2285652912.11108.00-001.p02c11o144.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 17 Aug 2006 02:58:57 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 17 Aug 2006 12:05:02 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu, 17 Aug 2006 11:58:30 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7j17u4zw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 17 Aug 2006 09:05:02.0781 (UTC) FILETIME=[39789ED0:01C6C1DC]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25559>

Quoting r. Junio C Hamano <junkio@cox.net>:
> Subject: Re: git log - filter missing changesets
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> 
> > Hi!
> > git log with -- parameter seems to sometimes miss changesets that
> > affect a specific directory:
> > ...
> > what gives?
> 
> Most likely history simplification threw away the entire side
> branch.
> 
> This is getting to be a FAQ I suspect.
> 
> http://thread.gmane.org/gmane.comp.version-control.git/21633
> 
> 

Yes, --full-history helps. Thanks!
I'm still not sure *when* does this simplification happen -
the changes that got hidden do not add/remove any files - but oh well.

BTW, --full-history does not seem to be documented on git-rev-list(1)
man page.

-- 
MST
