Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B67C433F5
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 05:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiAHFnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 00:43:52 -0500
Received: from mail-pj1-f46.google.com ([209.85.216.46]:46856 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiAHFnw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 00:43:52 -0500
Received: by mail-pj1-f46.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so8836744pjb.5
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 21:43:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9Ztlj60iba8BA7WN2hSqDI2nQi/lT9RqQ+CvXM8cN4=;
        b=jWdLH8qpDjbW8CWPodO1aWfkWw4K3hKLhZw9W9OoxRFuLUM2PSOyN0qOPqY65M10iI
         Uvh+2aTgyyClPQ41C0TFO+E7Iz9pv5Ct18SAdFor4GPj5EpEor6T26fLzcoxSWOGTXCK
         7H1YUhEebctGOb+bPLN32ssNYErwUKU0+/rKVp/POyOVCK1t/zhMl3EIFM12ljRu0jbv
         JmLDi6OXJamc/25boL8/5QtcKeXfX4YFtzivIZCQLi5uP00MYoCC8vtRGDSlso3TMTN9
         6FPWqANzV63WKiW7DS7NMnv2zY+B7KAaw7jPA+AZt/BsL/N0C0OmlLyruaWVvezkro9A
         3ieg==
X-Gm-Message-State: AOAM533zInfgxzWo3dEjkv5aNylTwzItnRgiNO77uZYFYTZcFMvlwCwX
        JolAuF82jjaC/yYuAy4nDdzwHvqR6RN+jcDu9i8=
X-Google-Smtp-Source: ABdhPJymQ1YklQ5lrCsgftr+iBmIMAY0sgW7WowRh3gGnfUc1yWGW380lDeNM+ZLN7WonDZnkXxk/C1mcPc8duKj/0g=
X-Received: by 2002:a17:90b:783:: with SMTP id l3mr19121806pjz.104.1641620631544;
 Fri, 07 Jan 2022 21:43:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638874287.git.ps@pks.im> <cover.1641556319.git.ps@pks.im> <b52e59cdac75e6c4530cb39f7dcb41bb327f50e2.1641556319.git.ps@pks.im>
In-Reply-To: <b52e59cdac75e6c4530cb39f7dcb41bb327f50e2.1641556319.git.ps@pks.im>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 8 Jan 2022 00:43:40 -0500
Message-ID: <CAPig+cR=XAwUT9EdLjOdw3RrOXPUspR2VMW-wv5p8hOMc=iAxQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] refs: demonstrate excessive execution of the
 reference-transaction hook
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 7, 2022 at 3:09 PM Patrick Steinhardt <ps@pks.im> wrote:
> Add tests which demonstate which demonstrates that we're executing the
> reference-transaction hook too often in some cases, which thus leaks
> implementation details about the reference store's implementation
> itself. Behaviour will be fixed in follow-up commits.

s/which demonstate which demonstrates/which demonstrate/

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
