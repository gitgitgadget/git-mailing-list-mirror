From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: undoing something
Date: Mon, 16 Mar 2009 15:06:31 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A2AEFA4@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 20:08:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjIAx-0005Rv-LN
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 20:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbZCPTHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 15:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbZCPTHJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 15:07:09 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:55819 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbZCPTHI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 15:07:08 -0400
X-ASG-Debug-ID: 1237230424-48a701690000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP id 6955E216E32
	for <git@vger.kernel.org>; Mon, 16 Mar 2009 15:07:04 -0400 (EDT)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id jXW7Eel5f67yEoXv for <git@vger.kernel.org>; Mon, 16 Mar 2009 15:07:04 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Mar 2009 15:07:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: undoing something
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: undoing something
Thread-Index: AcmmalFaRr6H17RrQBGIGliu4j0P8A==
X-OriginalArrivalTime: 16 Mar 2009 19:07:03.0565 (UTC) FILETIME=[64435BD0:01C9A66A]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1237230424
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113355>

I made a mistake.  Big deal, now that I know that git storage is
immutable and changes just add to what's already there.  

A quick look at
	git reflog show topic
tells me that {1} is the one I want.  So, how do I rewind branch topic
to point to topic@{1} ?
I did it by making a tag, and then in gitk pointing to it and picking
"reset to here" from the context menu.  

A while back I was looking for the right/easy way to simply repoint my
branch to where I wanted.  The best answer was to use push.  But, I
wonder if gitk and other high-level commands simply call a more
primitive command that does this?  And can I call it directly?  Or is
push with a dot as the repository just doing this with no excessive
processing and trust that the side-effects are all vacuous?

--John
(please excuse the footer; it's not my choice)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
