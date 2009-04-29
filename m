From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: Windows Server?
Date: Wed, 29 Apr 2009 11:18:13 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70AE3F277@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70AE3F0A6@EXCHANGE.trad.tradestation.com> <18071eea0904281546u52423fe3saf7abaa486bfa0ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Thomas Adam" <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 17:20:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzBZy-0005cf-Go
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 17:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756939AbZD2PTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 11:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756260AbZD2PTx
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 11:19:53 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:34578 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756757AbZD2PTw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 11:19:52 -0400
X-ASG-Debug-ID: 1241018381-0b7103cb0000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam & Virus Firewall) with ESMTP
	id 85BB03C4EF3; Wed, 29 Apr 2009 11:19:42 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id 6evLdGa4Cb7sFqMj; Wed, 29 Apr 2009 11:19:42 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 29 Apr 2009 11:18:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: Windows Server?
In-Reply-To: <18071eea0904281546u52423fe3saf7abaa486bfa0ec@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Windows Server?
Thread-Index: AcnIUxunB+hAYeL/S1KKBlISkS9hLgAib5Lg
X-OriginalArrivalTime: 29 Apr 2009 15:18:45.0039 (UTC) FILETIME=[C97B2BF0:01C9C8DD]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1241018382
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117896>

> Well, git-daemon speaks the git:// protocol which generally is for
> pull only.  If you're wanting push and pull access, using something
> like ssh is the way to go.

Ah, good to know.  Thanks.

> 
> Yes, using ssh is fine.
> 
> > Is there anything that needs to be done on the server machine, other
> > than having a SSH server, and formulating the path the way the disk
> > really is on that machine (as opposed to the network share
> structure)?
> 
> Nope -- a running ssh server is all that's needed.  The clients then
> would need an ssh-client to contact the server over ssh, of course.
> Not knowing anything about WIndows, would putty provide this?

I suppose it also needs to have the main git executable on the system
PATH or be set up as some kind of alias known by the ssh server.  I
suppose it works by launching a shell on the server's end and feeding it
the command from the client's side.

I use PUtty at home for a shell into my Debian server.  I don't know how
git invokes it, but it's obviously other than having a GUI application
create a window for that purpose.  I'll dive into enabling/configuring
that once I have the server end going.

--John


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
