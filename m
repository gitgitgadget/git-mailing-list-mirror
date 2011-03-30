From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] git-pack-objects.txt: fix grammatical errors
Date: Wed, 30 Mar 2011 02:00:06 -0700
Message-ID: <1301475606-11339-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 11:00:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4rGt-0002Ry-7S
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 11:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549Ab1C3JAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 05:00:53 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57068 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab1C3JAx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 05:00:53 -0400
Received: by ywj3 with SMTP id 3so428115ywj.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=xmxohk/dUIj2LOW6PgeJJ6bWI8GqEI9+R1VNKm9mvSE=;
        b=tYapv0sU4LpfHuyC9r1NrLzfjewKDuxhtS+bUvHUaVjg4YDdR1bguRUNIkpz2fNqmB
         bOZwovo5r2Q1AF032Md0FqNgFyen4YNYQ1XL4gGx4Q5RcF+0hsNLUbc1Vusqyrya9seY
         79j73iDAAhZ80o+Q+DyZSfms8NSqO5R6TMrsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GwdhytxU8fj0Au9Rp4nqb6Zenf9yjLkwBXNUUp0+mviYi6xHtDJI6InNJHASHhbqXx
         iyrfG5/JxVCIB52ziIRXm+fVDeewmBEwensJwOrSgK/KZw0fVBueYgJ9SVxmilp0qNkv
         8dKry2wVnNst+YDbXVh7u//4c/cvPDknNYWtk=
Received: by 10.150.50.10 with SMTP id x10mr1133927ybx.345.1301475652415;
        Wed, 30 Mar 2011 02:00:52 -0700 (PDT)
Received: from earth ([75.85.182.25])
        by mx.google.com with ESMTPS id q18sm2296096ybk.26.2011.03.30.02.00.50
        (version=SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 02:00:52 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 30 Mar 2011 02:00:06 -0700
X-Mailer: git-send-email 1.7.4.2.422.g537d99
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170369>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

This paragraph might need even more work. Paint away!

 Documentation/git-pack-objects.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index a51071e..442018b 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -190,9 +190,9 @@ self-contained. Use `git index-pack --fix-thin`
 (see linkgit:git-index-pack[1]) to restore the self-contained property.
 
 --delta-base-offset::
-	A packed archive can express base object of a delta as
-	either 20-byte object name or as an offset in the
-	stream, but older version of git does not understand the
+	A packed archive can express the base object of a delta as
+	either a 20-byte object name or as an offset in the
+	stream, but older versions of git don't understand the
 	latter.  By default, 'git pack-objects' only uses the
 	former format for better compatibility.  This option
 	allows the command to use the latter format for
-- 
1.7.4.2.422.g537d99
