From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: proper way to merge?
Date: Fri, 27 Feb 2009 17:11:22 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709F06FDA@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 23:14:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdAyY-0003Om-2h
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 23:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759114AbZB0WNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 17:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759212AbZB0WNG
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 17:13:06 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:33915 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759000AbZB0WNF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 17:13:05 -0500
X-ASG-Debug-ID: 1235772716-6d2302450000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP id 0BC8F1CE9D5
	for <git@vger.kernel.org>; Fri, 27 Feb 2009 17:11:56 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id BdcmB6kirrYtQ5RN for <git@vger.kernel.org>; Fri, 27 Feb 2009 17:11:56 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 27 Feb 2009 17:11:55 -0500
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: proper way to merge?
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: proper way to merge?
Thread-Index: AcmZKFMcHXrE8tkmRq+IX91uuF+RrQ==
X-OriginalArrivalTime: 27 Feb 2009 22:11:55.0699 (UTC) FILETIME=[66AAF030:01C99928]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1235772716
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111722>

I'm merging two branches: let's say "dev" is for development of future
releases, and "rel" is changes made to the current release for immediate
application.  Now I want to bring the changes made in rel back to dev.

Rather than trying to merge it all at once, I'm applying the changes a
few at a time and making sure it still compiles as I go.  Then,
git-reset and I have dev as my HEAD and the desired merge result in the
working tree.

Now, I want to introduce the proper commit node to show that this is the
graft.  But, I don't want to be presented with all the differences that
I already resolved; I know what it should look like already.  How do I
commit the current state of things and have it show up with both dev and
rel as parents? (then make that the new dev)

I'm also interesting in learning how to do it better next time.  But I'm
doing the incremental merging now and need to know how to conclude it.

--John

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
