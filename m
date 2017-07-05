Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EB79202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 19:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbdGETuS (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 15:50:18 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32835 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbdGETuR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 15:50:17 -0400
Received: by mail-pf0-f194.google.com with SMTP id e199so37302601pfh.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oD2pqIbH1iLbYAeO5Vo8Nsn0b6vNIpD9dwFqZMZO0VY=;
        b=J8Fh8sjs7sUEKlFQH02KnB5cxdRic1osBDxD0QaAUOBLtGKdDj5hZYoLsSC5DG0GIX
         +1vSuUEkoqQ3bQg9LA/Lm78yvsmK75Z2EVZVkyQxMBi3fSGasofrclFn0Cmt8Jr1dv2Y
         WTwi1eEXDF55Zod+AeZdj6Nd81ea1Y2IiE0faZue+WKQ+mDVisSwdYzuamFdDmtpZJvn
         L/dBKoShzl5Z0jOGnw6Q0gVT4lUXwxQUgp3uLvB9JigwmkjeK5Z/yQFurRunRj01k7zA
         cmncsIvjT5ZaAWefQoldW0b9EaCkVLX503R9cBNjyNauCBaAhXpEBLnWvaddEN6Hx8lK
         9ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oD2pqIbH1iLbYAeO5Vo8Nsn0b6vNIpD9dwFqZMZO0VY=;
        b=aRXVlIgbi+baG+St5VS1IunwRik7+ZTFySPusTyvLMh1oz6FP2s3Qm+l/piN72YcTx
         Ha/RtdYoRNToPD+XGAZj5HfrLRFN3EVydUXPpDBWqM+8o6ku1sZ9WskGlbF1IeRgUlcm
         A/baMQZTkGG60IMo/Jb2yxCw4WRkql8FP9b+PUQphsA4Ape9K1wtu+NIoVi2iR2N2VCg
         gql8gEK2GcWmoKerx6lqaPScfymkqtkEQq+Ag3X52QESJcPj8EoSp91yPdzeN1CpLlfW
         HesWKqQA2pF4WWrb9X8pYK6kL6I/C7YEysdrRXe8pG8guyh3ybTHHNja03g8HNq/ST3q
         yfWg==
X-Gm-Message-State: AIVw111sDkuYPCzuHQXulQ7dgp2v8lIeWo13TRPVXBuUIXQbGq3R5NXT
        QpcMqPA2lFsVMw==
X-Received: by 10.98.42.207 with SMTP id q198mr22488535pfq.143.1499284216742;
        Wed, 05 Jul 2017 12:50:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id q19sm59729562pfd.24.2017.07.05.12.50.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 12:50:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] hooks: replace irrelevant hook sample
References: <20170702112728.15757-1-kaarticsivaraam91196@gmail.com>
        <20170705165114.20662-1-kaarticsivaraam91196@gmail.com>
Date:   Wed, 05 Jul 2017 12:50:14 -0700
In-Reply-To: <20170705165114.20662-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Wed, 5 Jul 2017 22:21:14 +0530")
Message-ID: <xmqqr2xuhde1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> +sed -e '/^# Please enter the .*/ {
> +  N
> +  N
> +  d
> +}' "$1" >'.sed-output.temp' && mv '.sed-output.temp' "$1"

Three things that caught my eyes:

 - Between "git commit --cleanup=strip" and "git commit --cleanup=verbatim",
   lines that make up this initial instruction section are different.

 - "git grep 'Please enter the '" finds that this string is subject
   to translation, so the pattern may not match (in which case it
   will be a no-op without doing any harm, which is OK).

 - core.commentChar can be set to something other than '#', so the
   pattern may not match (I do not offhand know if that may cause a
   wrong line to match, causing harm, or not).

As merely an example, it probably is OK to say "this won't work if
you are not using the C locale, and/or you are using custom
core.commentChar".  So if we disregard the latter two, I would think

    sed -e '/^# Please enter the commit message /,/^#$/d'

may be simpler to reason about to achieve the same goal.  

Thanks.
