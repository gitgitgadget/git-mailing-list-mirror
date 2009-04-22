From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: What's going on here?  Bad repo, no error locally?
Date: Wed, 22 Apr 2009 11:59:41 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70ACE06C1@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE053E@EXCHANGE.trad.tradestation.com> <7vws9d46q9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 18:08:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwewn-0000Ss-Uk
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 18:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbZDVQDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 12:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbZDVQDn
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 12:03:43 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:40783 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbZDVQDm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 12:03:42 -0400
X-ASG-Debug-ID: 1240416216-1bb5019c0006-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam & Virus Firewall) with ESMTP
	id 95A6F36F5FB; Wed, 22 Apr 2009 12:03:37 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id 5FAmRgbPSH2dHQiV; Wed, 22 Apr 2009 12:03:37 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Apr 2009 12:02:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
x-cr-hashedpuzzle: AL2O BKIk B41o CNJc CYzt Dv0m F6B/ HHpp MDme NFCb RULv RbaJ Saz1 TBVG UkMI WS7v;2;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA7AGcAaQB0AHMAdABlAHIAQABwAG8AYgBvAHgALgBjAG8AbQA=;Sosha1_v1;7;{91DCBAB3-81FA-47B3-9D94-D7178D305B07};agBkAGwAdQBnAG8AcwB6AEAAdAByAGEAZABlAHMAdABhAHQAaQBvAG4ALgBjAG8AbQA=;Wed, 22 Apr 2009 15:59:41 GMT;UgBFADoAIABXAGgAYQB0ACcAcwAgAGcAbwBpAG4AZwAgAG8AbgAgAGgAZQByAGUAPwAgACAAQgBhAGQAIAByAGUAcABvACwAIABuAG8AIABlAHIAcgBvAHIAIABsAG8AYwBhAGwAbAB5AD8A
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: What's going on here?  Bad repo, no error locally?
x-cr-puzzleid: {91DCBAB3-81FA-47B3-9D94-D7178D305B07}
In-Reply-To: <7vws9d46q9.fsf@gitster.siamese.dyndns.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: What's going on here?  Bad repo, no error locally?
Thread-Index: AcnDCC4zGAQ6TFFbT1Ohy9/iy1PKtQAWv44Q
X-OriginalArrivalTime: 22 Apr 2009 16:02:36.0633 (UTC) FILETIME=[C1244C90:01C9C363]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1240416217
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117213>

> The dangling objects can happen if you push over dumb transport and
> interrupt in the middle, or you force a push of a rewound branch, so
it
> does not necessarily indicate any errors, but a missing object is
> always an error.


Thanks.

That's what I thought danglings were.  But why doesn't gc get rid of
them?


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
