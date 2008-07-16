From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] builtin-describe.c: make a global variable "pattern" static
Date: Wed, 16 Jul 2008 19:42:14 +0900
Message-ID: <20080716194214.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 12:43:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ4U2-0002wu-7d
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 12:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbYGPKmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 06:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755878AbYGPKmi
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 06:42:38 -0400
Received: from karen.lavabit.com ([72.249.41.33]:53533 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755185AbYGPKmi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 06:42:38 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 54CFBC843B;
	Wed, 16 Jul 2008 05:42:29 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id 3W5GCHACT1X1; Wed, 16 Jul 2008 05:42:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=jvxjr8CL4eh4duJHFteCIVHnyVoQXGEYzbpB8okkP5zkWnlHd51IsCsU0z+OA8U8AXlhvzkurs/rbvkToFyobdmS6nqEE38RH8EKPnmCMBBDaEs98ZQ45ngMlHUXamblnKKWkMFsSt+JEoRG2Zx1UcF7pz88KvhSVQutBV4UFcU=;
  h=From:Subject:To:Cc:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88662>

This variable is not used by any other file.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 builtin-describe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index e515f9c..62a1905 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -20,7 +20,7 @@ static int tags;	/* But allow any tags if --tags is specified */
 static int longformat;
 static int abbrev = DEFAULT_ABBREV;
 static int max_candidates = 10;
-const char *pattern = NULL;
+static const char *pattern;
 static int always;
 
 struct commit_name {
-- 
1.5.6.3

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
