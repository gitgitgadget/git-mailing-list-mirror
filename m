Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0928820D09
	for <e@80x24.org>; Tue,  6 Jun 2017 23:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbdFFXoN (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 19:44:13 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35806 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbdFFXoM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 19:44:12 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so25667322pfd.2
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 16:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eXSFho0s7VY1JQTYZuECtUQkX0hczIrWpjiJJQe1/s8=;
        b=BpjGmBhrShChJSeyLIodS7BLlXHxjqluEk7M2vvgOF8bOnI7wvVP/0UTaIn8YyfJ8T
         H+BJk/Co2Yk2UwILhpqfhpaBtgInzzAev+Vq1JvnFyLQRNmHXmO0Pp5esHyMOeiKg2WY
         jDaaqgMeZoNRBn9+/nAng/wpgnpPr8JFD/WaTgzU+ir1P62Fl4yS91Fm+0UjPQ2CRr2Z
         KVGSbz0wOx3AvobTvuSu8dv/orbBT3KGdUlNdUdTsuuGt6kTSy8w2ckitq5D6dqrrO12
         tYY6LzYyKBPwbkK4scspq9p0G1Dp2M0F57MyGeIJisyf6v4nhCL4Ep3rW1MUjSCGKo3S
         +cCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eXSFho0s7VY1JQTYZuECtUQkX0hczIrWpjiJJQe1/s8=;
        b=XQv14R6I58Py43UYrJ0TNuPUXUivkf0/WtKl9CeAO19GgLD5oCGGfos/YwiL61SMTV
         L0mMpmMnVgfL3nFukL66X0QX++UJFr4Pdh3dDEQ+rGLzHz3yF0snYnbvrNpT8lncRX/8
         BFLA+1716k1znDyCBDoHN/mPOE/1/POaajEH6bG8/IjTREbpIVPTP5vnuziUqzmS+Bqf
         oqxIoRVUzybq632c3BluP2hQd1qwiPxRVslQm9G5N5uAbvlTzIhdhL9JR+uKxONS+jVN
         uiQjsRX0EPApC16JnIbRbkYEuyvHTo6DdysJ+He5mFVVMdsVHTdraq+eQvhCmtmD81UN
         jA4w==
X-Gm-Message-State: AODbwcApUGuXg0kl+aez7fwa8Z4ocERsVIWETHfcFpFMFHYyijpDisqX
        VV80ER5vUD9f/w==
X-Received: by 10.99.121.206 with SMTP id u197mr29241508pgc.29.1496792652225;
        Tue, 06 Jun 2017 16:44:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:411:1ad6:6716:25ff])
        by smtp.gmail.com with ESMTPSA id b72sm68910952pfj.36.2017.06.06.16.44.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 16:44:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        =?utf-8?Q?R?= =?utf-8?Q?en=C3=A9?= Genz 
        <liebundartig@freenet.de>
Subject: Re: [PATCH] docs: suggest "Helped-by" rather than "Thanks-to"
References: <20170605105341.35096-1-adam@dinwoodie.org>
        <CAGZ79kYZ2yTHxxRUjFZpFWsOWwmh6RBXRd0_a1K9kMTo4exD6A@mail.gmail.com>
        <20170606125743.GE25777@dinwoodie.org>
Date:   Wed, 07 Jun 2017 08:44:08 +0900
In-Reply-To: <20170606125743.GE25777@dinwoodie.org> (Adam Dinwoodie's message
        of "Tue, 6 Jun 2017 13:57:43 +0100")
Message-ID: <xmqq7f0o8ywn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> On Mon, Jun 05, 2017 at 11:42:31AM -0700, Stefan Beller wrote:
>> So I was wondering if there is a command that shows all trailers?
>> Similar to a "shortlog -sne" I would want to have a list of all trailers.
>> This is because there might be an even more popular trailer than
>> "Helped-by", but we would not know when using the hack above.
>> 
>> While I do not think so, it would sure be interesting to have a list
>> of all these trailers available.
>
> I just did a quick search with the following knocked-together command:
>
>     git log --remotes --format=format:%B | sed -rn 's/^([A-Za-z0-9-]+): .* <.*@.*>.*/\1/p' | sort | uniq -c | sort -nr
>
> The top 10 such tags according to this (which is coincidentally the same
> list as the list of all tags used more than 100 times), with
> frequencies, are:
>
>   61535 Signed-off-by
>    1641 Acked-by
>     984 Reviewed-by
>     673 Helped-by
>     497 Reported-by
>     180 Cc
>     174 Suggested-by
>     159 Tested-by
>     158 Mentored-by
>     128 Noticed-by
>
> As you might expect, there are a number of entertaining ones that have
> only been used once or twice, such as "Looks-fine-to-me-by",
> "Worriedly-Acked-by", "More-Spots-Found-By", "Looks-right-to-me-by",
> "Hopefully-signed-off-by"...

Thanks for an interesting list.  Your replacing (totally
unconventional) Thanks-to with more common Helped-by is certainly an
improvement, but I wonder if we should encourage people to be
"original" in this area by having that "You can also invent"
paragraph in the first place.
