From: Jim Garrison <jim.garrison@nwea.org>
Subject: Beginner question on "Pull is mostly evil"
Date: Wed, 7 May 2014 15:40:28 +0000
Message-ID: <0C723FEB5B4E5642B25B451BA57E2730751C2642@S1P5DAG3C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 07 17:50:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi46t-0006fD-0X
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 17:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933174AbaEGPuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 11:50:12 -0400
Received: from gwo1.mbox.net ([165.212.64.21]:33602 "EHLO gwo1.mbox.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933010AbaEGPuJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 May 2014 11:50:09 -0400
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 May 2014 11:50:09 EDT
Received: from gwo1.mbox.net (localhost [127.0.0.1])
	by gwo1.mbox.net (Postfix) with ESMTP id 3gP27t42TWz18ZHJN
	for <git@vger.kernel.org>; Wed,  7 May 2014 15:40:42 +0000 (UTC)
X-USANET-Received: from gwo1.mbox.net [127.0.0.1] by gwo1.mbox.net via mtad (C8.MAIN.3.82G) 
	with ESMTP id 868segPOl5776Mo1; Wed, 07 May 2014 15:40:37 -0000
X-USANET-Routed: 5 gwsout-gwsd Q:gwsd
X-USANET-Routed: 3 gwsout-vs Q:bmvirus
X-USANET-GWS2-Tenant: nwea.org
X-USANET-GWS2-Tagid: NWEA
Received: from S1P5HUB5.EXCHPROD.USA.NET [165.212.120.254] by gwo1.mbox.net via smtad (C8.MAIN.3.96E) 
	with ESMTPS id XID821segPOM5093Xo1; Wed, 07 May 2014 15:40:37 -0000
X-USANET-Source: 165.212.120.254 OUT  jim.garrison@nwea.org S1P5HUB5.EXCHPROD.USA.NET TLS
X-USANET-MsgId: XID821segPOM5093Xo1
Received: from S1P5DAG3C.EXCHPROD.USA.NET ([169.254.3.187]) by
 S1P5HUB5.EXCHPROD.USA.NET ([10.120.223.35]) with mapi id 14.03.0181.006; Wed,
 7 May 2014 03:40:28 -1200
Thread-Topic: Beginner question on "Pull is mostly evil"
Thread-Index: Ac9qCIDoQWjB4uHUT6CmMgphMC+2gw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.98.171.2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248328>

During my initial self-education I came across the maxim "don't pull, fetch+merge instead" and have been doing that.  I think I followed most of the "pull is (mostly) evil" discussion but one facet still puzzles me: the idea that pull will do a merge "in the wrong direction" sometimes.

Do I understand correctly that this occurs only in the presence of multiple remotes?  
Can someone provide a simple example of a situation where pull would do the "wrong" thing?

Thanks
