Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 563B31F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 23:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfHNXTL (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 19:19:11 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:42044 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfHNXTL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 19:19:11 -0400
Received: by mail-ot1-f43.google.com with SMTP id j7so2010306ota.9
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 16:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4Pu4nBBD6AZY1eelsy5m6+wPucZPsW0DqChRbDHUqY=;
        b=V+fzPHeuiftWUGv4ZpkDQApoBkNlBrYZxXG8jFzReMEhayle7rSzj9cteN8LnxvYa8
         ZW51KB5Nag61TCNHHEql0yIr6h3R/ZkLflK5lVsrmiEb775mKb9p5bfAOVGxpR186tbP
         RDbUunjUmLQiJ3yNLlmEpVG/xc8T0lCA6bVlJkHbRvxwcxmVaUb4cZeqRYPDYWXiDFDL
         T8a+55x/+eKyiTTNnqAencggYZyRXLWwqGDZLzGneAju3nVxxD2wT88EvYIIi4p5fGKa
         TiWoFdRH1OxtAsji/jn2sqkwo7PAb2Y2vNCLvtRbFQIty+DIzn79MGUpXFWLkyQ4YTKI
         Guvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4Pu4nBBD6AZY1eelsy5m6+wPucZPsW0DqChRbDHUqY=;
        b=amYZ6tKneinNprUIRYaFFjx5ETEaeAunF5tqL0Bti5HKNnT5nsr17sXsemge7uo43F
         RJV0zohD/I7SuD3rqD4vRN2Iw4IRGSHU488JFPbqayFQDR80GJKXpwZEtRnuvaKfH+RR
         Ze9kAIaRa2fd2hbf7QXcx/BZuVUnuVrrYeJqq0n/QeXVvNNFuhoMIxhySwQGkun2UjGQ
         V4/zedxPW7gQP0E8sgJjaYuPJhbtfCk/36/B2h/cij/ZZDlN59yDFWupadW6bwAmaDip
         O0yB9gasULurta2CBKtObC6ZIusgZ5MOwOJaCcJmIlFqKdO5Ot+rqTeRvHFQ7yt+jvSC
         iBmw==
X-Gm-Message-State: APjAAAVircpVlxk8PVTyEI6Lw1vdpqMTMX6NKOHJI0QKiUEuGXn7c7w/
        uzuQhVNDLKIVg2q5SIEsRr3iQZjo2hVb38K+aPhcQw==
X-Google-Smtp-Source: APXvYqwE5Nsfhuv30jt56mUqqi8YKF89kVNqBcK15AG1E0r+bExDX3zTYM71vWTI4q0xi/CBpM/w5C+FimPDHuALq6g=
X-Received: by 2002:a5d:9a04:: with SMTP id s4mr2625419iol.19.1565824750024;
 Wed, 14 Aug 2019 16:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36i35tfv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36i35tfv.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 14 Aug 2019 20:18:58 -0300
Message-ID: <CAHd-oW4kMr+Q1GhNQ7B7RW2hafqokvUoxg9qkXXyt98L53=Ahw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2019, #04; Wed, 14)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio

On Wed, Aug 14, 2019 at 6:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
[...]
> * mt/grep-submodules-working-tree (2019-07-30) 1 commit
>   (merged to 'next' on 2019-08-02 at e1a46a195f)
>  + grep: fix worktree case in submodules

There is a new version of this patch here[1], addressing the comments
you and Christian made.

Thanks,
Matheus

[1]: https://public-inbox.org/git/901ddbf6a1d9eeff51b1b2282ebefad51e61b12d.1564629070.git.matheus.bernardino@usp.br/
