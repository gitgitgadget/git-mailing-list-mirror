From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: [ANNOUNCE] Guilt v0.23
Date: Tue, 20 Mar 2007 20:25:29 -0400
Message-ID: <20070321002529.GA17011@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 01:25:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HToe0-0000fp-N5
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 01:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbXCUAZd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 20:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbXCUAZd
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 20:25:33 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:44318 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbXCUAZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 20:25:31 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l2L0PTgZ018192;
	Tue, 20 Mar 2007 20:25:29 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l2L0PTJx018190;
	Tue, 20 Mar 2007 20:25:29 -0400
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42769>

Guilt v0.23 is available for download (once it mirrors out on kernel.org).

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


There are two brand new commands: fork and fold. A few minor bugs related to
really unusual patch names (containing commas) were fixed. And finally, each
command has a manual page!

As always, patches, and other feedback is welcome.

Josef "Jeff" Sipek.

------------
Changes since v0.22:

Brandon Philips (2):
      Get usage information from the USAGE variable
      Remaining guilt documentation

Josef 'Jeff' Sipek (14):
      Docs: Ignore generated usage-*.txt files
      Docs: Consistified the man pages
      Docs: Reimplemented cmd-list generation script in sh
      Docs: Added import-commit manpage
      Docs: Fixed up patchbomb documentation
      Docs: Include version Guilt version number in page footer
      Remove pop_patch as there are no real users
      fold: fold a patch into the topmost patch
      delete: use series_remove_patch instead of opencoding the logic
      fold: fixed patch backup creation
      Docs: guilt-fold manpage
      new: escape new patch name properly when changing the series file
      fork: fork the topmost applied patch
      Guilt v0.23
