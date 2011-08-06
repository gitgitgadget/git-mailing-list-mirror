From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 36/40] whitespace: remediate t9401-git-cvsserver-crlf.sh
Date: Sat,  6 Aug 2011 18:44:50 +1000
Message-ID: <1312620294-18616-36-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcX0-0005WP-9w
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853Ab1HFIqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:32 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:53446 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739Ab1HFIq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:29 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182831iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1TB50evGZ2O5mO+g3Z1YR6SjSUVilBb1EqoNKqSww+s=;
        b=AcbHFBeIMFHPT4uqidRFHNoCBUDarHIYPRIZDJbLsOyU4Ve7tuOhQ8Ylphb5cqqSqU
         2o0SUHJIwlzmwR8adpwEvDARSQjw3cQbVuIQT0NujNBNvyh08onQGXN4xZLc4R3RQETc
         94SUCDRkxz31PYxSTux2VgTHWdqjc6dwEkVZE=
Received: by 10.42.173.135 with SMTP id r7mr3176596icz.50.1312620389037;
        Sat, 06 Aug 2011 01:46:29 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178857>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t9401-git-cvsserver-crlf.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index ff6d6fb..302a24b 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -26,15 +26,15 @@ marked_as () {
 not_present() {
     foundEntry="$(grep "^/$2/" "$1/CVS/Entries")"
     if [ -r "$1/$2" ] ; then
-        echo "Error: File still exists: $1 $2" >> "${WORKDIR}/marked.log"
-        return 1;
+	echo "Error: File still exists: $1 $2" >> "${WORKDIR}/marked.log"
+	return 1;
     fi
     if [ x"$foundEntry" != x"" ] ; then
-        echo "Error: should not have found: $1 $2" >> "${WORKDIR}/marked.log"
-        return 1;
+	echo "Error: should not have found: $1 $2" >> "${WORKDIR}/marked.log"
+	return 1;
     else
-        echo "Correctly not found: $1 $2" >> "${WORKDIR}/marked.log"
-        return 0;
+	echo "Correctly not found: $1 $2" >> "${WORKDIR}/marked.log"
+	return 0;
     fi
 }
 
-- 
1.7.6.362.gf0e6
