From: John Dlugosz <JDlugosz@TradeStation.com>
Subject: RE: CRLF behavior
Date: Wed, 21 Jul 2010 18:00:01 -0400
Message-ID: <1A9EA7E081C3FE46A0F446FFB66D10EB93991B@FL01EXMB01.trad.tradestation.com>
References: <1A9EA7E081C3FE46A0F446FFB66D10EB9398F1@FL01EXMB01.trad.tradestation.com>
 <AANLkTil5hUWwSXcz9T7cgeU_LwYtx8Nio7lUaUebJ5YM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ben Martin <BMartin@TradeStation.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 23:59:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObhK8-0005SG-BP
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 23:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186Ab0GUV71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 17:59:27 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:53196 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758751Ab0GUV71 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 17:59:27 -0400
X-ASG-Debug-ID: 1279749558-34bf972f0001-QuoKaX
Received: from FL01EXCAHT01.trad.tradestation.com (fl01excaht01.trad.tradestation.com [10.4.0.166]) by mail2.tradestation.com with ESMTP id D1EGCYZ4cVD1QlYH (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Wed, 21 Jul 2010 17:59:18 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from FL01EXMB01.trad.tradestation.com ([::1]) by
 FL01EXCAHT01.trad.tradestation.com ([::1]) with mapi; Wed, 21 Jul 2010
 17:59:17 -0400
X-Barracuda-BBL-IP: ::1
X-Barracuda-RBL-IP: ::1
X-ASG-Orig-Subj: RE: CRLF behavior
Thread-Topic: CRLF behavior
Thread-Index: AcspGrM3vT7clNceT4yoHNk1rQd1/AAAp0zQ
In-Reply-To: <AANLkTil5hUWwSXcz9T7cgeU_LwYtx8Nio7lUaUebJ5YM@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Barracuda-Connect: fl01excaht01.trad.tradestation.com[10.4.0.166]
X-Barracuda-Start-Time: 1279749558
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://192.168.51.31:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151426>

> > I'm running MSYSgit on Windows, and have no mention of any kind of

> crlf conversion in the config files.

> > Running git config --list shows nothing that would suggest any such

> setting.

> 

> Try 'git config --global --list'

> 

> Avery



Running from the Windows console window, I get an error about HOME with --global.  From the "git bash here" prompt, doing 'git config --list' by itself shows more settings, including autocrlf=true.  IOW, it finds the global settings and merges them.



So, perhaps sometimes git sees the setting and sometimes it doesn't?  Doing 'checkout' from the command line might behave differently from git gui or some other Windows extension.



I don't know how msysgit called from some random process is supposed to set up environment variables for it?  I would think that the UNIX-like $HOME, which shows as some translated cygwin path from the git bash shell, should be set up automatically based on the Windows "special folders" as part of the MSYS stuff.



The "git gui" program, which is actually wish.exe, appears to have been invoked as:

	"C:\Program Files (x86)\Git\bin\wish.exe"  "C:\Program Files (x86)\Git\libexec\git-core\git-gui" "--working-dir" "D:\work\ORCAL\SCM\Dev"



Is there a way to tell from within git-gui or kgit whether it is finding that settings file?  I think that git-gui calls git.exe to do the work, just like I can call directly and presumably other extensions and tools do.



Is there a way to tell what's "really" in the repository, for a commit that pre-dates any trouble?



--John














TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
