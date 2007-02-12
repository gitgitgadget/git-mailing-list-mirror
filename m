From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: [ANNOUNCE] Guilt v0.19
Date: Mon, 12 Feb 2007 14:48:17 -0500
Message-ID: <20070212194816.GB12616@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 12 20:49:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGhAh-0006Pj-Ek
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 20:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965351AbXBLTsU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 14:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965353AbXBLTsU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 14:48:20 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:37801 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965351AbXBLTsT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 14:48:19 -0500
Received: from filer.fsl.cs.sunysb.edu (IDENT:7u+PDi6/h+A+IwXT9RjP19zbD3szAUnt@localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l1CJmHrJ014948;
	Mon, 12 Feb 2007 14:48:17 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l1CJmH2V014946;
	Mon, 12 Feb 2007 14:48:17 -0500
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39427>

Guilt v0.19 is available for download (once it mirrors out on kernel.org).

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


The most important change is the use of the patch file's mtime as the
GIT_{AUTHOR,COMMITTER}_DATE. Without this change, repeated invocations of
"guilt pop -a; guilt push -a" would create new commit's with different
commit dates, creating a lot of garbage commits. Other changes are mostly
related to expanding (and slightly fixing) the regression scripts.

Josef "Jeff" Sipek.

------------

Changes since v0.18:

Josef 'Jeff' Sipek (18):
      guilt-applied: added -c to list the commit hash for the patch
      guilt-new: Fix [ syntax
      patchbomb: Friendly wrapper for git-format-patch & git-send-email
      delete: Added argument -f to remove patch file
      Guilt v0.19-rc1
      regression: test new patch insertion
      regression: test new patch insertion at the end
      regression: Test push/pop given a patch name
      regression: Test for guilt-init in a already initialized branch
      regression: Test guilt-init on non-master branch
      regression: Fix test descriptions
      Centralize editor determining code
      new: added -e to edit the patch description interactively
      Makefile: Forgot to add guilt-patchbomb to the list of scripts
      regression: Fix regression test failure
      patchbomb: Added -n flag
      regression: Fixed regression suite failure
      Guilt v0.19

Theodore Ts'o (1):
      Use patch file's modtime as the git author and commiter date
