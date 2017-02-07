Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4000A1FAF4
	for <e@80x24.org>; Tue,  7 Feb 2017 11:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753988AbdBGLLg (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 06:11:36 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:35987 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753268AbdBGLLd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 06:11:33 -0500
Received: by mail-ot0-f171.google.com with SMTP id 32so83457908oth.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 03:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CQMD9WBwx9Uv8e+/CIdKsbK2Fn02cWvgbhCK1S09nOQ=;
        b=SfCHI5pkiOXUWM610PfF4DXK2DoKcuvYQBwc1HEPMLEXt7ML9G3UcUk5DWU2d2vmHY
         1uqslBHA2DJ/uIDy6fUI3vAQ8sOiW2/JOXIBQlstfiYWb7moUYzktpMjC6WTk6YozHGo
         OrE/IvIExCWwR/HQ7vitFnls/ngrBNqfR/SnqAapVyUXav2UtNJ9vp0mWLxV8jGkyete
         svmm9MzlRkORzLE5NkwTYNztjLl1fziJdc76ZiyLakE3vvLTln5r0Uw8V70xXcH6QhxQ
         jsrpNDtB+M2krU47x40tG4aszAPi00z/6S2ELEckCG13PRG9PzInEPfQWbpqMhdhDE5Q
         bm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CQMD9WBwx9Uv8e+/CIdKsbK2Fn02cWvgbhCK1S09nOQ=;
        b=XFx60EywBGtYeXwfkqEUd30dVgTg0pvgun+eN083v0UNRqgMLpIFJpu9ZQYCu4RQq5
         tsg771rjdBON8QmRIctm4jGnTTZUREZ33QVGoNx/cgAdYgOUMugm31aBJLzbk4rhfq0r
         nXSyAneorozl9JrbKD35Y5d17WDbe9mcEbbD4KFAzUoHQFklqQ2BY0Q4Dkmt+d5eH7SD
         VychMRTaK+mpGfYmZJCG2AD7KMxdllPC5WnsivSn2Ey++CHpQ5wqw3elfyF16cVhaaEZ
         szA/SUTKbvL+jzpTGwdq/lgdXg07IqJ2tkfK/cWb2xW2KZoRcPOqoDGENUrg7T7D77hS
         Vn0Q==
X-Gm-Message-State: AMke39lpUdWmfDMMB7CQSkfEvwoUPsqQ6LfUB5mjBFyErpK8EzIwUbgr3r/ru+KdLPR6qzqJtJeIB4gi/1Y5mw==
X-Received: by 10.157.9.214 with SMTP id 22mr7299302otz.128.1486465893224;
 Tue, 07 Feb 2017 03:11:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Tue, 7 Feb 2017 03:11:02 -0800 (PST)
In-Reply-To: <xmqq60kn2lia.fsf@gitster.mtv.corp.google.com>
References: <c2af75361b7b357fa905ab072bfdc45ad055ca49.1486386803.git.patrick.steinhardt@elego.de>
 <xmqq60kn2lia.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 7 Feb 2017 18:11:02 +0700
Message-ID: <CACsJy8ATyxrTrcym9qPY7EX+rukmF7MhZYEOoEtASrq5Gpg7RA@mail.gmail.com>
Subject: Re: [PATCH] worktree: fix option descriptions for `prune`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <patrick.steinhardt@elego.de>,
        Git Mailing List <git@vger.kernel.org>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 7, 2017 at 1:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Patrick Steinhardt <patrick.steinhardt@elego.de> writes:
>
>>       struct option options[] = {
>>               OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
>> -             OPT__VERBOSE(&verbose, N_("report pruned objects")),
>> +             OPT__VERBOSE(&verbose, N_("report pruned working trees")),
>>               OPT_EXPIRY_DATE(0, "expire", &expire,
>> -                             N_("expire objects older than <time>")),
>> +                             N_("expire working trees older than <time>")),
>
> Thanks for sharp eyes.

Yep.

This message never made it to git@vger right, because I didn't see it?
Oh no, gmail classified the original mail as spam again...

-- 
Duy
