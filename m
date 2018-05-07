Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32CDA200B9
	for <e@80x24.org>; Mon,  7 May 2018 16:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeEGQd7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 12:33:59 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:38096 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbeEGQd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 12:33:58 -0400
Received: by mail-ua0-f175.google.com with SMTP id y8so18777530ual.5
        for <git@vger.kernel.org>; Mon, 07 May 2018 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qKTsn0TuHntmg3SSFGy+kmN7GSpRWertNO667OEr3l8=;
        b=H8YkZMmDPHYiZ36BwCfVbSJJPXrNAP19njcM4hE5ktufDdG2L2qb+k2ocZ1HB5xFT3
         viYdXj1dVZQk5IZYpZMrsIgvbrM8OKk3zzOBZRnTTEDu6XNk7tKXa8cKGVnc0qMJAm1a
         PSz4FFMrN9f7jBbZmk8vTaLuNtcSTCNl1RdkCE7RCE2O0OCvvguq6sXaRevDr9OdCWBk
         eB8HW8OUD2RT7YifuEIlNTSN9wZ6loXFlB0dBP6WQe8m0A6guzbiZ0UyjMD7dd/0wsh9
         Ti+hNC+uPmsLFxiGgZkSeiiAh6EvmSBu0Wx/hJ+3VdCFkd9MI3ExWHJY5qeM3c9mK5gk
         e97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qKTsn0TuHntmg3SSFGy+kmN7GSpRWertNO667OEr3l8=;
        b=OhJ1q09Ac0TqqovnDT9rQIKPP+s2LuJJjbJdIiRNuvuscJJMRGo6/UTrdTBJDlkUKX
         bhCMYwZZd97PFP09gPFR1/Rps/NTgwx7Th6Ku3oWnbYRlUAclKECuG49+jwpd58Irb/w
         ckcOa8rRaTQtMgAbNazmVx/Ms78Bz6aIt4oEw6NzgYyHyJ4aFQnU4kLDvrMf5e2xEqSk
         3xE0TmgUTOL9O40TrvPQFAT/iXo7Miuv7eySrKPfwriY2ImKbqZn+vYseBy+QR8dwQuA
         eT59BE0wP7YQZjSLIGlm3VmBK6+b/Bkz85hhBxmdAI4PHlS+y3mM1Vp2sq2VonzosvXa
         Lcgg==
X-Gm-Message-State: ALQs6tD6PZc12VnipVLyJXgcIbUv1uB2EiffzSBmNC/OsqxFg+94Wz10
        mHsf5W4iInFjFYl1+Pj1tvNG9I+PpFRIwWNqVn8=
X-Google-Smtp-Source: AB8JxZrZ8RMjBL6J/VMF9oSSRmz1xDw8Td/+eCUUYHiknZ5TWS2Kd2nEkVYzcZdC6iThLi301Ta0E3CjTveTpiZi1Wk=
X-Received: by 10.176.10.26 with SMTP id q26mr32928597uah.23.1525710837533;
 Mon, 07 May 2018 09:33:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 7 May 2018 09:33:56 -0700 (PDT)
In-Reply-To: <1bb666a1-ce44-3eb0-e63c-a6a9e2a675dd@gmail.com>
References: <xmqqa7tbpl5q.fsf@gitster-ct.c.googlers.com> <1bb666a1-ce44-3eb0-e63c-a6a9e2a675dd@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 7 May 2018 09:33:56 -0700
Message-ID: <CABPp-BFyj7SCfUbJzfjt==abORdUtfgRRywyjf0V73rDnygHGw@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2018, #01; Mon, 7)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jakub Narebski <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, May 7, 2018 at 8:20 AM, Derrick Stolee <stolee@gmail.com> wrote:
> On 5/7/2018 10:58 AM, Junio C Hamano wrote:

>>   Will merge to 'master'.
>
> These have been queued for master for a few weeks. Is anything delaying
> them?

I'm actually curious what the "Will merge to 'master'" and "Will merge
to 'next'" are intended to mean in general.  I thought it meant that
the topic would be merged the following week barring further
discussion, but that hasn't always been the case and a quick look at
origin/todo suggests it's not at all uncommon for my assumption to be
wrong -- but that leaves me wondering what the intent actually is.  In
particular, I'm curious if there is anything I'm unaware of that I
should be doing that I'm not but which would help make topics
(particularly the big ones) work more smoothly.

Thanks,
Elijah
