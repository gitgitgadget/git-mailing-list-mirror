Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38FB01F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163065AbeBNThI (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:37:08 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:38731 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163004AbeBNThH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:37:07 -0500
Received: by mail-wr0-f179.google.com with SMTP id n7so1111468wrn.5
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RSVunph0aGcxOXqTpo8kJoAzht8x+NRRxxTOm3BgeZI=;
        b=FWU4wWy8aT8NuKSCpHFSmH9wWZrEqTGn83PQPlN8JTxiOVTwVePLrwozeDlfnsCukI
         uPvz/pcpAyJx8IHDlhDBlXlLxx0ywp2/fTKYJwFH2fM7ODvwEkfxByVrCpiw44BKh275
         jVVU+nfXZQk81nqdOd9MGeqenPsZ+GpD2UZSigcT1KC7TTgBcQEqqPc0+Sq4U3dLhyXs
         xNj+hMeSYQICB4jaQCsBW19b1oPSz730f4mwm837dehqDV4skfHCDIRA1Fl9PsXdJzNy
         VCiyKtQPqOlrYEZCV05Cu6mLv7/Dxq8cZLoHRL3O0KxeTQrLKviAP03ZEL4rMsZAq51N
         QDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RSVunph0aGcxOXqTpo8kJoAzht8x+NRRxxTOm3BgeZI=;
        b=AaVB2gMHDUuafF2ScCQSdEvDrKynevG1EfoJ/9uA1NeR1GC4i+rsGr4hF285s7KnPu
         MlCl5eIVoRQLwdg4vpnAxDVc5/BBm3+qZRdbHQdAU5HzKd96RwiECgQfcnTVvkQYqHDF
         9zRtGRMr0Nl1YQ75DAUM9kG+zlU035zPWsvowoBKuRzA89OI9zEZuVY/t6vodsZhyjYU
         /c0aFOjZo2ymWHi1UYIxHsosy3SUPWaI8TMa/Gn/5UJlooDRazYItXxbjofy/cub72BO
         C/3i8y43wn+jcN+kUKQQsu2skb2LnsP+jgn4rh9gqjvFksynqqZi3bLixyRFJjcNvmmk
         ORTA==
X-Gm-Message-State: APf1xPCcdwsFu1wZ9ve02gTMCdTQIm3ZvHmh1aug4jxGA0nMocYiOcn+
        vKzYgoiwjU9ZlAFJm5sk3wo=
X-Google-Smtp-Source: AH8x226uh0LqhyrEY6lJTZ0KrmdUtxZh/bmS3azZL8KSPOismtIB6hKL2n1du3CZhtHZUosgIfJNhw==
X-Received: by 10.223.201.147 with SMTP id f19mr292496wrh.61.1518637025501;
        Wed, 14 Feb 2018 11:37:05 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e15sm9583648wmh.39.2018.02.14.11.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 11:37:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] Correct mispellings of ".gitmodule" to ".gitmodules"
References: <alpine.LFD.2.21.1802131907480.17291@localhost.localdomain>
Date:   Wed, 14 Feb 2018 11:37:03 -0800
In-Reply-To: <alpine.LFD.2.21.1802131907480.17291@localhost.localdomain>
        (Robert P. J. Day's message of "Tue, 13 Feb 2018 19:09:31 -0500
        (EST)")
Message-ID: <xmqqpo57mkgw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> There are a small number of misspellings, ".gitmodule", scattered
> throughout the code base, correct them ... no apparent functional
> changes.
>
>  Documentation/technical/api-submodule-config.txt | 2 +-
>  contrib/subtree/git-subtree.txt                  | 2 +-
>  submodule-config.c                               | 4 ++--
>  t/t5526-fetch-submodules.sh                      | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
>   can't believe i forgot to sign my own patch. le *sigh* ...
>
> diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt

Just for future reference, the diffstat and summary comes _after_
the three-dash line, before which is your sign-off, and after which
you can have additional comment like "can't believe...".

No need to resend, as I can remove the cruft from the log message
while queuing.

Thanks.  The patch looks good.  Will queue.
