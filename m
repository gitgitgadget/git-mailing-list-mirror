Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1003B20248
	for <e@80x24.org>; Sun, 17 Mar 2019 19:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfCQTVR (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 15:21:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44097 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQTVR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 15:21:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id a3so9728450pff.11
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 12:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r14oc6qeK7482C7X9PT0nSJSee17yu/iIVx6dPMvi+w=;
        b=q85divu/ZpnW8KuBE0hK0gdDfe1rFPGDQAArfMnQfEDIud4R5AVaaS/XW0Vn532jXm
         /b8NOg83a+kRyjfgQxV2Yh0Mg55FKPduDn8XafuVOubvdiRg8i/dwFA6skluYCFMXKas
         B2LHhpmBNmBJscX8GJAIUtu+/mnI4Abh1Am7/woA4Da1/Mc5h1JQHC5ZP2Co4h+mCgzb
         Iidv1bqoL9oKR+dJhhYrIgxvpmf5KOlHENAqMNfkGXProXGsd1M1wMYr9y7KMdzO/HGK
         r601UeQPmhxfiZASRR6n+Co7obfWlZbzkAq1BFCH9bSK9iBBozwbFIxaz6DqIhS9w0RA
         35ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r14oc6qeK7482C7X9PT0nSJSee17yu/iIVx6dPMvi+w=;
        b=QuPOZDIABCqGutm8g1TStu9SowodofzoPWyjVGNkiFRF74e75LJu4PFmZzM9xLAsXq
         7pZDQ+YsC9JglW2BstkYqhvYiZ3YQ6ih3lD/wmMdLlLRi3SLF8UpdwwplgwvQc7pa1xg
         j861ETb/WASKEEZPxntPNMp4rJfN9V8m6Avf3Z2WnaasOvckiNv4WYU+Pan9hCmnypks
         nPxZ6FQ1qRGzy7mHkqXcHjAZ2+ThlQk8AocFQTdRymrwO9ifksybwiQRSDYWCMf7Ge5L
         Lkxff4akbinq5DE1h3ubi1LtRuF2blg2fjEPEh2rY/sQzCvpuQU5k9ITgi/PeX6lVZ6M
         7+GA==
X-Gm-Message-State: APjAAAXjBQVEhIAOuFjFZjUhtQmXMFSbsHh3JAESP3jUBgrE2peaLKkc
        ik8ToIX6tFlfe2yb1AdDcUgkMHYJqMlOHYxqpSI=
X-Google-Smtp-Source: APXvYqwVBs0Id/Mz+EEzHdZtU3RU4xQkubWR6l42w1dbN4X0+CSb8iKoo459QALTc29NAsw/lrRkCSoxuOl5Rg5LItE=
X-Received: by 2002:a63:f80f:: with SMTP id n15mr14101850pgh.283.1552850476879;
 Sun, 17 Mar 2019 12:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190308095752.8574-1-pclouds@gmail.com> <20190317124926.17137-1-pclouds@gmail.com>
 <20190317124926.17137-5-pclouds@gmail.com>
In-Reply-To: <20190317124926.17137-5-pclouds@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 17 Mar 2019 20:21:05 +0100
Message-ID: <CAN0heSockAdYiNeHtx+AJVH2cDKj3Q_BfmrtVtiBMxhGbaxUWA@mail.gmail.com>
Subject: Re: [PATCH v4 04/26] git-checkout.txt: fix monospace typeset
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        Jacob Keller <jacob.keller@gmail.com>,
        phillip.wood123@gmail.com, rybak.a.v@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Mar 2019 at 13:50, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pc=
louds@gmail.com> wrote:
>
> Add backticks where we have none, replace single quotes with backticks
> and replace double-quotes. Drop double-quotes from nested constructions
> such as `"@{-1}"`. Add a missing possessive apostrophe after the word
> "submodules" while at it.

Assuming you move those "submodules" hunks from an earlier commit, this
last part needs some tweaking since you're not adding a "'", but you
actually rephrase the docs to avoid a buggy AsciiDoc rendering. (And if
a while-at-it needs too much explaining, maybe just skip it altogether?
I dunno.)

Other than some things appearing in the wrong commit(?), this matches
the "how about this?" I sent for v3 and our discussion of that.



Martin
