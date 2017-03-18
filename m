Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4152420323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbdCRKGC (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:06:02 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:33697 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdCRKGB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:06:01 -0400
Received: by mail-ot0-f179.google.com with SMTP id a12so39821809ota.0
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zdGh7jmoWALHpA2vSup7XA3ZaKzs9mIdr/OPBLGcFpw=;
        b=TULcBG/kfatZVtpu/FAa2Yp4RPWPgw/7sMx7vz56WcWjBR1QLOgEhxc183TNxZcZqB
         XKD9N+/4cclLliZ/AcA1oN0EdsEo9U0e1CT4KKeybTCAv+ao3vVsqv0f32A0/WR4k55s
         lobP5zjsfXplpuE8qlC0084JnGul/Qx7HuoxNflGQSj960G7nCFLTfXppDAKlE5C4xYj
         /tkZeuI73s6k5pBkALZ+Xf2A9lw1v7Om/kzf1juiY/DCbkFc2x1S8giC83nGlbaBkU8K
         bqt1f9tdvXM4cRVffrwIpPZv+NQUnt4O7uOjE7XrLGi9x6Um+y7pdvMwHbh9hgET1hFJ
         w27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zdGh7jmoWALHpA2vSup7XA3ZaKzs9mIdr/OPBLGcFpw=;
        b=ZSmOBR54kiW4vVqp6e8SGlKaxzZzfdb/cuHUGWoYqRYQlk86k9kB5EagJPK0s5tCMe
         P1Fc1SBucjk33dY+en7hMhNDv4vIurNw9mbGG/oqETaW+mpm2DqddnctOXUcDcHnX3RL
         c0lU7DJKcMOz33/QW/YCSoCWaEuink6eWr2WgUiTzw+/498ouaZpF2fzIzMpPKw/cdFZ
         NEzH3/L83ugDeEguRfm9NZQDyBMmyU4NydtPkCNumVuiJdKev2Rh5Jy/Q6J3DVuTFXPd
         UtJMMEvRB7dXLb8E8aDbg/byxLbH+Smvq6qVSYRF9xwOs+aXuUfag2sj2AXaEBakPnRJ
         Ogsw==
X-Gm-Message-State: AFeK/H20j6MYmlwfOlDfqKm/5duJpo3tUxW/SwYWYs7gc44teCkG1WMikmjlos1wMl4YmzjUgMGkah0oaS5e4w==
X-Received: by 10.157.36.202 with SMTP id z68mr2941691ota.271.1489827740995;
 Sat, 18 Mar 2017 02:02:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sat, 18 Mar 2017 02:01:50 -0700 (PDT)
In-Reply-To: <vpq1svtstud.fsf@anie.imag.fr>
References: <vpq1svtstud.fsf@anie.imag.fr>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 18 Mar 2017 16:01:50 +0700
Message-ID: <CACsJy8D+VKGEtq6yMe+ZhfxKX2peCVXGZfZFckkZF_L=bWBqTg@mail.gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 23, 2017 at 10:02 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> * We need to write the application, i.e. essentially polish and update
>   the text here: https://git.github.io/SoC-2016-Org-Application/ and
>   update the list of project ideas and microprojects :
>   https://git.github.io/SoC-2017-Ideas/
>   https://git.github.io/SoC-2016-Microprojects/

Probably too late for GSoc 2017, but another idea for microproject (or
microprojects) is make use of dir-iterator.h more. For recursive
directory walking, this would make the code easier to read and
potentially avoid too deep recursion. There are three or four of them,
I think.
-- 
Duy
