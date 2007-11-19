From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: [ANNOUNCE] Guilt v0.28
Date: Mon, 19 Nov 2007 17:43:49 -0500
Message-ID: <20071119224349.GA9248@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, brandon@ifup.org
To: guilt@josefsipek.net
X-From: git-owner@vger.kernel.org Mon Nov 19 23:44:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuFLh-0004NX-Iu
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 23:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbXKSWn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 17:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbXKSWn4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 17:43:56 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:44610 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbXKSWn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 17:43:56 -0500
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id lAJMhoxS012632;
	Mon, 19 Nov 2007 17:43:50 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id lAJMhncH012630;
	Mon, 19 Nov 2007 17:43:49 -0500
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-07-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65512>

Guilt v0.28 is available for download (once it mirrors out on kernel.org).

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

(kernel.org seems to be slow at mirroring things today, so please be
patient)

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


This release took _far_ too long to make. The major changes since v0.27
include:

 - fix for insecure handling of temporary files (CVE-2007-5207)
 - push and pop now support -n <num> to push/pop specified number of patches
 - import-commit can import any commit from any branch
 - couple of other small bugfixes/tweaks

For more details about any of the commits, check the commits.

As always, patches, and other feedback is welcome.

Josef "Jeff" Sipek.

------------
Changes since v0.27:

David Chinner (1):
      {push,pop}: Add -n <number of patches> option

Erez Zadok (1):
      Documentation fixups

Eric Lesh (2):
      guilt-help: Make guilt-cmd --help show the right man page
      [GUILT PATCH] guilt-import-commit: Import commits from any branch

Josef 'Jeff' Sipek (6):
      {next,prev,top}: Update usage strings & docs
      guilt: Fix insecure handling of temporary files
      patchbomb: Be quiet when there are no Cc lines in patch header
      guilt: fixed bad interaction between push_patch() and git
      guilt: Fixed regexp matching the beginning of the patch
      Guilt v0.28

Peter Zijlstra (1):
      guilt: allow for full path in {top,next,prev}
