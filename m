From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
Subject: [ANNOUNCE] Guilt v0.29
Date: Wed, 19 Mar 2008 01:29:32 -0400
Message-ID: <20080319052932.GC11349@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: guilt@josefsipek.net
X-From: git-owner@vger.kernel.org Wed Mar 19 21:01:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4T6-0001jY-1R
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759410AbYCSTtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759405AbYCSTtK
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:49:10 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:34756 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756135AbYCSTtI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:49:08 -0400
Received: from josefsipek.net (baal.fsl.cs.sunysb.edu [130.245.126.78])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id m2J5TV2p001988;
	Wed, 19 Mar 2008 01:29:31 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id B2C1A1C008A2; Wed, 19 Mar 2008 01:29:32 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77525>

Guilt v0.29 is available for download (once it mirrors out on kernel.org).

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


This release is quite uneventful.  It is made up of a few fixes here and
there, and complete regression suite rewrite.  Unfortunately, most of the
exciting Guilt development went on in a topic branch, but the changes are
far too invasive for me to include them in v0.29, so I'm going to merge that
in for v0.30.

As always, patches, and other feedback is welcome.

Josef "Jeff" Sipek.

------------
Changes since v0.28:

Josef 'Jeff' Sipek (20):
      repair: new command to repair repository state
      patchbomb: Git parses the patch mboxes and extracts Cc lines automatically
      push: fix whitespace handling
      regression: rewrote regression suite core
      regression: test 010: test the init code
      regression: test 011: test failure of commands on non-init'd repo
      regression: test 020: test push code
      regression: test 023: test top code
      regression: test 021: test pop code
      regression: test 060: test files code
      regression: test 022: test applied code
      regression: test 024: test unapplied code
      regression: test 025: test new code
      regression: test 026: test delete code
      regression: test 027: test refresh code
      push: output current patch name, not cmd-line argument
      Use 'git <cmd>' instead of 'git-cmd'
      header: fix patch name existence in the series
      regression: add tests for guilt-header
      Guilt v0.29
