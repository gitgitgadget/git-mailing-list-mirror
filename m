From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: git-kill: rewrite history removing a commit
Date: Wed, 31 Jan 2007 22:54:02 +0200
Message-ID: <20070131205402.GH21097@mellanox.co.il>
References: <7v7iv3uelv.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 31 21:53:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCMSb-0001rC-NY
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 21:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030573AbXAaUxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 15:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030574AbXAaUxi
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 15:53:38 -0500
Received: from p02c11o145.mxlogic.net ([208.65.145.68]:51518 "EHLO
	p02c11o145.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030573AbXAaUxh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 15:53:37 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o145.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 1d101c54.2024582064.8102.00-004.p02c11o145.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Wed, 31 Jan 2007 13:53:37 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 31 Jan 2007 22:55:36 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Wed, 31 Jan 2007 22:53:01 +0200
Content-Disposition: inline
In-Reply-To: <7v7iv3uelv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 31 Jan 2007 20:55:37.0001 (UTC) FILETIME=[286E9190:01C7457A]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14970.000
X-TM-AS-Result: No--8.429700-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38295>

> When I find master~8 and master~9 to be undesirable, I would do:
> 
> 	$ git rebase --onto master~10 master~8
> 
> which rebuilds master~7 and onward on top of master~10, thereby
> dropping two commits.

That's good to know.
So it turns out I can just rewrite mine as a one-liner:
git-rebase --onto $1~1 $1

Thanks,

-- 
MST
