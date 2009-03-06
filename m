From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: git-forest on msysgit
Date: Fri, 6 Mar 2009 16:08:38 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A115F15@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 22:11:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfhJv-0000Ce-JX
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 22:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbZCFVJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 16:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753594AbZCFVJf
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 16:09:35 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:54874 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbZCFVJf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 16:09:35 -0500
X-ASG-Debug-ID: 1236373771-59e900f00000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP id F40001F370A
	for <git@vger.kernel.org>; Fri,  6 Mar 2009 16:09:31 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id ygReQYAXBjQ0kgda for <git@vger.kernel.org>; Fri, 06 Mar 2009 16:09:31 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Mar 2009 16:09:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: git-forest on msysgit
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-forest on msysgit
Thread-Index: Acmen7hq0boRDjfXTy2p3qH7Ebi+cA==
X-OriginalArrivalTime: 06 Mar 2009 21:09:31.0360 (UTC) FILETIME=[D7C26600:01C99E9F]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236373771
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112480>

I downloaded git-forest, and when I run it I get:

Can't locate loadable object for module Encode in @INC (@INC contains:
/usr/lib/perl5/5.8.8/msys /usr/lib/perl5/5.8.8 /usr/lib/perl5
/site_perl/5.8.8/msys /usr/lib/perl5/site_perl/5.8.8
/usr/lib/perl5/site_perl .) at /usr/lib/perl5/5.8.8/msys/encoding.pm
line 5

The line 5 in encoding.pm reads "use Encode;" and there is an Encode.pm
on the path, and in Encode.pm it uses XSLoader.  However, in the XS
subdirectory in the same directory as Encode.pm, I see only 2 files and
neither of them has to do with encoding.  So I'm guessing I'm missing a
file.

I wonder if I can just copy it from somewhere, like someone's Linux
build?

--John


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
