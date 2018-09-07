Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 979991F404
	for <e@80x24.org>; Fri,  7 Sep 2018 21:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbeIHCVR (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 22:21:17 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:41190 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbeIHCVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 22:21:16 -0400
Received: by mail-wr1-f46.google.com with SMTP id z96-v6so16239967wrb.8
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 14:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IVxH3P+9Iy+HrTFa4exYvP8cScveZB2ldr4CEbwZl1U=;
        b=KDvQ0L+Qr/tRY0ZFBsIeeCF8Clw4EPogUzaALn4u2DPzdD1Axp2VgO9UZzkGoKC+5x
         jQ3L1jFSURZP0e10yu4jKc+QxmXBFhoJpxrBZyRSWAUTiBxQP+wnn6gFwLFl3APHoCfR
         NdKlMejZMK1B88YB6AFc9DML7US1sc1SwdLpAoXrLPR13vX4889YRcezgEL3oFQh6D7a
         xHKMxNDor8IAJf5Xw0lLYSiUlYgbrnku9a8wSCgCww3dlTLlCTEtQt53GoV0gKow/FF6
         nS9HLs46Xtx4leXWhDadnWRSvrJ7tCWOcXXtxtLwYijVUe+aHOfNUdOXZxFHyYU2TKdu
         QMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IVxH3P+9Iy+HrTFa4exYvP8cScveZB2ldr4CEbwZl1U=;
        b=IEKFv/1U1PN4p73igbvA9/cUHvayKAwpxBc8RvdV3NK9x0GO44jZ6gWnxAUnqu/zn9
         d9cmpfiR7n1rRjQi9pHX5h5xg6oNv5ZVWUxbW+KFB5eiOW4dp/8RUMow181n1/vm0Nm0
         pZpGYrNSE5r4laYveXWUbwDXdUgVJiNPp7cFpsy0nHvo+weuXqQ5AmRjDaT8eCEwyAVU
         C8jbnrytgnSUoTcpKPQ4cdqC9pdG/rIBgdGQ5LCSq3nakzJJYFotxKlM8X0ENDtAbGtZ
         JG67iCzXHZrJYWjI69c09yIkHxf2Al+z/VLTcIcZwO49eoTwV3Sma1VODp9cNj0q8KxF
         udNw==
X-Gm-Message-State: APzg51DKW+EyhJemppJPh/HXbU7PjooLiwmB5vJzM2vBXQyySmzSOhbO
        7qBWC52B/qJUFpjwlsJJMFI=
X-Google-Smtp-Source: ANB0VdZwdGpkvMEaabPlwhK6BUvjO5t9f8y5OLoc2/eL3QCYVMaLWrJRPvqOopfXKPHljEggaZA2Bg==
X-Received: by 2002:adf:e3c4:: with SMTP id k4-v6mr7483163wrm.94.1536356301782;
        Fri, 07 Sep 2018 14:38:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r140-v6sm12662649wmd.7.2018.09.07.14.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 14:38:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 2/4] wt-status: rename commitable to committable
References: <20180906005329.11277-1-ischis2@cox.net>
        <20180906005329.11277-3-ischis2@cox.net>
Date:   Fri, 07 Sep 2018 14:38:20 -0700
In-Reply-To: <20180906005329.11277-3-ischis2@cox.net> (Stephen P. Smith's
        message of "Wed, 5 Sep 2018 17:53:27 -0700")
Message-ID: <xmqq7ejxvvhv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stephen P. Smith" <ischis2@cox.net> writes:

> Fix variable spelling error.
>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---

Thanks ;-)
