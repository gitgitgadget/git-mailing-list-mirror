From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: newb: Given a commit id, find which branches have it as an ancestor
Date: Fri, 13 Mar 2009 12:20:39 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A2AEA5A@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 13 17:23:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiA9g-0000QM-E9
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 17:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbZCMQVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2009 12:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbZCMQVL
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 12:21:11 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:49233 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbZCMQVK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 12:21:10 -0400
X-ASG-Debug-ID: 1236961268-3b6c02be0000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP id 2640C20E826
	for <git@vger.kernel.org>; Fri, 13 Mar 2009 12:21:08 -0400 (EDT)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id EuBFMAo5wBde3Xyq for <git@vger.kernel.org>; Fri, 13 Mar 2009 12:21:08 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.122]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Mar 2009 12:21:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: newb: Given a commit id, find which branches have it as an ancestor
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE: newb: Given a commit id, find which branches have it as an ancestor
Thread-Index: Acmj93K0kY/Z0aroS+a8X4xJ+rUO5Q==
X-OriginalArrivalTime: 13 Mar 2009 16:21:07.0535 (UTC) FILETIME=[B6C47DF0:01C9A3F7]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236961268
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113205>

=3D=3D=3D Re: =3D=3D=3D
What I'm beginning to suspect is that all the commits that should have
gone to master went to some unnamed branch.
Is that reasonable/possible/likely?=A0 This commit has a full ancestry,
but doesn't appear to be on any branch.
=3D=3D=3D end=3D=3D=3D

Both gitk (comes with git) and QGit showthe branches on the GUI when yo=
u highlight the commit of interest.

As for recovering lost commits, I've been down that road, and using fsc=
k or worse yet looking at all the files in the objects directory is no =
fun.=A0 The 'reflog' is your friend!=A0 Use reflog to spot which one is=
 interesting, and then use something like
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 git tag here HEAD@{5}
and then bring up gitk with "all branches" and sort it out.

--John
(please excuse the footer; it's not my idea)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ G=
S: TRAD) of three operating subsidiaries, TradeStation Securities, Inc.=
 (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a=
 trading software and subscription company, and TradeStation Europe Lim=
ited, a United Kingdom, FSA-authorized introducing brokerage firm. None=
 of these companies provides trading or investment advice, recommendati=
ons or endorsements of any kind. The information transmitted is intende=
d only for the person or entity to which it is addressed and may contai=
n confidential and/or privileged material. Any review, retransmission, =
dissemination or other use of, or taking of any action in reliance upon=
, this information by persons or entities other than the intended recip=
ient is prohibited. If you received this in error, please contact the s=
ender and delete the material from any computer.
