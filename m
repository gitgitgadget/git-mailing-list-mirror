From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 6/8] t/README: Document test_expect_code
Date: Thu,  1 Jul 2010 15:10:02 +0000
Message-ID: <1277997004-29504-7-git-send-email-avarab@gmail.com>
References: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 17:16:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OULUz-0000yb-3k
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 17:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab0GAPQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 11:16:15 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50235 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab0GAPQN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 11:16:13 -0400
Received: by ewy23 with SMTP id 23so813775ewy.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 08:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=7CzyS8BlJJHC2Xunabs4Hpp7K+9PxEkNblosgELOIHU=;
        b=i8byd57Xz1Fc0lbNChDTKzxAp64430sa3IACsDKMu0dzZTIYZtpYIxH6rgqWDsVbn+
         RZmrvbkf2eKAOkUEjBx8z6GoJpmgxPtuUWYmPf04Qll585tFUVvji4IJF2h+XgwuRUDg
         MkXF4NJLQR8XBLxg/S7SP8xIJ9z7c5yZ7RBig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uonggEKz5ozH3sU6qx1wP+eX/8VQpTwWLBNXXVHcQaKBEe2fXgDkSB+LdLGJjezg3R
         Pj1+tsVHj6sJ6mjmhb4MnK9p/m66WW5zuRTsF1iz9b1ACMku4+TNNgzd1GxG0nkI/ssy
         W9Hoq8rdh2npcBzRQeVGaLlwFPeQVGoNQAYdM=
Received: by 10.213.112.212 with SMTP id x20mr2556011ebp.50.1277997055341;
        Thu, 01 Jul 2010 08:10:55 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v59sm10377672eeh.12.2010.07.01.08.10.53
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 08:10:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150043>

test_expect_code (which was introduced in d3bfdb75) never had any
documentation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 43d6d4d..6232567 100644
--- a/t/README
+++ b/t/README
@@ -276,6 +276,13 @@ library for your script to use.
   =20
    Like test_expect_success this function can optionally use a three
    argument invocation with a prerequisite as the first argument.
+  =20
+ - test_expect_code [<prereq>] <code> <message> <script>
+=20
+   Analogous to test_expect_success, but pass the test if it exits
+   with a given exit <code>
+=20
+ test_expect_code 1 'Merge with d/f conflicts' 'git merge "merge msg" =
B master'
=20
  - test_debug <script>
=20
--=20
1.7.1.251.g92a7
