From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [ANNOUNCE] Stacked GIT 0.7
Date: Sun, 02 Oct 2005 10:17:07 +0100
Message-ID: <1128244627.9740.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 02 11:18:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELzyH-000095-Cw
	for gcvg-git@gmane.org; Sun, 02 Oct 2005 11:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVJBJRP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 05:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbVJBJRP
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 05:17:15 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:43467 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751032AbVJBJRP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2005 05:17:15 -0400
Received: from aamta10-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20051002091708.OYXS9239.mta09-winn.ispmail.ntl.com@aamta10-winn.ispmail.ntl.com>;
          Sun, 2 Oct 2005 10:17:08 +0100
Received: from cpc1-cmbg5-3-0-cust202.cmbg.cable.ntl.com ([81.104.192.202])
          by aamta10-winn.ispmail.ntl.com with ESMTP
          id <20051002091708.OXMG6183.aamta10-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust202.cmbg.cable.ntl.com>;
          Sun, 2 Oct 2005 10:17:08 +0100
To: GIT <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9608>

Stacked GIT 0.7 release is available from http://www.procode.org/stgit/

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

What's new in this release (the full ChangeLog is in the archive):

      * Uses the renamed GIT commands (requires GIT >= 0.99.7) 
      * 'pick' command to cherry-pick a commit object as an StGIT patch
        using a three-way merge. It also allows reverse-applying 
      * 'commit' command to permanently store the applied patches into
        the repository 
      * 'push' can now fast-forward the patches if the base tree object
        has not changed 
      * The configuration file supports the 'editor' field 
      * '--version' option for the 'mail' command to generate the e-mail
        subject in the form '[PATCH version nr/total]' 
      * '--showpatch' option for 'refresh' to show the patch content
        when editing the patch description 
      * '--branch' option for several commands to work on a given branch
        instead of the current one without switching 
      * the 'pull' command was updated to follow the 'git pull' API 
      * '--base' option for 'import' to import a diff file on a
        different base and perform a three-way merge with the HEAD
        afterwards 
      * Support for the '.gitignore' file 
      * Several other optimisations 
      * Bug fixes

Many thanks to Paolo 'Blaisorblade' Giarrusso, Chuck Lever, Pierre
Ossman and Junio C Hamano for contributing patches to this release.

-- 
Catalin
