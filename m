From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: problem with cherry picking
Date: Mon, 20 Apr 2009 16:07:20 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70ACE0021@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 22:09:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvznh-0001e0-9A
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 22:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930AbZDTUHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 16:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754280AbZDTUHf
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 16:07:35 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:53196 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbZDTUHe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 16:07:34 -0400
X-ASG-Debug-ID: 1240258052-4c6403cc0006-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP id 1962C3588EE
	for <git@vger.kernel.org>; Mon, 20 Apr 2009 16:07:33 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id IYNXdNjKQHMz6tLg for <git@vger.kernel.org>; Mon, 20 Apr 2009 16:07:33 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Apr 2009 16:07:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: problem with cherry picking
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: problem with cherry picking
Thread-Index: AcnB85x6PZ4RMkmZSHWU0/7ld8SdkQ==
X-OriginalArrivalTime: 20 Apr 2009 20:07:21.0862 (UTC) FILETIME=[9D64EA60:01C9C1F3]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1240258053
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117027>

Someone at work here jumped the gun and committed something before
fetching an amended branch.  Typical stuff -- now his work and the
repo's work diverged.  His change was purely new files, no big deal.  In
gitk, reset his dev to origin/remote/dev, then cherry-pick his new
commit.

But it barfed all over the place.  One problem was read-only files.  But
even after purging those, it had the same complaint, something about
untracked file would be modified.  What's the deal here?

I talked him through accomplishing it another way -- reset hard back to
his new commit, reset mixed to the proper ancestor, and re-doing the
commit.

But I want to understand what the issue is here.

--John


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
