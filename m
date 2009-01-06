From: jidanni@jidanni.org
Subject: [PATCH] Documentation/diff-generate-patch.txt the truth about "diff --git"
Date: Tue,  6 Jan 2009 12:01:17 +0800
Message-ID: <1231214477-15208-1-git-send-email-jidanni@jidanni.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 05:02:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK39M-0001Ue-Jc
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 05:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbZAFEBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 23:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbZAFEBV
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 23:01:21 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:43694 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752604AbZAFEBU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2009 23:01:20 -0500
Received: from jidanni.org (122-127-36-59.dynamic.hinet.net [122.127.36.59])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id D59A4D2738;
	Mon,  5 Jan 2009 20:01:19 -0800 (PST)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104633>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/diff-generate-patch.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 0f25ba7..dfc186c 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -19,6 +19,7 @@ diff format.
 The `a/` and `b/` filenames are the same unless rename/copy is
 involved.  Especially, even for a creation or a deletion,
 `/dev/null` is _not_ used in place of `a/` or `b/` filenames.
+(Diff(1) does not actually have a --git option.)
 +
 When rename/copy is involved, `file1` and `file2` show the
 name of the source file of the rename/copy and the name of
-- 
1.6.0.6
