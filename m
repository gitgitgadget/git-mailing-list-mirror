From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: How to merge FETCH_HEAD?
Date: Wed, 17 Jan 2007 07:09:55 +0200
Message-ID: <20070117050955.GC4329@mellanox.co.il>
References: <Pine.LNX.4.63.0701162235200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 06:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H738y-0002M7-OY
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 06:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbXAQFPZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 00:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbXAQFPZ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 00:15:25 -0500
Received: from p02c11o144.mxlogic.net ([208.65.145.67]:59884 "EHLO
	p02c11o144.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbXAQFPY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 00:15:24 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o144.mxlogic.net (mxl_mta-4.0.2-1)
	with ESMTP id be0bda54.2659339184.56397.00-004.p02c11o144.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Tue, 16 Jan 2007 22:15:23 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 17 Jan 2007 07:11:16 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Wed, 17 Jan 2007 07:08:19 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701162235200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 17 Jan 2007 05:11:16.0594 (UTC) FILETIME=[EA6A1520:01C739F5]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14940.001
X-TM-AS-Result: No--8.820200-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36986>

> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Subject: Re: How to merge FETCH_HEAD?
> 
> Hi,
> 
> On Tue, 16 Jan 2007, Michael S. Tsirkin wrote:
> 
> > Would it be useful to have git-pull . FETCH_HEAD work?
> 
> No. FETCH_HEAD is local. And for local merges, you should use git-merge, 
> not git-pull.

But, that can not take FETCH_HEAD either.
Would it be useful for git-merge FETCH_HEAD to work?

-- 
MST
