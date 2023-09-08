Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049D5EC875E
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 00:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbjIHAB4 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 7 Sep 2023 20:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjIHABx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 20:01:53 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8861C1BC8
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 17:01:49 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5734b893a11so968640eaf.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 17:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694131309; x=1694736109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mUrQJkISretoH5NfbeD/FZIWRpQ7SHfoE0TneS3KE0=;
        b=HYnnYhzWWmslFBBpm+sGO3/19ksSq6WRw4L+FgqirGVA42wFa7VsL+TIs7ZHHwcU9K
         tJzSeYaqNnfQh1cpyM80XC3V6uZ+qP4JBvf8s33p1wN1sKLq0309n5QPAw6UiWik9pFa
         kYnf51a4bIC99+k635mJHBbW9cJ7F+rBwd/XvBBbBx12EaqdjVYc41R0vmjWkW2uMcot
         5JEFxpn56FXAEvgzEs3n+SzmEOEEPKnGImsGEk2/4Vh1MWIuY4mpXoR+0JaGPNpIE9nh
         X4O1Lsy69JbnI+7VPvMqvAqTzgTfOmtHietu+pBIvjClS/kxqPRfbu6izyPyjqLzgnQx
         6zOg==
X-Gm-Message-State: AOJu0YyqhnOtnGXPcW2KlZ2iKvWNoPD62GZG6Mlo0JudYOSxFGiDxG6l
        Iu7ReCuye2jT2snzsog86LPjwQeCbtZlWcueML8kSh3lBTA=
X-Google-Smtp-Source: AGHT+IEOZA/IFgPI0y3Q+qre9KJjay5yyaAxPRE7zVe9rJm294wMC8HmBrcCLl6CX+Dx4qsZbP0M65pwWImghwMDGRI=
X-Received: by 2002:a05:6358:248e:b0:135:99fa:a125 with SMTP id
 m14-20020a056358248e00b0013599faa125mr1035003rwc.1.1694131308802; Thu, 07 Sep
 2023 17:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694123506.git.me@ttaylorr.com> <de6c2a0d70c3e62bd70fdca8b5c6c2ae6eaa13f5.1694123506.git.me@ttaylorr.com>
In-Reply-To: <de6c2a0d70c3e62bd70fdca8b5c6c2ae6eaa13f5.1694123506.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 7 Sep 2023 20:01:35 -0400
Message-ID: <CAPig+cR8pYr6Z2Jojw-QO4n5qFkEpMgQh+ApFK352-r9da4KTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] t7700: split cruft-related tests to t7704
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 7, 2023 at 5:52 PM Taylor Blau <me@ttaylorr.com> wrote:
> t7700: split cruft-related tests to t7704
> ---

Missing sign-off.
