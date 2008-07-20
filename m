From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] Teach "git-merge" that "stupid" merge strategy no longer exists
Date: Sun, 20 Jul 2008 19:21:25 +0900
Message-ID: <20080720192125.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 12:22:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKW3j-0001kA-4A
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 12:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564AbYGTKV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 06:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755560AbYGTKV2
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 06:21:28 -0400
Received: from karen.lavabit.com ([72.249.41.33]:48306 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755452AbYGTKV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 06:21:28 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 622BBC88B1;
	Sun, 20 Jul 2008 05:21:19 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id Z3F6P37S3BU5; Sun, 20 Jul 2008 05:21:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=VZhBivo59c6z319GD6De4JimbQyGtv6CET3U0+gyeOCOMyHp3ZZQIFfAXLQ/nuHUY0hVdd3+CfV0hytvfwPfB1jmdMUdhR6EQvsEKAF7/LklgVzkhdV4/K3l4LuKjQ6TiEBSu7VrfIgmbABMRjSh8M4IHgw/mjjJTfmeXDmXJW0=;
  h=From:Subject:To:Cc:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89177>

Next release 1.6.0 will not have "stupid" merge strategy, but
"git merge -s confused origin" still includs it in the list of
available merge strategies.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 builtin-merge.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 129b4e6..edc6016 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -54,7 +54,6 @@ static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
 	{ "octopus",    DEFAULT_OCTOPUS },
 	{ "resolve",    0 },
-	{ "stupid",     0 },
 	{ "ours",       NO_FAST_FORWARD | NO_TRIVIAL },
 	{ "subtree",    NO_FAST_FORWARD | NO_TRIVIAL },
 };
-- 
1.5.6.3

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
