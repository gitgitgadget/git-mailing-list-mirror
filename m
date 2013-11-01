From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: [PATCH] Documentation: "pack-file" is not literal in unpack-objects
Date: Fri,  1 Nov 2013 11:42:43 -0400
Message-ID: <1383320563-3927-1-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <xmqqy5592itp.fsf@gitster.dls.corp.google.com>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 01 16:43:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcGsT-0003OV-9L
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 16:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474Ab3KAPnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 11:43:09 -0400
Received: from mail.savoirfairelinux.com ([209.172.62.77]:60836 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430Ab3KAPnH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 11:43:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 013F010D7062;
	Fri,  1 Nov 2013 11:43:04 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JRL37p2RaDQj; Fri,  1 Nov 2013 11:43:03 -0400 (EDT)
Received: from localhost (mtl.savoirfairelinux.net [208.88.110.46])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A00D510D7061;
	Fri,  1 Nov 2013 11:43:03 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <xmqqy5592itp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237214>

This patch makes it clear that "pack-file" is not to be spelled as is in
the unpack-objects usage.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 Documentation/git-unpack-objects.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 817788e..12cb108 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -9,7 +9,7 @@ git-unpack-objects - Unpack objects from a packed archive
 SYNOPSIS
 --------
 [verse]
-'git unpack-objects' [-n] [-q] [-r] [--strict] < pack-file
+'git unpack-objects' [-n] [-q] [-r] [--strict] < <pack-file>
 
 
 DESCRIPTION
-- 
1.8.4.2
