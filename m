From: Petr Baudis <pasky@ucw.cz>
Subject: [ANNOUNCE] git-pasky-0.7
Date: Sun, 24 Apr 2005 02:59:23 +0200
Message-ID: <20050424005923.GA8859@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 24 02:55:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPVOg-0001mg-La
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 02:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVDXA7j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVDXA7j
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:59:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55993 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262211AbVDXA7Z (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 20:59:25 -0400
Received: (qmail 18118 invoked by uid 2001); 24 Apr 2005 00:59:23 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  this is the last release of git-pasky, my SCMish layer over Linus' git
tree history storage tool. The next releases will be called 'cogito' and
will feature a significantly reworked user interface (finally). Get
git-pasky-0.7 at

	http://www.kernel.org/pub/software/scm/cogito

or

	ftp://ftp.kernel.org/pub/software/scm/cogito

  You can also pull, but actually you might as well not want to do that
if you don't know that you will be able to recover possible
inconsistencies (for no local changes, read-tree $(tree-id) &&
checkout-cache -f -a && update-cache --refresh should do). The
pulling/merging tools in older versions contain bugs which _might_
affect this pull.

  The biggest change is in the way the directory cache is used (this is
internal thing, nothing user-visible except less bugs). Now that we have
diff-cache, git-pasky uses that instead of show-diff, and drops the
add/rm queues. This also makes the diffs coming from git diff more
consistent-looking.

  To pick randomly from the other changes - older zlib compatibility,
always use bash, git patch output changes/fixes, git log timezone fix,
plenty of bugfixes and of course merges with Linus. Thanks to all the
contributors!

  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
