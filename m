From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 1/2] Document "git log --source"
Date: Mon, 10 Nov 2008 18:58:15 +0900
Message-ID: <20081110185815.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 10 11:00:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzTZ5-0000cx-Pk
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 11:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbYKJJ6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 04:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbYKJJ6z
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 04:58:55 -0500
Received: from karen.lavabit.com ([72.249.41.33]:36084 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478AbYKJJ6y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 04:58:54 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 184ABC7B2B;
	Mon, 10 Nov 2008 03:58:53 -0600 (CST)
Received: from 7469.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id BVUW3D20SWO4; Mon, 10 Nov 2008 03:58:53 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=d4LHgHk4LUVa5Z58/e1bdDW4Tm1oxStJpqg/wyopK+rYIbng4FOHYpCUjYZrkCKgfScn/QixF0svTw24TJRCETMIXK9I/FBwbNvnJZUea4jMuHP0JkUKScdohAHOSQiwxtdGNar2usFvsOzPbtcKcck8JeAdli/fXH9+9qULWy4=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100506>

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 Documentation/git-log.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 93a2a22..34cf4e5 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -40,6 +40,10 @@ include::diff-options.txt[]
 --decorate::
 	Print out the ref names of any commits that are shown.
 
+--source::
+	Print out the ref name given on the command line by which each
+	commit was reached.
+
 --full-diff::
 	Without this flag, "git log -p <path>..." shows commits that
 	touch the specified paths, and diffs about the same specified
-- 
1.6.0.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
