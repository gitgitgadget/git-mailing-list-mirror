Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8E23308C
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 22:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXr5g5x4"
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C424F5
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 14:31:49 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so33423725e9.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 14:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700001107; x=1700605907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DBRBR+x4LfV3zElNQ0DxBI8o4LzjnC/Oi8auSaFnb9A=;
        b=VXr5g5x4hjQBFAVCQ0le6Klma25XSZnFA1JNJhYJaXYRuTn/d9UxAdcXIgxvVKNj42
         zbOx9IXxLxLa0BynfdKz6b+tuYr97c4ylQ0uTr/ZLKUJ0n02I62//YY3boMJtNFSw77l
         1YhxQG/JZCEA43r13peEx6haTSdROOIF3sGObnEtoptLEK/oBQMdYmi75CIQLHUfTELp
         YYzzI6UvtuJXKvnT1GVpb7XOcWKMMSoH4226O4dA6G2sshSjH7nPAsua/gxr4jYVzUZQ
         XowyqBjgpuzAHViVppJmdqh+TcidyoHtGCHh74vUKZm3om2XQmfWX0EkmCmu5WWv+HF4
         hsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700001107; x=1700605907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DBRBR+x4LfV3zElNQ0DxBI8o4LzjnC/Oi8auSaFnb9A=;
        b=q//d8n5qVo4LFjoV+PDjFgzddxtrYPmgNxo01kDweHhjMs+kBm4+a4WJJ8znIheM0/
         gLHFUay7VjxmMqLHKd0IsgSXyPhpzPpqSCC5j169SjQbWvNKNJLnOYNo4epMVwLDVLXs
         P8VqDKIzUkcAdOpZZ1RmoLDeyf5d8t34byxShyJY3tPkMGs9rzhPESiOI7swCOnyA6YX
         s/EZfmcM6Zn+K6QaPlT/WW66bemKNZTfArSaSS2A5j9NAM550odCGNgKkEkxFjl9bXGN
         IyB1POMI7dJVmlBXJvkEg01uawkZznK8IhWx11UrOQiTUvuzn77d6R0DU4e96YjcAlEI
         yvDw==
X-Gm-Message-State: AOJu0YwPvTUdwhj4U4jjCB/16S9iKBBBrjJyJD/b+gQ/ka2lVUCmkFqt
	sdU2FZbXc5nVNdbu5ahgOQrfY1dfQTShdw==
X-Google-Smtp-Source: AGHT+IE0W7PuqOIHqYkwtXjVeP+PiWREGJwFugs+dPjXdDaOXd9VjZVDsFxn7WxLLJqbGI9oHfhTXg==
X-Received: by 2002:a7b:c057:0:b0:408:53d6:10b3 with SMTP id u23-20020a7bc057000000b0040853d610b3mr8925319wmc.22.1700001107443;
        Tue, 14 Nov 2023 14:31:47 -0800 (PST)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id q3-20020a05600c46c300b00405442edc69sm18685911wmo.14.2023.11.14.14.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 14:31:47 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH] RelNotes: tweak 2.43.0 release notes
Date: Tue, 14 Nov 2023 22:31:27 +0000
Message-ID: <20231114223127.11292-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some more detail on the $(decorate) log format placeholder and tweak
the wording on some other points.
---
 Documentation/RelNotes/2.43.0.txt | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/RelNotes/2.43.0.txt b/Documentation/RelNotes/2.43.0.txt
index 770543c464..9a68074a4a 100644
--- a/Documentation/RelNotes/2.43.0.txt
+++ b/Documentation/RelNotes/2.43.0.txt
@@ -10,8 +10,8 @@ Backward Compatibility Notes
    prefix.  If you are negatively affected by this change, please use
    "--subject-prefix=PATCH --rfc" as a replacement.
 
- * "git rev-list --stdin" learned to take non-revisions (like "--not")
-   recently from the standard input, but the way such a "--not" was
+ * "git rev-list --stdin" recently learned to take non-revisions (like
+   "--not") from the standard input, but the way such a "--not" was
    handled was quite confusing, which has been rethought.  The updated
    rule is that "--not" given from the command line only affects revs
    given from the command line that comes but not revs read from the
@@ -43,10 +43,10 @@ UI, Workflows & Features
 
  * Git GUI updates.
 
- * "git format-patch" learns a way to feed cover letter description,
-   that (1) can be used on detached HEAD where there is no branch
-   description available, and (2) also can override the branch
-   description if there is one.
+ * "git format-patch" learns option "--description-file" to feed in a
+   cover letter description that can be used when no branch description
+   is available, or that can override the branch description if there is
+   one.
 
  * Use of --max-pack-size to allow multiple packfiles to be created is
    now supported even when we are sending unreachable objects to cruft
@@ -56,7 +56,9 @@ UI, Workflows & Features
    "--subject-prefix" option and used "[RFC PATCH]"; now we will add
    "RFC" prefix to whatever subject prefix is specified.
 
- * "git log --format" has been taught the %(decorate) placeholder.
+ * "git log" format strings now support a "%(decorate)" placeholder that
+   can be used to customize the symbols and the tag prefix used in ref
+   decorations.
 
  * The default log message created by "git revert", when reverting a
    commit that records a revert, has been tweaked, to encourage people
@@ -99,7 +101,7 @@ UI, Workflows & Features
  * The attribute subsystem learned to honor `attr.tree` configuration
    that specifies which tree to read the .gitattributes files from.
 
- * "git merge-file" learns a mode to read three contents to be merged
+ * "git merge-file" learns a mode to read three files to be merged
    from blob objects.
 
 
@@ -127,7 +129,7 @@ Performance, Internal Implementation, Development Support etc.
  * The code to keep track of existing packs in the repository while
    repacking has been refactored.
 
- * The "streaming" interface used for bulk-checkin codepath has been
+ * The "streaming" interface used for the bulk-checkin codepath has been
    narrowed to take only blob objects for now, with no real loss of
    functionality.
 
-- 
2.43.0-rc2

