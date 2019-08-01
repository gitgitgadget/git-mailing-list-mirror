Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7531F731
	for <e@80x24.org>; Thu,  1 Aug 2019 22:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389857AbfHAWkw (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 18:40:52 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:39552 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfHAWkw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 18:40:52 -0400
Received: by mail-io1-f45.google.com with SMTP id f4so148030535ioh.6
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 15:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMGyAnMjXNswkvsaMucdgvAg/aTHGjS2X1+2ubg591U=;
        b=vDcBeK/l6qf+l1D64ABRB3HzyMnTG9cuMZF+dQphYZ7zuBCnMxVBdUdJk60edh4Gy9
         3HgqlB1RRhO9aUkpuRcOC26ekJ9IKIf881vmJOXiJkfxizdaP1tnnlxv3W0sfxyIMx2Y
         jQREek10M2p83sj/yk6f+bgcQ+vyvUlDXpH32oZ2WYi+GNq50QMR5xp3411rd9S2ZA8u
         b7S/9dvf/EQjj5kurue3T6FohsPMDz1NHCZCnSNy6PyR4bVqKOvzVlK4Y5bcNe+1Am44
         D2JaAi/d5KLLtIrLENqTQB25CEiyrMBkbtYQLEc3+jqOejVqYgvO3pvDtJnW7KczKJQc
         xMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMGyAnMjXNswkvsaMucdgvAg/aTHGjS2X1+2ubg591U=;
        b=DU1Yxiy9y1FCdQICfP91Wwd8r0z16AaYRnjGt9Fgn9+XRzAupvWCTsmfTCBgF2y4No
         LxXLAa7VEKE1v/2QnCkwqShjjMQizTRdBinEYMoKV1Uxt5rq8NIabtr/PXrHhaTDgkMk
         QIOfAqXXhpcFYAndZTUf4JdT6F8JETrv81QjLCJaM+530yiwWdQilcUjJsR6NocYbvQt
         iUxBoLr8PIhsw3mR2hXn5WhQ+wcwfkJMJQShCjxZrAKrbAIjdNbPTdTgsSunauQm7YfC
         7SJ1GVPwANKyGkcOEv/BUoQPFDe2GEqkxiZEAl8jmcBf1xVPi9jZhRtSFM9vaMuwRvvT
         uH8w==
X-Gm-Message-State: APjAAAWPLy6K//PNj9efhrPky4FDU+ClsLLPg7Qe5xC1//dV+oVQuRSn
        cOFQD3FugKKZEpj/vIetiBt7GKESaVFjzVbtQmWRZEo8uak=
X-Google-Smtp-Source: APXvYqzhLiisq/ulXvNIhpNbQ60VmcIgQOyuoamBAhRAd4WYtFwAQDPNKjpQji57JDXfD8mDBrydmknkYxITvS+GsHU=
X-Received: by 2002:a5d:8890:: with SMTP id d16mr72867132ioo.274.1564699251043;
 Thu, 01 Aug 2019 15:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <CA+KyZp6mYx4C22syAu=W2Okf7tDwtQ+7vVUBaQ-2D70PTS+GaA@mail.gmail.com>
In-Reply-To: <CA+KyZp6mYx4C22syAu=W2Okf7tDwtQ+7vVUBaQ-2D70PTS+GaA@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 1 Aug 2019 15:40:40 -0700
Message-ID: <CAGyf7-F2qs2=51hdA-1BB=12w7GiwaVZ974eYKFzu-=OKj8Q=g@mail.gmail.com>
Subject: Re: cannot clone --single-commit instead of --single-branch
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 1, 2019 at 1:52 PM Alexander Mills
<alexander.d.mills@gmail.com> wrote:
>
> Looking for help with this problem:
>
> https://stackoverflow.com/questions/57316783/git-clone-single-branch-does-not-work-for-sha-commit-ids
>
> Essentially looking for:
>
> git clone --single-commit

There's no such option, which will be why it doesn't work. I suspect
the closest feature is a shallow clone, performed using git clone
--depth=1. That's still not going to allow passing an arbitrary SHA-1,
though; it'll only support a branch name, the same as --single-branch,
which --depth implies (unless --no-single-branch is specified, at
which point it fetches the depth for all branches).

Promisor remotes and other in-flight changes might help provide some
of what you're looking for, but I'm not aware of any already-available
solution. Perhaps something like VFS for Git, if whatever hosting
solution you're using supports it.

Hope this helps!
Bryan
