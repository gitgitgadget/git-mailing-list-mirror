Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5CB11F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeC1Wvy (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:51:54 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:34837 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeC1Wvx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:51:53 -0400
Received: by mail-yb0-f171.google.com with SMTP id v66-v6so1378193ybv.2
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=63+oDoBEIJTga5pjpFIAFQAI2kMncjRyA0yd+WZnjxU=;
        b=KkurpsI7x4NfV7WMbIUBF/TxDkxc3dPgIAlK3YU0Nta7PVrPX6YFTAVl9XSlfX2M3m
         8xWYOSbSpEz8xGfi4Qi/JM6RwF/sgGTvNtRv+wtEJBkBI8ogbzHLAOjLBrU7oqOjLSNJ
         TeJLe0phL86zAFyqcwQTi+47sdDw7yR7YT5HZ30neUgkVEMv/QD3iy1dSkcDHGNpcpTw
         B1tQFF8jNUHKDFvXXNP2/2q4qZXLSBfx9HJAhuPKoGEFXEnLFJHM5bpOA9DDuM+qJ5dr
         ALXZGQR/NioL9v/3bkaxccRvcBM9gwoBc2OuiCv4mlwx8xD815MBTGbS/rN36Tlm00Vr
         qw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=63+oDoBEIJTga5pjpFIAFQAI2kMncjRyA0yd+WZnjxU=;
        b=fTrJWSQFTKWlIFi9PtyHbH2FA44jFLKpWuq+iwGCBgN1NYhzcDcMyAagf5BONg4lbm
         l/PWb6De3DlNRfibB38qb6C1u3lRERRqJ/zJuiuawf+4siT7tjzq7x/vEmZre55Vff5d
         t4Uqou0lAN8ALCKc6osLQJxKTYXoEQP5ckp7BDdRO2shz4Oy7cNhkNDuHOp4cPPexH/j
         6wmZQm0bxclRKND463fkmC/vKeyMeMXlG0PEP7MG/PFQT+ngBcxYedA5Nzro7f5soJiC
         3r94CF8m5vO7MSQMx9wdiOOmI63inL1jS+T5nQEuLpIOLzjEkqp4GfeIwCV57e4+eRZT
         C2Wg==
X-Gm-Message-State: AElRT7FKuZDPeEc/ezl+jSD0EiHAdVAIYf5ZyT+nqOxpeQcHq6eVDsYt
        lu8Cayu5j8KGgkJZBGy0wx7HqXuY4L6Yww7bxGp6P3Hn
X-Google-Smtp-Source: AIpwx4+gZGGn+k7DhwVD7e7PkZ/5Gh0QjvX9fkvVUFRyHPrehwvT5NFwe+0UZ6PXUs3C355ytZ+PbjRgLtkhd40Pz3I=
X-Received: by 2002:a25:2782:: with SMTP id n124-v6mr3519737ybn.307.1522277512626;
 Wed, 28 Mar 2018 15:51:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 28 Mar 2018 15:51:52
 -0700 (PDT)
In-Reply-To: <CAGZ79kbqG2iG6A=aawiyVsr=NFRtJqt1XHeC3kMaRce27JHCSw@mail.gmail.com>
References: <xmqqsh8k6khj.fsf@gitster-ct.c.googlers.com> <CAGZ79kbqG2iG6A=aawiyVsr=NFRtJqt1XHeC3kMaRce27JHCSw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Mar 2018 15:51:52 -0700
Message-ID: <CAGZ79kYuEE5V3AH9CZHb=fma=JnvhFW8MkK6Nt0kwEinfuBV6A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2018, #05; Wed, 28)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> * sb/packfiles-in-repository (2018-03-26) 12 commits
> ...
>>
>>  (this branch uses nd/remove-ignore-env-field and sb/object-store.)
>>
>>  Refactoring of the internal global data structure continues.
>>
>>  Waiting for a follow-up discussion.
>
> I'll review this one more closely and start a discussion.

Actually this looks good to me.
