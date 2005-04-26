From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Date: Tue, 26 Apr 2005 14:22:45 +1000
Message-ID: <1114489365.7111.40.camel@gaston>
References: <20050426032422.GQ13467@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 06:20:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQHY4-0003Ef-I5
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 06:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVDZEY1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 00:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVDZEXo
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 00:23:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:45510 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261324AbVDZEXJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 00:23:09 -0400
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j3Q4HhgJ013893;
	Mon, 25 Apr 2005 23:17:44 -0500
To: pasky@ucw.cz, git@vger.kernel.org
In-Reply-To: <20050426032422.GQ13467@pasky.ji.cz>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-04-26 at 05:24 +0200, Petr Baudis wrote:
>   Hello,
> 
>   here goes Cogito-0.8, my SCMish layer over Linus Torvald's git tree
> history tracker. This package was formerly called git-pasky, however
> this release brings big changes. The usage is significantly different,
> as well as some basic concepts; the history changed again (hopefully the
> last time?) because of fixing dates of some old commits. The .git/
> directory layout changed too.
>
> .../...

Unless you already did this in the latest release, it would be nice to
have something like havign all the low level tools be by default in some
~/lib/git or whatever, and only the cg-* scripts in ~/bin on install,
unless maybe you pass some kind of I_AM_A_REAL_GIT=1 on the make
line ...

I don't really plan to use the low level tools, and I don't like the way
they clobber my bin namespace :)

Ben.


