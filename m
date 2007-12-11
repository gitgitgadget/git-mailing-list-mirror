From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH Resend] Stupid typos in git-checkout.sh
Date: Tue, 11 Dec 2007 17:13:05 +0100
Message-ID: <20071211161305.GH15448@artemis.madism.org>
References: <20071211160925.GF15448@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 17:13:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J27jd-0004Lv-PB
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 17:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbXLKQNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 11:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbXLKQNH
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 11:13:07 -0500
Received: from pan.madism.org ([88.191.52.104]:34252 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbXLKQNG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 11:13:06 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1D0CE2E8FA;
	Tue, 11 Dec 2007 17:13:06 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 7FE9C49EDF0; Tue, 11 Dec 2007 17:13:05 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20071211160925.GF15448@artemis.madism.org>
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67879>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  Woops there was another typo in the usage, fix it at the same time.

 git-checkout.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index f6d58ac..d3e1bd0 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -2,13 +2,13 @@
 
 OPTIONS_KEEPDASHDASH=t
 OPTIONS_SPEC="\
-git-branch [options] [<branch>] [<paths>...]
+git-checkout [options] [<branch>] [<paths>...]
 --
 b=          create a new branch started at <branch>
 l           create the new branchs reflog
 track       tells if the new branch should track the remote branch
 f           proceed even if the index or working tree is not HEAD
-m           performa  three-way merge on local modifications if needed
+m           perform a three-way merge on local modifications if needed
 q,quiet     be quiet
 "
 SUBDIRECTORY_OK=Sometimes
-- 
1.5.3.7.2248.g93a2
