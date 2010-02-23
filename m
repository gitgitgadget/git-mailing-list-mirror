From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v5 01/11] test-lib: unset GIT_NOTES_REF to stop it from influencing tests
Date: Tue, 23 Feb 2010 01:42:19 +0100
Message-ID: <b31adf93b35f0003255856c61d002ccf69379c37.1266885599.git.trast@student.ethz.ch>
References: <cover.1266885599.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 01:43:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjisK-0002rD-JD
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 01:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab0BWAm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 19:42:59 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:48627 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544Ab0BWAmy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 19:42:54 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 01:42:50 +0100
Received: from localhost.localdomain (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 01:42:31 +0100
X-Mailer: git-send-email 1.7.0.218.g73a398
In-Reply-To: <cover.1266885599.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140753>

---


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
1.7.0.218.g73a398
