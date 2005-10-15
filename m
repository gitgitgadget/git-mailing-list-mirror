From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [ANNOUNCE] Stacked GIT 0.7.1
Date: Sat, 15 Oct 2005 11:59:51 +0100
Message-ID: <1129373992.7719.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 15 13:01:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQjnH-0001tz-Ia
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 13:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVJOK77 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 06:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVJOK77
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 06:59:59 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:18830 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751105AbVJOK77 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 06:59:59 -0400
Received: from aamta12-winn.ispmail.ntl.com ([81.103.221.35])
          by mta08-winn.ispmail.ntl.com with ESMTP
          id <20051015105957.VWWO10357.mta08-winn.ispmail.ntl.com@aamta12-winn.ispmail.ntl.com>;
          Sat, 15 Oct 2005 11:59:57 +0100
Received: from cpc3-cmbg5-3-0-cust13.cmbg.cable.ntl.com ([81.104.194.13])
          by aamta12-winn.ispmail.ntl.com with ESMTP
          id <20051015105957.UDZB10626.aamta12-winn.ispmail.ntl.com@cpc3-cmbg5-3-0-cust13.cmbg.cable.ntl.com>;
          Sat, 15 Oct 2005 11:59:57 +0100
To: GIT <git@vger.kernel.org>
X-Mailer: Evolution 2.4.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10130>

Stacked GIT 0.7.1 release is available from http://www.procode.org/stgit/

This is a bug-fix/optimisation release, no new features were added.

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

What's new in this release (the full ChangeLog is in the archive):

      * 'push' command optimisation - git-apply will be tried first,
        falling back to a three-way merge if it does not succeed
      * escape punctuation in the parsed e-mail addresses to avoid
        problems when passing the environment to the GIT commands

-- 
Catalin
