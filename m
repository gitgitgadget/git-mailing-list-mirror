From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 00/19] gitweb: Remove dependency on external diff and
 need for temporary files
Date: Sat, 26 Aug 2006 20:42:08 -0700 (PDT)
Message-ID: <20060826.204208.85688529.davem@davemloft.net>
References: <200608240015.15071.jnareb@gmail.com>
	<200608252315.57181.jnareb@gmail.com>
	<Pine.LNX.4.64.0608262026230.11811@g5.osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 05:42:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHBXP-000748-Jz
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 05:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWH0DmM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 23:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWH0DmM
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 23:42:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:30406
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751180AbWH0DmM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 23:42:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 3D4A1AE45F6;
	Sat, 26 Aug 2006 20:42:08 -0700 (PDT)
To: torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.64.0608262026230.11811@g5.osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26085>

From: Linus Torvalds <torvalds@osdl.org>
Date: Sat, 26 Aug 2006 20:30:49 -0700 (PDT)

> Ok, can we now please fix my final annouyance, which is that gitweb from 
> the very beginning has apparently believed that the "Signed-off-by:" etc 
> lines are not important, and they get stripped away when looking at the 
> "commit-diff".

Isn't this to keep the email address from being published on the web
and thus harvested by spammers?

If it will obfuscate the email address, that's fine I guess.
