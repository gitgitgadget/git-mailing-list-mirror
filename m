From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: More help with "pull" please
Date: Wed, 1 Apr 2009 15:28:51 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A7D4D9A@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 01 21:33:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp6BT-0006IA-RN
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 21:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbZDATbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 15:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbZDATbh
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 15:31:37 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:49116 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351AbZDATbg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 15:31:36 -0400
X-ASG-Debug-ID: 1238614288-303e012a0006-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP id 0C93D27B157
	for <git@vger.kernel.org>; Wed,  1 Apr 2009 15:31:29 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id gdPJRaToj3dPWkxb for <git@vger.kernel.org>; Wed, 01 Apr 2009 15:31:29 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.122]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Apr 2009 15:29:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: More help with "pull" please
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: More help with "pull" please
Thread-Index: AcmzABZiihTvVFwJS5uATzoQ194x1Q==
X-OriginalArrivalTime: 01 Apr 2009 19:29:43.0719 (UTC) FILETIME=[35966370:01C9B300]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1238614289
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115409>

I've actually given up on using "git pull" at all, preferring to fetch
first, examine in gitk, and then decide whether to merge or whatever.

The problem I have is that it seems to always want to merge "something"
with the current checked-out branch.  It always throws the remote HEAD
into the mix, or if fetch lines are set up in the configuration file,
takes the first thing on there regardless of which branch I'm currently
checked out.  Maybe I'm wrong, but I just re-read the man page, forward
and backwards, and am more bewildered than ever.

Anyway, I want to help out a co-worker who has a more specialized
situation that may be right for a pull.  Also, I'll talk him through
cloning the remote from the beginning, so the config files won't be all
strange or not setup from the previous users.

The only remaining issue is the remote in question:  it is not a bare
repository, and may be in use locally as well, at least for maintenance.
So I can't trust its HEAD to be anything reasonable at any given time.

This person wants to track a remote branch tip.  When that advances or
otherwise changes on the remote, update the working tree to match.  It
will always use the same branch, let's call it ReleaseCandidate for this
discussion.

My question is:  What is the easiest way to create this local repository
and operate it so that he can just keep it following that branch on the
remote?

Thanks,
--John
(excuse the footer; it's not my idea)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
