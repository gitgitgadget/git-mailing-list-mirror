Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D93D920248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfCCBZe (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:25:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40676 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCCBZd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:25:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id g20so1458588wmh.5
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 17:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=JSaX2nkGmjJwbItnCdXzS6e/h1hie87bEXLGLi8QVvk=;
        b=uGzG/DPw3wtPwRpMiqGk6gChyZ0nwgYAKMeSRCSM39+tmtmH5Fx2dult1WcvAM3boy
         SgHtpGb7NGkLty6byeF4mFw7EW2OxY0bkZ1n5LVxvie/WPndiZNdMFCp2gPWORkFmqOD
         2Cxf3e05HWZRicFhgIC1JqNA1wN2VvpkcYl/VFcqGyMKgv3u3ipWKUZEkJeVjeN6bprY
         pO5+4IfnEmBRKtFBSNW1IbILjjYcZzW3Uq2KremStuf/ulNmB4Qyl9COZu19lu9yvl/W
         uD/InGDPD9Si4yXpneDdu4Wbv4yaQcq/PGpgZ3r4q0TdYFDC0r2vLaIErbMs7MBkCVo4
         k/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=JSaX2nkGmjJwbItnCdXzS6e/h1hie87bEXLGLi8QVvk=;
        b=c3KHY+9efZEcKVhCBblD2+TpFmvgx05ZIu38iS27ynkFJu62KunKKfik8SRZad68nw
         3Oi1cSQV1Cz91efpE+P6AjKCvirEBBhG8qkkVT8nPf+MlW6LNERbrIWBhm0wuBbgawCR
         zawI6QFJI5KsF+TRDSHfgd/2gf3Qrh01hVAQ9Y7/ICoomTmTuLy2d22w58fbD0I83YhH
         ev3kHOvE5crrBV8JoD8NDSWhuzeYL+7qQBJiX45JaOglqliHTm6DWnqj3cn+tsZ+WD3n
         K8NOqzzELDbYVUyophhGFytWg9cyg503UcIXpCjqv/zMvSx582jSihjokXTKMBBHKF43
         /Vjw==
X-Gm-Message-State: AHQUAuYCUMvAtRhDyBPUU+f+M4hWitkg3XN/+RND7f3TKzqf+kKVyxFE
        vnSHE/LERSwEigJa0MgMtRY=
X-Google-Smtp-Source: APXvYqzXgGQ3A6NoOAjt27f7hGkQCm45iwT8TkUMN/dx7xUdyVpmMy7DlUV3sMU2iflK564ZbNgSYQ==
X-Received: by 2002:a7b:c756:: with SMTP id w22mr7111022wmk.12.1551576331510;
        Sat, 02 Mar 2019 17:25:31 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y140sm8963708wmd.18.2019.03.02.17.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:25:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] asciidoctor-extensions: fix spurious space after linkgit
References: <CAN0heSqLbn7dRu4eARpyMqhFYpj3Pr5i=EMPnQZK9hUfWmf-KQ@mail.gmail.com>
        <cover.1551290936.git.martin.agren@gmail.com>
        <20190228235018.GE601925@genre.crustytoothpaste.net>
Date:   Sun, 03 Mar 2019 10:25:30 +0900
Message-ID: <xmqqmumc3g1h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Wed, Feb 27, 2019 at 07:17:51PM +0100, Martin Ågren wrote:
>> Just like v1 [1], this v2 removes a spurious space which shows up in a
>> large number of places in our manpages when Asciidoctor expands the
>> linkgit:foo[bar] macro. The only difference is a new paragraph in the
>> commit message of the first patch to explain why we need to explicitly
>> list a file we depend on.
>> 
>> Thanks Eric and brian for your comments on v1.
>> 
>> [1] https://public-inbox.org/git/cover.1551123979.git.martin.agren@gmail.com/
>> 
>> Martin Ågren (3):
>>   Documentation/Makefile: add missing xsl dependencies for manpages
>>   Documentation/Makefile: add missing dependency on
>>     asciidoctor-extensions
>>   asciidoctor-extensions: fix spurious space after linkgit
>> 
>>  Documentation/Makefile                  | 4 ++--
>>  Documentation/asciidoctor-extensions.rb | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> This version looks good to me. Thanks again for getting this cleaned up.

Thanks, all.  Will queue.
