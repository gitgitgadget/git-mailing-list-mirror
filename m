From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Stacked GIT 0.4
Date: Sat, 09 Jul 2005 10:05:39 +0100
Message-ID: <1120899939.7125.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 09 11:05:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrBHV-0006vk-4r
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 11:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbVGIJFo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 05:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbVGIJFo
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 05:05:44 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:42223 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S263171AbVGIJFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 05:05:42 -0400
Received: from aamta09-winn.ispmail.ntl.com ([81.103.221.35])
          by mta07-winn.ispmail.ntl.com with ESMTP
          id <20050709090541.DHKW481.mta07-winn.ispmail.ntl.com@aamta09-winn.ispmail.ntl.com>;
          Sat, 9 Jul 2005 10:05:41 +0100
Received: from cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com ([81.104.192.179])
          by aamta09-winn.ispmail.ntl.com with ESMTP
          id <20050709090541.UMPX3667.aamta09-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com>;
          Sat, 9 Jul 2005 10:05:41 +0100
To: GIT <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Stacked GIT 0.4 release is available from http://procode.org/stgit/

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

Note that StGIT is not an SCM interface on top of GIT and it expects a
previously initialised GIT repository. For standard SCM operations,
either use plain GIT commands or the Cogito tool.

For more information, see the README file in the archive.

What's new in this release:

      * Support for configuration files (/etc/stgitrc,
        ~/.stgitrc, .git/stgitrc)
      * Configurable merge tool ('diff3' by default)
      * Empty patches are marked with a '0' when listed with
        'series' (useful for tracking upstream merges)
      * Support for patch description templates (with variables like
        author details and diffstats)
      * 'files' command to show the files modified by a patch (either a
        simple list or with diffstats)
      * 'push --undo' option to cancel a push operation
      * 'push/pop --to' option to perform the operation on a range of
        patches between the given names
      * 'push --reverse' option to push patches in reverse order
      * 'diff --stat' option to show the diffstats instead of the diff
      * Faster 'pop' - it now switches directly to the bottom of the
        last patch to be popped
      * The three files involved in a three-way merge are left in the
        working tree in case of a conflict for further analysis (can be
        overwritten with the 'keeporig' option)
      * Many bug fixes

--
Catalin
