Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C888820899
	for <e@80x24.org>; Fri, 11 Aug 2017 23:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753217AbdHKXXk (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 19:23:40 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:35537 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753127AbdHKXXk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 19:23:40 -0400
Received: by mail-ua0-f178.google.com with SMTP id d29so20579100uai.2
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 16:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wvzn/Q4LlpJWNygIwuYMa1smKU2cdqUjR2i2TGlGM6A=;
        b=N9vGpdjpCiVbidgfcU0Wajy0GN+/YZDfknNgekb5r1HQy/P8O9XRayY44HzvIrQxii
         vLdaJtDcitIv49r5DBdNMqVRfviD4ega2KQ0FkOZdK/TOCnvfjG9e9BiW0dsSMkyRvho
         L5yGq7dXwqZ5ADU57Yjn3KiFxaWq3LowxLSshdx2mgrepMkrfW+8IoS7DlROEw004QJq
         kMgOE8isDCN5wFhjQQHBtc7MuPHzBKrusbnn8zmQWGLkvbV4yN9opMQT4QmGwTp71xFt
         9nrX+SQ7RSNkscU6YEKvtjctRZsFlLhdZEpI87ed+gfceIn7Mmo3DobLTMu/w//7dT0S
         nCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wvzn/Q4LlpJWNygIwuYMa1smKU2cdqUjR2i2TGlGM6A=;
        b=mYcNKIzwFrmMprCz95pnyUV6W7VBGQDKnZu8cyPI7sJG4vH/18m7FMMldjRFT3JXYv
         Z1MyAClq3kalXj9Qq4GrIcHBE9nee8mKb7XkbgjovD8l9urJwWw1jkKR//dlsmqm5awt
         IDbP0cSEY4AT4gmkgCT5LGDFQflnE1I4NoQQlx0tNjrpngMAKC3j5Yi8yU2Ie2CVMbvH
         Re6b5Zl6gM34xvMfPubngaqsJFPEjEuRgPuogVzgJpnbeNXqT+2fc8ff45UV3EaWNs+t
         txpwjxM7MdU40DACDeFQKTJFkTOajBnKT4LLF17C4e8/wIXe9dqQcjnftsY0SwP/hxr1
         fVGQ==
X-Gm-Message-State: AHYfb5iZIqocrPXGfT6lglFq9mP46yuwVll4iEhgT2y7uFiXndbi/g55
        agUCtcUzjZafopUCKh+BPovKUniOhGXu
X-Received: by 10.159.35.169 with SMTP id 38mr9130021uao.35.1502493819321;
 Fri, 11 Aug 2017 16:23:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.77.140 with HTTP; Fri, 11 Aug 2017 16:23:08 -0700 (PDT)
From:   ankostis <ankostis@gmail.com>
Date:   Sat, 12 Aug 2017 02:23:08 +0300
Message-ID: <CA+dhYEXDsgnmKTf9OW+_QTPkcVkfm99ffWOYdum7uUTnvaaCeA@mail.gmail.com>
Subject: Would it make sense to add `--depth=0` feature?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Would it be feasible/sensical to support clone/fetch with --depth=0?
The point is to download the tags/commit objects but not the actual
trees and blobs,
creating a "ledger" acting as a promise for the remote'e repo content?

Is there some estimation of the effort required to do such thing?

Best,
  Kostis
