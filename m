Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 066651F403
	for <e@80x24.org>; Thu,  7 Jun 2018 17:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933407AbeFGRNK (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 13:13:10 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:41299 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932737AbeFGRNI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 13:13:08 -0400
Received: by mail-yw0-f196.google.com with SMTP id s201-v6so3240268ywg.8
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 10:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JLEUADXugSIkd4s9SPioUDOx0mmKNpXe6HO5U2DwmUg=;
        b=CeybtaIgkejKryFlLzFqxpSsbThqHw4ObNz4tjhfoNOIdXSzFLnjEXU3ueAJdWXEI/
         qIC8XXlw3XQ45/SG9Q8jEbKGTwHEWasB46PGRoa1MzxqjQnoWrULUUUFfexfdvjGTOef
         7BJVz9iLZKBCzuT+74KgQxTD17DTuJ+lJ44XHfPjpVr9PNdeiG1TPQgVYeH4doBAXh9f
         J6H1FwIh0XUcxptFsEd+KcNFAqzRvcdOS5xFAvMypOq0qkFBkylHF4NjyDKFdu6s5ghs
         tTsQjvVaE1Ql0kWoKFkRY0a4i+LpAq2eHVVM4jGBXeuJgAffuaGI1FVIQdFQtu+XZMKR
         vCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JLEUADXugSIkd4s9SPioUDOx0mmKNpXe6HO5U2DwmUg=;
        b=jYvluspnk6p+dfkuzQUnkOmFaCSvR1TjPrpkkctjrt7r9a4sX0aKBHBLbTjVyTttZb
         DBYTbQsP3UMRpCtCyvg1mdDgeZSKYy4qi/gU4Vmpgi2sD1mE6c7XX63lWVqgTL8LWXBA
         6Ia8KgKgpBjjjFLWD+4LXDQ9Z8lUxD7iWgVo1HHb9gx77FUbXeE0wxOJPMSkuZBg71O8
         6vWHIQ52sQMYFSb+j9lGs3F3OS3/Yi3EHKzRytoInH5lsSXPJGboH02b/UyUaJu/UC/f
         YrSJXq8JX64YbKcCwKtK7NIqR4jAHxS9d2enApn6jg8N5iYTn6aKHK/tESZQb8geqRy+
         ZARg==
X-Gm-Message-State: APt69E1ap2BihM6gGOSPhBR/zx4ouaZY0uXN519Sh1K8LC854B9qAn46
        KuYOHANmQbWm2KM13WPYVNMXjKZahofv2gB8lrs=
X-Google-Smtp-Source: ADUXVKJTdzt6KxPmjE8aTUCPBfRFI0CmNJ8HP3JVUnCFss2/lCZnmryOobuWG+JZ+YeNGRXLP65UjQvm9PwUJW+5s6A=
X-Received: by 2002:a81:6088:: with SMTP id u130-v6mr1612709ywb.418.1528391588164;
 Thu, 07 Jun 2018 10:13:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:785:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 10:13:07 -0700 (PDT)
In-Reply-To: <20180607141209.24423-3-git@jeffhostetler.com>
References: <20180607141209.24423-1-git@jeffhostetler.com> <20180607141209.24423-3-git@jeffhostetler.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 7 Jun 2018 13:13:07 -0400
X-Google-Sender-Auth: XRPmgPpHu25jOK1IdaL601mMPWk
Message-ID: <CAPig+cS8MjQNKabrQwuWzO4DDYJcfP_81n9H37efgXOiRzv9TQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] json-writer: t0019: add perl unit test
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 10:12 AM,  <git@jeffhostetler.com> wrote:
> Test json-writer output using perl script.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
> diff --git a/t/t0019/parse_json.perl b/t/t0019/parse_json.perl
> @@ -0,0 +1,52 @@
> +#!/usr/bin/perl
> +use strict;
> +use warnings;
> +use JSON;

This new script is going to have to be protected by a prerequisite
since the JSON module is not part of the standard Perl installation,
thus will not necessarily be installed everywhere (it isn't on any of
my machines, for instance). Something like:

    test_lazy_prereq PERLJSON '
        perl -MJSON -e "exit 0"
    '

which would be used like this:

    test_expect_success PERLJSON 'parse JSON using Perl' '
        ...
    '
