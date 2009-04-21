From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: Strange, can't push
Date: Tue, 21 Apr 2009 17:21:15 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70ACE04E4@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 23:30:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwNXa-0003EX-IY
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 23:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbZDUV12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 17:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbZDUV12
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 17:27:28 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:46430 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbZDUV12 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 17:27:28 -0400
X-ASG-Debug-ID: 1240349229-1f3c01200002-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam & Virus Firewall) with ESMTP id B98ED366A3B
	for <git@vger.kernel.org>; Tue, 21 Apr 2009 17:27:09 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id CuBNPLMKPoQnc7o1 for <git@vger.kernel.org>; Tue, 21 Apr 2009 17:27:09 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 21 Apr 2009 17:26:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: Strange, can't push
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Strange, can't push
Thread-Index: AcnCxxqOoxaR00xrS8WSn/Z1LIPW0w==
X-OriginalArrivalTime: 21 Apr 2009 21:26:15.0531 (UTC) FILETIME=[CD4B3BB0:01C9C2C7]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1240349229
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117158>

Locally, the view in gitk, after fetching, is that branch B is one
commit ahead of remotes/pub/B.  But doing a push doesn't advance it.
Pushing to another label did get it there, under that name.

Is this another "sorry about msysgit" thing, or is it something that
might happen from time to time that someone might explain to me?

My work-around is to go to that remote repository and delete and rename
the branch from the successful temp I did push.

Could it have something to do with the remote repository not being
"bare"?  Or with the responses being too slow?  

--John

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
