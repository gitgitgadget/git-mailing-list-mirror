Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D30C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 21:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiGAVeD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 1 Jul 2022 17:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiGAVeB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 17:34:01 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF7C3616A
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 14:34:00 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31bf3656517so35069147b3.12
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 14:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KKf+XWl6qmXZy3Ua+jjlex2QsN+LBJgL3fich08HPKs=;
        b=y0bmNXYbtZyMsA5ekV8LLuFWAdeSTjcaglBRWAiqEqTFdOT5ORDyR5jljAOzzfw5qP
         Vx2HZnS6u5YMUenELZ5ce8lEKeKMYsZtkTITBKDBQxL3+mANaK3cia5Ty7p4LsbLtPhn
         Y/vTPADuE90VVZuOfpl2uwW2HF/8GtbLnP8cF5ocnqhbASH5JmgaOfyXmmIMUNcYcads
         0jCJs3WGXBiVk80tMHiqXvtPz7IGMI0DYx6kh4eQQyIo7Mg4OYx3UN+v/qQDcyWsEuLr
         3JDHDb9iE+r6UYrSlNd1RTsyRvXidMHK8ZyxuzO4l5/IVMctR5OgZZeeWqlA2Mh7RsRc
         nubw==
X-Gm-Message-State: AJIora8Ras6K5wTGUNrdTAvZU7rePAxBK6Q4+v5kBPkdi3ObaD9EoVOB
        VU2lHKR4kWcWxBilZGuMarD2NuS+Xhwy9wb6QEQ=
X-Google-Smtp-Source: AGRyM1tb7MqOzyMSXz0HU1PpDzCzC8XKdGBmGIPgoVmplnTRK9qMvRmpAnkByWhpGwVX9wSQO8cQO18MCswzB7m56TM=
X-Received: by 2002:a81:57d2:0:b0:317:81b3:2460 with SMTP id
 l201-20020a8157d2000000b0031781b32460mr20116297ywb.493.1656711239973; Fri, 01
 Jul 2022 14:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com>
 <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com> <patch-v3-3.4-9a5e7208dec-20220701T102506Z-avarab@gmail.com>
In-Reply-To: <patch-v3-3.4-9a5e7208dec-20220701T102506Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Jul 2022 17:33:49 -0400
Message-ID: <CAPig+cT4CF+fmMNOkuf+Yq5O1-p=UsHOXXOGUpn1wy4HNJZ+TA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] cocci: remove "when strict" from unused.cocci
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 1, 2022 at 6:36 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Remove the "when strict" constraint from the newly introduced rule to
> find unused code. As seen in the change this will help us find cases
> where a "return" was causing spatch in the middle of our match was
> causing spatch to abort its analysis.

There seem to be some extraneous words in this paragraph. Did you mean:

    Remove the "when strict" constraint from the newly introduced
    rule to find unused code. As seen in the change this will help us
    find cases where a "return" in the middle of our match was
    causing spatch to abort its analysis.

?
