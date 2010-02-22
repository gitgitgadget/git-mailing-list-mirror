From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 01/11] test-lib: unset GIT_NOTES_REF to stop it from influencing tests
Date: Mon, 22 Feb 2010 01:10:14 +0100
Message-ID: <a001bcef61b98562dcde481615a733aa2ac44e5a.1266797028.git.trast@student.ethz.ch>
References: <cover.1266797028.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 02:07:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjLt4-0000D3-Dh
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 01:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779Ab0BVAKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 19:10:51 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:28109 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753765Ab0BVAKu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 19:10:50 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 01:10:50 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 01:10:29 +0100
X-Mailer: git-send-email 1.7.0.147.g5aeb9
In-Reply-To: <cover.1266797028.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140627>

---

New in this round.

 t/test-lib.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index afd3053..1e7eab1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -54,6 +54,7 @@ unset GIT_OBJECT_DIRECTORY
 unset GIT_CEILING_DIRECTORIES
 unset SHA1_FILE_DIRECTORIES
 unset SHA1_FILE_DIRECTORY
+unset GIT_NOTES_REF
 GIT_MERGE_VERBOSITY=5
 export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
-- 
1.7.0.147.g5aeb9
