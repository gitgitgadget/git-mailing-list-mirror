From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: Windows Server?
Date: Wed, 29 Apr 2009 11:22:06 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70AE3F27E@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70AE3F0A6@EXCHANGE.trad.tradestation.com> <20090428224653.GT23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 17:23:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzBcY-0007Hw-7U
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 17:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbZD2PWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 11:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755050AbZD2PWl
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 11:22:41 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:35728 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929AbZD2PWl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 11:22:41 -0400
X-ASG-Debug-ID: 1241018558-0aa702370002-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam & Virus Firewall) with ESMTP
	id BF1B83C5184; Wed, 29 Apr 2009 11:22:39 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id xTzhvEU9M4FuP3QA; Wed, 29 Apr 2009 11:22:39 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 29 Apr 2009 11:22:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: Windows Server?
In-Reply-To: <20090428224653.GT23604@spearce.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Windows Server?
Thread-Index: AcnIUzpjF3quQocLRqOXpXL7M49wNQAiosVg
X-OriginalArrivalTime: 29 Apr 2009 15:22:38.0830 (UTC) FILETIME=[54D4D8E0:01C9C8DE]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1241018560
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117897>

> How are you going to run SSH on the server?  Cygwin SSH?

My first idea is to let the I.T. guys figure that out.  After all, they
are supposed to be helping us...right?  Is such a thing built into a
Windows server system?  But a quick search in Google turned up a
SourceForge project that's OpenSSH using a stripped down Cygwin that is
self-contained and doesn't require a separate Cygwin installation.

> But yes, the SSH protocol is the git:// protocol, tunneled through
SSH,
> and will be much more efficient over the VPN than SMB.

Someone else said that the git daemon is for fetching only.  So that's
not a limitation with the git: protocol, just the git-daemon itself?


--John

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
