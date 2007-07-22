From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Git tree for old kernels from before the current tree
Date: Mon, 23 Jul 2007 06:13:14 +0900
Message-ID: <20070722211314.GA13850@linux-sh.org>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com> <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 23:13:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICikK-0004LM-B7
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 23:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757361AbXGVVNk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 17:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755841AbXGVVNk
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 17:13:40 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:37369 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751657AbXGVVNj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 17:13:39 -0400
Received: from smtp.ocgnet.org (localhost [127.0.0.1])
	by smtp.ocgnet.org (Postfix) with ESMTP id CA9165203FB;
	Sun, 22 Jul 2007 16:13:37 -0500 (CDT)
X-Spam-Checker-Version: SpamAssassin 3.1.8-gr1 (2007-02-13) on smtp.ocgnet.org
X-Spam-Level: *
X-Spam-Status: No, score=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL,
	SPF_HELO_PASS autolearn=no version=3.1.8-gr1
Received: from smtp.ocgnet.org (localhost [127.0.0.1])
	by smtp.ocgnet.org (Postfix) with ESMTP id 5F8D75203FE;
	Sun, 22 Jul 2007 16:13:37 -0500 (CDT)
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp [124.34.33.190])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ocgnet.org (Postfix) with ESMTP id B92535203FB;
	Sun, 22 Jul 2007 16:13:36 -0500 (CDT)
Received: from localhost (unknown [127.0.0.1])
	by master.linux-sh.org (Postfix) with ESMTP id D397064C7C;
	Sun, 22 Jul 2007 21:13:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at linux-sh.org
Received: from master.linux-sh.org ([127.0.0.1])
	by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kjZvsLwOBDnn; Mon, 23 Jul 2007 06:13:14 +0900 (JST)
Received: by master.linux-sh.org (Postfix, from userid 500)
	id 7547064C80; Mon, 23 Jul 2007 06:13:14 +0900 (JST)
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53320>

On Sun, Jul 22, 2007 at 11:00:15PM +0200, Jan Engelhardt wrote:
> On Jul 22 2007 16:49, Jon Smirl wrote:
> > Continuing on with kernel archeology for embedded systems, any
> > interest in making a git tree with all of the kernel versions from the
> > beginning up to the start of the current git tree?
> 
> Well, it would be cool if history was somehow available (I recognize
> this would be a lot of work). One currently has to go through the
> bk repo if something is to be searched for in that timeframe.
> 
Err, that's crap. Have you even looked at gitweb? There's at least:

git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git

This has trees all the way back to 2.5.0.

and Linus also has:

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/old-2.6-bkcvs.git

for the BK history.

That's already more history than most people have any immediate use for,
going beyond that starts getting in to general completeness before
practical application territory.

Anyone still sending 2.4 patches with the intent of them being moved
forward and applied to a current kernel needs to be killfiled.
