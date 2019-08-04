Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 131541F731
	for <e@80x24.org>; Sun,  4 Aug 2019 01:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfHDB0Q (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 21:26:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37066 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfHDB0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 21:26:16 -0400
Received: by mail-io1-f68.google.com with SMTP id q22so40534881iog.4
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 18:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lufia-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=x2CIO9ql1dOBp3wEo+AV92WQ/x1OdRy7n5UQttieyVI=;
        b=BdEyKcw5FMhuwhgSyHqgOq/Ij6LQKzoCFuJtNBpukDezbRrjw202zATAZrCTizKGpZ
         83v1MEDUlD9lVpt6Ct51YgWBTfj321lwYhf9vjRciczdSjo/rVkf/tAX+hz4N5yNtAjI
         OS+T17T4hHQurUCMghKrXmU1sr0u5Qf/MEOQWKukEnGEe9R1/v6g5lBhEvfSgyg9eqWy
         uIteJ34kiyYZBUrj/pyW3XxJ2/DJEiqhxJwpDybVoh5wYvsYFf46qF4N/ecHcgYAzXK1
         BoJOp1uydJS5v85/p6fTGgz1kWagv1Q39M7MZ6anLmfx0Y2i04RJHM2zEHpqPtgXY5m/
         uX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=x2CIO9ql1dOBp3wEo+AV92WQ/x1OdRy7n5UQttieyVI=;
        b=MTX1XdWjyLKhLALPVwaKzq1jmbBOu9JfxD/2fCf8JCHISFyTqVxMf5NrGW5FvKHfjA
         7kBuiC02Of8jSHVoeZo2+CSEDPntBT4duUbd1Wy1arRuYSDBFQ+10i9xb3bhuQOkPJy+
         ya9SnQrXbimVJCgXwqX/FqziluxSr7NAao4bsrNqegD65K26v++tEC2WgOg8uhBoxbC1
         RsgDBpwpZKyOoCMXNvDMWTYimqg4X8MZVpJ/FKvalZYssdH5WxMBKkGAlLN4owLGNC1m
         KH0U13FMzkLW5enBI+snR9zlTHWAWFJD+NWni3mKbeZOd5VbEUWRqNWPnTIxIpBKGE2D
         xYgg==
X-Gm-Message-State: APjAAAVb2ZYZRJXxxdbInMWcLW+ZEEU1brz0LEqhIwjvBhtBKziZinA/
        mNom4A0fu4ZeNMpVo0dCFyOEesUXHPfIV/5vQPw=
X-Google-Smtp-Source: APXvYqzUR8SyJCx2LFH3BmAA15aGiYdUAM6Mowu4a6Cg73URPZW01Dt1WA7IlgJyJC/1TGfJh3mtmfjzeitG+6QcR9Q=
X-Received: by 2002:a05:6638:281:: with SMTP id c1mr7302737jaq.43.1564881975087;
 Sat, 03 Aug 2019 18:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.305.git.gitgitgadget@gmail.com> <d00bbdce0d5104f1793b7fa0dce14f678e9fb331.1564876327.git.gitgitgadget@gmail.com>
 <20190804000310.GD118825@genre.crustytoothpaste.net>
In-Reply-To: <20190804000310.GD118825@genre.crustytoothpaste.net>
From:   Kyohei Kadota <lufia@lufia.org>
Date:   Sun, 4 Aug 2019 10:26:04 +0900
Message-ID: <CAFMepck4QDxBqBZ_jbwshrMC7W++a_BG4RzC_ct1-2sb2ReeyQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] Add plan9/wrap.c
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        lufia via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        lufia <lufia@lufia.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2019-08-04(Sun) 9:03 brian m. carlson <sandals@crustytoothpaste.net>:
>
> On 2019-08-03 at 23:52:12, lufia via GitGitGadget wrote:
> > From: lufia <lufia@lufia.org>
> >
> > Plan 9 has bind(1) instead of ln(1), but bind isn't persisted to the disk.
> > However it isn't efficient to copy git to git- subcommands such as git-add.
> > Therefore Plan 9 needs wrap.c to switch behavior by executable name.
>
> Does Plan 9 have symbolic links? The INSTALL_SYMLINKS option uses
> symlinks instead, which should avoid the need for hard links.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204

No, Plan 9 don't have a feature to create symbolic link.
I think Plan 9 will not be going to have hard- and symbolic- links.
http://doc.cat-v.org/plan_9/4th_edition/papers/lexnames
