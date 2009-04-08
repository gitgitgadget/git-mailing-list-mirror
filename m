From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: git checkout and pwd?
Date: Wed, 8 Apr 2009 14:12:37 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A99A3D6@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 08 20:16:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrcJb-0006uy-HQ
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 20:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765853AbZDHSO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 14:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764896AbZDHSO3
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 14:14:29 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:44285 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762193AbZDHSO2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2009 14:14:28 -0400
X-ASG-Debug-ID: 1239214454-7aac0323000e-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP id 4779F2D6C18
	for <git@vger.kernel.org>; Wed,  8 Apr 2009 14:14:16 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id qRpgqBKbZl7Zvfw1 for <git@vger.kernel.org>; Wed, 08 Apr 2009 14:14:16 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 8 Apr 2009 14:13:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: git checkout and pwd?
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git checkout and pwd?
Thread-Index: Acm4dZjbowYDpnMTTAmmWwb9iyIunw==
X-OriginalArrivalTime: 08 Apr 2009 18:13:17.0129 (UTC) FILETIME=[B0A88B90:01C9B875]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1239214456
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116104>

On a Windows system running msysgit, I entered the command:

	git checkout -b -l jmd/mt_queue

and got a reply of: 
fatal: git checkout: updating paths is incompatible with switching
branches.
Did you intend to checkout 'compile.vc8/Win32/release/jmd/mt_queue'
which can not be resolved as commit?

Is there something about this form of checkout that requires that it be
issued while in the "top level" directory of the project (i.e. the one
containing the .git subdirectory)?

--John
(sorry about the footer; it's not my idea)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
