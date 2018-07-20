Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE0541F597
	for <e@80x24.org>; Fri, 20 Jul 2018 23:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeGUA1z (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 20:27:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52382 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbeGUA1z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 20:27:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so10808455wmh.2
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 16:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lpnLJ64KLG2KxGKJVKubiNZhvMKp5UlrKSOCg5uiA64=;
        b=HAYA4ahg0WmS7bd4el453wL+1OgIrJJWKDV4qDyNk+zU+jQyPETjJMXxUas496+Lhj
         nyeXKvJOe5hS+RPS3I/GDmRcgwrsLEOdiI9bXDo7BKTa1pthJQYSd8JV3qNzDcpU2Xy7
         4NuLdYjqDuVvMdrRrAvI4IWRWcUFP2K1Orc95OF2/VGxxd8weoZay9fPdR5HsjN9yMgs
         WniQblWl0fFR+lf185J3pCW0yfs72oMmFMEHJG7FwaDjEnF5grNNBGJOt3w4BUPgT2xG
         S7DVCb9AwG7uPLN928sioAuJzjtsj9AS2dGnZb37HsPM7ZvMgzyKg1Q5IuKsaTbTp1YS
         9fVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lpnLJ64KLG2KxGKJVKubiNZhvMKp5UlrKSOCg5uiA64=;
        b=Q9u0g7T/ofdfXSdn5IqhhnkUYfskhlorsOA5bbjaXSXQopzWDwxOULFpFc9z/xWz3E
         RZmSGdfiZX8fjuPPyzqev2CfHrjcyzyuAU3RGpnhBTGBb5A6x/zmox60ygckEgHscwJi
         BnLmlLIf5ZLqbSEH9M6c3iYYcngir8BRB8sb0Ea7uB1dpGd8XUsLy4ss/eohgYo0sMOx
         zuoqXstiVXpNL6M1pYa3eRo5AonO16dDfdWow/XLEnaTclaLKyx6qScutVioVez1ypcZ
         /sBrRPZp9ZEk1bBccFWt8buXqqLPLVqlonlZMhhKNdODfWAC18WDhx3wpiPLfQcHRyjK
         SWqw==
X-Gm-Message-State: AOUpUlHwBo0CYvQ17sfI+fUquFTTy0AUkmLJ5TSVML03+XrpPYAjFHlZ
        VvF4lvm0g5m+Bjpl0pYdrUY=
X-Google-Smtp-Source: AAOMgpelNDhkn/RrG1/9wHlwPeouIOd07yT+99sjWd0ujHIpQ7HMCd52yWjt77YUdOtzcw7L2Igx7g==
X-Received: by 2002:a1c:ea9b:: with SMTP id g27-v6mr2423378wmi.152.1532129845348;
        Fri, 20 Jul 2018 16:37:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c124-v6sm3234183wma.47.2018.07.20.16.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 16:37:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, Andrei Rybak <rybak.a.v@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Documentation: fix --color option formatting
References: <ccf73807-1856-1ce8-365a-0c4fb25ea7bf@gmail.com>
        <20180718174944.GB3084@sigill.intra.peff.net>
        <20180720223608.GE18502@genre.crustytoothpaste.net>
Date:   Fri, 20 Jul 2018 16:37:24 -0700
In-Reply-To: <20180720223608.GE18502@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 20 Jul 2018 22:36:08 +0000")
Message-ID: <xmqqo9f18onf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Both AsciiDoc 8.6.10 and Asciidoctor support SOURCE_DATE_EPOCH for
> reproducible builds[0], which should reduce the date noise.  We could
> also add a Makefile knob to set git_version to an empty string or an
> --abbrev=0 equivalent for such a situation.
>
> [0] https://reproducible-builds.org/specs/source-date-epoch/

I probably should take advantage of this feature and update the
install target of Documentation/Makefile, where I manually filter
out these noise changes between what is installed and what is going
to be.  That serves as my final sanity check before pushing out the
result of an integration cycle that updates the 'master' branch, as
that is when the pre-formatted html and man pages are updated, and
as part of that, "make install" for these two formats are run to
give me a chance to eyeball the differences.

Being able to lose the (impricise) manual filtering would be great.

