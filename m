From: David Miller <davem@davemloft.net>
Subject: Re: + wireless-fix-iwlwifi-unify-init-driver-flow.patch added to
 -mm tree
Date: Tue, 13 May 2008 22:15:29 -0700 (PDT)
Message-ID: <20080513.221529.20855966.davem@davemloft.net>
References: <200805140405.m4E45oBc015343@imap1.linux-foundation.org>
	<20080513.213927.191790810.davem@davemloft.net>
	<20080513215737.fe1bdebd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linville@tuxdriver.com,
	ron.rindjunsky@intel.com, sfr@canb.auug.org.au,
	tomas.winkler@intel.com, git@vger.kernel.org
To: akpm@linux-foundation.org
X-From: git-owner@vger.kernel.org Wed May 14 07:17:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw9ME-0001an-EJ
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 07:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbYENFPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 01:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbYENFPh
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 01:15:37 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47931
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751583AbYENFPg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2008 01:15:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 208FBC8C1F2;
	Tue, 13 May 2008 22:15:30 -0700 (PDT)
In-Reply-To: <20080513215737.fe1bdebd.akpm@linux-foundation.org>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82071>

From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 13 May 2008 21:57:37 -0700

> This is a(nother) case where a toolchain/process problem is forcing us
> to do something which we don't want to do.  In an ideal world we should
> tell the git developers "we want x, please" and hopefully they can give
> it to us.  Because right now, we're having to work around shortcomings
> in git and we are producing a lesser product as a result of this.  A tool
> should follow the way in which humans want to work, not vice versa.

This has beaten like a dead horse a thousand times.  Bringing
it up again isn't likely to cause further progress. :)

> Short-term...  dunno.  Perhaps you could have a two-weekly
> broadly-announced rebase in which you integrate all these dribs and
> drags back into their proper place?  Commit them with some well-known
> identifier in the title so that they can all be located when that time
> comes?
> 
> If you announce such a rebase a day or so beforehand then all the guys
> who feed into you could get their stuff merged up into your tree to
> minimise their pain when the rebase happens, perhaps.

This, along with the idea of taking care of all of the "dribs" right
before the real merge, is error prone.

It means I have to play with large collections of patches all at one
time.  The reason I use GIT is because I'm stupid and make mistakes,
therefore I don't like playing with patches.

I used to play this game, it's a lot of work and it sucks.  One
"drib" can require fixing up 200 patches down the chain.  And
I've had this happen to me all the time in the past when I was
rebasing all the time.

Not this specific case, mind you, but it is a real concern in general.
