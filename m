Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1DE2FC3F
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI1Jso4M"
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8486E6
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:17 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7788f727dd7so365942685a.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699991656; x=1700596456; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuSjzb8ICb5KOgTYkuCmKFUpHwEa+zamEtcXoSEXEG0=;
        b=SI1Jso4MAKsIAXyI2tGBIYtPIPQJf4Uusoed2Sz1p4kWEOqw9fd0PJT1mdOwdyncRp
         w8m9hWx/bMvv1Q9M0QvA0scoBgKLMDDHUbJ17jn126k9GllCypQJKmReX7eFdqfrqgG2
         6mJsto6UNtEt1OJYTH9L9j3M/szVmb/HrBSEASZhMqgXWEo2M9Z0vrXZtQdU2umIh3ZX
         f/7LYjkgMlJZ1mROboEMuTujczCnCkGkQ8D3Yc1T5kl1JHHp7xT1+PYFS7TygJkKfi03
         LsocTnJ9wwHHCb6qHdhAt5M+z7kmjmhQSIpmzBHMfWslnDF3PzflWnj4TZDHRZxP5URV
         z0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699991656; x=1700596456;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuSjzb8ICb5KOgTYkuCmKFUpHwEa+zamEtcXoSEXEG0=;
        b=TyuvTnb1M6G8UlAHFJ0CA5dmptw3fgybDQbajtwdekeky+AtmmlGGHUI085fK30B3i
         irr2Ey0syMsL0m8T+W2zGQk2d/WDf8UXcE8dfResVhLYk8TjAvLBv5UWyqklDw0j5TAe
         fGhiIPST52oa0DChjhlW6B6wPyAgEBuaEzGXkNC6pMMmU2iufTDePYQFYpoExjHmBlKN
         1O8pZNN0A0Bw/I/Vknv9HULOunr/ZyD5nzng96fO/OtXQskwBKuIGhJRJqzZeNnJDALQ
         sixK4zDuIZWrqlUQGBHAuvcWg9e0AJjkL8rW44kN+VJstPuS8AZ1cSy80I0OedIx/mlX
         GBGQ==
X-Gm-Message-State: AOJu0YwhTLIyizPTH16pIEYW19NV2Zk7MmBMss4Zifl/w+y+rQoMwVtf
	+2ALN/WiioZrToRtb3xCYSKZtdwBnTM=
X-Google-Smtp-Source: AGHT+IHsROCN6ykgVuO67/hMMQ5H47MyrlYzbFNWv6aHYPDSMNYqJzSe+0JGVAWxO6cj88TAXJJ3Wg==
X-Received: by 2002:a05:6214:564b:b0:671:ab5c:d14a with SMTP id mh11-20020a056214564b00b00671ab5cd14amr3429861qvb.52.1699991656195;
        Tue, 14 Nov 2023 11:54:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dw8-20020a0562140a0800b006715ebb014fsm3159752qvb.36.2023.11.14.11.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:54:15 -0800 (PST)
Message-ID: <8eb2fc2950c04bd6fe91112e7056dedeec774e6a.1699991638.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 19:53:56 +0000
Subject: [PATCH v2 08/10] for-each-ref: clean up documentation of --format
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
Cc: Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Move the description of the `*` prefix from the --format option
documentation to the part of the command documentation that deals with other
object type-specific modifiers. Also reorganize and reword the remaining
--format documentation so that the explanation of the default format doesn't
interrupt the details on format string interpolation.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-for-each-ref.txt | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e86d5700ddf..b136c9fa908 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -51,17 +51,14 @@ OPTIONS
 	key.
 
 --format=<format>::
-	A string that interpolates `%(fieldname)` from a ref being shown
-	and the object it points at.  If `fieldname`
-	is prefixed with an asterisk (`*`) and the ref points
-	at a tag object, use the value for the field in the object
-	which the tag object refers to (instead of the field in the tag object).
-	When unspecified, `<format>` defaults to
-	`%(objectname) SPC %(objecttype) TAB %(refname)`.
-	It also interpolates `%%` to `%`, and `%xx` where `xx`
-	are hex digits interpolates to character with hex code
-	`xx`; for example `%00` interpolates to `\0` (NUL),
-	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
+	A string that interpolates `%(fieldname)` from a ref being shown and
+	the object it points at. In addition, the string literal `%%`
+	renders as `%` and `%xx` - where `xx` are hex digits - renders as
+	the character with hex code `xx`. For example, `%00` interpolates to
+	`\0` (NUL), `%09` to `\t` (TAB), and `%0a` to `\n` (LF).
++
+When unspecified, `<format>` defaults to `%(objectname) SPC %(objecttype)
+TAB %(refname)`.
 
 --color[=<when>]::
 	Respect any colors specified in the `--format` option. The
@@ -298,6 +295,10 @@ fields will correspond to the appropriate date or name-email-date tuple
 from the `committer` or `tagger` fields depending on the object type.
 These are intended for working on a mix of annotated and lightweight tags.
 
+For tag objects, a `fieldname` prefixed with an asterisk (`*`) expands to
+the `fieldname` value of object the tag points at, rather than that of the
+tag object itself.
+
 Fields that have name-email-date tuple as its value (`author`,
 `committer`, and `tagger`) can be suffixed with `name`, `email`,
 and `date` to extract the named component.  For email fields (`authoremail`,
-- 
gitgitgadget

