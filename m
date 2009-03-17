From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: Re: .gitk should created hidden in windows
Date: Tue, 17 Mar 2009 11:56:40 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A2AF295@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <lists@lanwin.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 16:59:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljbgf-0005E3-9q
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 16:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605AbZCQP5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 11:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755391AbZCQP5L
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 11:57:11 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:60722 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755477AbZCQP5K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 11:57:10 -0400
X-ASG-Debug-ID: 1237305427-7f18000c0000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 49B812194BC; Tue, 17 Mar 2009 11:57:07 -0400 (EDT)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id AZmKrJ8uYCmvaXNL; Tue, 17 Mar 2009 11:57:07 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Mar 2009 11:57:06 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: Re: .gitk should created hidden in windows
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: .gitk should created hidden in windows
Thread-Index: AcmnGPYoqmoKKa4VQ86W1c56ywMrng==
X-OriginalArrivalTime: 17 Mar 2009 15:57:06.0741 (UTC) FILETIME=[05A3C650:01C9A719]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1237305427
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113486>

=== Re: ===
The problem is that windows dose not hides files beginning with a dot as
it is in unix. So the .gitk file is created as visible in the windows
user profile. Problematic too is that i can no set the hidden attribute
to this file, because it is recreated every time i start gitk, so the
hidden attribute gets lost.
=== end ===

I didn't even notice that file, and I use gitk all the time.  That
directory it put it in, the "top level" user directory based on profile,
is not something that is directly examined by most users.  It is
probably used as roughly equivalent to the home directory under Unix,
but is not exactly---Windows has separate defined locations for
programs's settings, user documents, and desktop among others.  I think
this file properly belongs in %APPDATA%, which is a hidden directory.
The stuff in that directory is not itself hidden.

That is, use the APPDATA environment variable to locate the file, rather
than the HOME environment variable.

--John




TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
