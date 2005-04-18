From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 23:16:52 +0100
Message-ID: <20050418231652.C16789@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <20050417162448.A13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504170926410.7211@ppc970.osdl.org> <20050417195742.D13233@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 00:13:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNeUM-0007pd-2J
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 00:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVDRWRB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 18:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVDRWRB
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 18:17:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16145 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261191AbVDRWQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 18:16:58 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNeY2-000176-BE; Mon, 18 Apr 2005 23:16:54 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNeY1-0005yk-4H; Mon, 18 Apr 2005 23:16:53 +0100
To: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050417195742.D13233@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Apr 17, 2005 at 07:57:42PM +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ok, since the last one was soo successful, and I'm up for more
punishment, here's another attempt.  The diffstat is rather
interesting in this one, claiming no changes.  It should look
like this:

 arch/arm/lib/bitops.h |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+)

However, it seems that git diff can't handle new files appearing
yet.

The other interesting thing to note is that patches are generated
for '-p0' rather than '-p1' application, which is contary to our
historical requirements.  This is going to confuse people - can
we make it generate -p1 patches please?

Linus - assuming I un-messed-up my tree properly (it appears to
be correct and fsck-cache $(commit-id) is happy) please merge
this.  Thanks.

Linus,

Please incorporate the latest ARM changes, which can
be found at:

	master.kernel.org:/home/rmk/linux-2.6-rmk.git

This will update the following files:

 0 files changed

through these ChangeSets:

From: Russell King: Mon Apr 18 22:50:01 BST 2005
	
	[PATCH] ARM: Add missing new file for bitops patch
	
	Signed-off-by: Russell King


-- 
Russell King

