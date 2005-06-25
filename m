From: "David S. Miller" <davem@davemloft.net>
Subject: kernel.org and GIT tree rebuilding
Date: Fri, 24 Jun 2005 21:20:09 -0700 (PDT)
Message-ID: <20050624.212009.92584730.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jun 25 06:14:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm23k-0003lz-DR
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 06:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263331AbVFYEUs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 00:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVFYEUs
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 00:20:48 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31206
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S263331AbVFYEUk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2005 00:20:40 -0400
Received: from localhost ([127.0.0.1])
	by sunset.davemloft.net with esmtp (Exim 4.50)
	id 1Dm29n-0000ls-81
	for git@vger.kernel.org; Fri, 24 Jun 2005 21:20:39 -0700
To: git@vger.kernel.org
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


To get a clean history to push to Linus, I typically blow
away my trees and make fresh ones to stick patches into
which I want to merge.

That mostly works fine here on my local systems, but I know this
brings the master.org mirroring system to it's knees.  So what is the
generally condoned way to do stuff like this in a more friendly way?

Should I:

1) Do a git pull from Linus's tree once he takes my changes, then
   ask GIT to prune the tree?  How do I do that and how does it work?

2) Should I use .git/object/ database symlinking?

   Are there any scripts out there which do this automatically?
   Something as simple to run as "git-pull-script" and it takes
   care of using links when possible on a local filesystem.

It takes sometimes an hour for my tree updates on master.kernel.org
to propagate to rsync.kernel.org so I can ask Linus to pull.
That's crazy.
