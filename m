Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E58C636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 06:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjBWGsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 01:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjBWGsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 01:48:16 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD2683D8
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 22:47:53 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id bl7so11339630oib.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 22:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I8V6LZGzoLIsSf/Jpbd5JBCmD+v1mjdVtSCqJyQr1LQ=;
        b=m5VlOhi0ZdY/2OhHjRPHgbX3EAwHH+o+Vc3O6OmO8LDwxOUEFZL2NEcW0l5tBB9plW
         RWEQo8Gmbhb+DlSHyWZC512fqtxrOOwlj2sB3L8uqQ6TqBeU3eLBzDS5ECZFRgqZNpkr
         Ar/VFiOc40zLY7dMOQUQ7OJrjwKcEayGbEhxtC/oN4Tgt1pg/+omsL/ktZGXWdmHqYAS
         8PNbxakT+zNpB3igJibRKydX+b9RSqyghhCalOyghH437rBW/uXZgX112XSPOoiY2DvB
         tRQ4nHxAQZbXx4/QSR6hYANNfTYHE++pGKLctfKAhiw3QsaQ3dUmRj/ZQOpl7bSy1zfa
         Z+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8V6LZGzoLIsSf/Jpbd5JBCmD+v1mjdVtSCqJyQr1LQ=;
        b=S5MTfso5AHpl81wHL6rKvQRDQXU7vchUlZpmpB+FnpM/WpjNj1JNU+2iAvijIq2iFg
         5/VCag9+onSuyg07rDTU8ZRjElEQG5kUV/u/Hx8WxGDaru1r1pcVXy9PmCc7dXXMmoEh
         NqGD+n0mgLUYaWUPzq1BbfzsCx5wxLNKitG/9kbGm54QZXzyojTFLEku5gT0hldewIfN
         l139m8BF/4S3WlDhjzfX6Xs2t/oEgQs63T7EsBm2xZbpUPm5bOW8GKL4+VQANbTQtuCs
         2fWhgxyevHw6GkVC6O2kSU2orpRMzV9S80n9HCoW2neFfXA/9nW9Q6ociTaXeH2CBZAQ
         c+fw==
X-Gm-Message-State: AO0yUKWiB5a4a/E2YF3nCYbhM2a0PWuy1lC6/tVzZ/w5kkJSojLpeFPS
        AabSl+WWroCGHgctJnfCLMJDbEmoDHH5zVOi6m2rztHpMD0=
X-Google-Smtp-Source: AK7set9WaC3DLdZNJqqrNFZCXF4Q4rFN1Spr9NInCQZxyFE/4AD3XRvIFUOsfIz+/PNS7n67wci+9tfPrNfBLdUiJkU=
X-Received: by 2002:a05:6808:f8b:b0:377:ff13:d0e0 with SMTP id
 o11-20020a0568080f8b00b00377ff13d0e0mr916720oiw.229.1677134872509; Wed, 22
 Feb 2023 22:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20230222011317.97943-1-gvivan6@gmail.com> <20230223054040.30088-1-gvivan6@gmail.com>
 <be5fbb48-4599-f6d0-e7c3-cf0470ce8bbd@github.com>
In-Reply-To: <be5fbb48-4599-f6d0-e7c3-cf0470ce8bbd@github.com>
From:   Vivan Garg <v.garg.work@gmail.com>
Date:   Wed, 22 Feb 2023 23:47:41 -0700
Message-ID: <CADupsJP6T8OFCEJsyy4uFHvk8P-CfBODYpcR1n5jEWUiAND4Rw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] MyFirstContribution: add note about SMTP server config
To:     Victoria Dye <vdye@github.com>
Cc:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org,
        nasamuffin@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Since you also did this in your microproject, it's worth pointing out: you
> don't need a cover letter for a single-patch submission (see "Bonus Chapter:
> One-Patch Changes" in MyFirstContribution). You can include the range-diff
> below the '---' line (i.e., below the commit message) in your patch.

I didn't include the cover letter in either v1 but thought the range-diff was
important so I kept it in both v2's. Next time, I'll just put it below
the commit
message. Thanks!
