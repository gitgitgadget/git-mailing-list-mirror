From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig 0.7
Date: Thu, 31 May 2007 14:38:08 +0200
Message-ID: <20070531123808.GA25719@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 14:44:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Htk1M-00026m-CE
	for gcvg-git@gmane.org; Thu, 31 May 2007 14:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbXEaMon (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 08:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbXEaMon
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 08:44:43 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:57339 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbXEaMom (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 08:44:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 0A4B9F0076
	for <git@vger.kernel.org>; Thu, 31 May 2007 14:44:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m7kan5-yI9ws for <git@vger.kernel.org>;
	Thu, 31 May 2007 14:44:39 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 93F89F01B0
	for <git@vger.kernel.org>; Thu, 31 May 2007 14:38:08 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id C5E366DFD07
	for <git@vger.kernel.org>; Thu, 31 May 2007 14:36:05 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 826E962A5D; Thu, 31 May 2007 14:38:08 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48808>

Hello,

tig version 0.7 has been released into the wild. Apart from a few bug
fixes, cleanups, and minor improvements, it has support for a very basic
status view, which makes it possible to stage/unstage changes as well as
add untracked files.

Thanks for the patches related to the build/packaging infrastructure.

Grab the tarball at http://jonas.nitro.dk/tig/releases/
or pull it from git://repo.or.cz/tig.git

Following is a slightly edited shortlog:

Greg KH (1):
      Make it possible to install man pages and html files separately

Jakub Narebski (1):
      Infrastructure for tig rpm builds

Jonas Fonseca (22):
      Add TODO item about diff chunk staging/unstaging
      Fix revision graph visualization during incremental updating
      Introduce add_line_text to simplify pager based rendering
      move_view: fix view->offset overflow bug
      Be more paranoid about paths when updating the tree view
      Improve management of view->ref and the title line
      Move space separator from get_key to formatting in open_help_view
      Make keybinding reference more dynamic
      Add string_copy_rev
      Add notice about empty pager view
      Add open method to view_ops
      Refactor add_line_text parts into add_line_data; use it in main_read
      main_read: cleanup and simplify
      Add status view
      Add manpage XSL from git and enhance with literallayout fixes
      Add version information to man pages
      Move "static" version info to VERSION file
      Update sync-docs target to use git porcelain instead of cogito
      Various random Makefile cleanups
      Rename sync-docs to release-doc; add release-dist rule
      tig-0.7

-- 
Jonas Fonseca
