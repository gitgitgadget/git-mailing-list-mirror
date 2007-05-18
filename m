From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 15:46:09 +0300
Message-ID: <20070518124609.GH4708@mellanox.co.il>
References: <200705170539.11402.andyparkins@gmail.com> <200705181021.30062.andyparkins@gmail.com> <20070518110804.GD4708@mellanox.co.il> <200705181427.03598.Josef.Weidendorfer@gmx.de>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 18 15:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp28w-0007vN-37
	for gcvg-git@gmane.org; Fri, 18 May 2007 15:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbXERNFF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 09:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754426AbXERNFF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 09:05:05 -0400
Received: from p02c11o145.mxlogic.net ([208.65.144.78]:52989 "EHLO
	p02c11o145.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbXERNFE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 09:05:04 -0400
X-Greylist: delayed 1138 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 May 2007 09:05:04 EDT
Received: from unknown [194.90.237.34] (EHLO p02c11o145.mxlogic.net)
	by p02c11o145.mxlogic.net (mxl_mta-5.0.0-2)
	with ESMTP id 084ad464.1812450224.524037.00-541.p02c11o145.mxlogic.net (envelope-from <mst@dev.mellanox.co.il>);
	Fri, 18 May 2007 07:05:04 -0600 (MDT)
Received: from unknown [194.90.237.34]
	by p02c11o145.mxlogic.net (mxl_mta-5.0.0-2)
	with SMTP id f00ad464.2232044464.521751.00-017.p02c11o145.mxlogic.net (envelope-from <mst@dev.mellanox.co.il>);
	Fri, 18 May 2007 06:46:07 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.50]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 18 May 2007 15:46:30 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Fri, 18 May 2007 15:45:13 +0300
Content-Disposition: inline
In-Reply-To: <200705181427.03598.Josef.Weidendorfer@gmx.de>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 18 May 2007 12:46:30.0782 (UTC) FILETIME=[8EEC29E0:01C7994A]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-15182.003
X-TM-AS-Result: No--7.816200-4.000000-4
X-Spam: [F=0.0100000000; S=0.010(2007050201); SS=0.500]
X-MAIL-FROM: <mst@dev.mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47606>

> > What I *don't* want is a situation where the fact that original repository
> > resides in north america necessarily means that everyone who looks at *my* clone
> > of it will do a round trip to north america too.
> 
> Someone which clones from you probably does not have access to "~/gitrepo/linux26",
> so you have to provide a public visible URL either way, like
> 
>  [project "linux26"]
>    localurl = ~/gitrepo/linux26
>    url = git://myhost/mylinux26.git
> 
> and the "url" should be configured at the remote side at clone time.

Right. In other words, urls for each project are unversioned file, and git-daemon
needs to be taught to serve them up (I think it already serves head names, which are
unversioned too). Actually, can't something like what we do for remotes head
names work here as well?

-- 
MST
