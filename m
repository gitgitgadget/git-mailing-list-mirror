Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DECC433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 07:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiJGHNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 03:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJGHNR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 03:13:17 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CB433437
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 00:13:16 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id kg6so9345278ejc.9
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 00:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mZFG6ZSkopI33cGfZ2dMuqiLJhnpw5K1854OB70hHs=;
        b=smrSILOkIit88PH/uGPKoXxsQIcpAqrH3fdNTlvY4rPU/hFasdyeanA49thZ3PRNW9
         c9zDcmVQ8/SoSrArnuBHZePusfaYUDA0xkwz6a8kc7pb8nqboGtZ9xH6yR6qhCnxecuB
         65uNel/dDwHIh4r0RRizUgBUthnv+LMXSOPgOfTxY6l1exROT4sF2BL5XULI/IFtkQAz
         TAG1wzLJ4Hv5ft6ETNFfjhIIFNK0LpAHtvyZXPGmCZ5/OtzcW/P7O5XeLa5sRoHd6MHn
         LC+7nbOoDaTaiXIF/K1P77Nzb+bZpMBVq6rWOrMl8bsqrFXPLo4fzIb/jHfzs3nPYHgp
         PBKg==
X-Gm-Message-State: ACrzQf2s/cVV5gmKCiWkTfoD0EKmfvz1qQgxl8HzKKd/SMvg5hgFvB4b
        +vlZ6v/T0VlKgv4KD91fpK/fEp6EroJ7WxTXWgEc6sT7
X-Google-Smtp-Source: AMsMyM73MaBtPebC+zMlzktL7GEzkV8oJeTatHFnDE8Nu6jj8Qbu6pEbORuiHCDaCiFUyIVLWLUYkH2VZTsz3HHQiEQ=
X-Received: by 2002:a17:907:9812:b0:781:bbff:1d20 with SMTP id
 ji18-20020a170907981200b00781bbff1d20mr2994281ejc.33.1665126795029; Fri, 07
 Oct 2022 00:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAApTLm9DJW6zARsbJOCEcahkuLHA23tCF=rJ1Vy0J+kufBfTGA@mail.gmail.com>
In-Reply-To: <CAApTLm9DJW6zARsbJOCEcahkuLHA23tCF=rJ1Vy0J+kufBfTGA@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 7 Oct 2022 09:12:38 +0200
Message-ID: <CA+JQ7M9082jsYsVtRCocAkXU5-C-=gs3vOvgP8G3CKbyz872KQ@mail.gmail.com>
Subject: Re: A possibly mistake on the "Git Commands - Setup and Config page"
To:     ddady <ddady1@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2022 at 8:12 AM ddady <ddady1@gmail.com> wrote:
>
> Hi,
>
> If i'm not mistaken, the path of configuring Notepad++ as default text
> editor 64 bit version is: "C:\ProgramFiles\Notepad++\notepad++.exe"

Can confirm this seems to be the default path for the 64-bit installer
