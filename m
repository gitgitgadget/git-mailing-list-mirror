From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: parallel make problem with git
Date: Thu, 30 Aug 2007 09:50:29 +0300
Message-ID: <20070830065029.GE16312@mellanox.co.il>
References: <20070830063810.GD16312@mellanox.co.il> <7v7inda5ar.fsf@gitster.siamese.dyndns.org>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 08:50:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQdrU-0007OY-9U
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 08:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbXH3Guh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 02:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754192AbXH3Guh
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 02:50:37 -0400
Received: from p02c11o142.mxlogic.net ([208.65.144.75]:52250 "EHLO
	p02c11o142.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbXH3Guh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 02:50:37 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o142.mxlogic.net (mxl_mta-5.1.0-1)
	with ESMTP id cb866d64.2415262640.285189.00-005.p02c11o142.mxlogic.net (envelope-from <mst@dev.mellanox.co.il>);
	Thu, 30 Aug 2007 00:50:36 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.50]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Aug 2007 09:53:21 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu, 30 Aug 2007 09:49:45 +0300
Content-Disposition: inline
In-Reply-To: <7v7inda5ar.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 30 Aug 2007 06:53:21.0880 (UTC) FILETIME=[74504D80:01C7EAD2]
X-Spam: [F=0.0100000000; S=0.010(2007082901); SS=0.500]
X-MAIL-FROM: <mst@dev.mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57006>

> Quoting Junio C Hamano <gitster@pobox.com>:
> Subject: Re: parallel make problem with git
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> >     LINK test-chmtime
> > gcc: test-chmtime.o: No such file or directory
> > make: *** [test-chmtime] Error 1
> > make: *** Waiting for unfinished jobs....
> >
> > Any ideas?
> 
> Some missing dependencies, apparently.

Yes, I guessed as much :)

-- 
MST
