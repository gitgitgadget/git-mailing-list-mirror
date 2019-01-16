Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17CDA1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 10:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389312AbfAPKQN (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 05:16:13 -0500
Received: from mail-it1-f171.google.com ([209.85.166.171]:52647 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731943AbfAPKQM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 05:16:12 -0500
Received: by mail-it1-f171.google.com with SMTP id g76so2155239itg.2
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 02:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFUgJ3/YPfGu/g6PcM7c62PyqvCjaESx7lwF6rWw37g=;
        b=gPNJFvYMiOP1UZNEFXPKVk8Pfkyu51vNXfQT30UouXRBcOFaHhKy0k5mWNsMaWBCz8
         gtf+p4yEe/ZLgGt9ONL4fcmrJti+D/BfcgwuQYnNByJoh2KYeOls8G8hzdn+9ITEgP8c
         GjV9ZZ/zb1to9yng1W8SG9d4B+FvxjkSinLohU0EYvYuSrH6c4z0HQIbcC9luxPSFKhQ
         mSrXu4HUkInttkmQFLjZ8vHc/iMb/5y0YOrcNZGuSF62hBH/54dJMizNc4zorURB4b+P
         PO7idt/RTGjcQBtyxnJ9FL8PKTY+fJg9vo8MB+V8bb6kcfnPsknpxwgnnKq+rcdLf6H9
         OPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFUgJ3/YPfGu/g6PcM7c62PyqvCjaESx7lwF6rWw37g=;
        b=jaOPVEglyhiFhaoNdCIBVpaoN1Kd5GrJNhdMl587NHS8a4WXeNBM+Et3Zo074sR0Ne
         ZnKgj4OHrRAIg+FtJ051rLptzLy1DCrMgyr7dtjTWSOFwv8QTvoYHD9183Yfb8L6pAUO
         aJT/qluJjOXtjBhdviKYvbqBL5Dse0DdFrF1AsF2FguuYNwPBvf8oyKKs+sjjv2oqf6f
         m3g60o4P10IxqzbJokpE5oxfB1WN86DOa2GbVHgZn21iSwM2VIEwGjq9xXcxPMAHoU9t
         NFq5UXzXWRNGWxdzqcK+P6MCwkqFUwTSOiyo1WTmuA3ZM0EpSnzTFQwsziduwjS/eDBD
         3TmA==
X-Gm-Message-State: AJcUukdN2CHhKP/wDhsmAg7BN0m+/l2Hrty7gnitY5WjkUxvPq97eT5I
        1jR8EjsoNvNEzaRGhmbEarXsfhN+bb8t1Dqw+6iCaRVA
X-Google-Smtp-Source: ALg8bN5ECVIgkF0l/Zzv2LgZhA8cjKb/d1h8I5doGCa6Dim0S5kWTCIqoP96KJ9On79Ksc/57iXNQTMCwvb6q61/o3U=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr4446515jak.30.1547633771987;
 Wed, 16 Jan 2019 02:16:11 -0800 (PST)
MIME-Version: 1.0
References: <CALM8fiaUqxscb0GWHTidXmaDv_2QqkzN4sybA377cr59G6+yCQ@mail.gmail.com>
In-Reply-To: <CALM8fiaUqxscb0GWHTidXmaDv_2QqkzN4sybA377cr59G6+yCQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 16 Jan 2019 17:15:46 +0700
Message-ID: <CACsJy8CJgWpTfbTjSKtCayOCXVpESps99HuzcHRCxr4LwzYaaA@mail.gmail.com>
Subject: Re: New to git. Need help!
To:     Kaustubh Shankar <kaustubhshan@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 16, 2019 at 5:02 PM Kaustubh Shankar <kaustubhshan@gmail.com> wrote:
>
> Hello everyone,
>
> I'm new to this mailing list and have also joined the IRC channel recently.
> I want to start contributing by possibly fixing small bugs or errors.
> I have gone through the suggested guidelines and documentation but it
> is too large and I don't know where to start.

Maybe https://git.github.io/SoC-2018-Microprojects/ and
https://public-inbox.org/git/38df1011-34d3-e34e-9c4c-b70a0c6576df@gmail.com/T/#m8f272e3359add2679343acdf7f8ccd8f2547fc16

> If anybody could help me out it would be much appreciated.
>
> Regards,
> Kaustubh Shankar
-- 
Duy
