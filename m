Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6821F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeFEUfW (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:35:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34056 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbeFEUfV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:35:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id q4-v6so20312700wmq.1
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=0EoadVuAKISa2cFy06ebH8Agqh74lKn6SD3ZEQ7kTdk=;
        b=pg+IwCsAYbMgIheNxHYmov5eToe/8aWHyFBHP+gTMyMrL3bn5X8i3y1/tcEN7KaLSn
         O/L6y5RAY61ClZSTMbr2nIttDO7zziezgmuw2wo813P8DYo9LaJrnN3nOSzj8Z1T9f5J
         k8AvhB7ybAnM1nPyUA6pdMUVdO838m5T8WsEPSdxD9nyAB5zaMeCL511Sgb0isdTjipJ
         hpWMxIHg0F4rjxpVSRkyUJSS1LXUKlAdlL5iJ8NQS27K3J2Cw/ymK5F5m/WoE9kbCdxH
         lyAyHW4e1adduLADUJSf/3nCbzpINEyuCzoEhHaEIMEZS9PLlPsGTRpcC7p06vA5K6Rb
         ZXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=0EoadVuAKISa2cFy06ebH8Agqh74lKn6SD3ZEQ7kTdk=;
        b=oY2k3OytBYE78JpMjAa8JDNs49K50cK66+F/X1S5qDfMBfake0JuUpVQUbOMhCcCSM
         WQAmkivq4vKhA1Yqr9A7lKXwb03VBbwInSP/fmAdElYo36XPr7fjbhx0R8sphdsc9mCa
         euciUG6yfy/Rc65RFZpc2m35guI8v/1siXh5iGnewKB7FwRr1g78DpDj+unIAtK1WcfE
         +WvdkT5TgHuV+oDi82mNuEnz3JLPV64PqnEAHa1Or3qFCwZb9mHFZ1IHGRWe/+FHsCzy
         fWlPaQgmaxtUk5Ebnu7XQpnKNDJD9wg0IrjtoQn04WDENMeWIfVS22A7mrx07oZHe29f
         kOHQ==
X-Gm-Message-State: APt69E0hpFos+RPhhWDKZb2Ny/W9jZF9gdIHcPuE5b8X2ivvdaZubtls
        9AWMyxUf6C+AsfdPZbnkDHA=
X-Google-Smtp-Source: ADUXVKIWcWVH5pJjhLEr8arse4Uua7z5UgufBzV461x4bjAaJO0YkgBnw84P3Hq/ouKtBMDVSREhIw==
X-Received: by 2002:a50:a844:: with SMTP id j62-v6mr609268edc.210.1528230920184;
        Tue, 05 Jun 2018 13:35:20 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id e46-v6sm9299683edd.80.2018.06.05.13.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:35:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: link to gitsubmodules
References: <20180605202449.28810-1-bmwill@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180605202449.28810-1-bmwill@google.com>
Date:   Tue, 05 Jun 2018 22:35:18 +0200
Message-ID: <87o9gpynsp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 05 2018, Brandon Williams wrote:

> Add a link to gitsubmodules(7) under the `submodule.active` entry in
> git-config(1).

Did you mean to change either the subject or content of this patch? Your
subject says gitsubmodules(7), but you link to git-submodule(1).
