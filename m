From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: Cryptic error messages?
Date: Tue, 21 Apr 2009 12:54:38 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70ACE0360@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0030@EXCHANGE.trad.tradestation.com> <20090421120814.GL25059@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 18:59:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwJJY-0002lw-Is
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 18:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbZDUQ5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 12:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbZDUQ5r
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 12:57:47 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:58739 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbZDUQ5r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 12:57:47 -0400
X-ASG-Debug-ID: 1240333029-25460137000a-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 0EA4D36322F; Tue, 21 Apr 2009 12:57:12 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id pfcZk1Aweb2Jyn5F; Tue, 21 Apr 2009 12:57:12 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 21 Apr 2009 12:56:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: Cryptic error messages?
In-Reply-To: <20090421120814.GL25059@dpotapov.dyndns.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Cryptic error messages?
Thread-Index: AcnCeexhhFzR/RRqRwy67JfXUqn9TQAJztHg
X-OriginalArrivalTime: 21 Apr 2009 16:56:13.0674 (UTC) FILETIME=[143C0CA0:01C9C2A2]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1240333033
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117135>

It's git version 1.6.2.msysgit.0.186.gf7512.  The remote is file based,
so the same copy is being used.  I would suspect that the problem is
with the network.

git fsck always tells me about dangling objects, so that's normal? In
this case, it said something about a broken link.  I just recopied it
from another location.  But, is it possible to delete just the bad
parts, and have a push from others flesh it out again?

> -----Original Message-----
> From: Dmitry Potapov [mailto:dpotapov@gmail.com]
> Sent: Tuesday, April 21, 2009 7:08 AM
> To: John Dlugosz
> Cc: git@vger.kernel.org
> Subject: Re: Cryptic error messages?
> 
> On Mon, Apr 20, 2009 at 04:18:09PM -0400, John Dlugosz wrote:
> > $ git push
> > Counting objects: 9, done.
> > Compressing objects: 100% (8/8), done.
> > Writing objects: 100% (8/8), 3.62 KiB, done.
> > Total 8 (delta 4), reused 0 (delta 0)
> > Unpacking objects: 100% (8/8), done.
> > fatal: unresolved deltas left after unpacking
> 
> I think that is the key message...
> 
> > error: unpack failed: unpacker exited with error code
> > To //tx01fs01/sys/dev/git/repositories/aardvark.git
> >  ! [remote rejected] dev -> dev (n/a (unpacker error))
> > error: failed to push some refs to
> > '//tx01fs01/sys/dev/git/repositories/aardvark
> > .git'
> >
> >
> >
> > Huh?  I'm having trouble defending git's reputation.
> 
> I don't think that information is very helpful. It would be far more
> useful to know what version of Git on client and server sides are
> running. Also, running "git fsck --full" may be helpful.
> 
> I suspect you have a very old Git version on the server side.
> 
> 
> Dmitry

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
