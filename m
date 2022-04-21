Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6F0C433FE
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 22:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392340AbiDUXBi convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 21 Apr 2022 19:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392318AbiDUXBh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 19:01:37 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6135E42EC4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 15:58:42 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id j16so5909453vsv.2
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 15:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HLuCUtPzPom5eA/HKFIhVpx/PXeAJp2/AB70eVVKU8A=;
        b=r9+BGKN5KbteAo+WsDtpsg6JQvV4UirNtZmb1aWdXlIyn3BL5e9aTkyQr/yOEwy2ZG
         VY5RVxrztZ+AE/CoNeo2MtJQ9mCJ8P4TsixwswJCSRG4nUPNrnQn4IqNXQmX21IhHLiG
         QawBFeRp0NLsBNxaY7VyNYwEgfEqNjQPEBw+b/1x0Nth24wLZLEO2Ceak1mmC+mNdv+H
         Q88zVQdfYYdgmKsw+SUjtWR0WqNJ1RH3S1Gtxy4g8vyZhtrSp4zciRbGGye0JQZ1aJ4r
         jK9mWwDKsq3e4ZjIDcp6OR7g1JycecoYhszJyat+pr5Z5QkxT8O8yX63dKDNTtDT/Kb+
         zVjw==
X-Gm-Message-State: AOAM532WCyb/Cl2NSTQVfa8197MnRltzDjBcCYQ+CtuszR8guEhC6663
        Nhfli5dAjDjHiVqERaOH3qRTUX8h//fGzF0Z+Z4eUkb1quo=
X-Google-Smtp-Source: ABdhPJywnrh3cGMCNOCXZUmBHjttPf1xyEwqcViIFXrNFDpa6CmGUCSQJ4LEh53a2rA8LW1EDyfp/PbHan1VOtD5woc=
X-Received: by 2002:a05:6102:e53:b0:32a:120f:3ef0 with SMTP id
 p19-20020a0561020e5300b0032a120f3ef0mr581261vst.14.1650581921314; Thu, 21 Apr
 2022 15:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220421225515.6316-1-carenas@gmail.com>
In-Reply-To: <20220421225515.6316-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Apr 2022 18:58:30 -0400
Message-ID: <CAPig+cQh7piGQwQwS+d8RRSDODQwmB2V73w__s4yX=09YLRpWg@mail.gmail.com>
Subject: Re: [PATCH] ci: make perforce installation optional in macOS
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 6:55 PM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> Using brew to install perforce has several documented[1,2,3,4] edge
> cases that make it fail periodically, so if problems were found while
> installing it, just continue without it.
>
> This means that until the problem is solved all perforce tests will be
> skipped in macOS, but they are still most likely covered by the other
> unaffected runs and will be covered again once the issue solves itself.
>
> 1 0eb3671ed96 (ci(osx): use new location of the `perforce` cask, 2019-10-23)
> 2 5ed9fc3fc86 (ci: prevent `perforce` from being quarantined, 2020-02-27)
> 3 3831132ace6 (ci/install-depends: attempt to fix "brew cask" stuff, 2021-01-14)
> 4 https://lore.kernel.org/git/cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com/
> ---

Missing sign-off.
