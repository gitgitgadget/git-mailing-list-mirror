From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] mailinfo: accept >From in message header
Date: Fri, 28 Jul 2006 00:32:52 +0300
Message-ID: <20060727213251.GA17234@mellanox.co.il>
References: <7vbqraoi9s.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 27 23:31:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6DSC-00087D-Sa
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 23:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWG0Vbe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 17:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWG0Vbe
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 17:31:34 -0400
Received: from mxl145v69.mxlogic.net ([208.65.145.69]:53467 "EHLO
	p02c11o146.mxlogic.net") by vger.kernel.org with ESMTP
	id S1750968AbWG0Vbd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 17:31:33 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o146.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id 4b039c44.2384595888.114748.00-002.p02c11o146.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 27 Jul 2006 15:31:32 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 28 Jul 2006 00:37:12 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Fri, 28 Jul 2006 00:32:52 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqraoi9s.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 27 Jul 2006 21:37:12.0406 (UTC) FILETIME=[D2262760:01C6B1C4]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24349>

Quoting r. Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] mailinfo: accept >From in message header
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> 
> > From Majordomo@vger.kernel.org  Thu Jul 27 16:39:36 2006
> >>From mtsirkin  Thu Jul 27 16:39:36 2006
> > Received: from yok.mtl.com [10.0.8.11]
> > ....
> >
> > which confuses git-mailinfo since that does not recognize >From
> > as a valid header line. The following patch makes git-applymbox
> > work for me:
> 
> Wouldn't that kind of breakage confuse git-mailsplit as well?
> 

Hmm - I normally don't use it - just pipe stiff from mutt into git-applymbox.
A quick test seems to indicate git-mailsplit works fine.

But why should it - mailsplit just needs ^From to match new mail,
correct? So the escaped >From is good for it.

-- 
MST
