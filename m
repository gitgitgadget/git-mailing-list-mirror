Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 687401F453
	for <e@80x24.org>; Wed,  6 Feb 2019 09:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfBFJjE (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 04:39:04 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:39933 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfBFJjE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 04:39:04 -0500
Received: by mail-pf1-f182.google.com with SMTP id f132so545143pfa.6
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 01:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wjdwUSMYNB58wvKbvRQS3nIiswpgjJTuFW3EVUofQ/8=;
        b=RqGfpg0EDO+6s1/I767S76C7alvdvoWpDVjTF75jcbJuvmJshwVaxxSh/CwpkODHH0
         pbd4DJFLwG1PoEEQs5dsgu/BMUQ+mc6PzSqiPf88WttCj1D0ZQSpTpDT4yqKXktvuDOv
         3kWh67+i1Ojp9/eXoTFTxOWnSIaDtjClsNqgYy1Lzn9EuhO2C6VqDnGHpN/Vfz2ZiMwd
         D2gQOiDHXQivQqU9CejstX2HBuPh1tFjZVwSVltuVerlyYNwtZyrRNf6tEFi/M1ppehY
         rHclQ99LxbO1nsxjVumUSK2dMn3Z7jzU9d56ej/DX9AtKBLzTC+pnnoAz+njDbbIYy1U
         UZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wjdwUSMYNB58wvKbvRQS3nIiswpgjJTuFW3EVUofQ/8=;
        b=uD+/0vYQWDS4LdLf0LRHD1KzbW95NxiJN2vCbCzitmjat+/s46s+HY0+P1R4EH3fd+
         dZnFXrJYF7klCCfwWEVUKhFUurcGXy/4q2JtN3IGHehQqq0rfcrQUBOo72GQNN2hBpg1
         jBPH+TVqJF1u75tyy5gU6DvUtV0GEJMkSEOf6T1o7mJ8sgn/s9zUugT2Z0ly5l0FINhn
         sUgvmnfdCIfmUJKm6OQpaWPC/kATxb1WSAxsxpebwKVZSwUqBkBh7yeFWJE/heDYmPAv
         evrKgjHNQsIdazEvZqZiypP8vJtUlSE7ixW9sUdCGhjJSA7AhBmocaCWP1wvpVTW4Pr3
         Qwwg==
X-Gm-Message-State: AHQUAuZrQBqMUtbEhZaQSdA9WbrRZD/W4NowXmpZeWak7SgwGidZgLlN
        5bjrGw0em24qDCUPA8a9zjsKcW3r
X-Google-Smtp-Source: AHgI3IaE+/MmWd31Yy8Td2UZN/RLoYICujOi/Gr97K4EOf+x62owO6DwPCz2X4UkEYgpgy1yyTQaMw==
X-Received: by 2002:a63:e63:: with SMTP id 35mr3665946pgo.347.1549445943053;
        Wed, 06 Feb 2019 01:39:03 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id z1sm7842461pfi.155.2019.02.06.01.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 01:39:01 -0800 (PST)
Date:   Wed, 6 Feb 2019 01:39:00 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2019, #01; Tue, 5)
Message-ID: <20190206093900.GA20697@archbookpro.localdomain>
References: <xmqq1s4lst7m.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1s4lst7m.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 05, 2019 at 03:37:01PM -0800, Junio C Hamano wrote:
> * dl/merge-cleanup-scissors-fix (2019-01-27) 4 commits
>  - merge: add scissors line on merge conflict
>  - merge: cleanup messages like commit
>  - t7600: clean up 'merge --squash c3 with c7' test
>  - commit: extract cleanup_mode functions to sequencer
> 
>  The list of conflicted paths shown in the editor while concluding a
>  conflicted merge was shown above the scissors line when the
>  clean-up mode is set to "scissors", even though it was commented
>  out just like the list of updated paths and other information to
>  help the user explain the merge better.
> 
>  Will merge to 'next'.

We should pull v6[1] of the patchset before we merge into next. It
resolves merge conflicts related to the changed function signature of
`append_conflicts_hint`.

[1]: https://public-inbox.org/git/cover.1548219737.git.liu.denton@gmail.com/
