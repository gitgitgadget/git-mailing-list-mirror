From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: git rebase: unexpected conflict
Date: Wed, 7 Feb 2007 23:14:22 +0200
Message-ID: <20070207211422.GH12140@mellanox.co.il>
References: <7vabzp7lgs.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 22:14:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEu7J-0000Qk-5N
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 22:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422750AbXBGVOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 16:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422771AbXBGVOI
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 16:14:08 -0500
Received: from p02c11o145.mxlogic.net ([208.65.145.68]:55376 "EHLO
	p02c11o145.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422750AbXBGVOG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 16:14:06 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o145.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id e114ac54.2216819632.6822.00-013.p02c11o145.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Wed, 07 Feb 2007 14:14:06 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 7 Feb 2007 23:16:00 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Wed,  7 Feb 2007 23:11:42 +0200
Content-Disposition: inline
In-Reply-To: <7vabzp7lgs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 07 Feb 2007 21:16:00.0442 (UTC) FILETIME=[2A8D19A0:01C74AFD]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14984.001
X-TM-AS-Result: No--10.738400-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38970>

> > git-show can not limit its output to just the part of patch
> > that affects the list of files I give, the way git-diff can.
> > Would such an extension be a good idea?
> 
> It is a good idea and I think it is implemented.
> 
> 	$ git-show <commit>... --- <paths>

Yes, this works. But this seems undocumented. Right?

-- 
MST
