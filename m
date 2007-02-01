From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Fri, 2 Feb 2007 01:01:00 +0200
Message-ID: <20070201230100.GL17617@mellanox.co.il>
References: <20070201220657.GB19271@fieldses.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 00:00:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCkv2-0002hG-6y
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 00:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422681AbXBAXAf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 18:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbXBAXAf
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 18:00:35 -0500
Received: from p02c11o143.mxlogic.net ([208.65.145.66]:59166 "EHLO
	p02c11o143.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422681AbXBAXAf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 18:00:35 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o143.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 21172c54.2106149808.6789.00-013.p02c11o143.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 01 Feb 2007 16:00:34 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 2 Feb 2007 01:02:34 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Fri,  2 Feb 2007 01:00:00 +0200
Content-Disposition: inline
In-Reply-To: <20070201220657.GB19271@fieldses.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 01 Feb 2007 23:02:34.0846 (UTC) FILETIME=[0F6F37E0:01C74655]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14972.000
X-TM-AS-Result: No--6.084300-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38423>

> Quoting J. Bruce Fields <bfields@fieldses.org>:
> Subject: Re: [PATCH] add --remote option to git-clone.
> 
> On Fri, Feb 02, 2007 at 12:01:22AM +0200, Michael S. Tsirkin wrote:
> > I'm often annoyed by the fact that when I clone from this repository,
> > I get a copy of all topic branches and origin tracking master
> > by default, when I actually might only want to work on a different
> > topic. And getting all extra branches is annoying on a slow connection.
> 
> Can you quantify "annoying"?
> 
> Not a challenge, I'm just curious--I would've thought that, for most
> projects, even with long-lived topic branches, it wouldn't be that
> expensive to get a second branch once you'd gotten one.

Shawn already answered that, I concur.

-- 
MST
