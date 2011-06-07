From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: [PATCH] Notes that tags need to pushed explicitely
Date: Tue,  7 Jun 2011 12:48:33 +0200
Message-ID: <1307443713-14534-1-git-send-email-sdaoden@gmail.com>
References: <20110606130205.GA41674@sherwood.local>
Cc: Steffen Daode Nurpmeso <sdaoden@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 12:49:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTtqb-0004SM-2m
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 12:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876Ab1FGKtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 06:49:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57251 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab1FGKtP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 06:49:15 -0400
Received: by fxm17 with SMTP id 17so2986555fxm.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 03:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=g3JgX5rnumBFq+r6UBHI+jvciIc0+KXY0YwihPI4rMU=;
        b=PxFLJp15BFFRGQj69rCe78x6R7LZNiFOq3ZvPtN4I10R3h+sp6V3Nxr3EWJ79gXRzm
         5J9ZHNDrptjqtQXM/MWG27vKGBP7qoVWXwUHa3cyXLFtSW+MlZPQ9Ej/kKEh4rEQY/Cm
         cYCLopulojGL0MOD7QeyFP4E4/mMwe4g1pzYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DGj7kBQ37pjjxCPLYhIlS3RnFdc28iv83WBn/tr6PWB9Ie+0G8hTWGU6OqPh+WUtxy
         u3JPzprgME8mv652HnJKaJp2JWeNBDoWDNEO+Ce2boP6GJn75uxeV2T7Vexnghe5thoB
         FrDOKKl4Wc1TEK/EKHeWoRyoB0qaUt4CgTugQ=
Received: by 10.223.27.195 with SMTP id j3mr2289806fac.83.1307443754017;
        Tue, 07 Jun 2011 03:49:14 -0700 (PDT)
Received: from localhost.localdomain ([89.204.137.222])
        by mx.google.com with ESMTPS id 5sm738119faz.2.2011.06.07.03.49.11
        (version=SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 03:49:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0
In-Reply-To: <20110606130205.GA41674@sherwood.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175193>

---
 Documentation/git-tag.txt     |    3 ++-
 Documentation/gittutorial.txt |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index d82f621..242837f 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -27,7 +27,8 @@ Unless `-f` is given, the tag to be created must not yet exist in the
 If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
 creates a 'tag' object, and requires a tag message.  Unless
 `-m <msg>` or `-F <file>` is given, an editor is started for the user to type
-in the tag message.
+in the tag message.  Tag objects can be pushed upstream with
+linkgit:git-push[1].
 
 If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>`
 are absent, `-a` is implied.
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 0982f74..08c0c3a 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -520,6 +520,7 @@ names.  For example:
 
 -------------------------------------
 $ git diff v2.5 HEAD	 # compare the current HEAD to v2.5
+$ git push v2.5		 # push the tag upstream
 $ git branch stable v2.5 # start a new branch named "stable" based
 			 # at v2.5
 $ git reset --hard HEAD^ # reset your current branch and working
-- 
1.7.6.rc0
