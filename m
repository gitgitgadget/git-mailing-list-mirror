From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Stacked GIT 0.3 (now more Quilt-like)
Date: Tue, 28 Jun 2005 22:26:43 +0100
Message-ID: <1119994003.9631.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jun 28 23:22:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnNWE-0007lh-NT
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 23:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVF1V1q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 17:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVF1V1q
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 17:27:46 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:26947 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261435AbVF1V0p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 17:26:45 -0400
Received: from aamta11-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20050628212644.FHHK11649.mta09-winn.ispmail.ntl.com@aamta11-winn.ispmail.ntl.com>;
          Tue, 28 Jun 2005 22:26:44 +0100
Received: from cpc2-cmbg5-3-0-cust212.cmbg.cable.ntl.com ([81.104.193.212])
          by aamta11-winn.ispmail.ntl.com with ESMTP
          id <20050628212644.UDAA11226.aamta11-winn.ispmail.ntl.com@cpc2-cmbg5-3-0-cust212.cmbg.cable.ntl.com>;
          Tue, 28 Jun 2005 22:26:44 +0100
To: GIT <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A new StGIT release is available from http://procode.org/stgit/

What's new in version 0.3:
      * closer to the Quilt functionality
      * there is only one commit object per patch which can be
        indefinitely modified using the 'refresh' command. The commit
        objects are stacked on top of the base and can also be accessed
        via standard GIT commands
      * no 'commit' command. Use 'refresh' instead

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

Note that StGIT is not an SCM interface on top of GIT and it expects a
previously initialised GIT repository. For standard SCM operations,
either use plain GIT commands or the Cogito tool.

For more information, see the README file in the archive.

--
Catalin
