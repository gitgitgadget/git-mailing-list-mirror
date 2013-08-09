From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] Documentation/git-merge-file: document option "--diff3"
Date: Fri,  9 Aug 2013 20:09:32 +0200
Message-ID: <1376071772-28941-1-git-send-email-ralf.thielow@gmail.com>
Cc: gitster@pobox.com, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 20:10:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7r8T-0000D5-Tv
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 20:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758597Ab3HISJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 14:09:58 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:37908 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758594Ab3HISJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 14:09:57 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so2217180eak.4
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 11:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jqCoqyAJtVAyaLj0v6r3iOdtsE9SQPE+/BZDIeSVSy4=;
        b=lAzstJNrdBPwJ0yXvr7sFZUnFJdCcecauhs+/MKVfScgswnI3CeyYrVoPcaoIJqCfs
         vgHYfVdHVvQ7icvdSi1gGwod9H2GqbCX2qDkuWBdgoGsMRggVB2vOxtFfZlYzjSeaNMX
         ot+5X4pD2idhnitvqYQDq+BmAbTBzMVXF0Ysh5SrhtbUizMC5TWJjSm86Wbx3xzH0Rf9
         0crcfIOifR4FqPyW4x5O9fZw9FCFnzkx3ViqfE78TlhMfOEpx+miituI332kwoKTNfVZ
         mEbMqeRPMcpT4BYXcYi+BzDGXWv332syx3nwifpAC5btY+SF1dJd81wM5RVlNPJ/UTEJ
         +DQA==
X-Received: by 10.15.42.129 with SMTP id u1mr14329882eev.116.1376071795452;
        Fri, 09 Aug 2013 11:09:55 -0700 (PDT)
Received: from localhost (dslb-178-005-189-036.pools.arcor-ip.net. [178.5.189.36])
        by mx.google.com with ESMTPSA id j2sm30760078eep.6.2013.08.09.11.09.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 11:09:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.29.g4402f30
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232004>

The option "--diff3" was added to "git merge-file" in e0af48e
(xdiff-merge: optionally show conflicts in "diff3 -m" style)
but it was never documented in "Documentation/git-merge-file.txt".
Add documentation for this option.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 Documentation/git-merge-file.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index d7db2a3..d2fc12e 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
 	[--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
-	<current-file> <base-file> <other-file>
+	[--[no-]diff3] <current-file> <base-file> <other-file>
 
 
 DESCRIPTION
@@ -66,6 +66,9 @@ OPTIONS
 -q::
 	Quiet; do not warn about conflicts.
 
+--diff3::
+	Show conflicts in "diff3" style.
+
 --ours::
 --theirs::
 --union::
-- 
1.8.4.rc1.29.g4402f30
