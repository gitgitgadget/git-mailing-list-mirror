From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: [ANNOUNCE] Guilt v0.20
Date: Wed, 21 Feb 2007 01:08:49 -0500
Message-ID: <20070221060849.GA3856@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 21 07:09:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJkfA-00019C-Rz
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 07:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbXBUGIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 01:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbXBUGIy
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 01:08:54 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:39956 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbXBUGIx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 01:08:53 -0500
Received: from filer.fsl.cs.sunysb.edu (IDENT:5a7cTDwWffBqA1ClJWItxr1Yc/z0TwZK@localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l1L68oVq004970;
	Wed, 21 Feb 2007 01:08:50 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l1L68nW1004968;
	Wed, 21 Feb 2007 01:08:49 -0500
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40282>

Guilt v0.20 is available for download (once it mirrors out on kernel.org).

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git

 
Pretty much all the changes are related to the patchbomb and import-commit
scripts. They now take a range of commits in one of these formats:

      <hash>		- one commit
      <hash>..		- hash until head (excludes hash, includes head)
      ..<hash>		- until hash (includes hash)
      <hash1>..<hash2>	- from hash to hash (inclusive)

Josef "Jeff" Sipek.

------------
Changes since v0.19:

Brandon Philips (1):
      guilt: Silence command echoing for echos in Makefile

Josef 'Jeff' Sipek (7):
      import-commit: simple commit to patch importer
      munge_hash_range: Helper function
      patchbomb: Use munge_hash_range
      import-commit: Use munge_hash_range
      patchbomb: Don't ask for the intro email if sending only one patch
      Centralize pager determining code
      Guilt v0.20
