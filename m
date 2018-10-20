Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7F91F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeJTUun (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45199 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbeJTUum (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id c24-v6so677774lfi.12
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QMpf33Ze85jdunoqvnfP23yuilcns2txI9+qcU4C0mI=;
        b=kFBkwePTqYOfInCLlpPSac4vdIWUiFy5EEYM5MeIFnP++Hp0Lzdp5RQyrrqJUDQ54H
         VJIUog8rs62Xlsq9Fi8jTlvnl76UgNLZvbOcBg8pQ3C/rUfOMkZGQTsNg1gDSO/llA4I
         vihpimLMb/GVr4D8DDZjDMWPQlpqNtBm+hE127S09VpFcciBCjALX/51DLLiT0XcPdz4
         wCw08tLR6bj25ZWBhTTpcKk3T7YNjfnOg+NpxsN5MMwxdLCxB8rAB36s28dqTTMEolgX
         24GiaP7TPvb5zY9YwHiJXcncq7V7RzLlnrOsTsIyPtZyoAo7/UsO6pgAFeYboGKdoC6a
         UcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QMpf33Ze85jdunoqvnfP23yuilcns2txI9+qcU4C0mI=;
        b=az8LRgE2R16PiRCdU421Cy62BogHTVkw1kzkLBKIV5NuDfr3YF1w9CnzK7jnEUV+jJ
         vYxjfwe4OHKceyBzO3iAxYolYNfXxYkX9IAMQ7Ne9TDM0KbSdY7+doOBruIJo6C6y5DL
         Pd/MlC76nM5n9Dz0jcqF/uuelocQ1Hzc9TfieNdYAseM3Da5f53WLKT/eUp82snkLyru
         xqM5qS9c1tGcIOwcNIdjLue1ybfgdf9RbYj5Ksx4pcRvGkhGNWHEEFPmq5EZy5tNSGmZ
         4g52wMjMT/HM7QZhl4shrTqs45lzPRxHp2f3ndTw+HKFNzGkejnr8ZoMuU7X/PnWm2Jr
         Y+5g==
X-Gm-Message-State: ABuFfogtkaBd4WdpNlA+XC2Qr/ttKAa4eDtF1tniFJM4Arwiy6D+RSwU
        SAF6c0MiL0kAEEPDRwWDxmBaFTFD
X-Google-Smtp-Source: ACcGV60MrkHjYOa0dHy6K/buDqdbt8q1Fcl2yJxZiqO7i9GiqXD6wG2Cs1DboSDxijimLd3cw7TUTA==
X-Received: by 2002:a19:4411:: with SMTP id r17-v6mr5805725lfa.87.1540039219036;
        Sat, 20 Oct 2018 05:40:19 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:18 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 52/59] config.txt: move transfer.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:41 +0200
Message-Id: <20181020123848.2785-53-pclouds@gmail.com>
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
 Documentation/config.txt          | 72 +------------------------------
 Documentation/transfer-config.txt | 71 ++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/transfer-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4b1efe0a95..b70f98baba 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -670,77 +670,7 @@ include::submodule-config.txt[]
 
 include::tag-config.txt[]
 
-transfer.fsckObjects::
-	When `fetch.fsckObjects` or `receive.fsckObjects` are
-	not set, the value of this variable is used instead.
-	Defaults to false.
-+
-When set, the fetch or receive will abort in the case of a malformed
-object or a link to a nonexistent object. In addition, various other
-issues are checked for, including legacy issues (see `fsck.<msg-id>`),
-and potential security issues like the existence of a `.GIT` directory
-or a malicious `.gitmodules` file (see the release notes for v2.2.1
-and v2.17.1 for details). Other sanity and security checks may be
-added in future releases.
-+
-On the receiving side, failing fsckObjects will make those objects
-unreachable, see "QUARANTINE ENVIRONMENT" in
-linkgit:git-receive-pack[1]. On the fetch side, malformed objects will
-instead be left unreferenced in the repository.
-+
-Due to the non-quarantine nature of the `fetch.fsckObjects`
-implementation it can not be relied upon to leave the object store
-clean like `receive.fsckObjects` can.
-+
-As objects are unpacked they're written to the object store, so there
-can be cases where malicious objects get introduced even though the
-"fetch" failed, only to have a subsequent "fetch" succeed because only
-new incoming objects are checked, not those that have already been
-written to the object store. That difference in behavior should not be
-relied upon. In the future, such objects may be quarantined for
-"fetch" as well.
-+
-For now, the paranoid need to find some way to emulate the quarantine
-environment if they'd like the same protection as "push". E.g. in the
-case of an internal mirror do the mirroring in two steps, one to fetch
-the untrusted objects, and then do a second "push" (which will use the
-quarantine) to another internal repo, and have internal clients
-consume this pushed-to repository, or embargo internal fetches and
-only allow them once a full "fsck" has run (and no new fetches have
-happened in the meantime).
-
-transfer.hideRefs::
-	String(s) `receive-pack` and `upload-pack` use to decide which
-	refs to omit from their initial advertisements.  Use more than
-	one definition to specify multiple prefix strings. A ref that is
-	under the hierarchies listed in the value of this variable is
-	excluded, and is hidden when responding to `git push` or `git
-	fetch`.  See `receive.hideRefs` and `uploadpack.hideRefs` for
-	program-specific versions of this config.
-+
-You may also include a `!` in front of the ref name to negate the entry,
-explicitly exposing it, even if an earlier entry marked it as hidden.
-If you have multiple hideRefs values, later entries override earlier ones
-(and entries in more-specific config files override less-specific ones).
-+
-If a namespace is in use, the namespace prefix is stripped from each
-reference before it is matched against `transfer.hiderefs` patterns.
-For example, if `refs/heads/master` is specified in `transfer.hideRefs` and
-the current namespace is `foo`, then `refs/namespaces/foo/refs/heads/master`
-is omitted from the advertisements but `refs/heads/master` and
-`refs/namespaces/bar/refs/heads/master` are still advertised as so-called
-"have" lines. In order to match refs before stripping, add a `^` in front of
-the ref name. If you combine `!` and `^`, `!` must be specified first.
-+
-Even if you hide refs, a client may still be able to steal the target
-objects via the techniques described in the "SECURITY" section of the
-linkgit:gitnamespaces[7] man page; it's best to keep private data in a
-separate repository.
-
-transfer.unpackLimit::
-	When `fetch.unpackLimit` or `receive.unpackLimit` are
-	not set, the value of this variable is used instead.
-	The default value is 100.
+include::transfer-config.txt[]
 
 uploadarchive.allowUnreachable::
 	If true, allow clients to use `git archive --remote` to request
diff --git a/Documentation/transfer-config.txt b/Documentation/transfer-config.txt
new file mode 100644
index 0000000000..4a5dfe2fc1
--- /dev/null
+++ b/Documentation/transfer-config.txt
@@ -0,0 +1,71 @@
+transfer.fsckObjects::
+	When `fetch.fsckObjects` or `receive.fsckObjects` are
+	not set, the value of this variable is used instead.
+	Defaults to false.
++
+When set, the fetch or receive will abort in the case of a malformed
+object or a link to a nonexistent object. In addition, various other
+issues are checked for, including legacy issues (see `fsck.<msg-id>`),
+and potential security issues like the existence of a `.GIT` directory
+or a malicious `.gitmodules` file (see the release notes for v2.2.1
+and v2.17.1 for details). Other sanity and security checks may be
+added in future releases.
++
+On the receiving side, failing fsckObjects will make those objects
+unreachable, see "QUARANTINE ENVIRONMENT" in
+linkgit:git-receive-pack[1]. On the fetch side, malformed objects will
+instead be left unreferenced in the repository.
++
+Due to the non-quarantine nature of the `fetch.fsckObjects`
+implementation it can not be relied upon to leave the object store
+clean like `receive.fsckObjects` can.
++
+As objects are unpacked they're written to the object store, so there
+can be cases where malicious objects get introduced even though the
+"fetch" failed, only to have a subsequent "fetch" succeed because only
+new incoming objects are checked, not those that have already been
+written to the object store. That difference in behavior should not be
+relied upon. In the future, such objects may be quarantined for
+"fetch" as well.
++
+For now, the paranoid need to find some way to emulate the quarantine
+environment if they'd like the same protection as "push". E.g. in the
+case of an internal mirror do the mirroring in two steps, one to fetch
+the untrusted objects, and then do a second "push" (which will use the
+quarantine) to another internal repo, and have internal clients
+consume this pushed-to repository, or embargo internal fetches and
+only allow them once a full "fsck" has run (and no new fetches have
+happened in the meantime).
+
+transfer.hideRefs::
+	String(s) `receive-pack` and `upload-pack` use to decide which
+	refs to omit from their initial advertisements.  Use more than
+	one definition to specify multiple prefix strings. A ref that is
+	under the hierarchies listed in the value of this variable is
+	excluded, and is hidden when responding to `git push` or `git
+	fetch`.  See `receive.hideRefs` and `uploadpack.hideRefs` for
+	program-specific versions of this config.
++
+You may also include a `!` in front of the ref name to negate the entry,
+explicitly exposing it, even if an earlier entry marked it as hidden.
+If you have multiple hideRefs values, later entries override earlier ones
+(and entries in more-specific config files override less-specific ones).
++
+If a namespace is in use, the namespace prefix is stripped from each
+reference before it is matched against `transfer.hiderefs` patterns.
+For example, if `refs/heads/master` is specified in `transfer.hideRefs` and
+the current namespace is `foo`, then `refs/namespaces/foo/refs/heads/master`
+is omitted from the advertisements but `refs/heads/master` and
+`refs/namespaces/bar/refs/heads/master` are still advertised as so-called
+"have" lines. In order to match refs before stripping, add a `^` in front of
+the ref name. If you combine `!` and `^`, `!` must be specified first.
++
+Even if you hide refs, a client may still be able to steal the target
+objects via the techniques described in the "SECURITY" section of the
+linkgit:gitnamespaces[7] man page; it's best to keep private data in a
+separate repository.
+
+transfer.unpackLimit::
+	When `fetch.unpackLimit` or `receive.unpackLimit` are
+	not set, the value of this variable is used instead.
+	The default value is 100.
-- 
2.19.1.647.g708186aaf9

