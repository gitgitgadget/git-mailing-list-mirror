Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03E47202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 18:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbdGESC1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 14:02:27 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36744 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdGESCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 14:02:16 -0400
Received: by mail-pg0-f41.google.com with SMTP id u62so127873736pgb.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gjQ4kVvCKepLmOGX4vnpWLPsdMfS7cMoNhzt5p9Ueec=;
        b=bjw31NPJcsMnO/gRb7Si+QTDHLXos+hXbT6k1wGFG1D3nDJ/D1640WavaxbrdfqozO
         BLkDqdbx+5ugx1JZXJbhAxAp6bClraAYSX0RLpsVIcBAgLcb3XET+vDed+SeywHOblKq
         oAMEJwnEJ3XjhW8gQ9J3YE/PBM1yXhEa+4cL6ziZMPn0pOTDEhOSlMQp0CWUPKr6bUiz
         p1ZrNtLfbT5owqGLKrP9UKcv7wRAij/btXqK4OKy+znO2/PG5fQoORHNKAT1u5qrbYbA
         lhtcuWUzI19aVlAg0bdeflvGTlgosCzVCS9F55H6kBQqZk4Nwi3grrsYmsySOApP4utS
         PFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gjQ4kVvCKepLmOGX4vnpWLPsdMfS7cMoNhzt5p9Ueec=;
        b=O4QqdFV/t58NRX4ax/g3nYQkSVov2KAxkhSESLQWWEx33sKIH2SOhy6W8x0w52lVBO
         UZQ6XXzaCr5uUkbkr1PvTvVsoykA29OnFmZCLXw7AxrEkAKmqFzHLI79ICvP9wBsx1mV
         c1zzGm6k4JwXPXm1JRtBMWphg2AttrkvQ8v3gQEtIz92by08eBTzhkpX73gb0kBIJ8jt
         hinM3H8orGuhZXgUsLSwJnsVW1D0sjc63Y2kfMBGDIBlq4MBAdHo8AuFZuL5ZMGiaKIh
         QAXZRIIIfb4/lTEsn53TXWA7ZTsx4ZUycm4Gci/4XPUuD+V7kybqliu7ZhagXazF5Lmy
         cxTg==
X-Gm-Message-State: AIVw111xiZFfRpeqXONfl44ccUaOjUS9VZwQXJT2d6jvQvk8IkfzwEV5
        g3EGb7FhUtyPLsLickrbrb2xnJFXvtNcB9E=
X-Received: by 10.84.191.131 with SMTP id a3mr23747074pld.279.1499277735225;
 Wed, 05 Jul 2017 11:02:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Wed, 5 Jul 2017 11:02:14 -0700 (PDT)
In-Reply-To: <xmqqeftvjzgk.fsf@gitster.mtv.corp.google.com>
References: <20170703185533.51530-1-sandals@crustytoothpaste.net> <xmqqeftvjzgk.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 5 Jul 2017 11:02:14 -0700
Message-ID: <CAGZ79kbb33=BtspboOTXiPJtOYqFtS3pwNgqnggJv6Kn9uyPVw@mail.gmail.com>
Subject: Re: [PATCH 00/12] object_id part 9
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 4, 2017 at 9:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> It is possible there will be some other conflicts with in flight topics,
>> as get_sha1 is commonly used in the codebase.  This is unavoidable to
>> some extent, but should be kept in mind.  My experience is that usually
>> the required changes for conversion are minimal.
>
> Thanks.
>
> It did have a few conflicts in submodule area and sequencer, but
> they were (hopefully) trivial to resolve.  The result is queued at
> the tip of 'pu'.  It seems to pass the tests locally and also at
> Travis.

The series as queued (modulo 2 minor nits/questions asked in
patch 11/12) as well as the conflict resolution look good to me.

Thanks,
Stefan
