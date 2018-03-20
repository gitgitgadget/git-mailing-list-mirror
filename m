Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12431F404
	for <e@80x24.org>; Tue, 20 Mar 2018 22:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeCTWIk (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 18:08:40 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:35990 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCTWIj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 18:08:39 -0400
Received: by mail-it0-f46.google.com with SMTP id c1-v6so3425834itj.1
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 15:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Inca6rDYnPtsbiZouoDYPTUMPFUsrM+Fhxk3dTbZLzU=;
        b=Jt1/f5dSxuW7WkAqfs9nJNUfLsqIa+PPk/2OYbJolfAgir5yGgWXZYyjFlDoZnGGfk
         PsEV1vz+RBEaWI9uIXpeYioxKiJG3eDMSZ6mmKFXnkKWXVVHgpBe6FhRrPsF8vPYRsQO
         Ctkk9qi7G0Jyt6mWh0NmejHiZeGbpphEffCaPSZakJ8pATDGUvLnhhSBI8qifM9WVKsL
         Ev73kcvO8HyLeffNgRa8UznJtFfVFxdRT6XYMXLv85WxmnlvuDdEOeqj50n42G7NG9f3
         wmtyiciJvwikJn8QJyD5gtCjermhCBBU2+v8fk0aY9Z4aR84KbtdIK/9r53lyL08aL8e
         U0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Inca6rDYnPtsbiZouoDYPTUMPFUsrM+Fhxk3dTbZLzU=;
        b=CrOwSTnLrGwmMdQr1Pq8JM7XGP/d4VzFRi9bE28qk2SXf6G7Xtvodd98qykEDhVFun
         bg55gzkraEEwQ8MgKgP/zUv+GKpnDhM/aptJsa3uKFXFvakOcsc6zwJ/RRG4YTkmalTa
         pAOjlrS+AzVcfdNKIx2GGJL+TEr1HJa4elMsDsrb6I9PrRBda9NOZQDi5PgcKshbs3Ec
         2mGIjPa21Bpr8vPFcuFQ5kKD/qBCNIfmLGBdCX+ClaAKChPJnyFqUEmyxDtUqn98eUfl
         KXFRi7nt3VEWQCbgzhF1nD4go4JbKokvSimz95yFf7ie0+7UoxnKmGPoZCoTubtsr6+/
         uC+A==
X-Gm-Message-State: AElRT7EWYL6MBxTC0eF/thSvYlE8/cYSnpKZOFLT+y770mbMkTUugIpa
        vd3dbL4/xPL46UCgwbRRuiMD2b105e7dwUv7HYQ=
X-Google-Smtp-Source: AIpwx49JWIsPIrtIc3c3qxztxxZFvWsENd9XHqFxiphbtktaSD2ytwPCQfjHgczWD9ryNR5u7K/wjObKRwJzjtjvOFQ=
X-Received: by 2002:a24:db89:: with SMTP id c131-v6mr1522910itg.129.1521583718238;
 Tue, 20 Mar 2018 15:08:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.146.25 with HTTP; Tue, 20 Mar 2018 15:08:37 -0700 (PDT)
In-Reply-To: <1521576562.2188.10.camel@gmail.com>
References: <1521576562.2188.10.camel@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 20 Mar 2018 23:08:37 +0100
Message-ID: <CAP8UFD3NKCSN8mVDiCUzvor5uZh4nFCAw4T0zgxpvHLf9AWmyA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtHU29DXSBDb252ZXJ0IOKAnGdpdCBzdGFzaOKAnSB0byBidWlsdGluIHByb3Bvcw==?=
        =?UTF-8?B?YWw=?=
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Mar 20, 2018 at 9:09 PM, Paul-Sebastian Ungureanu
<ungureanupaulsebastian@gmail.com> wrote:
>
> * Convert function: this step is basically makes up the goal of this
> project.

Could you explain a bit more how you would convert a function? Or
could you explain for example how you would convert "git stash list"
below?

> * Ensure that no regression occurred: considering that there are plenty
> of tests and that I have a good understanding of the function, this
> should be a trivial task.
>
> * Finally write more tests to ensure best code coverage.

Maybe, as Dscho suggested to another potential GSoC student, it would
be better to write more tests before converting the function.

> # Useful resources
> There has been a lot of progress made in this direction already and I
> believe it will serve of great help. However, from my understanding it
> is not yet mergeable and it requires changes.
>
> https://public-inbox.org/git/20170608005535.13080-1-joel@teichroeb.net/
> T/#m8849c7ce0ad8516cc206dd6910b79591bf9b3acd

Maybe you should Cc the author of this patch series.

Also please notice that the patch series started with adding some tests.

> I am expecting to submit a patch for every command that is converted.
> This way, I have well set milestones and results will be seen as soon
> as possible. Moreover, seeing my contributions getting merged will be a
> huge confidence boost to myself.

> Each =E2=80=9Cconvert=E2=80=9D phase of the project below is not only abo=
ut converting
> from Shell to C, but also ensuring that everything is documented, there
> are enough tests and there are no regressions.
>
> 14th May - 20th May             - Convert "git stash list"

For example could you explain a bit more which functions/commands you
would create in which file and how you would call them to convert `git
stash list`
