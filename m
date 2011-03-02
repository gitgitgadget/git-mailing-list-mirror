From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 3/4] Clean: Remove unnecessary `\' (line continuation)
Date: Wed, 2 Mar 2011 15:25:23 +0000
Message-ID: <a59d19d0-f279-43fe-8ac6-06c4bd13c941-mfwitten@gmail.com>
References: <1fbceaa8-398c-44ec-8833-a03e4cca6805-mfwitten@gmail.com>
            <ca8eabbf-ed1b-4b46-a7f7-4b068a2de5b7-mfwitten@gmail.com>
            <5bddd028-bf38-46b9-a189-bdb09038dfdd-mfwitten@gmail.com>
            <d92be3a1-6f30-4b04-ac38-39058e5a6959-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:03:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4ync-0001qJ-D5
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 19:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933004Ab1C3RDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 13:03:11 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38370 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932909Ab1C3RDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 13:03:09 -0400
Received: by pzk9 with SMTP id 9so231452pzk.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 10:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=X5GD3yurqqTg23vpTJouJ26lI0dlI4i/bWtvOzsbChQ=;
        b=v+yXOEtqbosIucra6ybrWyzP2jmDFbozMpdxtnulHsXqywQyumYaQn7VMyZY/sf2K3
         eP+DJaYln6b6FZpeS6JDm0C+DBjp/2ZXiG/6uzqhicR8DD2uiS6rEUH8YVjWK3uY8/Xg
         RYk49c7/4/C0fI20dwLcMR2pCaZfpsHsfX//Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        b=Jf75CoMNKIQT77HgPnJRBA8Imtee/hkS1aRb5kdfxNBdBgx5+xA/ZESvHr8YnI9y8x
         jDRKuIU+VufhNb3++BxLGvWchacVYqrd42GSyhDfNvv9LpYWy+7xSnwnnIWPfpvc1DF2
         xGapTp5V7wPQFx2hgvdbDSrWTkXW7rYry2lBM=
Received: by 10.142.194.3 with SMTP id r3mr1045592wff.352.1301504589377;
        Wed, 30 Mar 2011 10:03:09 -0700 (PDT)
Received: from gmail.com ([109.123.119.163])
        by mx.google.com with ESMTPS id x11sm314976wfd.13.2011.03.30.10.03.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 10:03:08 -0700 (PDT)
In-Reply-To: <1fbceaa8-398c-44ec-8833-a03e4cca6805-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170394>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 t/t8001-annotate.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
index 45cb60e..68ac828 100755
--- a/t/t8001-annotate.sh
+++ b/t/t8001-annotate.sh
@@ -8,7 +8,7 @@ PROG='git annotate'
 
 test_expect_success \
     'Annotating an old revision works' \
-    '[ $(git annotate file master | awk "{print \$3}" | grep -c "^A$") -eq 2 ] && \
+    '[ $(git annotate file master | awk "{print \$3}" | grep -c "^A$") -eq 2 ] &&
      [ $(git annotate file master | awk "{print \$3}" | grep -c "^B$") -eq 2 ]'
 
 
-- 
1.7.4.18.g68fe8
