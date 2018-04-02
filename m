Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 423C71F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932426AbeDBUIS (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:08:18 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:51268 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932228AbeDBUIR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:08:17 -0400
Received: by mail-it0-f50.google.com with SMTP id b5-v6so9503217itj.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zf4IfLi+O221IvZIAHv3YQFPaphk4orhBJaMhC+z6kg=;
        b=E8XU7bI3/QoojjoFTgWucMUJQUeCpzIwK75zYMzihMUKXqJqJRySRbQzAQ3ryKQxIw
         ywHxbmv1Q5SM0M6LJfkhe/04z1KpE8cWg46/ahxNq+ho/vioYDCqio1LY0rb+rPnNh+2
         iSWB/He+/jfWMYmGGCV7d2g/jKLCnoEklbYQ5iyYoC1xfqYNpqQQG3eaQN9LT40W2Fv+
         KELLX+52hEDJqI2NCerjtLPHKoWKOlG7pdgSN8ymZc3c5tSjGTUf2QWj1tPGNtmlSREg
         iDXuaQYpiloCUn1iOi+Ln/NNgSI9DcASmp62IcY46QiX6y/+P1DLnbdj5RfTZ6mP76j9
         WYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zf4IfLi+O221IvZIAHv3YQFPaphk4orhBJaMhC+z6kg=;
        b=D3JPb6feNADHTTRNucvpGNgIe2zsz7A6sXLjb5US1bRRtjVvlf26WwtFdZ0EtpOrDD
         btB3rjx6ZnIwCPZabwfiYnE7JdUbneUuW6ruNNkcP6QItmieRntXpWskxYGxNAExxFeg
         ZJQ3nfTGS5CcjwLQfVRw3gvBZBlQZNOu6cv3mUGnU2OS8GyPg5FGl4oSMhcyMgwCDuxj
         EC440xOJNyF7OFCpYSNLMcEdYxLgUfVIUTFKyuK8geiz9jn++dM9UJXXVEOlCtCTyZSz
         dsg6R+xSJHA8RZcygzuPREWXsNMAM6eTMpSP38IQvH+yPlAKp7uN6s83EjmHg0zBULrL
         rdMA==
X-Gm-Message-State: ALQs6tD2rRkn+EzxWRewZmbya4MXmsg7nFQC2wmq7307II2wv8Yd3uVv
        lb/0dHBkJ8L9iUXEkjPuQcZyXeFOJfS8lDDbZh8=
X-Google-Smtp-Source: AIpwx49AOfm/SyMC4wYU4vR9N1a7vVunrhmtsTOg6nSRFGsKtA4t/WwqEvjpv0YNohlYHku8E5IRz56ma/Bh7sij+FE=
X-Received: by 2002:a24:fe87:: with SMTP id w129-v6mr2405146ith.35.1522699696871;
 Mon, 02 Apr 2018 13:08:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.85.6 with HTTP; Mon, 2 Apr 2018 13:08:16 -0700 (PDT)
In-Reply-To: <74BBE628-B8FC-4699-9A23-F774D4908011@gmail.com>
References: <20180305200400.3769-1-sidm1999@gmail.com> <89AEA176-2D3F-4271-958E-1C6BCC944842@gmail.com>
 <CAMOtk6Df_7Jb9bX=8PfB9e4-5rRi8QSmXEK7=DmZui6LNBMSLQ@mail.gmail.com> <74BBE628-B8FC-4699-9A23-F774D4908011@gmail.com>
From:   Siddhartha Mishra <sidm1999@gmail.com>
Date:   Tue, 3 Apr 2018 01:38:16 +0530
Message-ID: <CAMOtk6D9AtzNpufnv7hbCUAVYVgTiL-O_Ni=R0DB4LOHUNV=7A@mail.gmail.com>
Subject: Re: [GSoC] [PATCH] travis-ci: added clang static analysis
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 1, 2018, 8:10 PM Lars Schneider <larsxschneider@gmail.com> wrote:

>
> That's a good summary and I don't see a better solution. While (3)
> sounds nice, I think (2) is the fastest/most pragmatic solution.
>
> We already use the Travis cache [1]. You could use that mechanism to
> store a file with the latest number of bugs in the cache directory
> $HOME/travis-cache
>
> If the "number of bugs" file does not exist, then create it and don't
> complain. If the file exists and the previous number of bugs is higher
> or equal, then don't complain either. If the file exists and the previous
> number of bugs is lower, then let the build fail.
>
> Do you think that could work?

Apologies for having sent this message twice, the last one wasn't in
plain text and were therefore not properly forwarded to the mail
group.

If we only consider the number of bugs in the last pushed commit, a
situation might happen that a commit creates a lot of bugs. If a
subsequent commit then fixes only a few of the previously created bugs
the build would still pass since the number of bugs from the last
commit has decreased.

Should this be the intended behaviour or should adding the number of
allowed bugs be a more deliberate process?

Thanks,
Siddhartha
