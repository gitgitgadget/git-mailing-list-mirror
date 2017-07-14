Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3192027C
	for <e@80x24.org>; Fri, 14 Jul 2017 04:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750914AbdGNEvX (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 00:51:23 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:33839 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdGNEvX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 00:51:23 -0400
Received: by mail-ua0-f172.google.com with SMTP id z22so45777221uah.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 21:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pp7GjyySNriFLVJgIhWLXQL+JkbPQvraBJL0Zhdn93Q=;
        b=iGYfkKb7JH5sQYoejlyOnSDBV5qV7TNhonAT1fXO+c2R5p1rYl2IWqDuPKHDGSfW4/
         2q5lQuQ+t9kgqsRcEfjy+zm8abrqOAgdYtdJtFUWw4MbqraZLlkV3OzrtwbCoEh2rEna
         Y+xLOguKMITcdkvyjyMS4cBYiW71hzRfEti/qeJhOhUFG+0yebBb2aOFncUoeJ7tU3aJ
         bY2VGXtKwCzNS6FZCL8fnGpiH3L1J+ndHsRFg/r4vpoUilawEJEzy4JuJI8KYb+UsxJC
         m8vJwIltK3phiZkGWlbnl5Ihmj/NITrXOcZQSThpy9p79a3RO61TmynhYaOuvME7kiwx
         d3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=pp7GjyySNriFLVJgIhWLXQL+JkbPQvraBJL0Zhdn93Q=;
        b=KthCya/xxYRvsD5tRpfwyJUu8m/HPbSygar4AN7jSja9QgvzsdkHntdTzac/JRi7nA
         h2xajX7GG1xegu2zZUUZnYQ0qdQYT7c6LycrKb59BqloCPZdkolo7L6bIaVnnv/KMXno
         aUT9vikEEhVsiEeLZNjAp9V6GDI3bpF8/xYYWlqSBwfHqHnh4Mkhg8+s8Et+c1ugJGAy
         mgxGaks1WI1uKvmCnRAPs+VAph7sAs8RBeIxW4Zp8CWw5ztx2s3EXVqEjqbJTLtb09Am
         gm1H9s3P+zZrPmLCS8SwNcMIirxyyJSQ1xiHleRpqcwqjfXpZIyYVV3xXf1Q+jb8xsYt
         RXLw==
X-Gm-Message-State: AIVw110BNPS89WphEmAL1GhDyykbpdMGkE2JvQp2B9HLhIy0HqY3UIyL
        5g19evQoACuIBm2Vda+3XDmmW9aTNg==
X-Received: by 10.176.2.184 with SMTP id 53mr1395834uah.22.1500007882370; Thu,
 13 Jul 2017 21:51:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.69.91 with HTTP; Thu, 13 Jul 2017 21:51:21 -0700 (PDT)
In-Reply-To: <CANmutwCSGgLxESPmTJZXkid6P1N6HwwOTaz=7QHOsSPrrHQ4EQ@mail.gmail.com>
References: <CANmutwCSGgLxESPmTJZXkid6P1N6HwwOTaz=7QHOsSPrrHQ4EQ@mail.gmail.com>
From:   Lutz Roeder <lutz.noreply@gmail.com>
Date:   Thu, 13 Jul 2017 21:51:21 -0700
Message-ID: <CANmutwAJd3qUbNmPv5WpD4zr=rt=Zt3sJ3Ackuasu=pOCRz-5g@mail.gmail.com>
Subject: Re: Git on macOS shows committed files as untracked
To:     peff@peff.net, git@vger.kernel.org, tboegi@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using precomposeunicode still reproduces the issue:

Repro steps:

1. Download https://www.dropbox.com/s/0q5pbpqpckwzj7b/gitstatusrepro.zip?dl=
=3D0
2. unzip gitstatusrepro.zip && cd gitstatusrepro
3. git reset --hard
4. git -c core.precomposeunicode=3Dtrue status

On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

"d\314\207\316\271\314\223\314\200\342\225\223\316\265\357\256\257\360\222\=
221\217\342\227\213\342\225\223\320\243\314\213/"

nothing added to commit but untracked files present (use "git add" to track=
)

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Thanks for the fast analyzes -
> in short:
> what does
> git -c core.precomposeunicode=3Dtrue status
> say ?
>
>
> The easiest thing may be to set
> git config --global core.precomposeunicode true
