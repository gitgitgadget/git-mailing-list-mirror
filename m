From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/6] rebase: trivial style fixes
Date: Fri, 30 Aug 2013 16:56:47 -0500
Message-ID: <1377899810-1818-4-git-send-email-felipe.contreras@gmail.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 00:01:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFWlF-0006zB-Nj
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 00:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858Ab3H3WBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 18:01:38 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:45557 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582Ab3H3WBg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 18:01:36 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so2991286oag.35
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BM91by4gV7Afen1UcUe4bOPuMP3/Dt/VRuMKk2TrYAc=;
        b=vAFRU38ASXcz1q0Yz/qiYpxto4J1HvaDsxHoXQoxYvTkKy/g2le04D3qGNqBO6lw9l
         Ipz5YaCpJNx9XJ5ueTCbrKAujtYtS8GkMw6X0h3sfc3U2ZPbJy8WuDFTch1n7Xb1desK
         TEIebI7Q0479LjEfzA7rJdHa6LRU64nSPl20G5GtMexExMQKQqy0/ycbpnyIlmu8+NWT
         F4cJryOCcPCEyBulHcljXn6exiN7YJYTEXGnzWf5vp4KF4THhtjz1P9zmPoUNDn0Xvxp
         EMGpBdJizHbYL/DkRPuz+/T//lvLQqwWhBsFCUiJoEdrcmuGc+jaPzEgWvp1ty2LPy6Z
         woKA==
X-Received: by 10.182.143.103 with SMTP id sd7mr8389037obb.70.1377900095908;
        Fri, 30 Aug 2013 15:01:35 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id nw5sm87807obc.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 15:01:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233473>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 8d7659a..2c02853 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -324,7 +324,7 @@ done
 test $# -gt 2 && usage
 
 if test -n "$cmd" &&
-   test "$interactive_rebase" != explicit
+	test "$interactive_rebase" != explicit
 then
 	die "$(gettext "The --exec option must be used with the --interactive option")"
 fi
@@ -486,7 +486,7 @@ case "$#" in
 	switch_to="$1"
 
 	if git show-ref --verify --quiet -- "refs/heads/$1" &&
-	   orig_head=$(git rev-parse -q --verify "refs/heads/$1")
+		orig_head=$(git rev-parse -q --verify "refs/heads/$1")
 	then
 		head_name="refs/heads/$1"
 	elif orig_head=$(git rev-parse -q --verify "$1")
-- 
1.8.4-fc
