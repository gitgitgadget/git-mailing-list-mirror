From: Paul Mackerras <paulus@samba.org>
Subject: version 0.91 of gitk out now
Date: Sun, 15 May 2005 23:11:25 +1000
Message-ID: <17031.19069.345408.888580@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun May 15 15:11:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXIuA-00089V-WE
	for gcvg-git@gmane.org; Sun, 15 May 2005 15:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVEONLs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 09:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVEONLs
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 09:11:48 -0400
Received: from ozlabs.org ([203.10.76.45]:13743 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261390AbVEONLr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 09:11:47 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id C3262679F2; Sun, 15 May 2005 23:11:45 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have just put version 0.91 of gitk on ozlabs.org at:

	http://ozlabs.org/~paulus/gitk-0.91

(that's the actual script, just wget it and run it).

New features in version 0.91 include a menu bar, a widget to show the
SHA1 id of the selected commit, a find facility for searching for
commits, better error handling, and the ability to increase and
decrease the font size with control-KP+ and control-KP- (and
control-equal and control-minus).

Gitk is a commit viewer written in Tcl/Tk.  Its main features are a
compact and clear representation of the commit graph and the fact that
it shows the headline, author and date of each commit in the summary
window, allowing developers to scan quickly through a large number of
commits and home in on the ones of interest to them.  When a commit is
selected, the full commit message is shown, along with the colorized
diff for commits that have one parent.

Apart from the -b (use bold font for names), -c (color the commit
graph according the the committer) and -d (order commits by date)
options, all other arguments to gitk are passed to git-rev-tree to
allow the user to specify which commits to display.

Paul.
