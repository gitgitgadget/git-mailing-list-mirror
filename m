From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: fetch and pull
Date: Wed, 18 Mar 2009 12:50:02 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A3FC50D@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AF023@EXCHANGE.trad.tradestation.com> <76718490903161514ubbdc948o1a0251212fe65fea@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E70A2AF0A9@EXCHANGE.trad.tradestation.com> <76718490903161709v6d8d09f6k17d2fe1a5e56fb03@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E70A2AF22F@EXCHANGE.trad.tradestation.com> <76718490903170921r36843c11y5aac537d53384298@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E70A3FC0A5@EXCHANGE.trad.tradestation.com> <20090318063103.6117@nanako3.lavabit.com> <20090318085849.GA8118@atjola.homenet> <450196A1AAAE4B42A00A8B27A59278E70A3FC468@EXCHANGE.trad.tradestation.com> <20090318153120.GC8118@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Nanako Shiraishi" <nanako3@lavabit.com>, <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: =?iso-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 17:52:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljz0K-0005O7-8O
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 17:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873AbZCRQux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 12:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755839AbZCRQux
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 12:50:53 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:52770 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744AbZCRQuw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2009 12:50:52 -0400
X-ASG-Debug-ID: 1237395049-041e01090000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 9316C21D08A; Wed, 18 Mar 2009 12:50:49 -0400 (EDT)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id rPr2ZmCdOVsenO2E; Wed, 18 Mar 2009 12:50:49 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 18 Mar 2009 12:50:49 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: fetch and pull
In-Reply-To: <20090318153120.GC8118@atjola.homenet>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: fetch and pull
Thread-Index: Acmn3qEHS+GJsCJZRbOKtfdc7vzxLwACcP6Q
X-OriginalArrivalTime: 18 Mar 2009 16:50:49.0260 (UTC) FILETIME=[B0D2E6C0:01C9A7E9]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1237395049
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113628>

> Hm? Both clone and "remote add" setup the fetch line by default. So you
> manually adjusted the config to add the remote as just an url alias?
> I'm
> not convinced that such manual config changes are "normal" either. At
> least you're most likely the first user from which I've heard that he
> did that.

No, he manually added
	[remote "pub"]
	url = //...

only.

I'm sure he wouldn't know "clone" if it bit him.  I assume the entire repository and working tree was simply copied from his machine.

This is the same guy who insists on rebasing the dev branch.  As soon as I learned to use "git log" I tried to convince him that he should merge, not rebase, but he won't listen.  So I got control and did the merge (not rebase) and am trying to device a work-flow and matching cook book for the team.

Nobody thought to post to this mailing list either.  So you have a selection bias in your sample.  I speculate that there is a larger population of people who use git poorly, and that includes not participating in the community to learn better.

Just like you can write Fortran in any language, git happily lets you treat it like SourceSafe, with a dash of "just enough knowledge to be dangerous" use of other features.

--John
(sorry about the footer)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
