From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: Help designing work flow
Date: Thu, 5 Mar 2009 15:17:36 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709F07D30@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 21:19:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfK2F-0003EL-NE
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 21:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbZCEURn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 15:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754974AbZCEURl
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 15:17:41 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:54028 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbZCEURl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 15:17:41 -0500
X-ASG-Debug-ID: 1236284258-7d8100f50000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP id 380291F006E
	for <git@vger.kernel.org>; Thu,  5 Mar 2009 15:17:38 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id mOY2xtnNGKdwhcoi for <git@vger.kernel.org>; Thu, 05 Mar 2009 15:17:38 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Mar 2009 15:17:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: Help designing work flow
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Help designing work flow
Thread-Index: Acmdz2y0+xbrsf/lSw+b8cjSBdT3aQ==
X-OriginalArrivalTime: 05 Mar 2009 20:17:37.0449 (UTC) FILETIME=[6D4F8990:01C99DCF]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236284258
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112333>

I know we (my group) should use "topic" branches and apply them back to
the dev branch when done.  There is concern that the commit history gets
too full of detailed stuff, especially with several developers, that you
can't tell what "really changed".  So, our dev branch should appear to
contain only commit nodes representing completed assignments; not every
day's checkpoint and trying to keep one's own stuff on top to avoid
merging later.

I guess that's how it is on these Open Source projects where patches are
submitted by email and applied by the maintainer.  We don't see the
details, just the final patch.  But, my situation will be developers
gathered around an in-house master repo, and everyone should be able to
push their own changes as assignments are completed.

What is the best procedure to achieve that?  Or what are some good
alternatives with trade-offs?

I see that if a topic branch is merged (disabling FF if applicable), the
main line (leftmost parent) will be a history of completed topics.  But,
we don't need to keep the detailed side-branches forever, and even if
gitk and other visualization  tools can be told to just show the main
line, advanced use such as git log this..that will forever be packed
with the micro-details.

So, unless someone has more input along that line, I'm assuming that we
want to apply the completed topic as a single-parent commit.  That is
the natural result if preparing patches and then applying them, but is
there a simpler, direct way to do that in git?

The detailed topic branches can be kept around for a while, for the
original author to extend if it needs to be returned to, and to examine
if the gestalt change in the single commit is too overwhelming to
understand, or to help figure out what might have broken.  But after a
while they can be deleted and then gc will free up the disk space.

Anything else I should look into?

--John


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
