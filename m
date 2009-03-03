From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: More on "fast foward"
Date: Tue, 3 Mar 2009 12:45:30 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709F0769A@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 03 18:48:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeYin-0006IV-4J
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 18:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbZCCRqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 12:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbZCCRqL
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 12:46:11 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:38676 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbZCCRqK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 12:46:10 -0500
X-ASG-Debug-ID: 1236102367-29a703980000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP id E10F81E1A53
	for <git@vger.kernel.org>; Tue,  3 Mar 2009 12:46:07 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id Wyn1m6XYNYIOfVce for <git@vger.kernel.org>; Tue, 03 Mar 2009 12:46:07 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Mar 2009 12:46:07 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: More on "fast foward"
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: More on "fast foward"
Thread-Index: AcmcJ9hlx7qjvDHeROaWJTzkRF4kBg==
X-OriginalArrivalTime: 03 Mar 2009 17:46:07.0520 (UTC) FILETIME=[EE76F200:01C99C27]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236102367
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112134>

After I merged the release fixes back into the development branch, I was
surprised that push complained that it was not fast-forward.  I thought
someone must have added something since I looked, but no, my repository
matches exactly.  My new dev branch label is the immediate descendant of
the old one.  My new node has another ancestor as well, but so what?
The same changes, not recorded as a merge, would work without complaint.

The glossary states, "A fast-forward is a special type of merge where
you have a revision and you are "merging" another branch's changes that
happen to be a descendant of what you have. In such these cases, you do
not make a new merge commit but instead just update to his revision.
This will happen frequently on a tracking branch of a remote
repository."  Why did that not work this time?

I'm especially worried about this because it means that topic branches
merged back to the development core when ready would not be a fast
forward, and the "ordinary users" should not force pushes.

What am I missing?

--John
(please excuse the footer; it's not my idea)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
