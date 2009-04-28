From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: Windows Server?
Date: Tue, 28 Apr 2009 18:41:51 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70AE3F0A6@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 00:43:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyw0z-0004F1-C2
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 00:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbZD1Wmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 18:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753104AbZD1Wmu
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 18:42:50 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:58105 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbZD1Wmt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 18:42:49 -0400
X-ASG-Debug-ID: 1240958568-779502ca000a-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam & Virus Firewall) with ESMTP id AAD953B8830
	for <git@vger.kernel.org>; Tue, 28 Apr 2009 18:42:48 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id Njl1zFmrDFHkyfG9 for <git@vger.kernel.org>; Tue, 28 Apr 2009 18:42:48 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Apr 2009 18:41:57 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: Windows Server?
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Windows Server?
Thread-Index: AcnIUoXsAI98pzaNTqKLHcv2UoHNjA==
X-OriginalArrivalTime: 28 Apr 2009 22:41:57.0494 (UTC) FILETIME=[89680960:01C9C852]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1240958568
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117825>

We are a Windows' shop, writing software that runs on Windows.
Naturally, the network location I.T. provided for the repository is on a
Windows server.  I'm concerned with using file:// access once everyone
starts using it in earnest, especially over a cross-continent VPN.

I suppose that git-daemon isn't available as a Windows service.  I
posted a short time ago asking about it, and the news did not seem good.
So, is ssh a good second?  That is, the manipulations of the central
repo is being done by the machine that owns that disk, and the protocol
talks between the two copies of git?

Is there anything that needs to be done on the server machine, other
than having a SSH server, and formulating the path the way the disk
really is on that machine (as opposed to the network share structure)?

--John
(watch out for the footer...)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
