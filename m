From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: undoing something
Date: Tue, 17 Mar 2009 11:08:23 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A2AF242@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AEFA4@EXCHANGE.trad.tradestation.com> <7veiwxwa9z.fsf@gitster.siamese.dyndns.org> <450196A1AAAE4B42A00A8B27A59278E70A2AEFD7@EXCHANGE.trad.tradestation.com> <20090317064519.6117@nanako3.lavabit.com> <7vtz5ssk0s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>, "Paolo Bonzini" <bonzini@gnu.org>,
	"Jay Soffian" <jaysoffian@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Nanako Shiraishi" <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 16:12:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjaxH-0001Nl-T6
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 16:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbZCQPI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 11:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbZCQPI5
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 11:08:57 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:56719 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbZCQPI4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 11:08:56 -0400
X-ASG-Debug-ID: 1237302532-74fa037f0002-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 8B76B219187; Tue, 17 Mar 2009 11:08:53 -0400 (EDT)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id hhtqTmI2joiLxA3h; Tue, 17 Mar 2009 11:08:53 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Mar 2009 11:08:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: undoing something
In-Reply-To: <7vtz5ssk0s.fsf@gitster.siamese.dyndns.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: undoing something
Thread-Index: Acmmz1cK1f/5toTKTTChX3GpddJ1tgAQlCtA
X-OriginalArrivalTime: 17 Mar 2009 15:08:52.0896 (UTC) FILETIME=[48C61200:01C9A712]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1237302533
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113477>

> The documentation is indeed wrong.  It is more like "create a new
> branch,
> or if the named branch already exists, reset the tip of it".  

Awesome.  Then  git branch -f name newpos  is exactly what I need.  

I wondered why something that should be so simple, and is available from
every GUI, is not easy from the command line.

--John


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
