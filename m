From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 2/2] Document "git log --simplify-by-decoration"
Date: Mon, 10 Nov 2008 18:58:17 +0900
Message-ID: <20081110185817.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 10 11:00:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzTZ6-0000cx-HJ
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 11:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbYKJJ65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 04:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbYKJJ65
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 04:58:57 -0500
Received: from karen.lavabit.com ([72.249.41.33]:36086 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478AbYKJJ64 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 04:58:56 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 0B743C7B2B;
	Mon, 10 Nov 2008 03:58:56 -0600 (CST)
Received: from 7469.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id VO2A0347LGI1; Mon, 10 Nov 2008 03:58:56 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=snDsdxu+/ltHy9XPe0MMxXmmvB7DvcN2VbFc8TpCVO1naXkcPHEcXTy1B+B5DVaq6GQlzd9R0uFpLADNtPv10nevqo0K8j2XjJcniCzM43z4J3fS3DT44My8dZTovmmE/Ll7pLC1LAeOYuu7eHtp1tAt9CxjC3v6+6ymecc79P8=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100505>

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 Documentation/rev-list-options.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 966276b..977290c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -456,6 +456,13 @@ Note the major differences in `N` and `P` over '\--full-history':
   removed completely, because it had one parent and is TREESAME.
 --
 
+The '\--simplify-by-decoration' option can be used to treat commits that
+are not referenced by tags as TREESAME, and treat commits that are tagged
+as !TREESAME (even when they have exactly the same tree as their parents).
+This can be used when you are only interested in the big picture of the
+topology of the history.
+
+
 ifdef::git-rev-list[]
 Bisection Helpers
 ~~~~~~~~~~~~~~~~~
-- 
1.6.0.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
