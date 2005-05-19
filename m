From: Paul Mackerras <paulus@samba.org>
Subject: gitk-1.0 released
Date: Thu, 19 May 2005 23:05:20 +1000
Message-ID: <17036.36624.911071.810357@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu May 19 15:07:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYkin-0007tz-V5
	for gcvg-git@gmane.org; Thu, 19 May 2005 15:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVESNGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 09:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVESNGM
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 09:06:12 -0400
Received: from ozlabs.org ([203.10.76.45]:17374 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262487AbVESNFW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 09:05:22 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id DA4E467A03; Thu, 19 May 2005 23:05:20 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have released a new version of gitk.  I got brave and called it 1.0
and it is at:

	http://ozlabs.org/~paulus/gitk-1.0

(that's the actual script itself).

Gitk is a git commit viewer with the following features:

* Clear and compact representation of the commit graph
* Displays headline, author and date of each commit in the
  summary window
* Displays the full details of one commit - the comments,
  list of files and colorized diff - in the details window
* Find function for searching through commits
* Displays the SHA1 ID of the selected commit and makes it
  the X selection so it can be pasted into other windows
* Convenient key bindings for scanning through each commit
  in turn

Gitk passes its command-line arguments to git-rev-tree to allow you to
select the range of commits to display.  With no arguments it will
display all the commits starting at HEAD.

The key bindings are:

up or p: select the commit on the next line up from the current one
down or n: select the commit on the next line down from the current one
pageup: scroll the commit summary window up one page
pagedown: scroll the commit summary window down one page
delete or backspace or b: scroll the details window up one page
space: scroll the details window down one page
u: scroll the details window up 18 lines
d: scroll the details window down 18 lines
f: move to the start of the next file diff in the details window
^F: search for commits matching the search string
^G or /: select the next commit matching the search string
^R or ?: select the previous commit matching the search string
^- or ^KP-: reduce the font size
^= or ^KP+: increase the font size
^Q: quit.

Features added since the last release include:

* Better error handling.
* Gitk now remembers the layout of the window, so if you adjust the
  sizes of the panes to suit, then quit and restart, it should display
  the panes in the proportions you have chosen.
* Instances of the search string are now highlighted in the details
  window as well as the summary window.
* The circle diameter and line thickness now scale with the font size.
* Accommodates the new git-diff-tree output format.

Paul.
