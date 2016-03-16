From: Eric Wong <normalperson@yhbt.net>
Subject: [PULL] git-svn URL canonicalization fixes for 2.8
Date: Wed, 16 Mar 2016 20:48:24 +0000
Message-ID: <20160316204824.GA1571@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:48:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agIMp-00037W-Gx
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 21:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077AbcCPUs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 16:48:26 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37412 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753917AbcCPUsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 16:48:25 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96ABB633808;
	Wed, 16 Mar 2016 20:48:24 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289032>

Adam reported these problems which affects SVN 1.7+ users.
These should be cherry-picked to "maint", too.  Thanks.

The following changes since commit c2c5f6b1e479f2c38e0e01345350620944e3527f:

  RelNotes for 2.8.0: typofix (2016-03-15 10:58:59 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git master

for you to fetch changes up to b557165311f7ed1b94d94a74e7ea3a6e76bbbe88:

  git-svn: fix URL canonicalization during init w/ SVN 1.7+ (2016-03-16 20:16:23 +0000)

----------------------------------------------------------------
Adam Dinwoodie (1):
      t9117: test specifying full url to git svn init -T

Eric Wong (1):
      git-svn: fix URL canonicalization during init w/ SVN 1.7+

 git-svn.perl                  | 14 ++++++++------
 t/t9117-git-svn-init-clone.sh |  6 ++++++
 2 files changed, 14 insertions(+), 6 deletions(-)
