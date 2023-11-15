Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpKvhii/"
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2C0E5
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 11:07:45 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-421ae930545so220691cf.0
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 11:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700075264; x=1700680064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVeTjrqm3S380Lff2YDriUNkPMRZaabMdiOB2HofYdc=;
        b=LpKvhii/C7NEnuYrfVvMX7s4oZp0sB2jk8gQ9Qt4RIVoS+Y642i07xQgaCQoRWQcWD
         fYhUjMDHZV9erIQRy78C6Iy4irtyF1+x05Y2L/A3d0Ifo+TR8iJKWwLgimVdTtVLVjSv
         wWPjGPvw9Xoau1FXPN5OHb2jupd130c241AaD1mY052EeUNMssTmHTkYDGEeoDt1eZLw
         ShvOczjkx4zPnImpZuefakTqGUedEP6HiyA/7Dui64P2cHHjKu5U0LVG2lp+WH27m4Mj
         uNogN9sxRwmoESGgJkCmRebRvkVTkxWmfW5UvOpNFuBr1arZ2aZM8AZHLmPhdOW5D6YZ
         EBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700075264; x=1700680064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVeTjrqm3S380Lff2YDriUNkPMRZaabMdiOB2HofYdc=;
        b=VkyoLl/cdHWPyI8/P6T4KQg1J3Whtgbz4sm2DGFrWZO2L3zTS2gU1eYUD8qdqwq5l4
         zAIEbtbH0MH9piHpA2JjuWkiORq+8RLOFkyyZXgTTc3tF6rZfzZf6MgH9WIFDavzGhX/
         qh/VxrARHq6pLXYvZYRZGKanRM4k3HlD+E98bFPCzbADM/W4+YXBMibcfdCuOl1u49Rg
         swoEaj16ye89hCRU+5Jq4H6A3mbefVPLOrdjoSk+Q1NAhBFAzjMWuAdWdU1vZL/RIQU/
         QzouKnyrIrpCKtfx/cl544VkCXUEB9iWb3g9jN08iaNxkadSY/KGpuD4x9aJEDeVF0ao
         ENoQ==
X-Gm-Message-State: AOJu0YzN4DwcSGtOSelWzvnS2/lUZOgODz1QCnPVxhOUCRyHGv4SUsYE
	rVIdlnxks4fGVyWG/YgX3MoWZFqhBak=
X-Google-Smtp-Source: AGHT+IHHRRQVpsFu9U9BU9Gz+ml6Cdfbw+u8Ds/xwpyH1bkaLGWpsofdyyXeNd5yXNrDahPwy17UYg==
X-Received: by 2002:ac8:5e52:0:b0:419:a2c6:820e with SMTP id i18-20020ac85e52000000b00419a2c6820emr7836599qtx.12.1700075264004;
        Wed, 15 Nov 2023 11:07:44 -0800 (PST)
Received: from u.ad.analog.com ([185.7.230.119])
        by smtp.gmail.com with ESMTPSA id y26-20020ac8709a000000b004197079f2f8sm3712722qto.64.2023.11.15.11.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 11:07:43 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v2] RelNotes: tweak 2.43.0 release notes
Date: Wed, 15 Nov 2023 19:07:32 +0000
Message-ID: <20231115190732.2615-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc1
In-Reply-To: <20231114223127.11292-1-andy.koppe@gmail.com>
References: <20231114223127.11292-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some more detail on the $(decorate) log format placeholder and tweak
the wording on some other points.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
Now with 100% more signature. Sorry for the unnecessary noise.

 Documentation/RelNotes/2.43.0.txt | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/RelNotes/2.43.0.txt b/Documentation/RelNotes/2.43.0.txt
index 770543c464e..9a68074a4a5 100644
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
2.43.0-rc1

