From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: Re: fetch and pull
Date: Mon, 16 Mar 2009 15:00:46 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A2AEF9A@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Junio C Hamano" <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 20:03:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjI5Y-0003AS-Eh
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 20:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758389AbZCPTA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 15:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758412AbZCPTA4
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 15:00:56 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:55115 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265AbZCPTAz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 15:00:55 -0400
X-ASG-Debug-ID: 1237230051-48a3015e0002-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 3A0E6216D7F; Mon, 16 Mar 2009 15:00:52 -0400 (EDT)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id OXrT2QKMEIAJeSTX; Mon, 16 Mar 2009 15:00:52 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Mar 2009 15:00:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: Re: fetch and pull
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: fetch and pull
Thread-Index: AcmmaYOKDtJohyDSQt2B3xvVeIPNPw==
X-OriginalArrivalTime: 16 Mar 2009 19:00:51.0108 (UTC) FILETIME=[8642EE40:01C9A669]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1237230052
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113353>

=== Re: ===
> So, after inspecting the changes, how do you fast-forward your local
dev
> to sync up with origin/dev?

$ git push . origin/dev dev
=== end ===

That did not work.  It just reports "everything up to date".  If I
understand the point of what it does correctly, I think

	$ git push . +origin/dev:dev

is correct.



TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
