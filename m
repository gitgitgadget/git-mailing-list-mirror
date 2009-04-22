From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: What's going on here?  Bad repo, no error locally?
Date: Tue, 21 Apr 2009 20:18:22 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70ACE053E@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 02:20:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwQCo-0000oT-0A
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 02:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbZDVAS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 20:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753753AbZDVAS2
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 20:18:28 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:42210 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbZDVAS0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 20:18:26 -0400
X-ASG-Debug-ID: 1240359505-53d501ef0000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam & Virus Firewall) with ESMTP id 996BF368CA5
	for <git@vger.kernel.org>; Tue, 21 Apr 2009 20:18:25 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id YaIfRtEW2CR1zFIB for <git@vger.kernel.org>; Tue, 21 Apr 2009 20:18:25 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 21 Apr 2009 20:18:25 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
x-cr-hashedpuzzle: BsYA BtWZ CuD8 DZLL E0hY FKbE F68M GSjP GhTG HCkw HN26 HsVA IY7Q JGcj K2vv K41w;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{B8427D55-66FE-4CE7-B9A8-AEA1CA382A3D};agBkAGwAdQBnAG8AcwB6AEAAdAByAGEAZABlAHMAdABhAHQAaQBvAG4ALgBjAG8AbQA=;Wed, 22 Apr 2009 00:18:22 GMT;VwBoAGEAdAAnAHMAIABnAG8AaQBuAGcAIABvAG4AIABoAGUAcgBlAD8AIAAgAEIAYQBkACAAcgBlAHAAbwAsACAAbgBvACAAZQByAHIAbwByACAAbABvAGMAYQBsAGwAeQA/AA==
Content-class: urn:content-classes:message
x-cr-puzzleid: {B8427D55-66FE-4CE7-B9A8-AEA1CA382A3D}
X-ASG-Orig-Subj: What's going on here?  Bad repo, no error locally?
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: What's going on here?  Bad repo, no error locally?
Thread-Index: AcnC39ivCaDKjyMbTLSr+iSqq7jfcw==
X-OriginalArrivalTime: 22 Apr 2009 00:18:25.0125 (UTC) FILETIME=[DA363150:01C9C2DF]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1240359505
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117164>

Developer B runs git fsck --full, gets no errors but one dangling blob.
Does a push.  No errors.
Now, on the upstream repo, I run fsck, and find a bunch of danglings (as
always) and a missing blob.
Any fetch from that repo will fail, due to that missing blob.

What's going on?  How can I fix his local repository, other than blow it
away and start over, and copy his current files over and rebuild the few
commits of interest?

--John

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
