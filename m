From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] parse-options.c: make check_typos() static
Date: Wed, 16 Jul 2008 19:42:18 +0900
Message-ID: <20080716194218.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 12:43:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ4U2-0002wu-Sm
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 12:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291AbYGPKmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 06:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755988AbYGPKmn
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 06:42:43 -0400
Received: from karen.lavabit.com ([72.249.41.33]:53534 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755956AbYGPKmm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 06:42:42 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id AD138C843E;
	Wed, 16 Jul 2008 05:42:33 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id LQ1368N5KBAL; Wed, 16 Jul 2008 05:42:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=GHsOKsbj0ScXt6oYRNYxy/mWGhW55tfIhKSJmwkiZadtM690DuN9Ts7RM+I0q6EZeLO+Buu2/IrMFFkj5qUjlVsmY+vE4+aDOGM7lEPiOOuTnD7OVzWDZL02SAIyq4HI5PRKLmtSk2M8cbpIo2SqcR4jizl3sgd9XM2a6ENS/YU=;
  h=From:Subject:To:Cc:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88663>

This function is not used by any other file.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 parse-options.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 2fd5edb..987b015 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -214,7 +214,7 @@ is_abbreviated:
 	return -2;
 }
 
-void check_typos(const char *arg, const struct option *options)
+static void check_typos(const char *arg, const struct option *options)
 {
 	if (strlen(arg) < 3)
 		return;
-- 
1.5.6.3

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
