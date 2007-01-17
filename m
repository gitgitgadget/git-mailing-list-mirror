From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: How to merge FETCH_HEAD?
Date: Wed, 17 Jan 2007 08:33:53 +0200
Message-ID: <20070117063353.GF30926@mellanox.co.il>
References: <7vk5zmtc1n.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 07:33:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H74Ml-00020R-SD
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 07:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbXAQGde (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 01:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbXAQGde
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 01:33:34 -0500
Received: from p02c11o141.mxlogic.net ([208.65.145.64]:39349 "EHLO
	p02c11o141.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbXAQGdc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 01:33:32 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-4.0.2-1)
	with ESMTP id b33cda54.2710879152.29988.00-004.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Tue, 16 Jan 2007 23:33:31 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 17 Jan 2007 08:35:15 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Wed, 17 Jan 2007 08:32:17 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk5zmtc1n.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 17 Jan 2007 06:35:15.0233 (UTC) FILETIME=[A5AD6110:01C73A01]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14940.001
X-TM-AS-Result: No--13.689900-4.000000-2
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36988>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: How to merge FETCH_HEAD?
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> 
> >> No. FETCH_HEAD is local. And for local merges, you should use git-merge, 
> >> not git-pull.
> >
> > But, that can not take FETCH_HEAD either.
> > Would it be useful for git-merge FETCH_HEAD to work?
> 
> Please try again, starting from the "git fetch".
> 
> I suspect the reason you think "merge FETCH_HEAD" does not work
> is because you lost FETCH_HEAD when you did "git pull . FETCH_HEAD",
> as I explained to you in an earlier message.

Yes, that was it, thanks!

-- 
MST
