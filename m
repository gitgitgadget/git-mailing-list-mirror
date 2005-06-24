From: Matt Mackall <mpm@selenic.com>
Subject: Mercurial 0.6 released!
Date: Fri, 24 Jun 2005 14:24:07 -0700
Message-ID: <20050624212407.GV27572@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jun 24 23:24:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlvep-00014W-4a
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 23:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbVFXVaX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 17:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbVFXVaU
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 17:30:20 -0400
Received: from waste.org ([216.27.176.166]:59607 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263267AbVFXVYP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 17:24:15 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5OLO7Y1001657
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 24 Jun 2005 16:24:07 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j5OLO76w001654;
	Fri, 24 Jun 2005 16:24:07 -0500
To: mercurial@selenic.com, linux-kernel <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is release 0.6 of Mercurial, the distributed SCM.

Mercurial is:
 - fast: as fast or faster than git or others for all important operations
 - easy to use: familiar commands, integrated help, integrated web server
 - space efficient: Linux kernel history back to 2.4.0 in 300MB
 - bandwidth efficient: 120MB to transfer that history
 - distributed: supports decentralized development with arbitrary merging
 - scalable: handles large numbers of files and revisions effortlessly
 - robust: append-only storage model with journalling and rollback
 - lightweight: small Python codebase

Available at http://selenic.com/mercurial/
Linux kernel repository at http://www.kernel.org/hg/

This release contains a huge number of improvements:

improved source tracking
  multi-head support
  permission tracking
  rename and copy tracking
  improved tag handling
friendlier, more robust command line interface
  integrated help
  faster startup
  better exception handling
  smarter three-way merge helper
improved communication
  faster outstanding changeset detection
  SSH-based push support
  non-transparent proxy support
improved configuration handling
  support for .hgrc and .hg/hgrc files
  save per-repo defaults for pull
new delta extension
  faster, smaller, and simpler than GNU diff or xdiff
  faster commit, push/pull, and annotate
improved interoperability
  convert-repo framework for importing from other SCMs 
  can work with gitk and git-viz
portability improvements
  tested on big and little-endian 32 and 64-bit UNIX platforms
  Windows support is nearly complete
and much more
  numerous performance tweaks and bugfixes
  automated test suite
  updated docs and FAQ


-- 
Mathematics is the supreme nostalgia of our time.
