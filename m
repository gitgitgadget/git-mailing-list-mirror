From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: Re: Help understanding "rebase"
Date: Wed, 11 Mar 2009 16:04:11 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A2AE398@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>, <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Mar 11 21:13:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhUhq-0006Ke-Lj
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 21:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbZCKUEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 16:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754825AbZCKUEw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 16:04:52 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:49683 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797AbZCKUEv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 16:04:51 -0400
X-ASG-Debug-ID: 1236801886-041301bb0002-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 6713A206738; Wed, 11 Mar 2009 16:04:47 -0400 (EDT)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id BjlLpZoE4fHRMrhV; Wed, 11 Mar 2009 16:04:47 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 11 Mar 2009 16:04:46 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: Re: Help understanding "rebase"
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: Help understanding "rebase"
Thread-Index: AcmihIspVy6KzrKfT4GGCpUBiyEKwQ==
X-OriginalArrivalTime: 11 Mar 2009 20:04:46.0464 (UTC) FILETIME=[A03F1000:01C9A284]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236801887
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112971>

=== Re: ===
It may help those who know the internals of git-rebase if you supplied
the
commands you used and your git version.

So, you're saying you did

   git checkout topic
   git rebase dev

or the equivalent

   git rebase dev topic

?  Are you sure you didn't get the arguments to rebase reversed?
===end===

Sorry, I did not write down exactly what I typed.  But the situation was
the latter:

	git rebase dev topic

While looking at the man page to get the arguments right, with dev being
"upstream" and the branch to rewrite last.  I suppose I _could_ have
gotten it backwards.

--John
(please excuse the footer)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
