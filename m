From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: [PATCH] Documentation: restore a space in unpack-objects usage
Date: Thu, 31 Oct 2013 17:41:11 -0400
Message-ID: <1383255671-12784-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 31 22:41:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbzzp-0002Vf-Nt
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 22:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180Ab3JaVle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 17:41:34 -0400
Received: from mail.savoirfairelinux.com ([209.172.62.77]:64056 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab3JaVle (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 17:41:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0523D10D73D8;
	Thu, 31 Oct 2013 17:41:33 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zNgHpYIECkJh; Thu, 31 Oct 2013 17:41:32 -0400 (EDT)
Received: from localhost (mtl.savoirfairelinux.net [208.88.110.46])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id B4E5710D73D7;
	Thu, 31 Oct 2013 17:41:32 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237187>

The commit 87b7b84 removed a space in the unpack-objects usage, which
makes the synopsis a bit confusing. This patch simply restores it.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 Documentation/git-unpack-objects.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index ff23494..817788e 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -9,7 +9,7 @@ git-unpack-objects - Unpack objects from a packed archive
 SYNOPSIS
 --------
 [verse]
-'git unpack-objects' [-n] [-q] [-r] [--strict] <pack-file
+'git unpack-objects' [-n] [-q] [-r] [--strict] < pack-file
 
 
 DESCRIPTION
-- 
1.8.4.2
