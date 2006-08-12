From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] make git compile on old version of engarde linux
Date: Sun, 13 Aug 2006 01:45:20 +0300
Message-ID: <20060812224520.GB13704@mellanox.co.il>
References: <7vac6etz5n.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 00:43:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GC2CT-0000xi-4J
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 00:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWHLWnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 18:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWHLWnW
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 18:43:22 -0400
Received: from mxl145v67.mxlogic.net ([208.65.145.67]:56277 "EHLO
	p02c11o144.mxlogic.net") by vger.kernel.org with ESMTP
	id S964968AbWHLWnV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Aug 2006 18:43:21 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o144.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id 9895ed44.1992022960.18428.00-007.p02c11o144.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Sat, 12 Aug 2006 16:43:21 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 13 Aug 2006 01:49:21 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Sun, 13 Aug 2006 01:45:20 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac6etz5n.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 12 Aug 2006 22:49:21.0421 (UTC) FILETIME=[8D0D6BD0:01C6BE61]
X-Spam: [F=0.1944351784; S=0.194(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25268>

Quoting r. Junio C Hamano <junkio@cox.net>:
> > This looks familiar; did the build error out when compiling
> > convert-objects.c by any chance? I suspect you have the same problem
> > that I encountered.  My fix was posted in "[PATCH 6/10] Fix header breakage
> > with _XOPEN_SOURCE."
> >
> > I have included my earlier mail message inline below, in case you wish
> > to confirm the that it fixes things for you too.
> 
> Alternatively Ramsay's _XOPEN_SOURCE patch is part of "next", so
> if it fixes the problem for you that would confirm the patch is
> a good one to have.
> 

BTW, would it make sense fr this patch to be cherry-picked into 1.4.8?
I guess the reason that LNK macros are under GNU_SOURCE is the following
text from stat(2):
 
       The S_ISLNK and S_ISSOCK macros
       are not in POSIX.1-1996, but both will be in the next  POSIX  standard;
       the former is from SVID 4v2, the latter from SUSv2.

-- 
MST
