From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: [ANNOUNCE] Guilt 0.17
Date: Mon, 8 Jan 2007 04:47:34 -0500
Message-ID: <20070108094734.GF2329@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 10:47:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3r6W-0008Hq-5o
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 10:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965300AbXAHJrg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 04:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965301AbXAHJrg
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 04:47:36 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:58461 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965300AbXAHJrf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 04:47:35 -0500
Received: from filer.fsl.cs.sunysb.edu (IDENT:Qyam4tgrQFEPa8ZVQ0/qnFAyVBl4mFST@localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l089lZLw027563;
	Mon, 8 Jan 2007 04:47:35 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l089lYXw027561;
	Mon, 8 Jan 2007 04:47:34 -0500
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36244>

Guilt v0.17 is available for download.

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


Overall, a lot of good changes that make the whole porcelain more robust.
The most notable one is the format of the status file (lists pushed patches)
which now also includes the hash of the commit object associated with the
patch.

Go ahead, use it, abuse it, and send patches ;)

Josef "Jeff" Sipek.

----------

Changes since v0.16:

Horst H. von Brand (2):
      Fix up Makefiles
      Run regression on the current version

Josef 'Jeff' Sipek (24):
      A minimalistic makefile
      Contributing doc file
      Added guilt-add
      Added guilt-status
      Expanded the HOWTO
      Added usage strings to all commands
      All arguments to guilt-add are filenames
      More thorough argument checking & display usage string on failure
      Changed status file format to include the hash of the commit
      Fixed guilt-refresh doing an unnecessary and somewhat wrong pop&push
      Fixed up guilt-{delete,pop} not matching the patch name properly
      Fixed guilt-{delete,pop} regexps some more
      Force UTC as timezone for regression tests
      Fixed a bug in guilt-pop introduced by the status file format switch
      Error messages should go to stderr
      Merge branch 'usage'
      Merge branch 'status-file'
      Yet another TODO update
      Added guilt-rm
      Makefile update & cleanup
      pop: Display the name of the patch from the status file, not the series file
      new: Create dir structure for the patch if necessary
      Documentation/TODO: Mark guilt-rm as done
      Guilt v0.17

-- 
NT is to UNIX what a doughnut is to a particle accelerator.
