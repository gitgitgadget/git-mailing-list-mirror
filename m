From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/44] request-pull: t: trivial whitespace style fixes
Date: Sat, 28 Sep 2013 17:03:33 -0500
Message-ID: <1380405849-13000-9-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2id-00030Z-AG
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226Ab3I1WKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:24 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63610 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190Ab3I1WKT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:19 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so4102368obc.5
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fn0X+Sn6erDaztroV2CiULZuF57VGvmZuLCRTNU068g=;
        b=wEuDdlSDxurAhxR3JDS8r4mOCbhXr3/logcEBYIMeFloix6zIv/kmQsw1yJiFUMdjh
         xbioXAnvc+ZIrdbKFoZMmht9NTaDUU/yn5M7KVMYAyCWYha72DJgt9uiUPgkwvuNQv8E
         taX3XDNAifSmFOv0u2DPSOwXWP9K+xgwljb8kHf4bIWYdEBizXi/zOQxFudmZKgpqd5s
         aLnx1Cu9rNeUw6A5lBtM4e8W8M54heV8yAnZCb7CtdW8jidILcOvFzVtwfx20JQit1Ne
         hZAXIgGBQ3J4xdpFnTMmjK07dQob6TmjNR24Z7QLyXqA3Lm/yzTlZvff00rCJr2lOq50
         Mg5A==
X-Received: by 10.182.117.195 with SMTP id kg3mr12394563obb.17.1380406219512;
        Sat, 28 Sep 2013 15:10:19 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm25431165oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235529>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5150-request-pull.sh | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 73f0369..9375912 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -5,7 +5,6 @@ test_description='Test workflows involving pull request.'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-
 	git init --bare upstream.git &&
 	git init --bare downstream.git &&
 	git clone upstream.git upstream-private &&
@@ -55,11 +54,9 @@ test_expect_success 'setup' '
 But keep the old version, too, in case some people prefer it." &&
 		git checkout master
 	)
-
 '
 
 test_expect_success 'setup: two scripts for reading pull requests' '
-
 	downstream_url_for_sed=$(
 		printf "%s\n" "$downstream_url" |
 		sed -e '\''s/\\/\\\\/g'\'' -e '\''s/[[/.*^$]/\\&/g'\''
@@ -113,11 +110,9 @@ test_expect_success 'setup: two scripts for reading pull requests' '
 	n
 	b shortlog
 	EOT
-
 '
 
 test_expect_success 'pull request when forgot to push' '
-
 	rm -fr downstream.git &&
 	git init --bare downstream.git &&
 	(
@@ -129,11 +124,9 @@ test_expect_success 'pull request when forgot to push' '
 	) &&
 	grep "No branch of.*is at:\$" err &&
 	grep "Are you sure you pushed" err
-
 '
 
 test_expect_success 'pull request after push' '
-
 	rm -fr downstream.git &&
 	git init --bare downstream.git &&
 	(
@@ -157,11 +150,9 @@ test_expect_success 'pull request after push' '
 	) &&
 	test "$branch" = for-upstream &&
 	test_cmp local/mnemonic.txt upstream-private/mnemonic.txt
-
 '
 
 test_expect_success 'request names an appropriate branch' '
-
 	rm -fr downstream.git &&
 	git init --bare downstream.git &&
 	(
@@ -180,11 +171,9 @@ test_expect_success 'request names an appropriate branch' '
 		read branch
 	} <digest &&
 	test "$branch" = tags/full
-
 '
 
 test_expect_success 'pull request format' '
-
 	rm -fr downstream.git &&
 	git init --bare downstream.git &&
 	cat <<-\EOT >expect &&
@@ -217,11 +206,9 @@ test_expect_success 'pull request format' '
 	) &&
 	<request sed -nf fuzz.sed >request.fuzzy &&
 	test_i18ncmp expect request.fuzzy
-
 '
 
 test_expect_success 'request-pull ignores OPTIONS_KEEPDASHDASH poison' '
-
 	(
 		cd local &&
 		OPTIONS_KEEPDASHDASH=Yes &&
@@ -231,7 +218,6 @@ test_expect_success 'request-pull ignores OPTIONS_KEEPDASHDASH poison' '
 		git push origin master:for-upstream &&
 		git request-pull -- initial "$downstream_url" >../request
 	)
-
 '
 
 test_expect_success 'pull request when pushed tag' '
-- 
1.8.4-fc
