From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: [ANNOUNCE] Guilt v0.24
Date: Sun, 29 Apr 2007 17:05:37 -0400
Message-ID: <20070429210537.GD4163@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161379AbXD2VGJ@vger.kernel.org Sun Apr 29 23:07:11 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161379AbXD2VGJ@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiGbs-0000aI-MX
	for glk-linux-kernel-3@gmane.org; Sun, 29 Apr 2007 23:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161379AbXD2VGJ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 29 Apr 2007 17:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161368AbXD2VGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Apr 2007 17:06:08 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:46013 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161340AbXD2VFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Apr 2007 17:05:40 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l3TL5bwk007902;
	Sun, 29 Apr 2007 17:05:37 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l3TL5bW6007900;
	Sun, 29 Apr 2007 17:05:37 -0400
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45840>

Sorry for the delayed announcement...

Guilt v0.24 is available for download.

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


The major changes are in status and fork commands. guilt-status now accepts
a number of flags to display only certain subset of changed files (e.g.,
only newly added files). guilt-fork is now smarter about the naming of
patches - following quilt's lead.

Additionally, Brandon Philips, went a head, and create a Debian package for
Guilt. So, if you are a Debian Unstable user, you can Guilt through apt.

As always, patches, and other feedback is welcome.

Josef "Jeff" Sipek.

------------
Changes since v0.23:

Eric Lesh (4):
      guilt-fork: Rename patches sequentially (ala quilt)
      guilt-fork: Use first argument (if given) as name of new patch
      Documentation/guilt-fork: document argument to choose name of new patch
      guilt: Add -h option to show man pages

Josef 'Jeff' Sipek (7):
      status: Major cleanup of status
      Docs: Document all options for status
      status: Added -n to hide status prefix from ouput
      status: change into the top of the repo before checking for changes
      Docs: Fixed up description of series -v
      pop: Added -f to force popping of the patch
      Guilt v0.24
