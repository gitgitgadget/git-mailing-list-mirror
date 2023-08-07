Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D13C001DE
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 18:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjHGSlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHGSly (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 14:41:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFBA171A
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 11:41:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-317c1845a07so3583555f8f.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691433712; x=1692038512;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nfo42OHfHhvLrHPkVVvyoBltur4ZP/zi0xChEPF/TjE=;
        b=R+QGR5vq8btNREsghUkOQmw2+HqtTBjn4+9jLrJMOyDkS8tbyg+tJnP204bx/fA1iF
         8Hp54z2hPlfd2bkka90GhK0jjRK5J+ZYBpyUjGqhAkDC4Z7A8TES07Sa8l4p7+TKitMJ
         CBLaWwAaA23JNt/MQ+WNeDZgLJaIqrQeA0kqtWn4StGJTzDbBKnTp6p+6TUIGSp3O4D+
         aJako/0QFEjZH3CDdk2v3j87T9NnvkciXW56zlbkrgvIUbDSMQQcu0zV294+Yl+0Md84
         bDR7L3sSAB8c+MwdeWdBUep5aFfrZtnK0EHMOi7uS5bAF/Ifu+aCAxEI0HOLjlMguJCO
         QIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691433712; x=1692038512;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nfo42OHfHhvLrHPkVVvyoBltur4ZP/zi0xChEPF/TjE=;
        b=b/mXEOztpGVKnyuQ8yW0Hoz5XCpnDMxB+YjHS3V2gmJU/S59w7hkBJYBHjss/eL4nu
         2p+X809t9uhwZ8txNYdoKBI6hD78eT3CrOxDcwvQXqL25d1h1ZdOXI4MSGCdVNdXStFp
         fB4rmlkYy4hx8A20+pmt2JxOnMyM6ixxx2x41uZPmWuxpiCadpbWmyf6YL67ARcMYgGb
         /AHz/G3n/89myZPvmEuOaWE+WPYanh84kLHbiJ/+FO5A8wshx8Cmf1gBKv68L3whtyBo
         iTag/fkgT9tuUtkttGQf1ZkBydJNfzd5t7Syrs0JMAbFEq5tTV1lj2Oze451DE6V44ws
         yjcw==
X-Gm-Message-State: AOJu0Yyqfq29GVKklCmmlh8uW3yMGs+dJWARAced3rLZTH3sbe6kqWuO
        3THXynlrv6zrIbCwh/Wd7lukDUM3XQI=
X-Google-Smtp-Source: AGHT+IFqIv05UB0LOLiywcUQfC1xMGK4czuZLxlVftbQxbYDt71gYbJNolaytkAczEE5JrDc7XeMhw==
X-Received: by 2002:adf:e842:0:b0:317:f046:25f3 with SMTP id d2-20020adfe842000000b00317f04625f3mr1818792wrn.37.1691433711611;
        Mon, 07 Aug 2023 11:41:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d4912000000b003143add4396sm11234075wrq.22.2023.08.07.11.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:41:51 -0700 (PDT)
Message-ID: <pull.1561.git.git.1691433710768.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Aug 2023 18:41:50 +0000
Subject: [PATCH] mailmap: change primary address for Glen Choo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Glen will lose access to his work email soon.

Signed-off-by: Glen Choo <chooglen@google.com>
---
    mailmap: change primary address for Glen Choo
    
    As mentioned elsewhere, I will be leaving Google. I've enjoyed working
    with so many folks here, so I'm sad that I won't have nearly as much
    time to spend on Git. Nevertheless, I'll still pop in from time to time,
    at least to fix the bugs bothering me the most :)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1561%2Fchooglen%2Fpush-usmowlsllvks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1561/chooglen/push-usmowlsllvks-v1
Pull-Request: https://github.com/git/git/pull/1561

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 733e047aa82..dc31d70b8c1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -80,6 +80,7 @@ Frank Lichtenheld <frank@lichtenheld.de> <flichtenheld@astaro.com>
 Fredrik Kuivinen <frekui@gmail.com> <freku045@student.liu.se>
 Frédéric Heitzmann <frederic.heitzmann@gmail.com>
 Garry Dolley <gdolley@ucla.edu> <gdolley@arpnetworks.com>
+Glen Choo <glencbz@gmail.com> <chooglen@google.com>
 Greg Price <price@mit.edu> <price@MIT.EDU>
 Greg Price <price@mit.edu> <price@ksplice.com>
 Heiko Voigt <hvoigt@hvoigt.net> <git-list@hvoigt.net>

base-commit: cba07a324d2cda06dd7a7b35b4579f800de024aa
-- 
gitgitgadget
