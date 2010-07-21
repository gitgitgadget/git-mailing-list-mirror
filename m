From: John Dlugosz <JDlugosz@TradeStation.com>
Subject: RE: CRLF behavior
Date: Wed, 21 Jul 2010 17:35:18 -0400
Message-ID: <1A9EA7E081C3FE46A0F446FFB66D10EB9398FF@FL01EXMB01.trad.tradestation.com>
References: <1A9EA7E081C3FE46A0F446FFB66D10EB9398F1@FL01EXMB01.trad.tradestation.com>
 <AANLkTil5hUWwSXcz9T7cgeU_LwYtx8Nio7lUaUebJ5YM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 23:34:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObgwC-0003Na-MZ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 23:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991Ab0GUVen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 17:34:43 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:52965 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754Ab0GUVen convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 17:34:43 -0400
X-ASG-Debug-ID: 1279748074-34be93540001-QuoKaX
Received: from FL01EXCAHT01.trad.tradestation.com (fl01excaht01.trad.tradestation.com [10.4.0.166]) by mail2.tradestation.com with ESMTP id HhL2T380DM7guA7j (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Wed, 21 Jul 2010 17:34:35 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from FL01EXMB01.trad.tradestation.com ([::1]) by
 FL01EXCAHT01.trad.tradestation.com ([::1]) with mapi; Wed, 21 Jul 2010
 17:34:34 -0400
X-Barracuda-BBL-IP: ::1
X-Barracuda-RBL-IP: ::1
X-ASG-Orig-Subj: RE: CRLF behavior
Thread-Topic: CRLF behavior
Thread-Index: AcspGrM3vT7clNceT4yoHNk1rQd1/AAAGRCQ
In-Reply-To: <AANLkTil5hUWwSXcz9T7cgeU_LwYtx8Nio7lUaUebJ5YM@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Barracuda-Connect: fl01excaht01.trad.tradestation.com[10.4.0.166]
X-Barracuda-Start-Time: 1279748074
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://192.168.51.31:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151422>

> > Running git config --list shows nothing that would suggest any such

> setting.

> 

> Try 'git config --global --list'

> 

> Avery



I thought that --list tells me the sum result of all the settings in force; i.e. the final result that should be used here and now.



> Try 'git config --global --list'



I get:  fatal: $HOME not set



Trying again from the "git bash here" shell, I see there is a core.autocrlf=true !



I see it is set in %APPDATA%\..\.gitconfig, which is where MINGW likes to put its per-user data (one level higher than it should be; Unix doesn't distinguish the appdata from the user files so it put it all one level higher where nobody knows to look!)



So, assuming it's been that way (the file is dated March), what's the repository "really" doing?  When things started acting funny, my co-worker found this setting and removed it from his.  If that's not it, I can only wonder why it started showing all-lines-changed ?



--John




TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
