Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E111FAED
	for <e@80x24.org>; Thu, 26 Oct 2017 08:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbdJZIlL (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 04:41:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50203 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbdJZIlI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 04:41:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id s66so1284093wmf.5
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BN8Cyx2HQJZFWEykMxe9WeJ+w8q4kxxBn9hg6AUSe6o=;
        b=DnRlyRDAkOEGWjyuQLjyrQRUZ9azRQKL7MtdLmiBslQ8cVAfJu/Dj7GGVf/O6Y6r9W
         oJc5mlqeKy/Z4PpS0kC1bOBfpvRDU06JPX8ev5XtM5iquvxsjYx518kHoIzh3+SoKAC7
         8J1gdELaSQwhkz2sMPHC7zBjHHhiRSyDj4pjZ1k455BEOmOcS0pQCGARhXbHh2FQ91Ud
         qnkKPDOhH5Joi2DlmC+3X0ILiILMkIALpad7weLd4kSqo5BBU6JVukhrDXT1B5M1LWau
         0/NYbHY0OAGI8D0rvtbaj4UFj754HUkmBpnVBIaCDceQM+ug6EJBs3xHFgV9JpqbLiGQ
         FsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BN8Cyx2HQJZFWEykMxe9WeJ+w8q4kxxBn9hg6AUSe6o=;
        b=nkHd9JSZAlzPk2wXW0KzCNuUZF4yNPlY1B1DACRZN8GHx796GFgXslnaAtt2sysKfl
         3IghCx/ABcHe31Rd/o7K1DwWOUC+OUnBT3wDbgbWniuud0ccoapMirc8RuwE37VEzHmt
         fejb7ICFS3Dw3rTNIUseicp8tkW7knChRzl6nUJ3yN1RdLywD35/MvV53dv8dgHZm+tQ
         NW+yIlJj60W3gss6QmVoBr2xmIwmqBN1ozlVzIzTyNmeMgHEMwGZxF56OJ2eX4Y5kJTv
         85mcEqF4D2VNec2pUTxGhOUBASiTChVZFvPqk7xaDTn1Bs+7XjeoYqx0utQixCQCUyZl
         PFdQ==
X-Gm-Message-State: AMCzsaVymmR5UygZhUQ2GFeYa2u6LFOO48BWR0W2LxK/WefTc31Ra6Ja
        fsQ1B245i7ouxIAHAncPW/qHFF51Ogj9TRMPKys=
X-Google-Smtp-Source: ABhQp+T6H09Kb4x0UtGAnr4161ojOPnJfH0lYsQ81L87mYVZfrXeJijDyRl6Btiwc75sur9cJWOaqL59juUM8IC5hag=
X-Received: by 10.80.137.91 with SMTP id f27mr26122471edf.18.1509007266877;
 Thu, 26 Oct 2017 01:41:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Thu, 26 Oct 2017 01:40:46 -0700 (PDT)
In-Reply-To: <CAPig+cTv4YW0m0PLH+UucEHjgQkbCsOunPrkKVDrPQXNkd=GAg@mail.gmail.com>
References: <6ecab31e7ed05f5e79ecd454b133a2bfa6ac9ab7.1509005669.git.mhagger@alum.mit.edu>
 <CAPig+cTv4YW0m0PLH+UucEHjgQkbCsOunPrkKVDrPQXNkd=GAg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 26 Oct 2017 01:40:46 -0700
Message-ID: <CA+P7+xoCKTaG9kV2T9YUHvagHVzD6v7A=neLzF3Qj1q8Fi0u-w@mail.gmail.com>
Subject: Re: [PATCH] t0000: check whether the shell supports the "local" keyword
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 26, 2017 at 1:28 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Oct 26, 2017 at 4:18 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Add a test balloon to see if we get complaints from anybody who is
>> using a shell that doesn't support the "local" keyword. If so, this
>> test can be reverted. If not, we might want to consider using "local"
>> in shell code throughout the git code base.
>
> I would guess that the number of people who actually run the Git test
> suite is microscopic compared to the number of people who use Git
> itself. It is not clear, therefore, that lack of reports of failure of
> the new test would imply that "local" can safely be used throughout
> the Git code base. At best, it might indicate that "local" can be used
> in the tests.
>
> Or, am I missing something?
>

I don't think you're missing anything. I think the idea here is: "do
any users who actively run the test suite care if we start using
local". I don't think the goal is to allow use of local in non-test
suite code. At least, that's not how I interpreted it.

Thus it's fine to be only as part of a test and see if anyone
complains, since the only people affected would be those which
actually run the test suite...

Changing our requirement for regular shell scripts we ship seems a lot
trickier to gauge.

Thanks,
Jake
