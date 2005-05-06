From: Paul Mackerras <paulus@samba.org>
Subject: Version of dirdiff to display diffs between git trees
Date: Fri, 6 May 2005 23:18:30 +1000
Message-ID: <17019.28326.351036.268948@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 06 15:13:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU2cF-0003ho-Od
	for gcvg-git@gmane.org; Fri, 06 May 2005 15:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVEFNSS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 09:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVEFNSS
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 09:18:18 -0400
Received: from ozlabs.org ([203.10.76.45]:63465 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261221AbVEFNSN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 09:18:13 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7F45167B3D; Fri,  6 May 2005 23:18:12 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have adapted my "dirdiff" program to be able to display differences
between git trees (without checking them out).  It can display the
differences between up to 5 trees, each of which can be either a git
tree (identified by a tree id, a commit id or a tag) or the working
directory.

The main window summarizes which files have changed.  Double-clicking
on a file name pops up a diff viewer window which displays the
differences between the different versions of the file in a
color-coded unidiff format.  I find it useful to copy .git/HEAD to
.git/OLD_HEAD before doing an update on my linux-2.6 repository, and
then after the update do

	girdiff OLD_HEAD HEAD

to see what has changed.  With the file list I can easily skip over
files that I'm not interested in and then use the diff viewer to look
at changes to files that I do care about.

I have called this version "girdiff" to distinguish it from my normal
dirdiff releases.  It is available at:

	http://ozlabs.org/~paulus/girdiff

If invoked as girdiff, or if invoked as dirdiff and the -g flag is
given, it will interpret its arguments as git trees rather than
directory or file names.  As a special case, the working directory is
indicated by ".".

This is still under development and there are probably bugs - let me
know if you find any.

Paul.



