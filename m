Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1EF61F453
	for <e@80x24.org>; Tue, 23 Oct 2018 21:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeJXGWn (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 02:22:43 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:46562 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeJXGWm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 02:22:42 -0400
Received: by mail-ed1-f51.google.com with SMTP id v22-v6so3084979edq.13
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 14:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bi5m9CUtHk9yRWnr9AReW0w/JeMbqeTvDJOWnz2+5GM=;
        b=t1iHc/ZEv818XUNbY9Te0MXWMiC9vJkVRRvd0+zIvMONwYGPbbTZgcUbI+uiN8iVYR
         HGjAZQHlMizkOBMft0/8VLrLijjoCpZn4GZnHuyJCP8km3zefY5cZ0DC+AqF5HgUalMk
         q6pDMk1BniuDfVJCYrSzaEZ3RZxv5hwuUPAfvmvUjDGULpnKTflkxPvzpGLGgBnsd4Iv
         xc3Cx+6UDHgACJn3N/7dC46a5a3GWQvscufzTZR6Mg5NkTTSjn/4QTcxrw8FhVJGJMl2
         deYtKqhvFT78k59WXSeea4NXCE0MIzZKfAWSAh+BYLxNJBF/dVAxzNDQmFKCtA56LjpZ
         Tz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bi5m9CUtHk9yRWnr9AReW0w/JeMbqeTvDJOWnz2+5GM=;
        b=im+5YjkDc76mQIhZAEDbjRhuoi7B6htCcTgdQ20I7Y3QYqxQC9RFhLRdD/ikfTsV2+
         4PgG1xVi69dW9v90720mfPDFM3wUDeNpeEITVMIk/j3plTdkGtKSFghIiFEItsqYXSgw
         JYz8RFpyM0ItE/lAwWvwetK9nXuoMIeyalTIWMmSdh1+/mkpVaWkMgcEqIFy3MmgxBWN
         W6dfJL2rb5BKiCS8YOgnX5/4BT6xtKMIqnopwQ8Di2pmyYWL1HrYaTq6sSV38AKTHcgR
         HbFtBH7oQ6gD/R/Sl8qTNiT5pk10wLY4E7WPICNZDJdCyJAMq5wYtSSVSP50KcQXC5Ku
         nHeA==
X-Gm-Message-State: ABuFfog4u9FIqYn8XR9w2bzq6+5NtW+ZU+0uSbPyXd7pkfvjis8RJTUP
        WCZYx22nLd30udtGjY3Dvtww2U+5CMun5zWPwJnTGEN6cuOYww==
X-Google-Smtp-Source: ACcGV63w/2ywP+JxVxFlBT9iVaVJGzsTAtOowE4txL86cxX/2KqQQXoFl2ajgFWTTPMFWWyxp6faol03+InbknrDG50=
X-Received: by 2002:a50:b607:: with SMTP id b7-v6mr16373181ede.215.1540331844785;
 Tue, 23 Oct 2018 14:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAGshahkvn3fcyuqtD-WQE9tn+7rSad84+mtA_cfkz+t42xqPdw@mail.gmail.com>
In-Reply-To: <CAGshahkvn3fcyuqtD-WQE9tn+7rSad84+mtA_cfkz+t42xqPdw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 Oct 2018 14:57:13 -0700
Message-ID: <CAGZ79kZf8owJUkYF2SsCr_2q8hKxZW_Z3SbUQr6YMgNh8THfXQ@mail.gmail.com>
Subject: Re: git pull defaults for recursesubmodules
To:     tvainika@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 2:04 PM Tommi Vainikainen <tvainika@gmail.com> wrote:
>
> I configured my local git to fetch with recurseSubmodules = on-demand,
> which I found the most convenient setting. However then I noticed that
> I mostly use git pull actually to fetch from remotes, but git pull
> does not utilize any recurseSubmoddules setting now, or at least I
> could not find such.
>
> I would expect that if git-config has fetch.recurseSubmodules set,
> also git pull should use this setting, or at least similar option such
> as pull.recurseSubmodules should be available. I'd prefer sharing
> fetch.recurseSubmodules setting here.
>
> I've attached a minimal patch, which I believe implements this
> configuration usage, and a test case to show my expected behavior for
> git pull.

This makes sense to me and the patch looks good to me.
It is unclear to me if this is a regression or an oversight of
of a6d7eb2c7a (pull: optionally rebase submodules (remote
submodule changes only), 2017-06-23)

Thanks,
Stefan
