Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD69C433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25976103C
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhJXRLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 13:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhJXRLU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 13:11:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51D8C061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:08:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y12so9087825eda.4
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y440wEWOC6qQgFvqcr7/y2f54XIoKj8PBhVPHNNspfY=;
        b=W8UErD/ahSm9i9LpBAtEYFh/AwxowrBHxidvfZAOWbTvgdhjf9sFwq4TJ7ilhyjZ6g
         8ekGrNxODnYjw9RdGf3Wqo6RPRMjQsuJwvP1M8/QbbWRX7MS0DFPdk//OVHo6V3iYnQa
         bK7/iqUFObC9RVv8c5ZPCyHtf30QjeovUEPU+ZbsbDidzOaHCNshOnYjKAcLUkdX7LKp
         BL91+v33DzXLuR5uMWl71IxB+v3z7PnbLsH4rxs86J37xHA3SJxW7VO03YmvYh3PB9wh
         Wv1qJxDZP4QwSLOrPNWPiYimH1jwKe1lY1nS0o60FssBlZSU1bDhk2fU0Sup0V4E/CNO
         JHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y440wEWOC6qQgFvqcr7/y2f54XIoKj8PBhVPHNNspfY=;
        b=0NyKimGjxRVqNthNFlYDg/pkwMdnjiZ5z8Q+juEt3DmYCc8H7hs1VwP0kmXvcFU/95
         i6DIZY5fEzx7nu4PbUmUcbhkGOVthTGOw5JVQf82+f4GMBq9/kzjejWLI9X0lw5sWAhC
         ZmC+XPoshwDrzpdDj5zbxfFeIRrNCb+9jXDydM+IfI+DV6YjbLAs4cVvozLO4Yqd31vo
         /eFyL9IFX4E32cfaK5uMZ5bA2dFlmGLiTEWcOUYbfgIKLCUlhiFn7+emQ/TVS70weFXp
         NmBRdi+hqYzuOZSpG4lDbukPP2prIkARzL8DlNxWPfpBNSuoM/uL9JfQUvzIb2f4D7Ta
         W9DA==
X-Gm-Message-State: AOAM530Olsp16vZ1duvC87aTwDlz0jYY/H9t6l2NJPBvH9tjMF7pWWSu
        6SyQBEeeCB/cQtQfQY0US61vEDiAPW+b4Q==
X-Google-Smtp-Source: ABdhPJwSrMe9Y/hqAbQeJq59SFXSJciCEzzUpQ19/0sDIYvKdM0/+joYv8t8yF2LztJ+c2lXsG3GwQ==
X-Received: by 2002:a17:907:d89:: with SMTP id go9mr15488024ejc.451.1635095338059;
        Sun, 24 Oct 2021 10:08:58 -0700 (PDT)
Received: from lena.c.hoisthospitality.com ([194.209.187.34])
        by smtp.gmail.com with ESMTPSA id v13sm6369378ejo.36.2021.10.24.10.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 10:08:57 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Subject: [PATCH 1/2] git.txt: fix typo
Date:   Sun, 24 Oct 2021 19:08:20 +0200
Message-Id: <3dac3680244e324fe88ca7bf61a940ca1e5018ea.1635093692.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.33.1.711.g9d530dc002
In-Reply-To: <cover.1635093692.git.martin.agren@gmail.com>
References: <cover.1635093692.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the spelling of "internally".

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 95fe6f31b4..6bb06d0b52 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -42,7 +42,7 @@ OPTIONS
 --version::
 	Prints the Git suite version that the 'git' program came from.
 +
-This option is internaly converted to `git version ...` and accepts
+This option is internally converted to `git version ...` and accepts
 the same options as the linkgit:git-version[1] command. If `--help` is
 also given, it takes precedence over `--version`.
 
-- 
2.33.1.711.g9d530dc002

