Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A87401F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbfKFPPI (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:15:08 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37159 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbfKFPPI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:15:08 -0500
Received: by mail-ot1-f65.google.com with SMTP id d5so9072898otp.4
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 07:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ql/cbAfHKAnIPSTbDPnGuCcvBnnk564jfXBoxm1a8G4=;
        b=FIdm2G+N1qAWL00TaL/l8H7z6n4HpflVZwCFkzfxEU/BnDbEtWxwJd9JdH/BSBX/kt
         CEtnOZ+rLea4MI2HAiK/cM30/wp7DvhhXaUgyNzt/QKRcv01mmsi1AHugKFcYgv2crjZ
         76TA+tsxzKHLb+ygPF42mtww6nCLJmXbFfi+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ql/cbAfHKAnIPSTbDPnGuCcvBnnk564jfXBoxm1a8G4=;
        b=HF0O/GjazRusKuN/DnECiDhCXwa73eec7Vxkts9IGUkyQLpB7oROgc8SYj3dGdrYwi
         rmI96pCk3cywmLz8FTA3BxVOSr0FWLIeD7mOXXG4va7smwVN/vL1ZJ53Cz1Vqbafm99Y
         AgJsThz4ccxTnEvN4pA41JjzU5DhJNFkU2++xXV/tkOp4ej5VrEiZDnr+v50v2Svr24D
         GNfhjsDXpf3ykpal+ZJDerqqE6SIHhSR7lZLI5UIR9p1cw5Gf99mI66D13G8iy+OxFfg
         oMnW9P7glbEhlXRJhaiDiDl62kZ37jobvLyPBFSoPRB0u1ln5WTszJ2q/Jfw8+xZHeB3
         Op7g==
X-Gm-Message-State: APjAAAV/zGjY9CcS2S9iutZH7+fZoOmz7eyGsRfX8Rq58mYNH5i0bvFa
        WdL2cchVmDUCmWoKsnLEcYZHmF2V0TjfvVdUh4dbEg==
X-Google-Smtp-Source: APXvYqzl9VPAojpKv7Jn6K8gwW4+KagpWAUcBVqO/wZZGxa+OX9k3mFYOY8CzkMdR+LfEHNL2MvW8Cg4XJw7xUAzuP0=
X-Received: by 2002:a9d:7b50:: with SMTP id f16mr2246844oto.264.1573053307168;
 Wed, 06 Nov 2019 07:15:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.448.git.1573013889.gitgitgadget@gmail.com>
 <5729dd380708da7b40805f75c5d475ff4c0b28c5.1573013889.git.gitgitgadget@gmail.com>
 <20191106073731.GA86608@syl.local>
In-Reply-To: <20191106073731.GA86608@syl.local>
From:   Nathan Stocks <cleancut@github.com>
Date:   Wed, 6 Nov 2019 08:14:51 -0700
Message-ID: <CAFo48e7NeHo7465G_as5ZUjYg9pHh+rM7iZ0kDyRypV-JLJibQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] t: fix typo in test descriptions
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Nathan Stocks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 6, 2019 at 12:37 AM Taylor Blau <me@ttaylorr.com> wrote:
> Nice find. I agree with your and Peff's conclusion about when these
> might have been introduced, so that they have survived so long indicates
> that this was an especially good find indeed.
>
> Your patch looks great to me.
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>

Great, thanks!

~ Nathan
