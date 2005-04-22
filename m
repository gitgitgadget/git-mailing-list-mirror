From: Petr Baudis <pasky@ucw.cz>
Subject: [ANNOUNCE] git-pasky-0.6.3 && request for testing
Date: Fri, 22 Apr 2005 05:09:31 +0200
Message-ID: <20050422030931.GA14565@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 22 05:05:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOoTj-0008Ss-50
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 05:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVDVDJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 23:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVDVDJk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 23:09:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42383 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261928AbVDVDJc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 23:09:32 -0400
Received: (qmail 16945 invoked by uid 2001); 22 Apr 2005 03:09:31 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  FYI, I've released git-pasky-0.6.3 earlier in the night. It brings
especially plenty of bugfixes, but also some tiny enhancements, like
colored log and ability to pick branch in the remote repository. git log
and git patch now also accept range of commits, so e.g. if you do

	git patch linus:this

you should get a sequence of patches (commit message + patch, with
delimiters between patches) which will bring you from linus to your
current HEAD. Of course the package is in sync with Linus' branch.

  Get it at

	http://pasky.or.cz/~pasky/dev/git/

or pull (it should work fine, no format changes).


  Not released stay changes I made later tonight, which change
git-pasky's usage of directory cache - it will record adds/removals to
it and use diff-cache instead of show-diff to check any differences. The
code is much simpler, but likely some small bugs were introduced in the
process - please report any problems you'll hit, and test heavily. What
is known is that you cannot diff specific files now.

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
