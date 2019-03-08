Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E186520248
	for <e@80x24.org>; Fri,  8 Mar 2019 01:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfCHBlZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 20:41:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38119 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfCHBlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 20:41:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id a188so10967561wmf.3
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 17:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6V/JvTc6+xe/fsT8xGM/ZeqvtrJQ1fBkfqA6RbAUYFM=;
        b=tmzOwWuBFIL11zFoHHYn4cGGEmbMsPW0KUBUyKfsEZP/hlD3/txgPssnMuYUuAyf8u
         Zu5zLVis9ec54OcLl7EqT9/Jf0arNGEA66EgtHgihUpJgaM8kDoPWJl4b0lA72UNSbUo
         DC/Rh/FFGf7FUSKU+JRtEzgt+hbsdaIQs1uGCRTtsAMPnfHzzds6jD3Za2XfRQ+l6FmK
         Q20KtsXlX3mVjcB8rgdoVqw4Hrl3ADgRXvEb15lDOXhSO6DX0n5l0CvhyIcptBBJkYv+
         tBdfJ/0gWjpvcdDtvnBFMu+sC16hsZdFd8iScZVcoXeX+ze2okCveMrL/vVfqziA+iVd
         XeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6V/JvTc6+xe/fsT8xGM/ZeqvtrJQ1fBkfqA6RbAUYFM=;
        b=shMmj6DZE0tifNtBqLyJzeYu/kDYilvmPtEafx2mVecvf9nxGmls+qAoWwfKSWtrxb
         KmfHDxFjEsxiT7Fw9wtqjAmZiC9MjT5xpNN7U4A7mm5qAGU/8B0ArFyt4XhTNETp5oTI
         B8CM2M+p75RRD2SNXR4Jh5iVVf2ExTfUlfwyHy/M6BaM/GgBDeMKKzZX9PA5VtO/nR2w
         Waw7aK6FLS/7o6GNv0wqcF4veNAKoYlCYhXLemqoAyJfGk/yjDEh23ROmOvFpY/JqBcL
         Jo+zZXgR1P+9FMKsILK5Ku7w2q09cjDRFj2vvoTLUW4WoNi4WVLOwGzRfP1WysCOWK4X
         6eJw==
X-Gm-Message-State: APjAAAXhTY4zMOS+MyKs01tkOQ+Ww3FrLqn+h5OT2nXg8zMyiv34FrDA
        4iTKUtra2MvSm5boYYPlXvboniIuBz8=
X-Google-Smtp-Source: APXvYqyPQ5gZFKA3fHJIQOjgEhEHTrEY4fCvQ7IUraWw3G88WlqpQVeBmvZ846SYkjZdiP83z93n0Q==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr7234153wmc.7.1552009283452;
        Thu, 07 Mar 2019 17:41:23 -0800 (PST)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g81sm8285912wmf.7.2019.03.07.17.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 17:41:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Drop last MakeMaker reference
References: <pull.146.git.gitgitgadget@gmail.com>
        <xmqqfts469h5.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1903071109020.41@tvgsbejvaqbjf.bet>
Date:   Fri, 08 Mar 2019 10:41:22 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1903071109020.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 7 Mar 2019 11:10:24 +0100 (STD)")
Message-ID: <xmqq1s3ikurh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Sun, 3 Mar 2019, Junio C Hamano wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>> 
>> > Back when we stopped using MakeMaker, we forgot one reference...
>> >
>> > Johannes Schindelin (1):
>> >   mingw: drop MakeMaker reference
>> >
>> >  config.mak.uname | 1 -
>> >  1 file changed, 1 deletion(-)
>> >
>> >
>> > base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
>> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-146%2Fdscho%2Fno-perl-makemaker-v1
>> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-146/dscho/no-perl-makemaker-v1
>> > Pull-Request: https://github.com/gitgitgadget/git/pull/146
>> 
>> Good ;-)
>> Thanks.
>
> Gentle reminder that this has not made it into `pu` yet...

Thanks.

I'll try to make it a habit not to respond to 0/1 (but instead to
1/1) as it is quite inefficient to get to 1/1 from 0/1 at least for
me X-<.

Or perhaps GGG can learn to avoid 0/1 for a single-patch topic ;-)

Thanks anyway.  Will try to apply directly on top of master.
