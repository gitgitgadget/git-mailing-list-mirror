Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaopbSlq"
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B852CD7D
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:35:24 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4079ed65582so9942575e9.1
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700796922; x=1701401722; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oq82+N+rJwfTEUZsLdvRFEbs0lYDdbBUAVc4r/ZjqOw=;
        b=IaopbSlqAbUKHbEOR8ZPjpBH6O4k+2U54PSY70WBOBnQ4+V9o9MRKWz08zkLyufg5C
         4wVfUVpwt73QQVY87hC/EuG79LJq0wSC4lhsSGMPg/4LNhfHs+LK7vSByqMwktgmOa3s
         lBdZCwDu2sV/jjvNOd3IY1zzwGMp2i4p06OaySgPlsGSEp2vjOZVZAakzq/mybKdiyFK
         cPS0oZVisCTwwhVtfpIPDL/qpiFp4KNanqNKQEPzzx2jb062qElNKbp2HK6Jll0Huqhd
         zFDZzUQMtbEyYMFUMBveBrfTz7BztkwjZQ6qK7uGHQ7fFf4kO1844gUdvbZSO2QPUlTq
         8BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700796922; x=1701401722;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oq82+N+rJwfTEUZsLdvRFEbs0lYDdbBUAVc4r/ZjqOw=;
        b=UKq7C3MOXVK0RUfDRA6qMijcMS6tHPlvnwN4C4HUU9GcwlJF5NpE9pG2DhoCwgM5pV
         lfSqutW1/nkMLXkppsgucstxpFNWUPX0aKuu7GC+2121G56noFL8JIFtzAcHR71dJ2Qn
         Ow6ZJj0c88a3hJGKtLjmRutvH4zjiASKUQZ7Vf7Jbop9OU+C9GonW9+2q4feXYcTxYNB
         3D9gO0SlOdaRuaHC5+/m22phKU1pn1vuIXvgaDPANTqF+J4YR2K9wcWUG2O7cqi+UgSl
         uoQAz7mCUC3LsLkGmG3DWa60ixHi710Taj7Kyoe3g8PF71SAERb4wn6SuC2hRdOf9qcq
         LxsA==
X-Gm-Message-State: AOJu0YzFSD4mzY3LeXO0V/qIHVny7mWjD4iw1/LR7aJvadhjodGBHzJ3
	5dEQSpxFR8bQJgBKFmObUBX3goXAAfQ=
X-Google-Smtp-Source: AGHT+IFQg/E421O5WyKf7dFeYeiAWfYIQX+fwGOwcayVwAHSyBvzB989vkMRUorTzqQQVOseJef15w==
X-Received: by 2002:adf:ef4e:0:b0:331:4e5e:d9e7 with SMTP id c14-20020adfef4e000000b003314e5ed9e7mr938711wrp.34.1700796922596;
        Thu, 23 Nov 2023 19:35:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3-20020a5d5443000000b003140f47224csm3138542wrv.15.2023.11.23.19.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 19:35:21 -0800 (PST)
Message-ID: <6d614a00a97eb5b3bb2b62db1e24390854810c21.1700796917.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1589.v3.git.1700796916.gitgitgadget@gmail.com>
References: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
	<pull.1589.v3.git.1700796916.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Nov 2023 03:35:15 +0000
Subject: [PATCH v3 4/4] doc: refer to internet archive
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Josh Soref <jsoref@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Josh Soref <jsoref@gmail.com>,
    Josh Soref <jsoref@gmail.com>

From: Josh Soref <jsoref@gmail.com>

These pages are no longer reachable from their original locations,
which makes things difficult for readers. Instead, switch to linking to
the Internet Archive for the content.

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 gitweb/gitweb.perl       | 2 +-
 sha1dc/sha1.c            | 2 +-
 t/lib-gpg.sh             | 2 +-
 t/t9816-git-p4-locked.sh | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b6659410ef1..6f139b8fc32 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -8193,7 +8193,7 @@ sub git_feed {
 	my $have_blame = gitweb_check_feature('blame');
 
 	# Atom: http://www.atomenabled.org/developers/syndication/
-	# RSS:  http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
+	# RSS:  https://web.archive.org/web/20030729001534/http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
 	if ($format ne 'rss' && $format ne 'atom') {
 		die_error(400, "Unknown web feed format");
 	}
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index dede2cbddf9..f993ef9c690 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -88,7 +88,7 @@
 /*
  * Should define Big Endian for a whitelist of known processors. See
  * https://sourceforge.net/p/predef/wiki/Endianness/ and
- * http://www.oracle.com/technetwork/server-storage/solaris/portingtosolaris-138514.html
+ * https://web.archive.org/web/20140421151132/http://www.perforce.com/perforce/doc.current/manuals/p4sag/chapter.superuser.html
  */
 #define SHA1DC_BIGENDIAN
 
diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 83b83c9abb5..add11e88fc0 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -13,7 +13,7 @@ test_lazy_prereq GPG '
 	gpg_version=$(gpg --version 2>&1)
 	test $? != 127 || exit 1
 
-	# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
+	# As said here: https://web.archive.org/web/20130212022238/https://www.gnupg.org/faq/gnupg-faq.html#why-does-gnupg-1.0.6-bail-out-on-keyrings-used-with-1.0.7
 	# the gpg version 1.0.6 did not parse trust packets correctly, so for
 	# that version, creation of signed tags using the generated key fails.
 	case "$gpg_version" in
diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
index 932841003cf..5e904ac80d8 100755
--- a/t/t9816-git-p4-locked.sh
+++ b/t/t9816-git-p4-locked.sh
@@ -9,7 +9,7 @@ test_expect_success 'start p4d' '
 '
 
 # See
-# http://www.perforce.com/perforce/doc.current/manuals/p4sag/03_superuser.html#1088563
+# https://web.archive.org/web/20150602090517/http://www.perforce.com/perforce/doc.current/manuals/p4sag/chapter.superuser.html#superuser.basic.typemap_locking
 # for suggestions on how to configure "sitewide pessimistic locking"
 # where only one person can have a file open for edit at a time.
 test_expect_success 'init depot' '
-- 
gitgitgadget
