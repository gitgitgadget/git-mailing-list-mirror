Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC491F463
	for <e@80x24.org>; Tue, 17 Sep 2019 08:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfIQIwO (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 04:52:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36350 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfIQIwM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 04:52:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so1756651pfr.3
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jq8XzIQsEiZ3TYkYp1IwCXq+D4XpDbM8zjxYxPQmeE4=;
        b=Ixxf7TA8HV5M3n60uHROZ8Qdc/C4vqkSe/AwUJ/q81skwo4ITRyd806D4UnprIrFZn
         kDHvCTa07xI73QnJFhhCg6psM9xAj75xyZA9RWFsnSJ2r4wtXyIYD+r2GXMWJfEvQrQt
         65GAuPhn7aIAQ1YrsRH9G+OA/nwEVPeJ1Ol5O7f886hsPg60nBsGHie/Gs4/qPNZ8k7Y
         P2ukGL9RmfEUmXZCGkB6JzbK9Rl6K+zjOVjLQ7jG/bWt5Q5uRoXjzKw4CcqYEGG0suyG
         C8yuI2bvAqdxLIgUxNXEaGOc+jSlJwE+8JhRgiv90p/TbIRElyZmTTm9U7GMM4KhSG9r
         mcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jq8XzIQsEiZ3TYkYp1IwCXq+D4XpDbM8zjxYxPQmeE4=;
        b=q4QsPIx4hA6p4S861Pefr5/kYLnop3EXT765hg8fIc/PQmqP7grqWn5t/wsrFqVW9e
         O3FzPnReMCm5AkwpGibgBYqMrFWhHZUOJTGcdoW3DPBIcFiB4g7F/D63rKtN9gpKnSsZ
         j5y+yW8YOhVO43scLxE3frw3pzF8Sr6rLHJMDtwWijjoOtQurn0Dj6ssmboHBTgw8ckJ
         63Y3B8Ego7voSsnepG7n7RTWmJ4iq+AwkvJ3GWVIwuyJkCSO6F4O8LyviAVVWERIAjBb
         3LiuBRwRs4golv9mTzbP7WjkLYpo+rAHVk97Dbs1KD9T1oaBHbo/BxSyGTfLLXBLZNNb
         fJlQ==
X-Gm-Message-State: APjAAAV16zTvFL4CO4vwyw0cWjEbL/MGLej1dvTVpp13Pl2Mz5zA8YuH
        XtJ3XR+JxKHnWP8Hr3kjdDLh3Mp3PXs=
X-Google-Smtp-Source: APXvYqyEuRCm2umoEbEdX+dc3dJj6Z7ZmKuK9m597M2Oz7G8mpqwJPnaYsF2KZQm39z3S9u5Y22oIQ==
X-Received: by 2002:a62:2b4d:: with SMTP id r74mr3054406pfr.30.1568710329439;
        Tue, 17 Sep 2019 01:52:09 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id k4sm1600989pjl.9.2019.09.17.01.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 01:52:08 -0700 (PDT)
Date:   Tue, 17 Sep 2019 01:52:06 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH] gitk: rename zh_CN.po to zh_cn.po
Message-ID: <6feff2e73e1c4ca838efcabe90e0978a4d88cb7d.1568710294.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running make from a clean environment, all of the *.po files should
be converted into *.msg files. After that, when make is run without any
changes, make should not do anything.

After beffae768a (gitk: Add Chinese (zh_CN) translation, 2017-03-11),
zh_CN.po was introduced. When make was run, a zh_cn.msg file was
generated (notice the lowercase). However, since make is case-sensitive,
it expects zh_CN.po to generate a zh_CN.msg file so make will keep
reattempting to generate a zh_CN.msg so successive make invocations
result in

    Generating catalog po/zh_cn.msg
    msgfmt --statistics --tcl po/zh_cn.po -l zh_cn -d po/
    317 translated messages.

happening continuously.

Rename zh_CN.po to zh_cn.po so that when make generates the zh_cn.msg
file, it will realize that it was successfully generated and only run
once.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 po/{zh_CN.po => zh_cn.po} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename po/{zh_CN.po => zh_cn.po} (100%)

diff --git a/po/zh_CN.po b/po/zh_cn.po
similarity index 100%
rename from po/zh_CN.po
rename to po/zh_cn.po
-- 
2.23.0.248.g3a9dd8fb08

