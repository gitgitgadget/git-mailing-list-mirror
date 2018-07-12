Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3721F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 02:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbeGLDB0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 23:01:26 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33692 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbeGLDB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 23:01:26 -0400
Received: by mail-lf0-f54.google.com with SMTP id u14-v6so22939989lfu.0
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 19:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=bFjiym6U2TyIG4MlHvwAaM2I4QHetNh8+GzX+qtLZ2U=;
        b=G2hprO+aYrR0s1ae1AltU05RlvNQXxdt0q8GS8DPAFU2MF0zQ5MpyuxEwwiwYbmHsc
         gO2ZGGvetosIL222s9b4QPMhlOGA8UMwACV2EeAkB75u0Px9aVdOzX5bppoQD4PQCwpG
         oUi7eR1/0Qawyp65HkKbdw9dAJ801pMwURApGeK6XXCntkXRw7+BzpASlA3GglmvJx18
         quOAmmUMXT0uGmLZG9LqLxsnRHH5EAZV4sAQVm9yc0fDv4ePwOAY2LfUKG5+tTxYuKp/
         SmREFZMVv+EVdib3PLaH6lAjYJqXSK00h8y5OB6q/Y74sWruDGXXb1t8blrwUPTXEyZh
         xSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=bFjiym6U2TyIG4MlHvwAaM2I4QHetNh8+GzX+qtLZ2U=;
        b=qFf/2GJa3IW50NC5j11AJK5dQ3kTADVkwivJeCuDpx60drwy4au8s6AoVbTuVakaxc
         4hv0kPzqAEjbCAxEOwn6SVhR5/KyWIjUQGdb2I08HziX9JPTP8V/W+8IFKcYKD6jrD83
         UZqw26vPbq5fmh82NL2a10w1ta6JolX2fHho4qY4jCAxKZYYIcA06AnsL7UWkodwVFRG
         DkxCnfpIUsBF+LokZ5sWVaTS8S7lg8bz7n1iabaAAypyXXjhtFnW7UzGRLRvOgUx1YIs
         Y/1NUtZlZGJL+VZqmkNVuF2/DYH5EvrCxINlvcDLjKJN9oWxkZXJJCuOaqzxwbXqDRim
         PM4w==
X-Gm-Message-State: AOUpUlGKM0wlFlhP7dkjwatmSWtRMD0buMlVuJNhfj8r5XUccBURqDa0
        YHhokkEy6hX9NBgN5UJIgdUVpuh5VstazXfj0nfAMdFa
X-Google-Smtp-Source: AAOMgpc0cuFFuBYf9GOLEuponEeJQox4Pc3vaetabX6R1iKjsXyVDrRnqwjhK8krQdcMNxgYb1PWVSyv48DZQxRagrY=
X-Received: by 2002:a19:a2d5:: with SMTP id l204-v6mr258226lfe.65.1531364044819;
 Wed, 11 Jul 2018 19:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com>
In-Reply-To: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com>
From:   Vitali Lovich <vlovich@gmail.com>
Date:   Wed, 11 Jul 2018 19:53:53 -0700
Message-ID: <CAF8PYMikJZF4Qk4VHhAUPB80LG=gjZBVNBu0yGKCLLPpdG_3sg@mail.gmail.com>
Subject: Re: rev-parse --show-toplevel broken during exec'ed rebase?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry.  Forgot to include the git versions I tested with (2.13.1,
2.17.0, 2.18.0)
On Wed, Jul 11, 2018 at 7:50 PM Vitali Lovich <vlovich@gmail.com> wrote:
>
> Typically git rev-parse --show-toplevel prints the folder containing
> the .git folder regardless what subdirectory one is in.  One exception
> I have found is that if one is within the context of git rebase --exec
> then show-toplevel always just prints the current directory it's
> running from.
>
> Repro (starting with cwd within git project):
> > (cd xdiff; git rev-parse --show-toplevel)
> ... path to git repository
> > git rebase -i 18404434bf406f6a6f892ed73320c5cf9cc187dd
> # Stop at some commit for editing
> > (cd xdiff; git rev-parse --show-toplevel)
> ... path to git repository
> > git rebase 18404434bf406f6a6f892ed73320c5cf9cc187dd -x "(cd xdiff; git rev-parse --show-toplevel)"
> ... path to git repository/xdiff !!!
>
> This seems like incorrect behaviour to me since it's a weird
> inconsistency (even with other rebase contexts) & the documentation
> says "Show the absolute path of the top-level directory." with no
> caveats.
>
> Thanks,
> Vital
