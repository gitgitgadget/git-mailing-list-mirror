From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: Problem with clone hanging
Date: Mon, 7 Aug 2006 22:41:58 +0300
Message-ID: <20060807194158.GB24013@mellanox.co.il>
References: <6AB138A2AB8C8E4A98B9C0C3D52670E301FA761E@mtlexch01.mtl.com>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan O'Sullivan <bos@serpentine.com>,
	Erik Mouw <erik@harddisk-recovery.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 21:40:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAAxV-0008VP-Oh
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 21:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWHGTkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 15:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWHGTkN
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 15:40:13 -0400
Received: from mxl145v65.mxlogic.net ([208.65.145.65]:36557 "EHLO
	p02c11o142.mxlogic.net") by vger.kernel.org with ESMTP
	id S932316AbWHGTkL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 15:40:11 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o142.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id b1797d44.2248555440.1326.00-007.p02c11o142.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 07 Aug 2006 13:40:11 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 7 Aug 2006 22:46:05 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon,  7 Aug 2006 22:41:58 +0300
To: Tziporet Koren <tziporet@mellanox.co.il>
Content-Disposition: inline
In-Reply-To: <6AB138A2AB8C8E4A98B9C0C3D52670E301FA761E@mtlexch01.mtl.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 07 Aug 2006 19:46:05.0171 (UTC) FILETIME=[1EB61430:01C6BA5A]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25034>

BTW, it makes sense (much faster to) clone Linus' tree, then pull
ofed_1_1 from www.mellanox.co.il

Quoting r. Tziporet Koren <tziporet@mellanox.co.il>:
Subject: RE: Problem with clone hanging

OK we will upgrade our git installation (but it will be only tomorrow)
You are correct - we have not set HTTP interface. Really we wanted that this git will be hosted by Sandia server but their system admin has not yet set it up.

Meanwhile I can send you all sources in a tarball if you want.

Tziporet

-----Original Message-----
From: Bryan O'Sullivan [mailto:bos@serpentine.com] 
Sent: Monday, August 07, 2006 8:22 PM
To: Erik Mouw
Cc: git@vger.kernel.org; Tziporet Koren
Subject: Re: Problem with clone hanging

On Mon, 2006-08-07 at 19:12 +0200, Erik Mouw wrote:

> Looks like the same problem that kernel.org used to have. The other
> side probably runs git-1.4.0, they should upgrade to 1.4.1.

OK, thanks for the helpful response.

>  In the mean
> time, you could clone using http and later on switch to git transport.

It seems like Mellanox doesn't publish that repository over HTTP, so I'm
stuck.  Tziporet, can you upgrade your git installation, please?

	<b


-- 
MST
