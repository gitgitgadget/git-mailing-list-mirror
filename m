Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCCBC433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 19:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiCMT4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 15:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiCMT4w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 15:56:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B190E7CDE2
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:55:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y8so12068165edl.9
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zS8aC6J8KpyHkKujVuiUbv9PHVPRM7KNA//ELj4nT4A=;
        b=dC54SZt2OSyrsoKgvHLZmUFXQ4SUZCmJunZZJRSgYgY7vfu+ai+w2/RJ6GGv8es8qr
         c9lbfEEVXBITLn2e8vxh6J0HgOWcC9R3YFao7DCYYKqV+ZQqj6j10vKKJDdvUvQdJdLB
         vUDJVweAf3kA94s/gyf2MnJL4cladtA0YkOg0ywN9cMdFyD7bAQz+mue+k8JZ0hHW8/4
         7zzZnvHh61Jbx0sHS42TM0BsrD6qRTVjWNXOIuXTnW/UNsK5P9d6eRCQeCyjI9d9ZCIE
         sgGiXJCy04wnHrod1Ctosqbz288wq4fWHcyF+MX/QP4NcUrQfBYH+zEUQk2iYrLbLtzy
         Ho2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zS8aC6J8KpyHkKujVuiUbv9PHVPRM7KNA//ELj4nT4A=;
        b=O8ae6vxxwLFgkGFB5NLW20p/x30A8vcn+ZcUU3vjXFqJ7hlvyaciShcS+cEJCLlqg8
         SyCu3Yek9DeupbGgKjoV/mIzt/NDy9lHJKtJjfrvY6kvTPFSrHMFpbEroEW/zU7fXjF4
         aDZWy2HFUrRJ2NgHmiQjLKlL7jgh+CF4mecGl7TM0Qrpp0+n37/wYtXC78rc25mGU5ei
         lEzPvDBOu6jNDjhZV+Yi7pMc/Ajc2FeFz+9jpw9htoLOLlMRl/6dvly4KfMnNSC27S4h
         NXP2EHp8RoJp/nYBf2GBKRrfrA0YP58HJ/Fl5y90DeRpY8C4/8VcQKb2ryXa+3qzj1QS
         habA==
X-Gm-Message-State: AOAM532gRUtYls+qhj8HrjrVFxxVFAEO+33WlYUHLGG3SZ/XLndMFCzE
        dDiQvjFeeoHQX9n+NFA6/45Czb6+auE=
X-Google-Smtp-Source: ABdhPJwcIi3wDGjWwRC1f1hANifBV9cCNbi5rKuQoD7xqwSM2orHUpUKkiiDsnzzfZDHRvpN0m8Rkg==
X-Received: by 2002:a05:6402:26d3:b0:416:4186:6d7d with SMTP id x19-20020a05640226d300b0041641866d7dmr17881636edd.129.1647201342923;
        Sun, 13 Mar 2022 12:55:42 -0700 (PDT)
Received: from fedora35.example.com ([151.27.250.86])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402354600b0041871c5b9a6sm2164087edd.41.2022.03.13.12.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:55:42 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 0/5] Remove. duplicate include directives
Date:   Sun, 13 Mar 2022 19:55:31 +0000
Message-Id: <20220313195536.224075-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series of patches does not solve any particular problems but
only eliminates unnecessary duplicate include directives
from git sources

Elia Pinto (5):
  attr.c: delete duplicate include
  builtin/gc.c: delete duplicate include
  builtin/sparse-checkout.c: delete duplicate include
  builtin/stash.c: delete duplicate include
  t/helper/test-run-command.c: delete duplicate include

 attr.c                      | 1 -
 builtin/gc.c                | 1 -
 builtin/sparse-checkout.c   | 1 -
 builtin/stash.c             | 1 -
 t/helper/test-run-command.c | 1 -
 5 files changed, 5 deletions(-)

-- 
2.35.1

