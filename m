From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [ANNOUNCE] Stacked GIT 0.6
Date: Sun, 21 Aug 2005 09:12:05 +0100
Message-ID: <1124611925.6957.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 21 10:12:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6kwV-00005C-KZ
	for gcvg-git@gmane.org; Sun, 21 Aug 2005 10:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVHUIMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 04:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVHUIMJ
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 04:12:09 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:41340 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750828AbVHUIMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2005 04:12:08 -0400
Received: from aamta10-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20050821081206.SGQZ9239.mta09-winn.ispmail.ntl.com@aamta10-winn.ispmail.ntl.com>;
          Sun, 21 Aug 2005 09:12:06 +0100
Received: from cpc1-cmbg5-3-0-cust219.cmbg.cable.ntl.com ([81.104.192.219])
          by aamta10-winn.ispmail.ntl.com with ESMTP
          id <20050821081206.QEIY3432.aamta10-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust219.cmbg.cable.ntl.com>;
          Sun, 21 Aug 2005 09:12:06 +0100
To: GIT <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Stacked GIT 0.6 release is available from http://www.procode.org/stgit/

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

A wiki page hosting the StGIT documentation is available at
http://wiki.procode.org/cgi-bin/wiki.cgi/StGIT. It only has a short
tutorial but please feel free to improve this page.

What's new in this release (the full ChangeLog is in the archive):

      * StGIT can now be installed in other directory than /usr (the
        default prefix is now $HOME). The '/etc/stgitrc' file is no
        longer installed since the defaults are hard-coded in StGIT
      * 'clone' command implemented
      * 'fold' command implemented. This command integrates a GNU diff
        patch into the current patch. It can also do a three-way merge
      * '--edit' option for 'import'. This option allows one to modify
        the patch description during the import operation
      * The '%(number)s' variable added to the e-mail templates which
        expands to ' number/total' if total > 1 or empty if total is 1
      * The README file is almost empty since the documentation moved to
        the web
      * Bug fixes

-- 
Catalin
