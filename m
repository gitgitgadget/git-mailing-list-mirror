Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1877B20281
	for <e@80x24.org>; Thu, 29 Jun 2017 17:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbdF2RwB (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 13:52:01 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35536 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752868AbdF2RwA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 13:52:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so12708290pgc.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/WpwSWgHQrO7L1EKFdfg6MTm5C5om808srRQDqvuVwo=;
        b=SFpk0NBbxFU+SQpOVb51lvvMMlwA/ICdMnnxynDHvPjP9ikmn7wG1Lk9VZJIxc16os
         fA6u7gYPI20/I6uFcydWyuaPnFTJLeHwS4zQ9mcFupvpXSSqe60lS2P7RxO93jFlKzLh
         LY2HaXe2kedt5k+U5x6zf4GfPS83lB3m82pB69300IaCBf72w/T++uXn4j7go+NKT86O
         yCXVkrd5P6rTNqI97Km3c6LHmT7tMhsynpHlGkWjkZPPfX/lVbyYp8tJ9uhtp9wDlqID
         HvGYVq/gidbvqx1e6bNo5Mz+D8p7gR72QypBrx7hPMUYpzk1AKDXGvyjHwb2oMSGk7ir
         gxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/WpwSWgHQrO7L1EKFdfg6MTm5C5om808srRQDqvuVwo=;
        b=Izy8AIOkta8DccGH44Gq0MlvSy0Ctdn2fGbyuRYcrLL5FpUOsIFO4F7ORvg6/tYvMT
         TPbIkAp4mWVMBbBpKwaeCem3As+STPFhKmJxQdgXHaGTgI3CtCodo5DCxRyWrea0PMfQ
         AOYX0cGMiAMXW32u83CBPv/yeXshkaa1sHIRdBvVBIQoTDwoXG6kdRxxzgVseVyzpI7E
         IUmNDsWInzU7Pc+/iIF5LO7rTl7Eb9uxeOm2Kxmr21wVPxvdtXWL3KGtoRQFARHMVt+i
         kwSd6PokII241KDrERwvi4uA4qQZQg3xd8RwkjDPPkAKXkZoFw7tO+IfXFs3RGKHH8mV
         wsKg==
X-Gm-Message-State: AKS2vOz3bmA1xu7zOM78eci6MB/y1qdRqab9SxW4XDV6OlomuH+/e0B5
        gmKjTEFjRHsDOw==
X-Received: by 10.84.236.14 with SMTP id q14mr19163157plk.254.1498758719239;
        Thu, 29 Jun 2017 10:51:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9846:b2e3:b31e:8976])
        by smtp.gmail.com with ESMTPSA id w69sm12134916pfk.107.2017.06.29.10.51.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 10:51:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] commit-template: add new line before status information
References: <xmqqshikvz1s.fsf@gitster.mtv.corp.google.com>
        <20170629170120.11479-1-kaarticsivaraam91196@gmail.com>
        <20170629170120.11479-2-kaarticsivaraam91196@gmail.com>
Date:   Thu, 29 Jun 2017 10:51:57 -0700
In-Reply-To: <20170629170120.11479-2-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Thu, 29 Jun 2017 22:31:20 +0530")
Message-ID: <xmqq4luyvg02.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The commit template adds the optional parts without
> a new line to distinguish them. This results in
> difficulty in interpreting it's content, specifically
> for inexperienced users.
>
> Add new lines to separate the distinct parts of the
> template.
> ---
>  I tried writing tests to ensure that the new line is added
>  but as it seems to require checking multi-line, special 
>  options of grep were required to check. I tried the following,
>
>    test_expect_success 'new line found before status message' '
>     ! (GIT_EDITOR="cat >editor-input" git commit) &&
>     grep -Pz "#\n# On branch" editor-input
>    '
>
>  It worked well locally but seems to make the build with 
>  GETTEXT_POISON=YesPlease to fail. So, I removed it.
>  Not sure how to write a good test for this change, sorry :(

The above is a good way to capture the input to the editor, but the
test with "grep -P" which is not portable would not work well.  You
however should be able to prepare an expected output with

	cat >expect <<\-EOF &&
	... expected contents to editor-input here ...
	EOF

and do "test_i18ncmp expect editor-input" instead of "grep -P".
