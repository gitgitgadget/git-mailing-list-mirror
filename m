From: John Dlugosz <JDlugosz@TradeStation.com>
Subject: rebasing and submodules
Date: Wed, 7 Apr 2010 13:21:07 -0400
Message-ID: <89030B4A18ECCD45978A3A6B639D1F24032A074E4C@FL01EXMB01.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 07 19:21:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzYwP-0007eK-Fu
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 19:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758103Ab0DGRVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 13:21:10 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:38073 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756986Ab0DGRVJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 13:21:09 -0400
X-ASG-Debug-ID: 1270660868-4934f87d0001-QuoKaX
Received: from FL01EXCAHT02.trad.tradestation.com (fl01excaht02.trad.tradestation.com [10.4.0.167]) by mail2.tradestation.com with ESMTP id OTIYzPnvNIR3m8uK (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for <git@vger.kernel.org>; Wed, 07 Apr 2010 1
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from FL01EXMB01.trad.tradestation.com ([::1]) by
 FL01EXCAHT02.trad.tradestation.com ([::1]) with mapi; Wed, 7 Apr 2010
 13:21:07 -0400
X-Barracuda-BBL-IP: ::1
X-Barracuda-RBL-IP: ::1
X-ASG-Orig-Subj: rebasing and submodules
Thread-Topic: rebasing and submodules
Thread-Index: AcrWdrVrVXtN/kWfTjqnRFhyCioDQw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Barracuda-Connect: fl01excaht02.trad.tradestation.com[10.4.0.167]
X-Barracuda-Start-Time: 1270660868
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://192.168.51.31:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144252>

The workflow I've introduced into the group is to use "topic" branches that stay floating on top of the "dev" tip by rebasing each day.  A completed "topic", when it's ready for everyone to use, gets merged back onto "dev" (either merge to preserve the detailed history, or squished to be a single change).



I'm quite comfortable with that, and it works well.



But submodules seem to throw a spanner into the works.  Perhaps it's a problem with the tools.  But if a submodule has been changed, the rebasing does not go smoothly.  At the very least, it stops to report a conflict.



What's going on here?  Is it something with the tools that doesn't like submodules that well?  What should I do when this happens?  What should I be doing as a general technique to prevent problems?  Is there already a treatment of this somewhere on the web?



Thanks,

--John




TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
