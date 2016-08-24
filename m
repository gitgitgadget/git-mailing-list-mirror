Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4A8C1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 20:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756167AbcHXUuI (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 16:50:08 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36089 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755524AbcHXUuH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 16:50:07 -0400
Received: by mail-yw0-f173.google.com with SMTP id u134so17728453ywg.3
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 13:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uEWmtmHBvp4Lx6ctxIZGcuJ4THiMXxgXjlbB4jCFuBk=;
        b=YH9yekZYuYXj1ZZdpH5HPqBOT7rx41iYoUEuHYfXh3qgvmnIv6idWiFrATI4+nV0an
         oHBNzRxly7Upblhryb2WYK6aKnbsrAbqlAzUdKt/Yv+w1Hw6dUUhZ+0is9fCMQI573ih
         BO6aSdliJgBuiDhw4QVwadhlGkCT6QgBHAaEtRuoBDyYifBxbUoLKfDlAu7LpY0xCLlz
         xXsjVZ0BNBc6PjxgRe9mbbCmfZzy89/0ud9I5tFxJB+XWJ4dYTJOwKWJ4yjZZ1fwi2No
         LbbG6N7nE8h/RYkBcS7ZxJwCiqhwi0NTfK7O2/HJRDscT6rrZ4RyADHE0fU0Ks/vL6bW
         9f4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uEWmtmHBvp4Lx6ctxIZGcuJ4THiMXxgXjlbB4jCFuBk=;
        b=NDV+8V9cJhWrs8cnjOIg6C4rDJCQO3/ShLv44tLV7Fq/wBol+TAXo7slKr+5ro/W1d
         iYJrsPZjqi3JbBTqcWC/4tlFpaGkLZrNl6aLuA1H+BqbHX6xcEHXDH1SGiirwxwCQL53
         ctnGs7CYYHqQKpRESETMD7lqYz1YaAMf1c4QvJfeFKJA1JVCLQoul7Gkjgiyolxh07Bu
         8AlIgB07K7+hFCnwHlCeiqowUqO8FNxfoL+rs2epsKCVwfRVwmKDc06UUd9TsVAnYIph
         xZdOARnfl5SIah3a4JaDgHi8GdjIdsuMZYiHIujx0WCQVkOCQla5M1Up5H/ZFt8NNbed
         o0Iw==
X-Gm-Message-State: AEkoouu5QJv22D6zFn+Yh5TYKoU3vhSiOZDeYULIU01SSsy32n3+ZSTZRlTdH9PmDkAdAtHBAuLD7JyiGjIqCw==
X-Received: by 10.129.46.136 with SMTP id u130mr4449939ywu.234.1472071730892;
 Wed, 24 Aug 2016 13:48:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Wed, 24 Aug 2016 13:48:30 -0700 (PDT)
In-Reply-To: <xmqqbn0irvan.fsf@gitster.mtv.corp.google.com>
References: <CAHd499DL2WiTgnk5A--qihUh-jF9m7aXDzHAQuW=bLRVW4Bniw@mail.gmail.com>
 <xmqqbn0irvan.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 24 Aug 2016 13:48:30 -0700
Message-ID: <CA+P7+xpv--eA8rdgwGLRCucSpVD5X9LjiN3_3Oo9o4L0t5Uk9Q@mail.gmail.com>
Subject: Re: diff <commit> using 3-dot behavior
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 9:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The merge-base is to compute the point you forked your topic from
> the mainline.  So if you want to compare your current state in the
> index with the fork point, you'd do
>
>         git diff --cached $(git merge-base master topic)
>
> and comparing your working tree state would be
>
>         git diff --cached $(git merge-base master topic)
>

Those are both identical?

Thanks,
Jake
