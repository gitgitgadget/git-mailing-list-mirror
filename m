From: Paul Mackerras <paulus@samba.org>
Subject: gitk-1.1 out
Date: Wed, 1 Jun 2005 20:09:15 +1000
Message-ID: <17053.35147.52729.794561@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 01 12:08:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdQ7V-0000rS-Md
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 12:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVFAKJ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 06:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVFAKJ1
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 06:09:27 -0400
Received: from ozlabs.org ([203.10.76.45]:25547 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261171AbVFAKJW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 06:09:22 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 78950679F2; Wed,  1 Jun 2005 20:09:20 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The latest version of gitk is at:

	http://ozlabs.org/~paulus/gitk/gitk-1.1.tar.gz

(yes, a real tarball this time, with a README even. :)

New features in this version include:

* Commits that are pointed to by a tag in .git/refs/tags are now
  marked with a little yellow "luggage label" shape attached to the
  circle representing the commit.  The tag name is written on the
  label.

* Gitk now uses git-rev-list instead of git-rev-tree.  This means it
  should be faster when looking at just a small range of commits.
  Instead of using "gitk HEAD ^ORIG_HEAD" though, you need to use
  "gitk HEAD ORIG_HEAD"; the arguments are passed to git-rev-list,
  which takes slightly different arguments from git-rev-tree.
  Unfortunately gitk still needs to see the whole git-rev-list output
  before it can start to draw the graph; I plan to address this.

* You can now type a tag name or a SHA1 id in the SHA1 field, and
  press return or the "Goto" button to jump to that commit.

Paul.
