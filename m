Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF441F462
	for <e@80x24.org>; Wed, 12 Jun 2019 02:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408473AbfFLCjb (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 22:39:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46751 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406202AbfFLCja (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 22:39:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so17044043qtn.13
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 19:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=psiJ6EwWGq/g/0znMR0m8qzXVFckDQMZIZq5WowfalA=;
        b=Q1Ndn3RXoRTzJGEC/scNfKny9/npBi1TZYzQ6tqwt4tUHb9c5mWhoKdFP15gfRy8qs
         ey9ErCXZizy0O25vexzAN3FyYtfV9u3zE5hklJ8kIqfTtk8r+PBHMOrIE1ZotJvYIKLV
         RO6oa02yJnP3n8GPtPRZs50BjQNcAYn/d4XWuxU+zA1gZd44CwZpftTFlS99mEXnEKc9
         s18Jwxk3KfLpaKc8P2TGmtIIgNmSc7ba3r5hnpi+ArFXEg7+Rg2uR7vDoVRuEpDkuQ2E
         IvBJgoV+bOFVfRyjrAYxmDooSPyiWIuUVZf7n6CjERDDIm6tv+JNPZNxPFQNtU3MIKPd
         OeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=psiJ6EwWGq/g/0znMR0m8qzXVFckDQMZIZq5WowfalA=;
        b=fRJiyiZVqIlIpPVSiCCIPM0xpPeDcBPNvQo2Q5cDWPKeCkEYGEiW3UsRx/IY7I8vgJ
         8fTDNHRn68ajK/1H6DozvUVIiHq8qpWwggdCO78r7jS/LxvBQA3vS1s+kihDsEMNfAvo
         Ijb7MimaMWn/PVYejnxgr5thoaEcptrHVzkkQzfOEtbHvSLkguR5yo8jh9/EROwcwmb0
         3Dpe8BrPqXdxGhOLZKKc5uyW0mr+WFmZUkzsxBtR11DhL0NIVodUyOhogUh+mHrA+NxC
         Ku/AHyoNxnkjQF/h6XLCK73EEKmmoiAICsINWaLjJ6ASgQ7v5RiqeGpdtUTzKAvg1+u9
         68pA==
X-Gm-Message-State: APjAAAUWeNIUN0jNNZx5enJcSk+w8F1N5olGwf1EtUFrIxrJv6yzXMqJ
        8tNLLkCsKi1qKgrZ8SyoSiaTxFNT
X-Google-Smtp-Source: APXvYqy+VEAM1daH2QEQGCCP/SkK7LC+QWX2weM8Fdwq7bh5CKW0naxio0/X/IYu/dujAF4RD4RNTg==
X-Received: by 2002:ac8:2ca5:: with SMTP id 34mr68902571qtw.246.1560307169416;
        Tue, 11 Jun 2019 19:39:29 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id c30sm8661037qta.25.2019.06.11.19.39.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 19:39:28 -0700 (PDT)
Subject: Re: [PATCH 0/2] Improve test code coverage on
 jt/partial-clone-missing-ref-delta-base
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1560286956.git.jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <464f2cb0-68a5-ec2b-e526-98874c27a8b4@gmail.com>
Date:   Tue, 11 Jun 2019 22:39:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <cover.1560286956.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/11/2019 5:06 PM, Jonathan Tan wrote:
> This series is on jt/partial-clone-missing-ref-delta-base.
> 
> Patch 1 is a cleanup, and patch 2 improves test code coverage. Thanks to
> Stolee for the code coverage report.
> 
> I have checked this by running `make coverage` then `make cover_db_html`
> on both "next" and this series, and comparing the output - the
> relevant line indeed shows up as uncovered on "next", and covered on
> this.

Thanks for the additional tests, Jonathan! The update in PATCH 2 looks
like it took a bit of work, so thanks for your efforts there!

LGTM.

-Stolee

