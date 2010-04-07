From: John Dlugosz <JDlugosz@TradeStation.com>
Subject: ghost refs
Date: Wed, 7 Apr 2010 12:38:03 -0400
Message-ID: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 07 18:54:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzYWS-0001Nx-P4
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 18:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758107Ab0DGQyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 12:54:25 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:37666 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758049Ab0DGQyY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 12:54:24 -0400
X-Greylist: delayed 979 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Apr 2010 12:54:24 EDT
X-ASG-Debug-ID: 1270658284-4935ebfe0001-QuoKaX
Received: from FL01EXCAHT01.trad.tradestation.com (fl01excaht01.trad.tradestation.com [10.4.0.166]) by mail2.tradestation.com with ESMTP id ALaoMno6T3z9wkSi (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for <git@vger.kernel.org>; Wed, 07 Apr 2010 1
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from FL01EXMB01.trad.tradestation.com ([::1]) by
 FL01EXCAHT01.trad.tradestation.com ([::1]) with mapi; Wed, 7 Apr 2010
 12:38:04 -0400
X-Barracuda-BBL-IP: ::1
X-Barracuda-RBL-IP: ::1
X-ASG-Orig-Subj: ghost refs
Thread-Topic: ghost refs
Thread-Index: AcrWcLFhPiE/5BC1QtStG6FtiybwTw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Barracuda-Connect: fl01excaht01.trad.tradestation.com[10.4.0.166]
X-Barracuda-Start-Time: 1270658284
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://192.168.51.31:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144250>

A couple times I've seen people who have some reference remotes/origin/foo after foo has been removed from origin.  What is the proper way to address that, other than removing the file directly?  It appears to not go away with a "fetch" even though it was deleted from the origin.  So what is the proper way to delete something on the origin so the deletion propagates?  I normally use "git push origin :foo".



--John

(sorry about the footer)


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
