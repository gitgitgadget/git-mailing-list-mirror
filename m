From: Petr Baudis <pasky@ucw.cz>
Subject: Bug in merge-base
Date: Tue, 19 Apr 2005 23:31:43 +0200
Message-ID: <20050419213143.GC9305@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 23:28:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO0Fx-0007D4-66
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 23:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVDSVbu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 17:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVDSVbu
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 17:31:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59078 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261667AbVDSVbt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 17:31:49 -0400
Received: (qmail 22328 invoked by uid 2001); 19 Apr 2005 21:31:43 -0000
To: barkalow@iabervon.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  I've hit a strange bug in merge-base I don't want to debug now. ;-)
I've been doing my regular git pull test from my main branch, but
suddenly git merge wanted to do a tree merge instead of fast-forward.
What went wrong?

  The commits tree looks like:

  36c764 -- 808162 -- ...... -- 8e08e7
  5b53d3 -'

(see the rev-tree output at
http://pasky.or.cz/~pasky/dev/git/stuff/rev-tree)

  The problem is, merge-base hints me wrong:

  $ merge-base 8e08e7 808162
5b53d3

instead of 808162.

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
