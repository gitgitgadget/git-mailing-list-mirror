From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Mon, 5 Feb 2007 20:48:14 +0200
Message-ID: <20070205184814.GD15775@mellanox.co.il>
References: <7vmz3smqpp.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 19:47:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE8sZ-0003Ib-Cs
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 19:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933320AbXBESrr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 13:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933289AbXBESrr
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 13:47:47 -0500
Received: from p02c11o141.mxlogic.net ([208.65.145.64]:46670 "EHLO
	p02c11o141.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933328AbXBESrq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 13:47:46 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 2db77c54.2480208816.1726.00-007.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 05 Feb 2007 11:47:46 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.50]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 5 Feb 2007 20:49:50 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon,  5 Feb 2007 20:47:43 +0200
Content-Disposition: inline
In-Reply-To: <7vmz3smqpp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 05 Feb 2007 18:49:51.0017 (UTC) FILETIME=[6ABD8990:01C74956]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14978.003
X-TM-AS-Result: No--3.837500-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38767>

> Junio C Hamano <junkio@cox.net> writes:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 	git clone git://.../git.git#html
> >
> > to mean "just fetch the branch html, and check it out".
>
> Except that I do not particularly think the URL fragment
> notation is such a "cool" syntax.

OK, but I think it would be very good I think to have *some* URL-like syntax for
git-fetch etc - people are used to copying URLs out of mail (lots of MUAs even
highlight these nicely) so I often see that current syntax <URL> <branch> confuses
people: they seem to lose the branch and fetch/pull the wrong one.


-- 
MST
