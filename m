Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26B7C433F5
	for <git@archiver.kernel.org>; Sun, 24 Apr 2022 00:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiDXA2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 20:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiDXA2p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 20:28:45 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F4917AA5
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 17:25:46 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id x5so626856uap.8
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 17:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3rajYO944Xz3KnawcTd6++JcvwWIa5keDFYZXrqlGk=;
        b=If6LpVDJoHgPC+RwZU2xMrJhLg1rxsuodAsYyXp2WSeEuZY69ph1QRkrK3vWxYrcKx
         nq/oK2795ZjwLNA4ISajMYaNL2PiiSAPJTN6HcoejhmdgpnSN0YAshVXFJmDwkOh1PfF
         5CCRbWzEaWYlHXq71PC/z8Mh4aOi98GUxe1WRCjfwxR8x1FHCxr3DszWW8WXOizKAw+2
         Ndu1EdzurWz4bRFNZ5afnmfOo1NfEVyn8rqPSPSCNZp9eQRDc5/232c/SlprdUcsUP8C
         9LPcpCYHXDyJmpzLCo6RqJlZltXHxCXmqIskJA0vs7cO25mimE9FpEvIm0hABOisjvCY
         OfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3rajYO944Xz3KnawcTd6++JcvwWIa5keDFYZXrqlGk=;
        b=SDjRRUUX44ml9H4kU6WHgl8OscSEPt1Q+fbwcYgONLCHB4LUk44b/VGfhoNvmq148w
         a5UYg1yVJ9GaVHkXIwnOw5I6nFOK119jCteRCwRMo07k0E/WCJ/wOxYrF56qnYLAbwME
         +kvjUqXWlsbwUN6mxlkFGQSICHgOzsT3gILSFvb5ALw8qnXWsFiPdbrk7d/k3e39ker9
         QwF+xmq7KzonuUIWl8nvwZ+nik/Q+t9U2GA6aNQuvN6w2rZ6qwcBnI6LQU0UnSnYTXDh
         21gu9sKMXLuKNUfP7DEBrj+RDNhBrqjgiN2/QpSTRxm6vk/BvsFKEuQdVTue1N9cOf38
         HklQ==
X-Gm-Message-State: AOAM532rQTwyVbaVqp3IY/W8DWP8qHEwJmrI+Oe3y5EHo9mHTMh5nW2V
        UtuhNFe7kGYTf/DvfurPnoV9Sd8wrOKZO1GHLG1kVIzd
X-Google-Smtp-Source: ABdhPJy/3qCbfoymoA5oxkj7RMUS+6U8LS5Go0xUq6QEeAE/XPqpwZ5Vr7sgTr3wUo7LGfRBRs6M8E7V+0Pf1olPf+Y=
X-Received: by 2002:ab0:654e:0:b0:360:303f:46c7 with SMTP id
 x14-20020ab0654e000000b00360303f46c7mr3504430uap.6.1650759945900; Sat, 23 Apr
 2022 17:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <patch-v5-10.29-07e36035a1e-20220421T181526Z-avarab@gmail.com>
 <20220423201129.34133-1-carenas@gmail.com> <xmqqo80r1kid.fsf@gitster.g>
In-Reply-To: <xmqqo80r1kid.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 23 Apr 2022 17:25:35 -0700
Message-ID: <CAPUEspibJOiMksnEQTNUiVMp0q7VrArtvL5ZnQFQ=vSr+gzqYw@mail.gmail.com>
Subject: Re: [PATCH] fixup! CI: move p4 and git-lfs variables to ci/install-dependencies.sh
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2022 at 3:59 PM Junio C Hamano <gitster@pobox.com> wrote:
> But if we cannot unify the way the installation is done for macOS
> and Linux that way, I do not think renaming $LINUX_P4_VERSION to
> another name is worth doing (notice that the point of the above
> exercise was to abstract these into just two variables, VERSION and
> ARCH).

BTW, I was intentionally holding those changes for the same reason; if
renaming the variable causes any pain (my guess was that it will be
unlikely since the code got moved already at that point, and so
renaming it at the same time would be unlikely to cause further
conflicts) then it shouldn't be done now (or maybe ever).

and those changes should only be done after all the refactoring going
on now is gone, and only if discussed first with a lengthy period of
RFC to make sure we get it right and go quickly.

Of course, the final version of it will be unlikely to NOT have a
single function that does the right thing based on those two variables
and those patches were ever going to be sent as RFC.

Carlo
