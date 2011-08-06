From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 39/40] whitespace: remediate t1000-read-tree-m-3way.sh
Date: Sat,  6 Aug 2011 18:44:53 +1000
Message-ID: <1312620294-18616-39-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcX2-0005WP-EU
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914Ab1HFIqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:47 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:43546 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898Ab1HFIqg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:36 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5183461iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RIuhlsLNZ9lyQQp9Ygev5DQNYRiGAMN8SOtmcQA1TXM=;
        b=vCXiDG4OJ//fOyJ79IBtilbOEx+6nwtC1oon5sXx1lecnYojrtzIrK5QmwIegdQv4M
         Rv0bXpq+TvjCoTw7NHmLs1IvJ+3sFYymqWmVzs3GVoibx4GTKomjClyCNXUKegh+jweU
         LS3O2kYf/YDOZcR4XAr01kSEtFMJ3UGppx2e4=
Received: by 10.231.113.170 with SMTP id a42mr916356ibq.64.1312620396704;
        Sat, 06 Aug 2011 01:46:36 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178862>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t1000-read-tree-m-3way.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index babcdd2..b461b42 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -169,7 +169,7 @@ checked.
   3  missing exists  missing   take A*     must match A, if exists.
  ------------------------------------------------------------------
   4  missing exists  A!=B      no merge    must match A and be
-                                           up-to-date, if exists.
+					   up-to-date, if exists.
  ------------------------------------------------------------------
   5  missing exists  A==B      take A      must match A, if exists.
  ------------------------------------------------------------------
@@ -180,21 +180,21 @@ checked.
   8  exists  missing O==B      remove      must not exist.
  ------------------------------------------------------------------
   9  exists  O!=A    missing   no merge    must match A and be
-                                           up-to-date, if exists.
+					   up-to-date, if exists.
  ------------------------------------------------------------------
  10  exists  O==A    missing   no merge    must match A
  ------------------------------------------------------------------
  11  exists  O!=A    O!=B      no merge    must match A and be
-                     A!=B                  up-to-date, if exists.
+		     A!=B                  up-to-date, if exists.
  ------------------------------------------------------------------
  12  exists  O!=A    O!=B      take A      must match A, if exists.
-                     A==B
+		     A==B
  ------------------------------------------------------------------
  13  exists  O!=A    O==B      take A      must match A, if exists.
  ------------------------------------------------------------------
  14  exists  O==A    O!=B      take B      if exists, must either (1)
-                                           match A and be up-to-date,
-                                           or (2) match B.
+					   match A and be up-to-date,
+					   or (2) match B.
  ------------------------------------------------------------------
  15  exists  O==A    O==B      take B      must match A if exists.
  ------------------------------------------------------------------
-- 
1.7.6.362.gf0e6
