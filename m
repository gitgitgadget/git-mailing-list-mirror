Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3DAD1F45F
	for <e@80x24.org>; Fri, 10 May 2019 00:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfEJAPI (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 20:15:08 -0400
Received: from mail-vk1-f173.google.com ([209.85.221.173]:37284 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfEJAPI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 20:15:08 -0400
Received: by mail-vk1-f173.google.com with SMTP id o187so1050212vkg.4
        for <git@vger.kernel.org>; Thu, 09 May 2019 17:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=syWJScqxQqqSzKRj/hYGwX0Lhzq57H+Mr3KL9uwJxVM=;
        b=O8lNwHZZi12g/AvX1sjkZghvcpzM18YHy5fZ61iFaN3dQetwzAG64IIoWvDn5I4K4s
         RzTXuq8CgpaAHkQarVrsLCR6khmC3wyr2m4JHo83HUJotS/FppuDnniKCBmIyeH6YpuK
         Fj+Ox48bQhLYCPyJceYXcnop+Q+uUQx2QZfAHNf9015IFAPWrfMDKSY3zk4nz9gznCsj
         pZ/eDQnMhAjbYyzhkQz1LVa0tmaryVuxquS6zG/DtU5vPKmMiKDn+r3s7kAs6gMLgKuO
         CMpXbpdtYznkdKu0gbP6IMAH3F+NZ8czt5VKviCFwNuTcRTKOt8GHbKRklVfQDuGSxC0
         xhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=syWJScqxQqqSzKRj/hYGwX0Lhzq57H+Mr3KL9uwJxVM=;
        b=NqF0XVxB5CadfUuRJEIMaao9qnD6A1GavtNByKvAlcmIsRJE7LW51kqj+SOFKZ3J4f
         Kx5FCyhGrG2rsRHM67DOuoSLJbFd3rZG0lSKqtKA0AvI0uOd4lk3D1ohAqVIa2VzfVv+
         Yua+LZv8LtV7wH9pkylqPwAYf62+qk98cmTeIt0GCaIHXl8XLR7Nhf+0EchE5fAmnWGS
         bhMv87ztJaSnpsYRAM2FnetSpwKMqhzweik4XdTF2uyrbri6iirFMYMcFzq00Y0qlfaN
         6VdbZlIDZfWDjsFxVyDFVz/pj0UCb7uFaGhJGClPg4Oy9qZEYbDcRKmBrr8Q8/rDiMEk
         SSZg==
X-Gm-Message-State: APjAAAW1vn2nW8uLITzre64Zd0T3yrXP+NLmsuznEcgXZSSN9qwD3qK/
        /uzHjL8gjykMWUZztr7GpQrbo+Aath/2okF19Os=
X-Google-Smtp-Source: APXvYqwH5j992vrAsAtkJbisEoNoXJMbwrE8lXO3e8pDGlRxlNRo0VV7goqBRcxq/BvyM8cYyDy2/fyi1ZlFkNbhYxI=
X-Received: by 2002:a1f:104d:: with SMTP id g74mr2634378vki.1.1557447306932;
 Thu, 09 May 2019 17:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905092243080.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1905092243080.44@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 May 2019 17:14:55 -0700
Message-ID: <CABPp-BGfLrggLTmo+9LuLH_iGJoRNv7SHATw4XQCNx4Rk6wc7g@mail.gmail.com>
Subject: Re: en/fast-export-encoding, was Re: What's cooking in git.git (May
 2019, #01; Thu, 9)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Thu, May 9, 2019 at 1:46 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Junio & Elijah,
>
> On Thu, 9 May 2019, Junio C Hamano wrote:
>
> > * en/fast-export-encoding (2019-05-07) 5 commits
> >  - fast-export: do automatic reencoding of commit messages only if requested
> >  - fast-export: differentiate between explicitly utf-8 and implicitly utf-8
> >  - fast-export: avoid stripping encoding header if we cannot reencode
> >  - fast-import: support 'encoding' commit header
> >  - t9350: fix encoding test to actually test reencoding
> >
> >  The "git fast-export/import" pair has been taught to handle commits
> >  with log messages in encoding other than UTF-8 better.
>
> This breaks on Windows, see
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=8298&view=ms.vss-test-web.build-test-results-tab
>
> Sadly, I ran out of time looking at it in detail.

Thanks for the heads up, and for taking some time to check it out.
The error doesn't seem obvious from the log.  Does Azure Pipelines
have anything like CircleCI's "Debug with SSH" feature[1]?  (Where one
can click a "Rerun job with SSH", and it'll restart the pipeline but
also print out an ssh command someone can use to directly access the
box on which the test is running, in order to be able to investigate.)
 Failing that, assuming I can find a Windows system somewhere, is
there a list of steps for setting up a development environment and
building git on Windows?

Elijah

[1] https://circleci.com/docs/2.0/ssh-access-jobs/
