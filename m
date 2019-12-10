Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D6BC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 21:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831E82467E
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 21:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfLJVFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:05:21 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33943 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfLJVFU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 16:05:20 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so20335763iof.1
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 13:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32s+7x7p/9vVv7y6c6iHCLoYAeC+06SyndyrK4TOLkI=;
        b=U2aM/oc/VogqgRTd2WnAoPeWYBw+3/gehymoaM4ojrlvli/WeScvxyHlR2urBu5ovg
         muAr7DxX69+z1dpTzec7AC7iMnlJYhm3ftLMWVW+a2IC2yiZDZ2vl3EsPk+uM5hNnI9a
         fu2Ml4USIR9uZTZn8xkWnJ79hy85mjB/4Go5nrNxmZKdK9NlU8mx7YDM+NVII0wdRiS1
         6jWTRiLCX9yr9Ax5Y1RbJT/7N9BIUWhJgH8QdPSKQ+BHIjOYdIR2EED0rMQuyMrm8UkG
         BgsmQudC3YWA9CBTG7spl9M3YTYEKiT/fxCrPyeju7tAqN3AaTHqZhM9qWSVG1HrTCUZ
         snvA==
X-Gm-Message-State: APjAAAU+jJJdeG9SkHX82egIGk2VnWfXNpEcVfdeMaFxLm4fucaa16lB
        bAW3kDaEWmcKWi6OrLTGJMHZHhT7y+2o0a+PK663psfw
X-Google-Smtp-Source: APXvYqw8pbHsa7qsXbcxyaQpGHosdYklri0/2LteB38zzgeNsoI5x6FwTjlOCM8TmEyixEK5eUrV3EcrTk8oqmu7Y80=
X-Received: by 2002:a05:6638:72c:: with SMTP id j12mr35292500jad.136.1576011920089;
 Tue, 10 Dec 2019 13:05:20 -0800 (PST)
MIME-Version: 1.0
References: <E2770343-BB39-458C-835E-04F0753783C3@mail.ru> <xmqqimmoq6vw.fsf@gitster-ct.c.googlers.com>
 <70575b23-6adb-a29b-8df8-f9099f86eb0e@gmail.com> <20191210205056.GA14079@coredump.intra.peff.net>
In-Reply-To: <20191210205056.GA14079@coredump.intra.peff.net>
From:   Ed Maste <emaste@freebsd.org>
Date:   Tue, 10 Dec 2019 12:18:51 -0500
Message-ID: <CAPyFy2ALrWmH3kS5RgzQ+BH+ZUiboQi0-FPLqr1qgsvtntEZCw@mail.gmail.com>
Subject: Re: Could /Documentation/technical/commit-graph.txt be relicensed
 under a permissive license?
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        KOLANICH <kolan_n@mail.ru>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 10 Dec 2019 at 15:51, Jeff King <peff@peff.net> wrote:
>
> That's my understanding as well. That said, I would not be opposed to
> some kind of statement in the documentation making our view explicit.

As someone with a vested interest in permissively licensed tools that
can perform some basic git-compatible operations, such a statement
would be appreciated.
