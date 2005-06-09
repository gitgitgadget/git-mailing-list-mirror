From: Petr Baudis <pasky@ucw.cz>
Subject: [ANNOUNCE] Cogito-0.11.3
Date: Thu, 9 Jun 2005 11:19:09 +0200
Message-ID: <20050609091909.GF29665@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 09 11:56:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgJ8V-0002WK-Tn
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 11:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVFIJTQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 05:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVFIJTQ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 05:19:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23277 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262313AbVFIJTL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 05:19:11 -0400
Received: (qmail 19922 invoked by uid 2001); 9 Jun 2005 09:19:10 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  it turned out that Cogito was so broken w.r.t. three-way merging that
I had to really release a bugfix version. So this version contains some
cleanups of the merge script, some more portability fixes (it actually
runs on Debian old stable now!), and especially few bugfixes - cg-log
works with individual files passed to it now, and merging should
hopefully work correctly now too.

  You know what to do. :-)


Junio C Hamano:
  Add read-tree -m 3-way merge tests.

Linus Torvalds:
  One more time.. Clean up git-merge-one-file-script
  Fix up git-merge-one-file-script
  Merge my and Petr's git-merge-one-file-script modifications
  Make sure we error out if we can't remove a file on automatic merges.

Petr Baudis:
  cogito-0.11.3
  Fix cg-merge's three-way content merge
  Support for compilation w/o OpenSSL
  Portable stub for the stat call
  Fix cg-diff -p to work with no -r specified
  git-merge-one-file-script cleanups from Cogito
  Further converge git-merge-one-file-script and cg-Xmergefile
  Remove useless ret=0 in the onefile merge scripts
  Make git-merge-one-file-script and cg-Xmergefile converge even more
  Fix cg-log called on specified files
  Tidy up some rev-list-related stuff
  Fix git-merge-one-file permissions auto-merging

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
