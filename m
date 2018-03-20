Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1C31F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 09:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751715AbeCTJQq (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 05:16:46 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:41249 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeCTJQp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 05:16:45 -0400
Received: by mail-io0-f172.google.com with SMTP id m83so1438221ioi.8
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 02:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+gVO9cAM1OV9QT5058QAcYeQeil3GT4smz9yzwTcSDc=;
        b=HB+YFX6+F2epAVJgyeTKTm2JamePdVtnsqwju5trcoDaHk1jsX31I9vmlFUeIeQ9Lr
         rVGs1WAYPaZcRDAlnD1sX+FPMY0mB/9bm8TJS0Ywe3pbPMTAGLWTx5MiC2ZVewY4rMRt
         YS3MODKynrcSbDO6PaZOFNH5a4S7EM+/ssn7iG1morbvEznFQXa+FKJOU3wKJDDs8pug
         ccIGKeHecmyheTj/78em4/EfTaa0OqPjqEE9m3z3tHtbNL3sT3nwPS5ak4TJKMBYDOOk
         yB+0Yhao62Q5G2+JqwPZ+wpG3Tppr4lmilKFBCJzr+kr10CmzMv8Fg0i9gtApwbPwy4y
         V6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+gVO9cAM1OV9QT5058QAcYeQeil3GT4smz9yzwTcSDc=;
        b=s2dS5yoxJTeK7K0/5bZm8Bknb2zIRqX6ILGja5jIKvIAubHyWIZMN1yTrYlA9xVj/y
         cchwBZqxwbjiBg616zFOVHMEHAHcpgxzpSh/EItNovnolwU6GhPWDDnNwwW7jvxX9CxQ
         rkbEbBBRx9O7HhqsxDkv0z8S9Zdl9HyKYVDb84dF+UvQum7n1Cxen2Jc8YxLyrBljmDr
         EQg4C70kz75c68khKX7LyDE2lYUKAQKOUN6QS6GHpCAvfnPVWloJzYr8tl+gHLH7urR1
         06wCFV+Beu6gUj5Vv1T7QI6xMv2OsAeOJ6UOAmmlCEim4q5uYGZBI0wGUBI4y6XvTIpF
         2PKg==
X-Gm-Message-State: AElRT7GCUHN7n+mE7Hs7GTO/jvH7Q8CqUrc20YWwou8GIK4KK6RqQ0h3
        X167GF+iT9fEIrIWO+JZA5Ki9Eg+62wkx1zJ/RM=
X-Google-Smtp-Source: AG47ELu/XAgxZB65gG5ygQn0sPQJ35/BsZBcg4STMAEG/RFLiUew3wT1/rkBLwXhdul4tIL/DsOn+cb7MrKFmCfFylo=
X-Received: by 10.107.93.20 with SMTP id r20mr14915281iob.53.1521537404827;
 Tue, 20 Mar 2018 02:16:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.146.25 with HTTP; Tue, 20 Mar 2018 02:16:44 -0700 (PDT)
In-Reply-To: <20180320090013.26512-1-predatoramigo@gmail.com>
References: <20180320090013.26512-1-predatoramigo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 20 Mar 2018 10:16:44 +0100
Message-ID: <CAP8UFD2gN9Litjm_Wn8XoR7QMg6BXasETUX33ntcB2_gQ5AVTg@mail.gmail.com>
Subject: Re: [RFC] [GSoC] Project proposal: convert scripts to builtins
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Mar 20, 2018 at 10:00 AM, Pratik Karki <predatoramigo@gmail.com> wrote:
> Hi,
> This is my draft for my proposal on "Convert Scripts to builtin" for GSoC.
> Please review and provide feedbacks.
>
> https://gist.github.com/prertik/daaa73a39d3ce30811d9a208043dc235

It would be easier for us to comment if the markdown was sent inline.

Thanks,
Christian.
