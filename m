From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 14/40] whitespace: remediate t5303-pack-corruption-resilience.sh
Date: Sat,  6 Aug 2011 18:44:28 +1000
Message-ID: <1312620294-18616-14-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:45:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcVx-000510-Ah
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530Ab1HFIpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:42 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:53446 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab1HFIpi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:38 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182831iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/vY36j+X8SOWsKPtqXHaCWsnCbiWrpCSXeY4J0CT+9I=;
        b=uH0LaiAepzqWRMBTJrFNe1TTHrpby3TIHWKjr7sQHk5U6Zp8W8bc0u4TxDoOcViZwQ
         yw0PNyvdaqOELGrL6TNn18mRTDa9VDQMxNIozt66L+3pzTmEnoHSm/LanLwuLscRf313
         g7ZVWoZhJVj8GjqTI9GqnLtvmfrZtKOM51TwU=
Received: by 10.42.165.67 with SMTP id j3mr3169354icy.368.1312620337941;
        Sat, 06 Aug 2011 01:45:37 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178840>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t5303-pack-corruption-resilience.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 5f6cd4f..b019b83 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -36,14 +36,14 @@ create_new_pack() {
     blob_2=`git hash-object -t blob -w file_2` &&
     blob_3=`git hash-object -t blob -w file_3` &&
     pack=`printf "$blob_1\n$blob_2\n$blob_3\n" |
-          git pack-objects $@ .git/objects/pack/pack` &&
+	  git pack-objects $@ .git/objects/pack/pack` &&
     pack=".git/objects/pack/pack-${pack}" &&
     git verify-pack -v ${pack}.pack
 }
 
 do_repack() {
     pack=`printf "$blob_1\n$blob_2\n$blob_3\n" |
-          git pack-objects $@ .git/objects/pack/pack` &&
+	  git pack-objects $@ .git/objects/pack/pack` &&
     pack=".git/objects/pack/pack-${pack}"
 }
 
-- 
1.7.6.362.gf0e6
