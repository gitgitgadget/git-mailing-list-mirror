Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B94CC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 21:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A1872083B
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 21:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgJEViH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 17:38:07 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43590 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJEViG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 17:38:06 -0400
Received: by mail-il1-f195.google.com with SMTP id t7so3989400ilf.10
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 14:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nb9+ks3qu/R94j2f6HBgT9U3BgbTNUcfbPuPUyoyOzA=;
        b=hTswVlU38HYOfnHLyBii65ITo4JcEEJ8j7vmc6SRlsaB6vDadVIj2XoSqfmmhmJpMp
         BgeMpP/k3QpjmBOn4SuejIhCZvXx1i6eeWBGLOMP8KZvSoJ1kpqnDeOKzeNLOXBQvHp+
         5U5p2DXi4rbp+OQ6v6rVWIBE0fmVFyyTNB6s9+i0LqwLRy3JTxAS4IrX6sgmQjHyInS6
         R5lng1xyvZASKtHMz8JaNwRsWSh3mSg0K3I9zqg/WBWTWXzE1H1AdnysjpQXjjKzgDlz
         8o755S3AJXoYqv+0a1jaIIuDAkf6c5b5enRcHZR+fB3Jojzvv70i7hbOzBw+80aYaQnF
         UEVA==
X-Gm-Message-State: AOAM5313TivQy65nOMvo+4RZb1zutT+XUStju284l+WRnqkRk/Agr3KO
        PAVXQ30kYAzXtd0tjhQ3Xb14MvfHddbObdybM1c=
X-Google-Smtp-Source: ABdhPJxLqT+2671CfZzYMjMG/u9jfZCcjmH1MJNWpMtxFU+aTLXEo8JSbcbdgSfLmZzrhdlqE+4Au+utD1/cms1gy/I=
X-Received: by 2002:a92:6711:: with SMTP id b17mr1214170ilc.100.1601933886219;
 Mon, 05 Oct 2020 14:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
 <CAPyFy2BsFLZZeEY=54evEJwed9q+Dc3TX3s1O+cr-nqwjCRHvg@mail.gmail.com> <nycvar.QRO.7.76.6.2010042124320.50@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2010042124320.50@tvgsbejvaqbjf.bet>
From:   Ed Maste <emaste@freebsd.org>
Date:   Mon, 5 Oct 2020 17:37:54 -0400
Message-ID: <CAPyFy2BeHnacdqd_C8BdPntsN7FCoTciL+s8fDXGhBU0H01FaA@mail.gmail.com>
Subject: Re: [PATCH 0/7] subtree: Fix handling of complex history
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Tom Clarkson via GitGitGadget <gitgitgadget@gmail.com>,
        git mailing list <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Tom Clarkson <tom@tqclarkson.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 5 Oct 2020 at 09:18, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> FWIW there have been more comments in favor of this patch in
> https://github.com/gitgitgadget/git/pull/493.
>
> I guess what this patch series needs to proceed further is an ACK by
> Avery?

Avery says "if it's good enough for Johannes it's good enough for me"
https://twitter.com/apenwarr/status/1313231132721401861
