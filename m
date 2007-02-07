From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] add -C[NUM] to git-am
Date: Wed, 7 Feb 2007 23:19:10 +0200
Message-ID: <20070207211910.GK12140@mellanox.co.il>
References: <7vejp17m3t.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 22:19:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEuCA-0002Wg-Tx
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 22:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422781AbXBGVSn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 16:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422786AbXBGVSn
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 16:18:43 -0500
Received: from p02c11o146.mxlogic.net ([208.65.145.69]:50617 "EHLO
	p02c11o146.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422783AbXBGVSm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 16:18:42 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o146.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 1324ac54.1927732144.5305.00-008.p02c11o146.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Wed, 07 Feb 2007 14:18:41 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 7 Feb 2007 23:20:48 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Wed,  7 Feb 2007 23:16:30 +0200
Content-Disposition: inline
In-Reply-To: <7vejp17m3t.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 07 Feb 2007 21:20:48.0986 (UTC) FILETIME=[D6896BA0:01C74AFD]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14984.001
X-TM-AS-Result: No--12.964500-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38971>

> Quoting r. Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] add -C[NUM] to git-am
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> 
> > Add -C[NUM] to git-am so that patches can be applied even
> > if context has changed a bit.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
> >
> > ---
> >
> > I just had to apply a largish number of patches on a project
> > that has evolved since, and I found the following to be useful.
> >
> > What do others think.
> 
> FWIW, I am in favor although I do not foresee myself ever using
> it.  However, this has slight ramifications.
> 
>  - we will be keeping applymbox after all.  shouldn't this be
>    side-ported to it?

OK.

>  - am is used as a workhorse for rebase.  shouldn't this be
>    accessible through its command line as well?

How will it be used?

-- 
MST
