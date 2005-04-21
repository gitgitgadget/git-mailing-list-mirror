From: Pavel Roskin <proski@gnu.org>
Subject: Switching between branches
Date: Wed, 20 Apr 2005 21:42:39 -0400
Message-ID: <1114047759.20044.22.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 21 03:38:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOQeC-0001wu-7K
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 03:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVDUBmr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 21:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVDUBmr
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 21:42:47 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:39114
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261176AbVDUBmm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 21:42:42 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id E40B9EFF27; Wed, 20 Apr 2005 21:42:39 -0400 (EDT)
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

Perhaps it's a naive question, but how do I switch between branches?  I
mean an equivalent of "svn switch" or "cvs update -r branch" that would
reuse the existing working directory.

I tried to switch a git-pasky working directory to the linus branch.

Here's what I tried:

git track linus
git cancel
git pull
git cancel
git merge linus
git cancel

After all that I found that README is still from the pasky branch.

Then I tried "git merge -b pasky linus" - this actually changed the
files to the linus branch, but it didn't remove files specific to
git-pasky.  Also, I'm surprised that I had to specify "-b pasky", as if
the currently checked out branch is unknown.

I'm using git-pasky 0.6.2.

-- 
Regards,
Pavel Roskin

