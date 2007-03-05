From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: [ANNOUNCE] Guilt v0.21
Date: Sun, 4 Mar 2007 19:44:00 -0500
Message-ID: <20070305004400.GC11920@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 01:44:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO1JN-00072k-35
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 01:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbXCEAoG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 19:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbXCEAoF
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 19:44:05 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:35361 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbXCEAoE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 19:44:04 -0500
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l250i0wn021645;
	Sun, 4 Mar 2007 19:44:00 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l250i0fl021643;
	Sun, 4 Mar 2007 19:44:00 -0500
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41393>

Guilt v0.21 is available for download (once it mirrors out on kernel.org).

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


There have been a lot of changes since v0.20. Some of the most important
ones, include...

1) Allow command abbreviation: 'guilt ser' will have the same effect as
   'guilt series'

2) "guilt push" behavior now matches "quilt push" when patch doesn't apply

3) guilt and guilt-init got a manpage (more will follow in future releases)

4) guilt-import-commit now saves the git Author field as the 'From:' line in
   the patch

5) guilt-refresh checks if there is a patch applied before trying to refresh
   changes

6) Several sanity checks

I know I either say it, or at least think it each time I make a release, but
really, this is the best release of Guilt yet. :)

As always, patches, and other feedback is welcome.

Josef "Jeff" Sipek.

------------
Changes since v0.20:

Brandon Philips (1):
      Initial guilt documentation

Josef 'Jeff' Sipek (14):
      makefile: Include import-commit in list of scripts
      Fixed do_make_header to include From:
      push: Fixed unkown patchname pushing all patches
      add/rm: Use print_usage instead of using $USAGE directly
      guilt: Document push_patch's new argument
      refresh: Make sure there is a patch applied before doing a refresh
      Reorder makefile rules & use .PHONY
      docs: Commands should be on a separate line
      Ignore *.html, *.1 and *.7 in Documentation/
      refresh: Use ~ as the backup file suffix
      Install manpages to $(PREFIX)/man
      Removed print_usage as it shouldn't be used
      help: A simple help command
      Guilt v0.21

Theodore Ts'o (1):
      Make "guilt push" match "quilt push" when the patch doesn't apply

Yasushi SHOJI (7):
      Allow command abbreviation
      Guilt: Format command list in usage
      Guilt: Do not allow patch name duplication
      Guilt: Replace print_usage and exit 1 with usage and die in git-sh-setup
      Guilt: add -v to guilt-series
      Guilt: series -v: Fix zero applied patch case
      Guilt: add a new command "files"
