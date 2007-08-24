From: "Jason Garber" <jgarber@ionzoft.com>
Subject: RE: empty directories
Date: Fri, 24 Aug 2007 12:10:10 -0500
Message-ID: <E7DE807861E8474E8AC3DC7AC2C75EE50329676F@34093-EVS2C1.exchange.rackspace.com>
References: <1187716461.5986.71.camel@beauty> <20070821134030.b763e9d3.seanlkml@sympatico.ca> <1187817948.5986.159.camel@beauty> <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 21:10:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOeYZ-0005q6-Kt
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 21:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763829AbXHXTKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 15:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764824AbXHXTKd
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 15:10:33 -0400
Received: from server107b.exghost.com ([207.97.244.177]:1544 "EHLO
	server107.appriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbXHXTKa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2007 15:10:30 -0400
X-Greylist: delayed 7201 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Aug 2007 15:10:30 EDT
Received: by server107.appriver.com (CommuniGate Pro PIPE 5.1.11)
  with PIPE id 88297554; Fri, 24 Aug 2007 13:10:27 -0400
Received: from [72.32.49.6] (HELO FE2.exchange.rackspace.com)
  by server107.appriver.com (CommuniGate Pro SMTP 5.1.11)
  with ESMTP id 88297448 for git@vger.kernel.org; Fri, 24 Aug 2007 13:10:13 -0400
Received: from 34093-EVS2C1.exchange.rackspace.com ([192.168.1.18]) by FE2.exchange.rackspace.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 24 Aug 2007 12:10:12 -0500
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: empty directories
Thread-Index: AcflE86QojIh6mT+T22bUvJpHvhzoABXYHDg
X-OriginalArrivalTime: 24 Aug 2007 17:10:12.0895 (UTC) FILETIME=[A21E82F0:01C7E671]
X-Policy: GLOBAL
X-Primary: jgarber@ionzoft.com
X-Note: This Email was scanned by AppRiver SecureTide
X-ALLOW: jgarber@ionzoft.com ALLOWED
X-Note: Spam Tests Failed: 
X-Country-Path: PRIVATE->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 72.32.49.6
X-Note-Reverse-DNS: fe2.exchange.rackspace.com
X-Note-WHTLIST: jgarber@ionzoft.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 70 80 
X-Note: Mail Class: ALLOWEDSENDER
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56592>

> But if .gitattributes would work, you probably could introduce both
full 
> permissions and ownership rules there. We read git attributes for
*other* 
> reasons when checking files out _anyway_, ie we need the CRLF
attribute 
> stuff, so adding ownership attributes would not be at all odd.
>
> 		Linus

And as a side-note, it would be quite trivial to write a script to
initially populate a .gitattributes file cleanly (and regen when
needed).

~ JasonG
