Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3415CCA480
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 16:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiGIQ41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 12:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGIQ40 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 12:56:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23B017068
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 09:56:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r14so2055320wrg.1
        for <git@vger.kernel.org>; Sat, 09 Jul 2022 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fwJiH29geBMM2Ga3hp9L2DBs1fpm5TVm9ie0kPiXG44=;
        b=inRv9+L+1G4rblg7A4kpMkvmt0dyKr4zjuaH2w0nbasclULkmwV2fCDFg2gv1FRalo
         qQAtshZWSIdGzPgVEguH0IueYLWmTK38T6mfnHDvQelCIKvdy+XIRVRGX3tAyHkd9GiL
         smEsllbpTkUaaYdMqNRt4UxyX2/OYGVymN5nue81PrWOwUbVUzTbL+tSyILZpzAnpr7V
         w+JLwF6CNuIjiAdJyI8cMb3x0EaKEhOq5NPVF4X25qY8ig6O1i0xthmsYHGq/bCnkU2i
         DnQ5SDmd8jOmiN+a3ThupGtlGA2gd9uuMwSuGTekHghYTsHC9R69NqAUT27txL2eFqPQ
         TS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fwJiH29geBMM2Ga3hp9L2DBs1fpm5TVm9ie0kPiXG44=;
        b=f9Q4IpMnQ63flvLJ3FTomFekvnVOGesB/8ysRCKoXkS21eqFIu3nkPwnsljbny/WI5
         7Dq8qki+G8vzgIqTZV9bi3Z6CnDhObLwUVF+vHwE6sbUn4yYM4GOkxstqMz/JzYh1S8w
         32nDhLBe1flKPMCETf4TIFyTg+OU9YGiqfrCE5nXwfCJ6GolgUNVV7TXPmmBtFz9YQSm
         D2NbwVmn4c+0Gl1CpeVafavE+3d5HqypOI91BGer07/E7wc0i3341MLs8348WIEv+o8o
         9rZgA+qhBWHLn5kkbqnYbL/KXSfhW7C6+LdH5tP+mek/rHCUUziUZmm2/IEGoYohPexW
         8jyA==
X-Gm-Message-State: AJIora+X9/sj2DrJQL21Yh74c5N4q1qCH5+f3PuFZdkJlW2/sdEdufQJ
        6t8v+QRBGEWkQZ5r7DXMjyoz0lGPG7A=
X-Google-Smtp-Source: AGRyM1t1Cp4d9eB1Kho2jAyGzNXz6CdQte666eYbA7ykestlpUrWtNhyd5qgjxF7w3mQrYO4EXU30A==
X-Received: by 2002:a5d:64eb:0:b0:21d:75bb:a2f3 with SMTP id g11-20020a5d64eb000000b0021d75bba2f3mr8818331wri.118.1657385784037;
        Sat, 09 Jul 2022 09:56:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c4f4700b003a2cc290178sm5221441wmq.46.2022.07.09.09.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 09:56:23 -0700 (PDT)
Message-Id: <f4c04019edcc3f81aa0bf877f9138c2dd7da9f05.1657385781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Jul 2022 16:56:18 +0000
Subject: [PATCH 1/4] glossary: add Object DataBase (ODB) abbreviation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

ODB abbreviation is used in the technical section without expansion.
Show the abbreviation in the Glossary.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/glossary-content.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index aa2f41f5e70..f3342a5ab69 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -257,7 +257,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	<<def_SHA1,SHA-1>> of its contents. Consequently, an
 	object cannot be changed.
 
-[[def_object_database]]object database::
+[[def_object_database]]object database (ODB)::
 	Stores a set of "objects", and an individual <<def_object,object>> is
 	identified by its <<def_object_name,object name>>. The objects usually
 	live in `$GIT_DIR/objects/`.
-- 
gitgitgadget

