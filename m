From: John Dlugosz <JDlugosz@TradeStation.com>
Subject: submodule problem
Date: Fri, 19 Mar 2010 12:54:25 -0400
Message-ID: <89030B4A18ECCD45978A3A6B639D1F2403299C8395@FL01EXMB01.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 18:15:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsfne-0002OE-7Y
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 18:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739Ab0CSRPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 13:15:49 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:53684 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656Ab0CSRPs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 13:15:48 -0400
X-Greylist: delayed 1001 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Mar 2010 13:15:48 EDT
X-ASG-Debug-ID: 1269017915-4c4d9a3b0009-QuoKaX
Received: from FL01EXCAHT01.trad.tradestation.com (fl01excaht01.trad.tradestation.com [10.4.0.166]) by mail2.tradestation.com with ESMTP id Ql0hEsR6SAvD0WW3 (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for <git@vger.kernel.org>; Fri, 19 Mar 2010 1
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from FL01EXMB01.trad.tradestation.com ([::1]) by
 FL01EXCAHT01.trad.tradestation.com ([::1]) with mapi; Fri, 19 Mar 2010
 12:54:28 -0400
X-ASG-Orig-Subj: submodule problem
Thread-Topic: submodule problem
Thread-Index: AcrHhNSzpr7ybBLhTnW+d1GiZAvV4Q==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: COcx DOow ETkY EqqZ EuSi EvJ3 E56W Ff/S Fs3K GUD0 GdqW
 I64K JzsV KLxa KazX
 Kgwu;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{F12914F0-869C-4D27-BAB3-B9BE6EAF02A5};agBkAGwAdQBnAG8AcwB6AEAAdAByAGEAZABlAHMAdABhAHQAaQBvAG4ALgBjAG8AbQA=;Fri,
 19 Mar 2010 16:54:25 GMT;cwB1AGIAbQBvAGQAdQBsAGUAIABwAHIAbwBiAGwAZQBtAA==
x-cr-puzzleid: {F12914F0-869C-4D27-BAB3-B9BE6EAF02A5}
acceptlanguage: en-US
X-Barracuda-Connect: fl01excaht01.trad.tradestation.com[10.4.0.166]
X-Barracuda-Start-Time: 1269017930
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://192.168.51.31:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142621>

I thought I knew what I was doing, after reading the instructions.



When I checked out an older version of the main project, I have to sync to the proper (older) version of the submodule too.  git admonished me to run the command from the toplevel of the working tree, and when that was done,



        git submodule update



gives no output.



        git submodule status



shows "-8441e..." which is the SHA1 of the version I expect I need.  But git status shows me that the submodule is modified.  git gui shows



        @ -1 +1 @@

        -Subproject commit 8441ea2e54fa2e8a4f45240a0d399f1c775a1789

        +Subproject commit bc47be2d623cbca83701d9f30a18fab6271dd38f



and gitk, run from the subproject's subdirectory, shows that bc47b, the newer stuff, is still active.  Browsing the files, I see this is indeed the case.



Now, my impression was that 'git submodule update' was supposed to check out the proper version, namely 4441e, not merely do nothing without even an error.  What am I missing?



--John



git version 1.6.5.1.1367.gcd48

msysgit on Windows XP 64-bit



=======================Sorry for the long footer; it's not my idea.


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
