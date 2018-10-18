Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6361F453
	for <e@80x24.org>; Thu, 18 Oct 2018 04:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeJRMjd (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 08:39:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40027 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeJRMjd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 08:39:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id d2-v6so32024293wro.7
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 21:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bUonOvRYP4rVMUPeWl3OJHGuKirvjaaYCIBaNsORm6o=;
        b=qnn4UCw/cVPRNN0XxhPKPXTQBU+v7U1R2qfn7atKjnH7of+BVfy1hQFZpDSOSj6kWr
         X2qtEx8mQgPWBT+Qv7CsqEpxSJCI1Z12kJ7MRrwQJHKuEWTzAx+ZnHf9Dxlo4H1mbol3
         V7bGJNpigwinEAh5WZjaxvOTVwLlzl+KF2IAgpKGsgGRHCCfDK3a4gue34XqGePfz45m
         bugcxTSC9vw+wLwksmCqaj2mcqPIqKWnW+enWdD4iAhWhiuum5Pb4EIlNZypAKC/coGz
         iYl+GNRVgU11kFIuAflhZnENo3BfIJcxvRYSPgWoF1G79kwAXERzeLyOBt4xIZcfZ//P
         3GNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bUonOvRYP4rVMUPeWl3OJHGuKirvjaaYCIBaNsORm6o=;
        b=CB1m1lsWOwCbZbOmJ1VkYI0fyfFiYL1N3DdZORZddSZPhmTRpyLPsPaDJm4dPFFMAa
         NOr6BnyXMR/U4Sn+x/N5AW2Gf7Ehj6UztFGCM8efS3fsEhTpV/2POcyws0wMmwEyf6bz
         xYpD9xRbcd6mHtDwdVfypELl18i44MP0N+hXV1ppQUgb5NbRbDZpF/kVaa5KNzZ/eju6
         zTUt6jTPs5mzOoC0ubjZF7MnIeYMyI4FNQnhhl9jJLcW7inOI9IAC5f1QpW95/eh7Ula
         jAmDOoDNxT59cxyv2Gc0zCF9HA9bwWcM9oMsYCWYoPMddinuSKCbrxmnKAi8qLjIxz0d
         yqTQ==
X-Gm-Message-State: ABuFfojtUypotByWMlbfQM94rxMM6dgNVZzm6kqDsDHVbMkXt7HO1X8g
        hxZ7o3j4gRdW6V0IqtsDlrQ=
X-Google-Smtp-Source: ACcGV60C4HItbHd8eIBao1qvEi77RI0uhVpDPAbkYVhjcvRT9LSEABYR4V0YRY2qQPqQNvvUG8JxtQ==
X-Received: by 2002:adf:e542:: with SMTP id z2-v6mr25239758wrm.53.1539837629067;
        Wed, 17 Oct 2018 21:40:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y125-v6sm4629976wme.12.2018.10.17.21.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 21:40:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH v2] headers: normalize the spelling of some header guards
References: <b33346d2-88bb-989a-356b-43a7c357a7dd@ramsayjones.plus.com>
Date:   Thu, 18 Oct 2018 13:40:27 +0900
In-Reply-To: <b33346d2-88bb-989a-356b-43a7c357a7dd@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 17 Oct 2018 23:13:26 +0100")
Message-ID: <xmqqd0s7vpdw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio,
>
> Since I didn't get any adverse comments, this version has the RFC
> label removed. Also, given that it seems the vcs-svn directory is
> not going away soon, I have included those headers this time as well.
>
> [Note: my email client (thunderbird) was updated yesterday to 60.2.1.
> As a result of recent reports, I sent this patch to myself and applied
> it with 'git am' and ... the results seem to be fine! ;-) Famous last
> words!]

Thanks, will queue.
