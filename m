Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463E71F731
	for <e@80x24.org>; Tue,  6 Aug 2019 02:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfHFCym (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 22:54:42 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:45123 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHFCym (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 22:54:42 -0400
Received: by mail-ot1-f43.google.com with SMTP id x21so23392973otq.12
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 19:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w620PdKNxtNDY0JFVNSUjuamkEVXDcvq7EmmaaqNGzM=;
        b=Anc0sULwqeLL5ukR6xTgBRCQaYBwQcYhylV4Hcb2C6OoY4wreewUgwTeOMzDp+PCeq
         NF80XHS8kBI28yvUfMlGXKMjbeNp6bRt1/eqwEQQQYT36Ya6Dc43lKMGYNUbhL5CNO4x
         wdS7/N2Ii0rYmMASnGPmwSkzGKijulOFL/iL7NY8Xx5Wtd4hfkZfn42LwcEx4I4mtb+x
         WoEXQi4Ef8BJpkya11hh6Awl0AUdROQkHEaR8J8tMc9Qad0sPm7bXmW1x2E3RrFPYph+
         kRd9QAketprTMieVS/zCUbXkdfqbnyHAA/WH/ugBZJPx9vgS5Lvr1xUsBgWUsdT8RjxZ
         1kHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w620PdKNxtNDY0JFVNSUjuamkEVXDcvq7EmmaaqNGzM=;
        b=ZrtVteZLSc9lmJY2nVdqrDEqfwJzAxoW/MJpZZ2qu1Wyd912kTeP0XYRKj0DQN0ox9
         fExFPdoRlzNBuIuH5MTe+8e+QmTm0aKaIqwKndz+h1ttUsRcUDUYgnjwlzLMWcV4dn8H
         laDhJmsJ8cU7FpLGNkzW9Wv/7qnUqBAQP1bpLy7brUWItRNL/igyDUBbJzYH4pIYmkXS
         Ll6cjaeqnMF0EBhONDkLDP7DEdUWJGjrv69bDR+AaFHFMpoNcU+GqYYVSYmGQuj9zDFT
         mRTeiZgLeow0qC1OD5I7QdmgCkYTPNvyptoU+TEqqgpf6i2C2jCB0MzRKzICtMMJtgTZ
         2pHw==
X-Gm-Message-State: APjAAAVKdA7ULxtFRl7yAUcUq2mQ7ET6oAYkr5E+jkwPsEP2BgHFEVmW
        ftxHt8FIfY+8vneFr/ZAda5RTBixDW06Av2SHKWiOJYTjjc=
X-Google-Smtp-Source: APXvYqwY+Xoz1VMFIDpxE7WKdveQMOdL0Xe3pH2GsHEMq8x9URSi5g16WMoNC2rY3gW+0yQoLQxR3nAlhG7zNHJ5QeU=
X-Received: by 2002:a5d:9711:: with SMTP id h17mr1201873iol.280.1565060081137;
 Mon, 05 Aug 2019 19:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
In-Reply-To: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 5 Aug 2019 23:54:30 -0300
Message-ID: <CAHd-oW7pT=RhsCnkhRzGDy1gXWN7a4AnwdYCNa6q6uri1O51FQ@mail.gmail.com>
Subject: Re: [GSoC] My project blog
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here's my report from last week:
https://matheustavares.gitlab.io/posts/week-11-wip-grep-protecting-textconv-and-submodules
I'm working to protect the operations I left behind on the first
version of the patchset[1]. And for that, I used a lot of the code Duy
provided[2] me as an example in the early days of this project. The
race conditions are now majorly gone, but the patches still need some
refactoring and there are still some problems to overcome.

Thanks,
Matheus

[1]: https://public-inbox.org/git/cover.1563570204.git.matheus.bernardino@usp.br/
[2]: https://gitlab.com/snippets/1834613#L3
