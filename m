Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4028BF9
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 04:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="rVhrcLWQ"
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A940F9F
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 21:15:18 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3433470a12.2
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 21:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697516118; x=1698120918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R9VLaRYn/YSOekZ+GFdB7Bp9UNTpqKdEoxJ2dr/uRwY=;
        b=rVhrcLWQ1F6uj1ztKiicgx9cN31PrEgF12MWktZyb7tfVgSoBU+fjIKpZ5elFyzQpU
         3Tfe6FhxURB2gsDTBVgzAWd6Nva82kgnwyd9y3Cn0y8PkppWoibQKAvcq6KxwX9OOP5X
         QCbbaGA38Bo8WffrvKJ0ILe45+Ndoi2nXs5OlWtqg/J3FZKYCSmSfPC6pOm57yfptp1g
         QSPJ876imnXS6wgykWDP9OJOLIs/+TJg8QcBN43Hf+G8ke1BF/o04n4aQ1RWJE1lDfbj
         T6JsRxMA+W+MI0me3lTuzx7JGJZchxP1JGXQQGiTf8S7ThgCQjDwfgVpv9gFDUVyqR/A
         mIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697516118; x=1698120918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9VLaRYn/YSOekZ+GFdB7Bp9UNTpqKdEoxJ2dr/uRwY=;
        b=oZDaZLd9NKAdOnc5mYjv3Hzqqd9KLeMAt7SZwIbFxa98zvLFFPdu2ZckwLeJ8CctUA
         XZcRxekM3oBTcKDuGaj1eOcVSsRyV4uPUUvXBR3cnQGjU2H6AwI+KCDloavp6k2ZOUgn
         +cJBhT/uocUrUXSzBRC2QNaU0Sx7UWVO0p3NfeNkUGDiFZwsfZf4/6I7DzliFigV8vd2
         cDck3xbPcdvDaxoahi3VVyu1yL+fRI71o/+Ew14WVGLGiiU7a/Eacgv632/eeOHd73Ll
         O3Lstu1h9kRLgH1IecEUQTIEESicgYPlRGIbEoP3MjXtwsKqe4YaZXosnRh5DfNWuEuI
         nCKQ==
X-Gm-Message-State: AOJu0YxL9eMw5fKc9mj5a1SRK64TUxpbGYq/FHKsuaIkBVh+oV/z3tf/
	RU64UGstZl16niR5ffLzexR4V5v57n296Ncg2SOwQZah
X-Google-Smtp-Source: AGHT+IFFXUZkVtLc3uEq+uIPoxrKalA5+iFQDJO+ns0AulC1Y+mPI+BCXLtVo4CB5G0tXLuw/TxjHw==
X-Received: by 2002:a17:903:308a:b0:1c4:13cd:b85f with SMTP id u10-20020a170903308a00b001c413cdb85fmr1180146plc.5.1697516117935;
        Mon, 16 Oct 2023 21:15:17 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-47-49.mycingular.net. [166.170.47.49])
        by smtp.gmail.com with ESMTPSA id jc17-20020a17090325d100b001c55e13bf2asm392543plb.283.2023.10.16.21.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 21:15:17 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [PATCH] Include gettext.h in MyFirstContribution tutorial
Date: Mon, 16 Oct 2023 21:15:03 -0700
Message-ID: <20231017041503.3249-1-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.398.ga9ecda2788.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The tutorial in Documentation/MyFirstContribution.txt has steps to print
some text using the "_" function. However, this leads to compiler errors
when running "make" since "gettext.h" is not #included.

Update docs with a note to #include "gettext.h" in "builtin/psuh.c".

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 Documentation/MyFirstContribution.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 62d11a5cd7..7cfed60c2e 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -160,10 +160,11 @@ in order to keep the declarations alphabetically sorted:
 int cmd_psuh(int argc, const char **argv, const char *prefix);
 ----
 
-Be sure to `#include "builtin.h"` in your `psuh.c`.
+Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
+`#include "gettext.h"` to use functions related to printing output text.
 
-Go ahead and add some throwaway printf to that function. This is a decent
-starting point as we can now add build rules and register the command.
+Go ahead and add some throwaway printf to the `cmd_psuh` function. This is a
+decent starting point as we can now add build rules and register the command.
 
 NOTE: Your throwaway text, as well as much of the text you will be adding over
 the course of this tutorial, is user-facing. That means it needs to be
-- 
2.42.0.398.ga9ecda2788.dirty

