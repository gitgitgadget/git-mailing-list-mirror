From: Petr Baudis <pasky@ucw.cz>
Subject: -p diff output and the 'Index:' line
Date: Sun, 29 May 2005 09:15:20 +0200
Message-ID: <20050529071520.GC1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 29 09:13:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcHyx-00068O-GX
	for gcvg-git@gmane.org; Sun, 29 May 2005 09:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVE2HP0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 03:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVE2HP0
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 03:15:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36581 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261261AbVE2HPW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 03:15:22 -0400
Received: (qmail 5736 invoked by uid 2001); 29 May 2005 07:15:20 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  so I've tried how would cg-diff output look like if I used the
git-diff -p argument, and I found that I miss the 'Index:' line.
Actually, what I really miss is the separator ==== line just below, but
it'd probably look weird without the 'Index:' line. I became used to the
separators and they enable me to quickly visually notice the files
boundary, which is more drudging if you have just the 'diff --git' line.

  What do you think? Would you hate it to show up in the diffs, or are
you ok with it?

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
