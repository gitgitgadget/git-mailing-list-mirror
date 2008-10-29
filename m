From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH 7/7] Documentation: avoid using undefined parameters
Date: Wed, 29 Oct 2008 21:25:45 +0100
Message-ID: <1225311945-17100-8-git-send-email-mail@cup.kalibalik.dk>
References: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-2-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-3-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-4-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-5-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-6-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-7-git-send-email-mail@cup.kalibalik.dk>
Cc: gitster@pobox.com, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 21:28:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvHeD-0006P1-CZ
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 21:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbYJ2U0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 16:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbYJ2U0C
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 16:26:02 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:42701 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754222AbYJ2UZu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 16:25:50 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 10B3D14089;
	Wed, 29 Oct 2008 21:25:50 +0100 (CET)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 726041405A;
	Wed, 29 Oct 2008 21:25:49 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.514.g23abd3
In-Reply-To: <1225311945-17100-7-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99407>

The <ref> parameter has not been introduced, so rewrite to
avoid it.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---
 Documentation/git-push.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 4e339c7..e848ff9 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -46,8 +46,8 @@ to fast forward the remote ref that matches <dst>.  If
 the optional leading plus `+` is used, the remote ref is updated
 even if it does not result in a fast forward update.
 +
-A parameter <ref> without a colon pushes the <ref> from the source
-repository to the destination repository under the same name.
+A lonely <src> parameter (without a colon and a destination) pushes
+the <src> to the same name in the destination repository.
 +
 Pushing an empty <src> allows you to delete the <dst> ref from
 the remote repository.
-- 
1.6.0.2.514.g23abd3
