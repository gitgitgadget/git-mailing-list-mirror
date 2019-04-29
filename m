Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7743E1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 19:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfD2T1j (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 15:27:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40970 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2T1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 15:27:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id f25so13334495qtc.8
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 12:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tPQ3s3WZUtdd1HwqICbicaudRzhLnuJcUzUr8TRY3Qs=;
        b=aPQZyyynGpjHW5ebVEUgxbI3yyiYxmDQfB9s5LA0W+QDrJeOMn/2tMh4RDZRA0aWfk
         ldwkQqbemECgjgMRkn1wjr8bYuvjJaYN/hAXNbO5pfqZQkubmycMQ3bxLWRlzZVUr+Hw
         WFQv0vAY27PYBl88N4vtG0WTLdmZTBEz5vovWBq8usryuiU7ZdCxLdNI75PZmu25Ul2c
         gqrX5Jf0HrpIkILKDGca7PDU36rQjjBVif1vNurw8OSgrNlgOAHIa1u6ShAWQ3L+4wbB
         FsUFO4RgSM/ADJ6D0KVWOtXezvGMLP/VvmdSx+BmvQpFwfYKS0FSUQADU9wPc09dW8bw
         m2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPQ3s3WZUtdd1HwqICbicaudRzhLnuJcUzUr8TRY3Qs=;
        b=FfDyGrzYlfA+oXr6T6zkiHOcbskO1LrLNFE2q7yNvxwg44sBFAhqlCLmUO3yI5BWMN
         jrhENdfJmRNifhZlaBLtnRm85czqCAHRsPsnrybsUcm/DMx4JE6SJF0dXoYkCf6Wg9bc
         +PGDIAGKzEFiiz4r2chhGk2ZT3zApEryyKlmkNCicV4XCHfV7pcFZTkz9NGknmFkYeL/
         PK0+PRxljD393Bh2f0rcm5A7MHa3mb/ePwmeXsxtJuCDq0qTCBpqwtEHXeU7LaJaxGvN
         12Ynf66SsmpvylhWjunrH0sL6iBSyglegRSKbeDAR4JURjNlw5a6CKpwPrNVOqzy59CM
         j9MA==
X-Gm-Message-State: APjAAAX3GCYGyAAA2llrh1DPb2uTVLLQmYDzgsc/X/LC2OM6rhOPIOZF
        N7IqI3VfGJUTz3o9M5mJd7MYCfLOPC4JZA0xbIo=
X-Google-Smtp-Source: APXvYqwJV+F0vUB9jELuyiIcMbLjBJzgC4wU9TU404VkgAQWISZdIDQOGb480fnFv0m1WoTPnq/89uSXgxLEPZBShJw=
X-Received: by 2002:ac8:2dba:: with SMTP id p55mr37161522qta.283.1556566057832;
 Mon, 29 Apr 2019 12:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190429051944.77164-1-nbelakovski@gmail.com> <20190429141224.GA9286@szeder.dev>
In-Reply-To: <20190429141224.GA9286@szeder.dev>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Mon, 29 Apr 2019 12:27:12 -0700
Message-ID: <CAC05387vvSWD8Y-ufFU9VXkrtLWEDXCL+DP95UkGf3wWhytgsA@mail.gmail.com>
Subject: Re: [PATCH v10 0/3]
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Testing with GETTEXT_POISON was broken since 6cdccfce (i18n: make
> GETTEXT_POISON a runtime option, 2018-11-08), and didn't catch any of
> these issues.  See:
>
>   https://public-inbox.org/git/xmqqlg0bvppc.fsf_-_@gitster-ct.c.googlers.com/T/#u
>
> The fix f88b9cb603 (gettext tests: export the restored
> GIT_TEST_GETTEXT_POISON, 2019-04-15) was merged to master just last
> week.
>

Ah I see, thanks for the info.
