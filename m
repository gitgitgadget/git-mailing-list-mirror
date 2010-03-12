From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v7 01/13] test-lib: unset GIT_NOTES_REF to stop it from influencing tests
Date: Fri, 12 Mar 2010 18:04:25 +0100
Message-ID: <75b9ed21559947cee7b1800e17ba3e3ac5a6dda9.1268413246.git.trast@student.ethz.ch>
References: <cover.1268413246.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 12 18:05:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq8IS-00018m-US
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 18:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758604Ab0CLRFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 12:05:05 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:18753 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758563Ab0CLRFE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 12:05:04 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 18:05:01 +0100
Received: from localhost.localdomain (213.55.131.184) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 18:04:41 +0100
X-Mailer: git-send-email 1.7.0.2.417.gbc354
In-Reply-To: <cover.1268413246.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142043>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Acked-by: Johan Herland <johan@herland.net>
---


 t/test-lib.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a0e396a..400bc6b 100644
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
1.7.0.2.417.gbc354
