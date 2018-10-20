Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D7991F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbeJTUuY (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45183 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeJTUuY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id c24-v6so677442lfi.12
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HcBRJQxt9SGWPCOxiMKVC3pyH6cCfaXIKEt8evBxo2A=;
        b=SGADudFLGIRIdwIyyO3CZiou/iF3BVdnFBI9xpPqu8Awzq4rfc6pfSjP0wROyy4M/z
         lF5+Je/dMYujg18cOP4JtWWEKBHLx2ZLd2pvoT+njkB8k6iGA1MhlzcOiWgKUA+AU+mL
         ZAK3ycEHrZPK/tlK0M89doKWO2gd+/YaiHAQq5zVmjtr0ipPthj0JX6phAMQ4zMDXcf/
         K9Mc+dc0elXruN7SoPt/6O3HaYbUBJFLsOUWz1t5xbxu2ow7mS8HHGP7iAgBOalx3aBw
         SaLFLMvyHeEhZnivnk4Gu86biBnmgnaTzC5df79fc719S3kuQ1T3zTL36sDTw1id6mQC
         pebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HcBRJQxt9SGWPCOxiMKVC3pyH6cCfaXIKEt8evBxo2A=;
        b=fFMO8eIknmwCB5UKHnQGcSrvvHHcNnv7abxRM6YNnTHV4Ra/oHXFmy1nU2NkBQplj8
         0RJquJIH/554eooeIgkKy0pASg1FT+XPBZnVSn/mSyS67qHcjyHsdeheSK3Uif9yqvjc
         KqvrQf1VPZmaHnahhg/c+DQS5KydRH9mjKfnhUBtDB+CNOMCHHjPeiR2m/WAhAY3bfbN
         3o6QXtetSGod1bwMeYBR/LXkI/FVycBOZCTxJjvZW8RSPfgAMRTt+WMjeCgMgVqDLKEF
         I+z00vWpTyZI1wIjMK/XtvkN8qwaZ73fhZPEknKliJp1LvvzlGlz5ImCW6vw+QKVunJd
         TlCA==
X-Gm-Message-State: ABuFfojkbft29PcVaq/rS9FXGc5iu9sxQUkfXxONQSV49XVu41rUl0G7
        dn1TY5mILgltI4p6zH67ZmVgFBWc
X-Google-Smtp-Source: ACcGV60WcUeP54itEpCd1l/PJflIqfe4j/n+Ia4LY1ZNXWi+qFPPrkqhW8y8mPgFG0tozmz3cPeaTg==
X-Received: by 2002:a19:3809:: with SMTP id f9mr347375lfa.148.1540039201237;
        Sat, 20 Oct 2018 05:40:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 39/59] config.txt: move pack.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:28 +0200
Message-Id: <20181020123848.2785-40-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt      | 121 +---------------------------------
 Documentation/pack-config.txt | 120 +++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/pack-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d1de7ccc89..45b184b247 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -628,126 +628,7 @@ include::mergetool-config.txt[]
 
 include::notes-config.txt[]
 
-pack.window::
-	The size of the window used by linkgit:git-pack-objects[1] when no
-	window size is given on the command line. Defaults to 10.
-
-pack.depth::
-	The maximum delta depth used by linkgit:git-pack-objects[1] when no
-	maximum depth is given on the command line. Defaults to 50.
-	Maximum value is 4095.
-
-pack.windowMemory::
-	The maximum size of memory that is consumed by each thread
-	in linkgit:git-pack-objects[1] for pack window memory when
-	no limit is given on the command line.  The value can be
-	suffixed with "k", "m", or "g".  When left unconfigured (or
-	set explicitly to 0), there will be no limit.
-
-pack.compression::
-	An integer -1..9, indicating the compression level for objects
-	in a pack file. -1 is the zlib default. 0 means no
-	compression, and 1..9 are various speed/size tradeoffs, 9 being
-	slowest.  If not set,  defaults to core.compression.  If that is
-	not set,  defaults to -1, the zlib default, which is "a default
-	compromise between speed and compression (currently equivalent
-	to level 6)."
-+
-Note that changing the compression level will not automatically recompress
-all existing objects. You can force recompression by passing the -F option
-to linkgit:git-repack[1].
-
-pack.island::
-	An extended regular expression configuring a set of delta
-	islands. See "DELTA ISLANDS" in linkgit:git-pack-objects[1]
-	for details.
-
-pack.islandCore::
-	Specify an island name which gets to have its objects be
-	packed first. This creates a kind of pseudo-pack at the front
-	of one pack, so that the objects from the specified island are
-	hopefully faster to copy into any pack that should be served
-	to a user requesting these objects. In practice this means
-	that the island specified should likely correspond to what is
-	the most commonly cloned in the repo. See also "DELTA ISLANDS"
-	in linkgit:git-pack-objects[1].
-
-pack.deltaCacheSize::
-	The maximum memory in bytes used for caching deltas in
-	linkgit:git-pack-objects[1] before writing them out to a pack.
-	This cache is used to speed up the writing object phase by not
-	having to recompute the final delta result once the best match
-	for all objects is found.  Repacking large repositories on machines
-	which are tight with memory might be badly impacted by this though,
-	especially if this cache pushes the system into swapping.
-	A value of 0 means no limit. The smallest size of 1 byte may be
-	used to virtually disable this cache. Defaults to 256 MiB.
-
-pack.deltaCacheLimit::
-	The maximum size of a delta, that is cached in
-	linkgit:git-pack-objects[1]. This cache is used to speed up the
-	writing object phase by not having to recompute the final delta
-	result once the best match for all objects is found.
-	Defaults to 1000. Maximum value is 65535.
-
-pack.threads::
-	Specifies the number of threads to spawn when searching for best
-	delta matches.  This requires that linkgit:git-pack-objects[1]
-	be compiled with pthreads otherwise this option is ignored with a
-	warning. This is meant to reduce packing time on multiprocessor
-	machines. The required amount of memory for the delta search window
-	is however multiplied by the number of threads.
-	Specifying 0 will cause Git to auto-detect the number of CPU's
-	and set the number of threads accordingly.
-
-pack.indexVersion::
-	Specify the default pack index version.  Valid values are 1 for
-	legacy pack index used by Git versions prior to 1.5.2, and 2 for
-	the new pack index with capabilities for packs larger than 4 GB
-	as well as proper protection against the repacking of corrupted
-	packs.  Version 2 is the default.  Note that version 2 is enforced
-	and this config option ignored whenever the corresponding pack is
-	larger than 2 GB.
-+
-If you have an old Git that does not understand the version 2 `*.idx` file,
-cloning or fetching over a non native protocol (e.g. "http")
-that will copy both `*.pack` file and corresponding `*.idx` file from the
-other side may give you a repository that cannot be accessed with your
-older version of Git. If the `*.pack` file is smaller than 2 GB, however,
-you can use linkgit:git-index-pack[1] on the *.pack file to regenerate
-the `*.idx` file.
-
-pack.packSizeLimit::
-	The maximum size of a pack.  This setting only affects
-	packing to a file when repacking, i.e. the git:// protocol
-	is unaffected.  It can be overridden by the `--max-pack-size`
-	option of linkgit:git-repack[1].  Reaching this limit results
-	in the creation of multiple packfiles; which in turn prevents
-	bitmaps from being created.
-	The minimum size allowed is limited to 1 MiB.
-	The default is unlimited.
-	Common unit suffixes of 'k', 'm', or 'g' are
-	supported.
-
-pack.useBitmaps::
-	When true, git will use pack bitmaps (if available) when packing
-	to stdout (e.g., during the server side of a fetch). Defaults to
-	true. You should not generally need to turn this off unless
-	you are debugging pack bitmaps.
-
-pack.writeBitmaps (deprecated)::
-	This is a deprecated synonym for `repack.writeBitmaps`.
-
-pack.writeBitmapHashCache::
-	When true, git will include a "hash cache" section in the bitmap
-	index (if one is written). This cache can be used to feed git's
-	delta heuristics, potentially leading to better deltas between
-	bitmapped and non-bitmapped objects (e.g., when serving a fetch
-	between an older, bitmapped pack and objects that have been
-	pushed since the last gc). The downside is that it consumes 4
-	bytes per object of disk space, and that JGit's bitmap
-	implementation does not understand it, causing it to complain if
-	Git and JGit are used on the same repository. Defaults to false.
+include::pack-config.txt[]
 
 pager.<cmd>::
 	If the value is boolean, turns on or off pagination of the
diff --git a/Documentation/pack-config.txt b/Documentation/pack-config.txt
new file mode 100644
index 0000000000..edac75c83f
--- /dev/null
+++ b/Documentation/pack-config.txt
@@ -0,0 +1,120 @@
+pack.window::
+	The size of the window used by linkgit:git-pack-objects[1] when no
+	window size is given on the command line. Defaults to 10.
+
+pack.depth::
+	The maximum delta depth used by linkgit:git-pack-objects[1] when no
+	maximum depth is given on the command line. Defaults to 50.
+	Maximum value is 4095.
+
+pack.windowMemory::
+	The maximum size of memory that is consumed by each thread
+	in linkgit:git-pack-objects[1] for pack window memory when
+	no limit is given on the command line.  The value can be
+	suffixed with "k", "m", or "g".  When left unconfigured (or
+	set explicitly to 0), there will be no limit.
+
+pack.compression::
+	An integer -1..9, indicating the compression level for objects
+	in a pack file. -1 is the zlib default. 0 means no
+	compression, and 1..9 are various speed/size tradeoffs, 9 being
+	slowest.  If not set,  defaults to core.compression.  If that is
+	not set,  defaults to -1, the zlib default, which is "a default
+	compromise between speed and compression (currently equivalent
+	to level 6)."
++
+Note that changing the compression level will not automatically recompress
+all existing objects. You can force recompression by passing the -F option
+to linkgit:git-repack[1].
+
+pack.island::
+	An extended regular expression configuring a set of delta
+	islands. See "DELTA ISLANDS" in linkgit:git-pack-objects[1]
+	for details.
+
+pack.islandCore::
+	Specify an island name which gets to have its objects be
+	packed first. This creates a kind of pseudo-pack at the front
+	of one pack, so that the objects from the specified island are
+	hopefully faster to copy into any pack that should be served
+	to a user requesting these objects. In practice this means
+	that the island specified should likely correspond to what is
+	the most commonly cloned in the repo. See also "DELTA ISLANDS"
+	in linkgit:git-pack-objects[1].
+
+pack.deltaCacheSize::
+	The maximum memory in bytes used for caching deltas in
+	linkgit:git-pack-objects[1] before writing them out to a pack.
+	This cache is used to speed up the writing object phase by not
+	having to recompute the final delta result once the best match
+	for all objects is found.  Repacking large repositories on machines
+	which are tight with memory might be badly impacted by this though,
+	especially if this cache pushes the system into swapping.
+	A value of 0 means no limit. The smallest size of 1 byte may be
+	used to virtually disable this cache. Defaults to 256 MiB.
+
+pack.deltaCacheLimit::
+	The maximum size of a delta, that is cached in
+	linkgit:git-pack-objects[1]. This cache is used to speed up the
+	writing object phase by not having to recompute the final delta
+	result once the best match for all objects is found.
+	Defaults to 1000. Maximum value is 65535.
+
+pack.threads::
+	Specifies the number of threads to spawn when searching for best
+	delta matches.  This requires that linkgit:git-pack-objects[1]
+	be compiled with pthreads otherwise this option is ignored with a
+	warning. This is meant to reduce packing time on multiprocessor
+	machines. The required amount of memory for the delta search window
+	is however multiplied by the number of threads.
+	Specifying 0 will cause Git to auto-detect the number of CPU's
+	and set the number of threads accordingly.
+
+pack.indexVersion::
+	Specify the default pack index version.  Valid values are 1 for
+	legacy pack index used by Git versions prior to 1.5.2, and 2 for
+	the new pack index with capabilities for packs larger than 4 GB
+	as well as proper protection against the repacking of corrupted
+	packs.  Version 2 is the default.  Note that version 2 is enforced
+	and this config option ignored whenever the corresponding pack is
+	larger than 2 GB.
++
+If you have an old Git that does not understand the version 2 `*.idx` file,
+cloning or fetching over a non native protocol (e.g. "http")
+that will copy both `*.pack` file and corresponding `*.idx` file from the
+other side may give you a repository that cannot be accessed with your
+older version of Git. If the `*.pack` file is smaller than 2 GB, however,
+you can use linkgit:git-index-pack[1] on the *.pack file to regenerate
+the `*.idx` file.
+
+pack.packSizeLimit::
+	The maximum size of a pack.  This setting only affects
+	packing to a file when repacking, i.e. the git:// protocol
+	is unaffected.  It can be overridden by the `--max-pack-size`
+	option of linkgit:git-repack[1].  Reaching this limit results
+	in the creation of multiple packfiles; which in turn prevents
+	bitmaps from being created.
+	The minimum size allowed is limited to 1 MiB.
+	The default is unlimited.
+	Common unit suffixes of 'k', 'm', or 'g' are
+	supported.
+
+pack.useBitmaps::
+	When true, git will use pack bitmaps (if available) when packing
+	to stdout (e.g., during the server side of a fetch). Defaults to
+	true. You should not generally need to turn this off unless
+	you are debugging pack bitmaps.
+
+pack.writeBitmaps (deprecated)::
+	This is a deprecated synonym for `repack.writeBitmaps`.
+
+pack.writeBitmapHashCache::
+	When true, git will include a "hash cache" section in the bitmap
+	index (if one is written). This cache can be used to feed git's
+	delta heuristics, potentially leading to better deltas between
+	bitmapped and non-bitmapped objects (e.g., when serving a fetch
+	between an older, bitmapped pack and objects that have been
+	pushed since the last gc). The downside is that it consumes 4
+	bytes per object of disk space, and that JGit's bitmap
+	implementation does not understand it, causing it to complain if
+	Git and JGit are used on the same repository. Defaults to false.
-- 
2.19.1.647.g708186aaf9

