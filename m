From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: More help with "pull" please
Date: Wed, 1 Apr 2009 19:26:12 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A7D4E7B@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A7D4D9A@EXCHANGE.trad.tradestation.com> <4659A860-4AF5-4E34-B38E-60C926E2BAE1@dbservice.com> <450196A1AAAE4B42A00A8B27A59278E70A7D4E71@EXCHANGE.trad.tradestation.com> <F364AB31-EC5B-4719-834E-58613BDBC433@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Tomas Carnecky" <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 01:31:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp9sN-0006KJ-Ug
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 01:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935774AbZDAX0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 19:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935469AbZDAX0u
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 19:26:50 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:36358 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935789AbZDAX0r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 19:26:47 -0400
X-ASG-Debug-ID: 1238628405-219e00790000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 790B7274C81; Wed,  1 Apr 2009 19:26:45 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id CeDhXMpqfiMu6K7q; Wed, 01 Apr 2009 19:26:45 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.122]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Apr 2009 19:26:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: More help with "pull" please
In-Reply-To: <F364AB31-EC5B-4719-834E-58613BDBC433@dbservice.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: More help with "pull" please
Thread-Index: AcmzH7j3d0xfCUZRT0alOjFLrRCtzQAAPwBw
X-OriginalArrivalTime: 01 Apr 2009 23:26:44.0654 (UTC) FILETIME=[51ECDCE0:01C9B321]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1238628405
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115426>

> I think Pull: lines are not used anymore in newer repositories.
...
> I'd say forget about Pull: because you won't see any of that in newer
> repositories. Instead, just use --track when checking out a branch you
> intend to follow. And, more as an implementation detail than anything
> else, remember that the tracking is done through the above mentioned
> config options (which you can set/change using git-config or directly
> by editing the .git/config file).

OK, the documentation is clear if I ignore that.
I expect it to be "well behaved" if I'm on a tracking branch and give it
no arguments, or if the single refspec argument is the correct remote
for the branch I'm on.  Otherwise (not a tracking branch) the docs just
say "It's complicated, backward compatibility" and presumably involves
those non-existent Pull: lines and the state of the remote's HEAD.



> Maybe it's because I'm using a fairly recent version
> (1.6.2.1.307.g91408).

I'm running git version (1.6.2.msysgit.0.186.gf7512), and I assume my
coworker's was a bit older.

--John


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
