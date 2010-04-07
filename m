From: John Dlugosz <JDlugosz@TradeStation.com>
Subject: RE: ghost refs
Date: Wed, 7 Apr 2010 18:10:41 -0400
Message-ID: <89030B4A18ECCD45978A3A6B639D1F24032A0750CC@FL01EXMB01.trad.tradestation.com>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
 	<r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
 	<20100407210010.GB27012@coredump.intra.peff.net>
 <89030B4A18ECCD45978A3A6B639D1F24032A0750BE@FL01EXMB01.trad.tradestation.com>
 <k2p32541b131004071503g4ce66e5bjac8270b10790a2af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 00:10:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzdSV-0005kb-0c
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 00:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948Ab0DGWKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 18:10:46 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:42531 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218Ab0DGWKp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 18:10:45 -0400
X-ASG-Debug-ID: 1270678243-49343c9a0002-QuoKaX
Received: from FL01EXCAHT02.trad.tradestation.com (fl01excaht02.trad.tradestation.com [10.4.0.167]) by mail2.tradestation.com with ESMTP id WEfwlVQ8YTbJsOE4 (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Wed, 07 Apr 2010 18:10:44 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from FL01EXMB01.trad.tradestation.com ([::1]) by
 FL01EXCAHT02.trad.tradestation.com ([::1]) with mapi; Wed, 7 Apr 2010
 18:10:43 -0400
X-ASG-Orig-Subj: RE: ghost refs
Thread-Topic: ghost refs
Thread-Index: AcrWnjaRVo/XJl6xQFy3e9vdVKnOYgAAN5Fw
In-Reply-To: <k2p32541b131004071503g4ce66e5bjac8270b10790a2af@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Barracuda-Connect: fl01excaht02.trad.tradestation.com[10.4.0.167]
X-Barracuda-Start-Time: 1270678243
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://192.168.51.31:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144289>

So do I still have to specify that I want a reflog when I create a branch, or does that always happen with local branches too?







> -----Original Message-----

> From: Avery Pennarun [mailto:apenwarr@gmail.com]

> Sent: Wednesday, April 07, 2010 5:03 PM

> To: John Dlugosz

> Cc: git@vger.kernel.org

> Subject: Re: ghost refs

> 

> On Wed, Apr 7, 2010 at 6:00 PM, John Dlugosz

> <JDlugosz@tradestation.com> wrote:

> >> You do have a reflog in the case of overwrite. Delete kills off any

> >> associated reflog (it would be cool if we had a "graveyard" reflog

> >> that kept deleted branch reflogs around for a while).

> >

> > Hmm, I thought you only had reflogs on your local branches, not the

> remote branches.

> 

> This used to be true, but I have confirmed that with the latest

> version of git, remote refs have reflogs (as they should for safety).

> 

> Have fun,

> 

> Avery


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
