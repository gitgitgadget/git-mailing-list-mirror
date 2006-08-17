From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: RFC: git pull <remote> making an octopus?
Date: Thu, 17 Aug 2006 12:46:47 +0300
Message-ID: <20060817094647.GG2630@mellanox.co.il>
References: <7v1wrfu3tl.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 11:47:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDeTS-0005nE-F8
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWHQJrR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWHQJrR
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:47:17 -0400
Received: from mxl145v69.mxlogic.net ([208.65.145.69]:64408 "EHLO
	p02c11o146.mxlogic.net") by vger.kernel.org with ESMTP
	id S964791AbWHQJrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 05:47:16 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o146.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id 32b34e44.2437335984.14042.00-002.p02c11o146.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 17 Aug 2006 03:47:15 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 17 Aug 2006 12:53:21 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu, 17 Aug 2006 12:46:49 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wrfu3tl.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 17 Aug 2006 09:53:21.0453 (UTC) FILETIME=[F936DDD0:01C6C1E2]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25576>

Quoting r. Junio C Hamano <junkio@cox.net>:
> > No, I just reproduced this on plain 1.4.2.
> 
> Doesn't reproduce for me and I am getting worried.

No, that was my mistake, sorry about not clarifying that.

Basically what confused me was the following text in get-fetch manpage:

	While git-pull  run  without  any  explicit <refspec> parameter takes
	default <refspec>s from Pull: lines, it merges only  the  first
	<refspec> found into the current branch, after fetching all the remote
	refs.

And this actually applied to remotes in $GITDIR/remotes and not just
when git-pull is run without any parameters.

-- 
MST
