Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC029C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 16:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbiEYQLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 12:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiEYQLK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 12:11:10 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74F0B41F2
        for <git@vger.kernel.org>; Wed, 25 May 2022 09:11:05 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id x2so36742158ybi.8
        for <git@vger.kernel.org>; Wed, 25 May 2022 09:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=QXqAcD0z3dxfQVDn4gdL1YkCG5ZpVXCcVkccVVlX2aE=;
        b=iDaxTuL8zNXCLSP5v3EqQiEOju6i6QG2K3UJ0xz7WMSv3mkb63FQ8kgb0wL/po+IwV
         P235GvxBGV34CmcfCmwkm12A7pJ9EeHnu8iq9B+FntpFUoV+qQi+diRUWOVLMoEocAO0
         smf3K+bpUWuW5AvzBGyhgJrV6xQuH2P+uX2/pk++aU6nxYbhsLLEz4/v9H1Tuf0GkNl/
         RrKhLDx1XXvscDnAIL19gXdAnuRHojXDJr27pnNXMZZeiy/L4bjqPyhg4O0oXU9VCjUf
         Pw0ppY0Sp+Ss5KGSEAArgbkJUuT/PDV4SanLbmC9x9OKjqystrACnciqN98tjdcRzaDV
         k7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QXqAcD0z3dxfQVDn4gdL1YkCG5ZpVXCcVkccVVlX2aE=;
        b=dZJDpVAF6CYQ/SEcW0eNgDKyjuIYpPJbsjskS5a137AbSZlYL+o+HZZ3jTYurOUzei
         kKtZx+a/BeiqsEz4bbWSWo1RfErnJuGtd/7b1EfVQdG31yzkmkoGWOj+CDJXe/sQmtHa
         94fxs6lCYe9xKTn4g13QIGjsAg7fohmfOUI/3DV8YBw9pzVjPdzyjy4TSiDNDqtoAapR
         k4wSFURu7a5XH196q6KU6qOJ5MynhVAudoheoGaRMkCLm4Ig6JjCeBVPkSCZF6fQaJko
         xIxKB/pnrCd6h6KwEMR8NYO7htkbtxe6vBmet1XFvETXAqZ5YVXq7Msn6OdGXu1/tZM4
         lDAA==
X-Gm-Message-State: AOAM532HGnJMENkWpLsE0/TAIvaSNzOryRXr3ien+7Irtir3EMrKr9UZ
        Djytr2BHZ781uIKcDKYppA9hwKQ6Y/FQZ7gXGGONdFXjjoqOkw==
X-Google-Smtp-Source: ABdhPJzdfIVmzgW4BwE6i2b0Zh4LNx/3mYdNr6BwKnjw6sgerHLsjzPOSGphRaSGSPlNus9lr1AyvS363MKAjvnyaxI=
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr32302129ybu.604.1653495064503; Wed, 25
 May 2022 09:11:04 -0700 (PDT)
MIME-Version: 1.0
From:   Aman <amanmatreja@gmail.com>
Date:   Wed, 25 May 2022 21:40:42 +0530
Message-ID: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
Subject: About GIT Internals
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

I have recently been reading The Architecture for Open Source
Applications book - and read the chapters dedicated to GIT internals.
And if I am being completely honest, I didn't understand most of it.

Could someone please assist - in sharing some resources - which I
could go through, to better understand GIT software internals.

(I am a high school student, and really want to learn more about how
all the great software and hardware around us work - which so many of
us take for granted)

Regards,
