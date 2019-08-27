Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A98C1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 03:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfH0DEE (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 23:04:04 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:39288 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfH0DEE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 23:04:04 -0400
Received: by mail-io1-f46.google.com with SMTP id l7so42794167ioj.6
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 20:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TlBQm+DS2K2W8dSt8qx5AxcWn9O5xWDzDjiV4aUICro=;
        b=Ve23OiVA1mHWZPq3yNpQpD9cFLRoDMXPF9ZsSnjrlTUJ3pdCWJQQOhzIwsltSr7F8E
         jABZMZLkObgZn9hd2p7lDC7vnCEfHv+qOVMSJE4ZRjMvhbBhzElyVn/yWf7g2pjUfbYt
         u5IkFTKMEAnNJnRrMIfaP5VJbFwzpS2Sl8XN4ElHEhR4sF3tG5nLmE/VTKGZT28uV1um
         qI2q6xPihMtRdEZfEG/vUH9Lzjs8AjqtHtLNaPlQZVbBNFwrl/ozpcvznLBLnB4xwiS6
         yLwUEjKUjnhIBzrQQ5H0WXX+qY3x/bFSknKldCCuPNg/xl3tdkxsMgZNoRZEXSTuRHNZ
         pUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlBQm+DS2K2W8dSt8qx5AxcWn9O5xWDzDjiV4aUICro=;
        b=J8cXMqFnY744S2IgdlR+29A/a0S5yTPcXKCQSt5RuAxzrJRqDPmeGn1t8goh/BmCZB
         9rTemfAhi52ZZFcOBXzKE/tgqGOmIueEjFpQXxpULj1kDvV5UlVJ//dlSwk7R1SXOnlF
         6BRkioM6qUqzprVCkZwcpU8p+DZ1KVu45guB5/quXSfpZ86UoduRV/DY6kBaAj8QuhDk
         H+Bi0q9tXGVDV3BNNBOdMQUaYvapcjBVCTAtkpZW/9CctdUL7UhAFkDtSWEQTzC6Hy2v
         RFuBocg4yZQiFd2ZmQLK6DM3tiIIrxEMGBbstSIoJMwPlS7Sb1/XxWNmas2IvrFa622j
         2ADQ==
X-Gm-Message-State: APjAAAURMQGjwD5ucuwqDP8fs8GK6SDEpo5MjvcXNOuql+ivjd5+9p6c
        C+rybFNGUMF7MjwyrFGx0rBzyhCUCibrIgTYDWRMqIzmJYc=
X-Google-Smtp-Source: APXvYqw718RFn11fPicPc8WTTgOQlx4RD29R/M2w4Qn37PQSGzT32D0aR1A8p5jdP3OxcC4u/EpshkZ7XfQw+7HjWzk=
X-Received: by 2002:a5e:d70a:: with SMTP id v10mr987566iom.19.1566875042871;
 Mon, 26 Aug 2019 20:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
In-Reply-To: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 27 Aug 2019 00:03:51 -0300
Message-ID: <CAHd-oW6rK8uwX9TazVi30oS_cGqWvaYoKMU+TsKyhp3qKaFjqw@mail.gmail.com>
Subject: Re: [GSoC] My project blog
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

Just wanted to share with you the final report on my GSoC project:
https://matheustavares.gitlab.io/posts/gsoc-final-report  I plan to
continue the project (as it isn't finished yet) and keep contributing
with whatever I can :) Thank you all for the support during this SoC!

Best,
Matheus
