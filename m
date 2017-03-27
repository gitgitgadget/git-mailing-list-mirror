Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F0A620966
	for <e@80x24.org>; Mon, 27 Mar 2017 09:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbdC0Jdy (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 05:33:54 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:37818 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbdC0Jdv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 05:33:51 -0400
Received: by mail-it0-f45.google.com with SMTP id 190so46008514itm.0
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lhki4c73StxDhb5MJyfTverbHuNUOtMKjnPwaGK3MhE=;
        b=K5tNvmk7X1G4sRH8ir+zBGu3pjTCDh5h/qIefAEvuyBrRwQ1WydpTNnXzbySTipa04
         hoR4Wm5x5VNYyPJcfu39YAghPG3v1hcuIDYtaQpZ6NcyL82+HPJjdhGUw3Z8EWAwUcxN
         H0TvKnKws6aMNyvaG28+en2WC7ZOtdBL1e8Rztv+FiJgO1vEnQNZwkzYloVVY/wjfV8j
         zpr/jTMF0KeqQ/CcOYyMhvt1wTHpUNslikQ7NbeJ74rivxYus/aYxxJQOSz05asY+FJN
         SSSbHSQaweb7Q5hz3Fc8ffxjJDwI62QpRsMWM98tnmOztMT4jQjnToxHD/YFkBsYuAE/
         eD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lhki4c73StxDhb5MJyfTverbHuNUOtMKjnPwaGK3MhE=;
        b=gLYtXakJVqP+48gzXEn+Y6C2oqUrDqwN5cny+t3MT20C4q0pMVN8obNBLVHGn1Z1/v
         BsSxOwSvgO0yIIhWgyKxOp9tdoztADdD4YbU6MSBJN/s19N7VL9XiH70+pJ0IF7uRXpW
         FZrjOe2vAMsbj69/WsCvX2Z7BM+MMvGspNMVkenf9W9h/FYNxn5W1z627VJhyZeZlNuy
         6IpAVWLlyAZeoDpE8dhHEyO5V82VIE61WjhfYcCe4i0ZH0FU4o1kAI8uQJAbB3UUHLWw
         MsnMp7QLGnnNE8WS62Rzf1RiVWbVKfrRQFk92nyUKDtDmyj6Jz8gyM0BPbR3r+tSf7Gy
         dlAw==
X-Gm-Message-State: AFeK/H3DQIMb8kApv1kEGTammOfaVzvA8NjeC+OA+3lHpe10kqBuWuFPFfXQ7++yZ6nGEWseikysHWvy70kojw==
X-Received: by 10.36.90.144 with SMTP id v138mr9494988ita.24.1490607206276;
 Mon, 27 Mar 2017 02:33:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 27 Mar 2017 02:33:05 -0700 (PDT)
In-Reply-To: <1490375874.745.227.camel@locke.gandi.net>
References: <1490375874.745.227.camel@locke.gandi.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 27 Mar 2017 11:33:05 +0200
Message-ID: <CACBZZX7HAg89htqPgkFd+ks-E7fcgAWfQ9n9qRj-YM88tj3t-A@mail.gmail.com>
Subject: Re: [PATCH] push: allow atomic flag via configuration
To:     Romuald Brunet <romuald@chivil.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 6:17 PM, Romuald Brunet <romuald@chivil.com> wrote:
> +test_expect_success 'atomic option possible via git-config' '
> +       # prepare the repo
> +       mk_repo_pair &&
> +       (
> +               cd workbench &&
> +               test_commit one &&
> +               git checkout -b second master &&
> +               test_commit two &&
> +               git push --mirror up
> +       ) &&
> +       # a third party modifies the server side:
> +       (
> +               cd upstream &&
> +               git checkout second &&
> +               git tag test_tag second
> +       ) &&
> +       # see if we can now push both branches.
> +       (
> +               cd workbench &&
> +               git config push.atomic true &&
> +               git checkout master &&
> +               test_commit three &&
> +               git checkout second &&
> +               test_commit four &&
> +               git tag test_tag &&
> +               test_must_fail git push --tags up master second
> +       ) &&
> +       test_refs master HEAD@{3} &&
> +       test_refs second HEAD@{1}
> +'
> +

Sent my earlier E-Mail too soon, so I missed this, there's no test
here for what "git config push.atomic false" && "git push --atomic"
does, is that atomic or not? I.e. what does "git -c push.atomic=false
push --atomic" do? Does the CLI option override the config as it
should?
