From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH 0/5] Proposed patches
Date: Fri, 06 Jun 2008 21:45:27 +0100
Message-ID: <20080606204322.8805.32313.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 22:46:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4ipT-0001J4-SP
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 22:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933277AbYFFUpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 16:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933274AbYFFUpf
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 16:45:35 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:16740 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933246AbYFFUpe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2008 16:45:34 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20080606204934.RUAE28496.mtaout01-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Fri, 6 Jun 2008 21:49:34 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080606205430.LHEW8797.aamtaout03-winn.ispmail.ntl.com@localhost.localdomain>;
          Fri, 6 Jun 2008 21:54:30 +0100
User-Agent: StGIT/0.14.2.168.ge637
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84107>

This series contains the patches pending in my "proposed" branch.
They've been updated following comments from Karl.


Catalin Marinas (5):
      Add test_patches target to Makefile
      Convert "init" to the new StGIT infrastructure
      Add stack creation and initialisation support to lib.Stack
      Create a git.Branch class as ancestor of stack.Stack
      Rename Repository.head to Repository.head_ref


 Makefile               |    9 ++++-
 stgit/commands/init.py |   14 ++-----
 stgit/commands/new.py  |    3 +-
 stgit/lib/git.py       |   58 ++++++++++++++++++++++++++++++-
 stgit/lib/stack.py     |   90 ++++++++++++++++++++++++++++++++++++------------
 5 files changed, 137 insertions(+), 37 deletions(-)

-- 
Catalin
