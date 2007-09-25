From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] User Manual: document import-tars.perl
Date: Wed, 26 Sep 2007 00:37:04 +0200
Message-ID: <1190759824-18896-1-git-send-email-vmiklos@frugalware.org>
References: <20070925201306.GW30845@fieldses.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 00:39:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaJ3W-0000Tm-8F
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 00:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbXIYWit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 18:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbXIYWit
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 18:38:49 -0400
Received: from virgo.iok.hu ([193.202.89.103]:58213 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840AbXIYWis (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 18:38:48 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DC9BC1B2515;
	Wed, 26 Sep 2007 00:38:46 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 761876FCF1;
	Wed, 26 Sep 2007 00:38:46 +0200 (CEST)
Received: from vmobile.example.net (dsl5401C72B.pool.t-online.hu [84.1.199.43])
	by genesis.frugalware.org (Postfix) with ESMTP id 0FD4C13A4126;
	Wed, 26 Sep 2007 00:38:46 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id C80B78C3C5; Wed, 26 Sep 2007 00:37:04 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.2.80.g077d6f-dirty
In-Reply-To: <20070925201306.GW30845@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59181>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Tue, Sep 25, 2007 at 04:13:06PM -0400, "J. Bruce Fields" <bfields@fieldses.org> wrote:
> One exception--the "series of tarballs" thing--I think it's cool that
> you can just unpack a bunch of tarballs and string them together into a
> git history.  It gives a good sense of how git works, and I don't think
> it's documented explicitly anywhere.  I think that might be kinda fun to
> write up.  But I haven't tried.

something like this?

VMiklos

 Documentation/user-manual.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index a085ca1..f722932 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -978,6 +978,19 @@ $ git add . # include everything below ./ in the first commit:
 $ git commit
 -------------------------------------------------
 
+If you already have a series of tarballs (typically previous releases without
+using a version control system):
+
+-------------------------------------------------
+$ mkdir project
+$ cd project
+$ git init
+$ perl import-tars.perl /path/to/tarballs/*.tar.bz2
+$ git checkout import-tars
+-------------------------------------------------
+
+You can find `import-tars.perl` in the `contrib/fast-import/` directory.
+
 [[how-to-make-a-commit]]
 How to make a commit
 --------------------
-- 
1.5.3.2.80.g077d6f-dirty
