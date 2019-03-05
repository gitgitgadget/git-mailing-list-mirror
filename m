Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9382920248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfCEMXv (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:23:51 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:55948 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEMXv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:23:51 -0500
Received: by mail-it1-f169.google.com with SMTP id z131so3795868itf.5
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SyqGSw9Npj+t66UJ9DHTfIDA0VuuZ4vz3ZBeUa4vvd8=;
        b=eOjD/BjffeMOR6tFXDzMKCZbf6mj70NN/noge0J8MR4OM9jD028uW3z88ebQKRBdMc
         Mttiva9bphmew0VTFEdVGWWiVKK4uhXHaXGYEuABRK90fbmGpYDdGY1F1vSR+JaiwZbt
         VtKAnjOVwT6G64/0S6CmOgWbKeBk1xsxMi7MPVteZTskD4wIgyi1umHJDlLqz3BaeusN
         CgYaC0A8DwYTIrWnzasramWd7Twf20g5bbldmq1u7MZl1mre/TWjs40zF++IZf773u2/
         udrgD0tlBb1oyP4LEgFHv10tR1TCbRhBh0s+QWzHiKT7SdFuNFFiIKE85ambk1ULa04Z
         1uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SyqGSw9Npj+t66UJ9DHTfIDA0VuuZ4vz3ZBeUa4vvd8=;
        b=KX7n5Bs45HFMSZBvgDWkH+1w+MGvpxqnwBC4GM2zB7fI7zoHtS6XCNuOU64Z12Zhyc
         hZoTgImfzBNjI7oWxvz84MAyebP8GTIdkOWNLjELVMqzmrDw6echP2I9+QPidYDkOyuz
         QMmDOJED/UE7EImWgO8kEOlcrvNmchfg0jmEgMlI/zciCBqgrss+FbjlM3TG6zn0Z7SH
         Iruzq2Ldp4ghxbSgBJt2c1o3SKjFPN06nBbPRUGC1zPn6bHlClCkwI4Edbwi9yBfiuV/
         yAnwajgUkb9FrgxOugzQ80EEVXmbOFYRp03Ku+GAAOTrZug4OzcOJFmrAS+1hLuEefSS
         6bBQ==
X-Gm-Message-State: APjAAAVt1hLXQr2nyNmh4CUzwLsMvVz6ro5xSyRt3BSayQQ98UV5bpJu
        ToD2//hweExIs1ruUJzGg4cSjBydVC7q2TOGshk=
X-Google-Smtp-Source: APXvYqyzSxGLs53eBkCAQgVr408iS3mQZ0Lk++8y23APyH/d6FTzw2eBX28NrpEqGQH/0HS+iGYGEyVzRYIYeUultD8=
X-Received: by 2002:a02:7e87:: with SMTP id g7mr905175jae.92.1551788630384;
 Tue, 05 Mar 2019 04:23:50 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <CACsJy8DhDe+28z2=3v1dBqco7q2Zj12hdKKT==yWFPui8SBkiw@mail.gmail.com>
In-Reply-To: <CACsJy8DhDe+28z2=3v1dBqco7q2Zj12hdKKT==yWFPui8SBkiw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 5 Mar 2019 19:23:24 +0700
Message-ID: <CACsJy8D=itd7m16BazCFjSgbPw1nQBaA_7SOZqpJS1N+njHSuw@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 5, 2019 at 7:04 PM Duy Nguyen <pclouds@gmail.com> wrote:
> Not sure if it's too late now. Anyway this could be something fun to
> do: support C-based tests in our test suite.
>
> ...
>
> I'm pretty sure I had some fun with this idea and made some prototype
> but I couldn't find it. If I do, I'll post the link here.

Found it. Far from complete, but it gives a general direction I hope

https://public-inbox.org/git/20180110090724.GA2893@ash/

-- 
Duy
