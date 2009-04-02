From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: More help with "pull" please
Date: Thu, 2 Apr 2009 10:45:12 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A7D4FF7@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A7D4D9A@EXCHANGE.trad.tradestation.com> <4659A860-4AF5-4E34-B38E-60C926E2BAE1@dbservice.com> <450196A1AAAE4B42A00A8B27A59278E70A7D4E71@EXCHANGE.trad.tradestation.com> <F364AB31-EC5B-4719-834E-58613BDBC433@dbservice.com> <7viqlnokrv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Tomas Carnecky" <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 16:47:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpOCt-00014C-N8
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 16:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757613AbZDBOqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 10:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757064AbZDBOqR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 10:46:17 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:36178 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555AbZDBOqQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 10:46:16 -0400
X-ASG-Debug-ID: 1238683573-0972002b0000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 12CB4286275; Thu,  2 Apr 2009 10:46:13 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id Qhqlzzy3pTiI7OhK; Thu, 02 Apr 2009 10:46:13 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.122]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 2 Apr 2009 10:46:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: More help with "pull" please
In-Reply-To: <7viqlnokrv.fsf@gitster.siamese.dyndns.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: More help with "pull" please
Thread-Index: AcmzOiWxIs9gKEFlSWaEYBIijwBzfwAZuEIw
X-OriginalArrivalTime: 02 Apr 2009 14:46:13.0451 (UTC) FILETIME=[C51739B0:01C9B3A1]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1238683574
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115471>

> If your repository is using .git/remotes/origin to name the "origin"

I don't have a directory under .git called remotes.  A new repository
made using clone describes origin in the config file.  Is that an old
way of doing things?

> remote, they are still honored.  But you are correct to point out that
> branch.<name>.remote and with the remote.<name>.* variables in
> .git/config
> are used to control these more recent features.  So in that sense the
> documentation is still correct.

A related question:  is the name "origin" hard-coded as the default, or
does each repository remember specifically which is the upstream
repository regardless of what you named it?  From what I see in the
config file, it would have to be per-branch.  I suppose in other cases
it's implicit in where the label was found under remotes.

--John

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
