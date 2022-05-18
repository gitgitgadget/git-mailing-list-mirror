Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD54C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 21:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243105AbiERVGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 17:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243251AbiERVGX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 17:06:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A06F248CF
        for <git@vger.kernel.org>; Wed, 18 May 2022 14:06:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id wh22so6002307ejb.7
        for <git@vger.kernel.org>; Wed, 18 May 2022 14:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blazepod-co.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=m6UwpUKtXixUg5Yq552UmT3AgoDJ6BOtpLslvQAHYFY=;
        b=OThKnsDASWrtVyN3s8iCqUuNp7MXrAX0Ymju+MMyJNlm0WSn48txAmSiaUDRm3Zwku
         TDUzknp37kAOkLS2nDDx8GLCrEKQYkBU3YYzBDbUxbFh5B/y5HOJjb6JJblZTSmZac6D
         uCbjM/UOH9j2XVQlgOaTJP5gNAxMuNQVFgpZPkeMQbwtoA++0L/cyOx4Mv7gkED3Bxew
         0fR/VRQvd+OrDzBcAVt/qOxFdLc5x2L2tvwfaYO/OgZuMyxiYoSKgv+ylam/p3opS3g0
         jOQ+MPveWohDlG0OR072sBoyoIpWlr/lu8COvhMB409CHz2swxcBY+x4o3FdD2oOPflK
         oUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=m6UwpUKtXixUg5Yq552UmT3AgoDJ6BOtpLslvQAHYFY=;
        b=78sN1ZL+NeO4uGCZKgMo+DB1aWrLJ29sSYQIdHQsOlRYo6SZWqbrAuTMA35QtslLvC
         2IdrGXZ2AhLEDgmvJrS+wCK9i2U23OdNeymg7KauSMcm27KSJ4ZnuUTro1IdCtCYdQHy
         Fh2FI/seCyjJOr0ZaCTO70ioBy8zkc8z/1IjujzPW3vaI5MKPqMme+NWU2/ai3NOeyal
         MXMlhv82Ot4RnSiNp4w7hu8IYNjYnYrYlPM+2qOGYOtnwXMFZzlD3hpHXReFzcffLZ2g
         oK+WrUPjyRB0VCAu14QOIvts96Z0V8pfahbdtViacAqRB41ecD2ix9nmu7noJc2lObfp
         xw6A==
X-Gm-Message-State: AOAM530usBpKXyR3mlzGuYkyKonMuUJ49YvVIh6AtFP1c7hRJ/WdjbdY
        LJBLoOzSi6nWpNdB0VaI6tCz9ous/HInrG2NYdm1Vg==
X-Google-Smtp-Source: ABdhPJwbzho2DW2MDS3rPcnNqY3WWCwMCZYfarl8Yl5c8jP83tqkUg8WI6KJ+DNq3+ywzbQxH2Fg0R2myCbIYFn2P6M=
X-Received: by 2002:a17:906:4fc3:b0:6e0:66a5:d59c with SMTP id
 i3-20020a1709064fc300b006e066a5d59cmr1334332ejw.131.1652907974588; Wed, 18
 May 2022 14:06:14 -0700 (PDT)
MIME-Version: 1.0
From:   Nadav Goldstein <nadav.goldstein@blazepod.co>
Date:   Thu, 19 May 2022 00:05:38 +0300
Message-ID: <CAApwGmCwB7=t7fDD96-NvSFXeqv59zOrr4ZCbmx65eQ5qiuJVw@mail.gmail.com>
Subject: Re: [PATCH] stash: added safety flag for stash clear subcommand
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        nadav.goldstein96@gmail.com, nadav.goldstein@blazepod.co
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I completely agree with everything you said :)

I will get to work on v2, thanks!
