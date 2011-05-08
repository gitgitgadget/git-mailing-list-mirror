From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 10/48] i18n: git-am "Falling back" say message
Date: Sun,  8 May 2011 12:20:42 +0000
Message-ID: <1304857280-14773-11-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ31f-0004kb-In
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175Ab1EHMXq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:23:46 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37472 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab1EHMVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:40 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325598eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=/UynDjeQUTKi56j0MvAVUQ1g3/yifGHKquH5IjQDScw=;
        b=wuJOyZQk6u8xStbs9SgJyP/L7Hy/sDT8dsb3qeGmdWB/fn0G+GXKFIQErGO2TlWb9H
         btJ89OHL0/V8ANeveMgBF78uMAZwQPM4WI/2o3zDL0p8Hq75KejJ07wzTL5ZXUDQZHL/
         boQte1qwX7x/RyxeX7kgao/7goNG8J9ZSDQ7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JI1FUD26cry+e9tFlGMa1Piu7n7pLqAebsBB2NflM4iAHEKratc9WRh7blrNYrgIA7
         5h1RyQmt2i4ZnS8mLRlIWc3NYEAr7ruaY+XrKS3iKdvzBkz7ru1UqRTJ5/2i34gR655v
         k3KvLe3pauFz6geIiC6mdOqBVidW+99gxM8oE=
Received: by 10.14.122.205 with SMTP id t53mr2962509eeh.106.1304857299753;
        Sun, 08 May 2011 05:21:39 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.38
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173150>

Make the "Falling back to patching base and 3-way merge..." message
used by fall_back_3way() translatable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 2c8770b..903d1e3 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -148,7 +148,7 @@ It does not apply to blobs recorded in its index.")=
"
     orig_tree=3D$(cat "$dotest/patch-merge-base") &&
     rm -fr "$dotest"/patch-merge-* || exit 1
=20
-    say Falling back to patching base and 3-way merge...
+    say "$(gettext "Falling back to patching base and 3-way merge...")=
"
=20
     # This is not so wrong.  Depending on which base we picked,
     # orig_tree may be wildly different from ours, but his_tree
--=20
1.7.4.4
