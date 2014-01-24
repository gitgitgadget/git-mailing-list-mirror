From: Jim Garrison <jim.garrison@nwea.org>
Subject: RE: Globbing for ignored branches?
Date: Fri, 24 Jan 2014 16:37:41 +0000
Message-ID: <0C723FEB5B4E5642B25B451BA57E273075148284@S1P5DAG3C.EXCHPROD.USA.NET>
References: <20140124090104.GA396@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 24 17:37:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6jlQ-0002E9-RR
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 17:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbaAXQhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 11:37:48 -0500
Received: from gwo1.mbox.net ([165.212.64.21]:44412 "EHLO gwo1.mbox.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbaAXQhs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jan 2014 11:37:48 -0500
Received: from gwo1.mbox.net (localhost [127.0.0.1])
	by gwo1.mbox.net (Postfix) with ESMTP id 3f9mHH3mnNz18WgLB
	for <git@vger.kernel.org>; Fri, 24 Jan 2014 16:37:47 +0000 (UTC)
X-USANET-Received: from gwo1.mbox.net [127.0.0.1] by gwo1.mbox.net via mtad (C8.MAIN.3.82G) 
	with ESMTP id 504saXqlQ8960Mo1; Fri, 24 Jan 2014 16:37:42 -0000
X-USANET-Routed: 5 gwsout-gwsd Q:gwsd
X-USANET-Routed: 3 gwsout-vs Q:bmvirus
X-USANET-GWS2-Tenant: nwea.org
X-USANET-GWS2-Tagid: NWEA
Received: from S1P5HUB5.EXCHPROD.USA.NET [165.212.120.254] by gwo1.mbox.net via smtad (C8.MAIN.3.94H) 
	with ESMTPS id XID517saXqlr0866Xo1; Fri, 24 Jan 2014 16:37:42 -0000
X-USANET-Source: 165.212.120.254 OUT  jim.garrison@nwea.org S1P5HUB5.EXCHPROD.USA.NET TLS
X-USANET-MsgId: XID517saXqlr0866Xo1
Received: from S1P5DAG3C.EXCHPROD.USA.NET ([169.254.3.130]) by
 S1P5HUB5.EXCHPROD.USA.NET ([10.120.223.35]) with mapi id 14.03.0174.001; Fri,
 24 Jan 2014 04:37:42 -1200
Thread-Topic: Globbing for ignored branches?
Thread-Index: AQHPGOPoobqMqkPcz0ei9YGpaZtoA5qUEthw
In-Reply-To: <20140124090104.GA396@x4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.98.171.2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241013>

> -----Original Message-----
> Behalf Of Markus Trippelsdorf
> Sent: Friday, January 24, 2014 1:01 AM
> Subject: Globbing for ignored branches?
> 
> I would like to ignore branches that match a certain pattern, e.g.:
[snip]
> 
> Is it possible to ignore all branches that match "hjl"?
 

If you mean ignore them when you do "git branch -a", then

git branch -a |grep -v hjl

If you mean "ignore" in some other scenario you need to be more specific about what you want.
