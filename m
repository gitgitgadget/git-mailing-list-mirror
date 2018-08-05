Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F841F597
	for <e@80x24.org>; Sun,  5 Aug 2018 03:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbeHEFb6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 01:31:58 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:44998 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeHEFb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 01:31:57 -0400
Received: by mail-pg1-f176.google.com with SMTP id r1-v6so4636978pgp.11
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 20:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=czKHyIi0G3WbJdQFmSSAwGSW7Durtdv0E4/YC08AtHc=;
        b=jQ/Kf5QmHftEGTtVl2YjayiQRZPheAepFxjfrbnLm4y6yGir16j5MRgu1+whJ/6WRs
         sOg/M7tNUVSexMDhci5bhXxBP1XyBUe8IyeRYpimNRKWbaJC2CYzBXhdP5ALpvtOMrD9
         FMIN7de6ek+VJ+EdpRGgv4+w/anmwUKIlRJHSkcYwlrPBRAnFZDt+5p8UGpuotrYEKbX
         FIlZQ7+Qzt0Iv0yW1+kL7vLaK3C/Ak2txG/vAzuVjhGHOETdkYmq40c7yUTyzsVzfD6z
         xM0WY4Ew04hvlkf4ai+XWPGeULaUer4vJfLH125HvZzzZXTIq1qFjsDlF8UU71FCQrdm
         OXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=czKHyIi0G3WbJdQFmSSAwGSW7Durtdv0E4/YC08AtHc=;
        b=ETwY0pKAZ3ZhA/DPh39nvSiSO8cLR90fc53G4ApHAwc2Xx2wUOwUygYh1btYDsnjlE
         XPCuWgZhZPYW12v2qtO/pfOi/PDbzHpeHpT1SmXMK8j3DOwEhHru+IYHtfAKOA+tXbUK
         IrZUr7AUZkoAb6q2NVQkqApB9ADkIUCCMaoi9CBR89j0kvmvh48uB81hhRCY9yIk13kM
         4o8t7y/N2eAT1KTBlL/zrwAzb1Z6RQKbv7u63DcoBJPzqwRx/4x7EnEPo8gYgeplUl/B
         ZZ56bpk4Md279AGJC/LecH6IozKDQdLwcRB8srZlh3EJABjKzHR3GToYGC5FJ2sj/IS9
         Qzzg==
X-Gm-Message-State: AOUpUlFp1t3Rd/7tipLeD5KLsxT8l2/GTbItqsyQiNYjMtsFg/rZCb5L
        V8mE5Ssk2CdrcZvF3VGarBE=
X-Google-Smtp-Source: AAOMgpdz8n4CU+6LUpKmnyywTP5IZH9awxFiTPmDYh13mDpRINUIjjR9PLi7bVWEnZaUdivdv9wTaA==
X-Received: by 2002:a62:f50b:: with SMTP id n11-v6mr11311835pfh.120.1533439736475;
        Sat, 04 Aug 2018 20:28:56 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j71-v6sm14993530pgd.23.2018.08.04.20.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 20:28:55 -0700 (PDT)
Date:   Sat, 4 Aug 2018 20:28:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How to push using SSH and pull using HTTPS for all repos on
 GitHub?
Message-ID: <20180805032854.GG258270@aiede.svl.corp.google.com>
References: <CAH8yC8mXaNDmLBpDmtVTP+6Yc8_fCz8YCadOL41fOvb2J6j=8Q@mail.gmail.com>
 <20180805012602.GB258270@aiede.svl.corp.google.com>
 <CAH8yC8nagnHtEosS0zNuHyh04GZYqfmL_5eR_R2qkWEBpxcM=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8nagnHtEosS0zNuHyh04GZYqfmL_5eR_R2qkWEBpxcM=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton wrote:
> On Sat, Aug 4, 2018 at 9:26 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Jeffrey Walton wrote:

>>> I'm having trouble setting up my ~/.gitconfig to push using SSH and
>>> pull using HTTPS for all repos on GitHub. The idea is, no passwords on
>>> pulls and only use the password for push.
[...]
>>>    [url "ssh://git@github.com/"]
>>>        insteadOf = https://github.com/
>>
>> Does putting pushInsteadOf here work?
>
> Yes, that was the trick.
>
> Thank you very much.

You're welcome.

I should have asked: do you remember where you first looked for this
answer in documentation?  Maybe we can improve it.

A few thoughts:

 1. git-push(1) could get a CONFIGURATION section.

 2. the description of url.*.insteadOf in git-config(1) could mention
    pushInsteadOf.  The description of url.*.pushInstead is right
    after it today, but there is nothing guaranteeing that that will
    continue to be true.

 3. Likewise, the description of remote.<name>.push could include a
    pointer.

 4. Maybe there's a place to put some thoughts on this in the
    user-manual, too.  It already mentions remote.<name>.push.

What do you think?

Thanks,
Jonathan
