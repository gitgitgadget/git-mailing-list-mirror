From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Stacked GIT 0.5
Date: Sat, 30 Jul 2005 22:32:06 +0100
Message-ID: <1122759126.6865.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 30 23:36:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dyz0H-0002ei-F5
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 23:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVG3Vfl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 17:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbVG3Vdj
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 17:33:39 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:7071 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262928AbVG3VcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 17:32:09 -0400
Received: from aamta10-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20050730213208.VPGB16172.mta09-winn.ispmail.ntl.com@aamta10-winn.ispmail.ntl.com>;
          Sat, 30 Jul 2005 22:32:08 +0100
Received: from cpc2-cmbg5-3-0-cust14.cmbg.cable.ntl.com ([81.104.193.14])
          by aamta10-winn.ispmail.ntl.com with ESMTP
          id <20050730213208.DQHL2760.aamta10-winn.ispmail.ntl.com@cpc2-cmbg5-3-0-cust14.cmbg.cable.ntl.com>;
          Sat, 30 Jul 2005 22:32:08 +0100
To: GIT <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Stacked GIT 0.5 release is available from http://www.procode.org/stgit/

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

Note that StGIT is not an SCM interface on top of GIT and it expects a
previously initialised GIT repository. For standard SCM operations,
either use plain GIT commands or the Cogito tool.

For more information, see the README file in the archive.

What's new in this release (the full ChangeLog is in the archive):

      * Improved help for commands
      * 'mail' command to automatically e-mail a range of patches. The
        e-mail format is fully configurable via templates
      * 'import' command to import a GNU diff patch. The patch file can
        be a standard e-mail message or a normal file with the patch
        description at the top
      * 'pull' command to automatically advance the base of the stack
        and merge the changes into the applied patches
      * 'clean' command to delete the empty patches in a series
      * 'rename' command to change the name of a patch
      * '--range' option for the 'export' command
      * '--force' option for the 'new' command to create a patch even if
        there are local changes in the tree
      * Default templates for the 'export' and 'mail' commands
        (installed in /usr/share/stgit/templates/)
      * Bug fixes

--
Catalin
