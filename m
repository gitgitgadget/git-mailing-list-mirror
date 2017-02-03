Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDBFD1F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 08:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbdBCIHa (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 03:07:30 -0500
Received: from mail-ot0-f175.google.com ([74.125.82.175]:33148 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbdBCIHa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 03:07:30 -0500
Received: by mail-ot0-f175.google.com with SMTP id 73so9201578otj.0
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 00:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rHsS65kjHO0H0y1SSsC/0cwfT+DW02pjoV2FqcTJCJA=;
        b=LMYhsd1M7ZBU1ZfLHjuPelpEhOhZXS2gBdaDB9QvhSQvTJaV+JFMgQXb49N0EopIJM
         AimFYqjw4tRAgq16dzVNh8dFx7ufAwP8O+2SaD3URn2Jjdnq7QhH1SOl1diLZIs80WVF
         XMrTKjVUAJqdQbcXrCe31n4qaxpdhSGdcI/xlfpvDHoxQT+IfkEsW/NbODE1EfvasWgR
         sVi1tCwSFIbMGZ90pAr4CVl4ZA+W4qYJy3BmSsNrY7YrzlZm8h6gv8qMx1ne8LA1t5dL
         FyvPL37ShszDEXqE1cgRjm2g7/g8gsP598OjEAhs/8L1WBt04OVrYKEuXUUVvObxKSTz
         jkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rHsS65kjHO0H0y1SSsC/0cwfT+DW02pjoV2FqcTJCJA=;
        b=DyC7A5ICQ1wBG/xQ52ztlK7RyG/EPxdxOoBJBQfBwEb9DNfT9EqEV4sd+cjSIEbfYz
         6hIz94EauM7+7qsVxa5W9pKpY7yAEZNHAHx6STufrUe2lTgGHQc5jmD38RB9OV9DOHjz
         M/HoKwY4Ohe8xz2FvYacJj8efNVsvMyPkjL59uzOYYmMnslZCvBvp03p9zcE9rWjiEzd
         BXmEpZPVk6T1gB4ax+wSr9ABLLWlsQZwccOEJrriPBIrv26ZWGdcwYLIvkAZsNPKk3N7
         jKvyMfT7/y3ed1Pjehdb4Czvt0RjB1zHE9MsAA7meaBEf1gf07Fn9G3E/HIFfN7T9a/V
         I/aQ==
X-Gm-Message-State: AIkVDXLddhES6XwdoVcosKpuwdZY5Uyv9PmPmic4BhpUD3K42TvLDZAvSEM+LDgcOH9rk6hNHYYs22snWlrmsA==
X-Received: by 10.157.46.57 with SMTP id q54mr7211161otb.28.1486109249391;
 Fri, 03 Feb 2017 00:07:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Fri, 3 Feb 2017 00:06:58 -0800 (PST)
In-Reply-To: <CAE1pOi0-8JnnZbdm9vu1RwTU1mXr7dboLC3ito3LcvK9gkNi_A@mail.gmail.com>
References: <CAE1pOi0-8JnnZbdm9vu1RwTU1mXr7dboLC3ito3LcvK9gkNi_A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 3 Feb 2017 15:06:58 +0700
Message-ID: <CACsJy8DjqrEZ=VaZo6bn4i2r=Wr8k4ExYv48N-rDvfPO=hqpLA@mail.gmail.com>
Subject: Re: How to use git show's "%<(<N>[,trunc|ltrunc|mtrunc])"?
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 3, 2017 at 12:51 AM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
> Hi all,
>
> I'm trying to get the committer date printed in a custom fashion.
> Using "%cI" gets me close:
>
> $ git show --format="%cI | %an" master | head -n 1
> 2017-01-31T17:02:13-08:00 | Hilco Wijbenga
>
> I would like to get rid of the "-08:00" bit at the end of the
> timestamp. According to the "git show" manual I should be able to use
> "%<(<N>[,trunc|ltrunc|mtrunc])" to drop that last part.
>
> $ git show --format="%<(19,trunc)cI | %an" master | head -n 1

You're almost there. Just insert another '%' between "trunc)" and "cI".

> How do I get "2017-01-31T17:02:13 | Hilco Wijbenga" to be output?

You'll get an ellipsis at the end though.. (i.e. 02:13... | Hilco)
-- 
Duy
