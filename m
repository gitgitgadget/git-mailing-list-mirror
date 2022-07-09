Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08EFC433EF
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 16:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiGIQ40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 12:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiGIQ40 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 12:56:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B257E17066
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 09:56:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so2783553wme.0
        for <git@vger.kernel.org>; Sat, 09 Jul 2022 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=C2P9mUpvGtORRRjVz+xB8PUiTdvHtixWgHYQ2CoHFVo=;
        b=cOqyHtuEWwcJVzSf4O2XOTtwr0SK8OuCHvSuHuI8zq68IwXMelDLlmEk/dAlZvpYwS
         umZ3ohBhVH755zqUSuueszrl0cPFpa6efDtFZAN9mbjvP7HHXxOZqDPw3UVMoRQeyXQp
         g1BCBm3ifUqMzNDV9C5I64l8yyojezX12/Jop19tF7Dtt06PjClQJsWwhoo1tHhhbKen
         /UVIus8F7QTBIUtxCj+WWV04I6VXqiGsi+jmqF3KeltCPDthXqwP8dXq34Qs+xh7eNxa
         c1k53tkVvutwnQ5PKa8NSqQvf5qMn+OH9Hsxqxi8FurHB13CFfrNaAZTdRiU6vV0UiWF
         wc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=C2P9mUpvGtORRRjVz+xB8PUiTdvHtixWgHYQ2CoHFVo=;
        b=j54HW4wyG8EMAOOLWwtlAOxX10nBdAwdIQrLR14TC18WenkkvT8RqdB9d8cJu0UXBu
         2d0vie0tZqtccHpXemXWO4pPoMRAn9hFkLVeGaXMXvP7ja/dtdKvc+GWoynjarsWm7O7
         bWRQoc+T+ulCYTQOclFJpeTK47CHdLkNmlJXNbj+eD03EtV0ltbmSUvrjQ5t/FJii3eN
         j4E+CjRWn6M5XQtXtE2YRu8P6HQagwHC7EVhIFL/V/HW3ZW3C2h8qGcKkFwVWghczpUt
         Qg+y6pVNw2QKP3dDI8tKbJczai2YxQlznpIlB49o/Q2h/yWD4rWPI1R0vVXnzTb6PlXs
         Cpwg==
X-Gm-Message-State: AJIora8pAfw2cnQyqMUXOiy5BsPr26jsPljAZO6k1rL9kyMNtj1Xd/ne
        NAAhgjpRUZ2RM/5hJ9j5IGsVTjkSqdo=
X-Google-Smtp-Source: AGRyM1tev4Fcz8mynTUzfErIHagR258y90y75HhAzQAl1NDrv3VM9MikRjFjWocvODQ79hAp+m9xfA==
X-Received: by 2002:a05:600c:21d7:b0:3a2:d737:ea98 with SMTP id x23-20020a05600c21d700b003a2d737ea98mr6351199wmj.144.1657385782873;
        Sat, 09 Jul 2022 09:56:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15-20020a5d488f000000b0020fe35aec4bsm1773753wrq.70.2022.07.09.09.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 09:56:22 -0700 (PDT)
Message-Id: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Jul 2022 16:56:17 +0000
Subject: [PATCH 0/4] Add some Glossary terms, and extra renormalize information.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This short series looks to add the basics of the reachability bitmap and
commit graph phrases to the glossary of terms. While these techniques are
well known to their developers, for some, they are just magic phrases.

The first patch [1/4] is to show OBD as an abbreviation to avoid a UNA [0]

Patch [2/4] provides a basic statement for the Commit-Graph's purpose.

Patch [3/4] provides a similar statement for the reachability bitmaps.

These two patches maybe misses out on some linking information as to the
benefits these have and the basics of their heuristic.

Patch [4/4] follows up on a bug report about the lack of idempotence for the
`--renormalise' command. See commit message for details.

[0] UNA Un-Named Abbreviation.

Signed-off-by: Philip Oakley philipoakley@iee.email

Philip Oakley (4):
  glossary: add Object DataBase (ODB) abbreviation
  glossary: add commit graph description
  glossary: add reachability bitmap description
  doc add: renormalize is not idempotent for CRCRLF

 Documentation/git-add.txt          |  3 ++-
 Documentation/glossary-content.txt | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)


base-commit: 30cc8d0f147546d4dd77bf497f4dec51e7265bd8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1282%2FPhilipOakley%2FGlossary_terms-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1282/PhilipOakley/Glossary_terms-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1282
-- 
gitgitgadget
