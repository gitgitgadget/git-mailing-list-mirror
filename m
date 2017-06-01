Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C8720D12
	for <e@80x24.org>; Thu,  1 Jun 2017 02:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751105AbdFACGV (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 22:06:21 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32894 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdFACGU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 22:06:20 -0400
Received: by mail-pf0-f172.google.com with SMTP id e193so23458151pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 19:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nSTiH1ap05B9HdQK6Hq9cWf+KCHfDbVBoqHOBmKEVsU=;
        b=m42XI2BvRu/YKBKdVNGQgSRh58GfGfgTUA7xzM7Lu0GCEkzHEfgjnaSxcqa/xTGou0
         AivMV4L3YQEURnuYx2aylMIrBu+iCW6+0K+A46BhoWL1A3ZvPSxd0z7XqxjBGFRPM/Ew
         0nwSh5UUQxGUUDAwHozRnmfVHrz78qoOnsTQAtXu6COFVueSvIRDhIt9amiqQzyddhKH
         tPIeB6cmbsz7Epuz9IN/QtpaqOk67iM4+OhomE932qmNPU/Ur2z4kDKbA5HBOJZgGsge
         9h784r3M00ad3j2BebIkd7WT/O/pXJmSqv/YGX3306eF0TwrNDCQiX5AfusB1x0ViShk
         9gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nSTiH1ap05B9HdQK6Hq9cWf+KCHfDbVBoqHOBmKEVsU=;
        b=R1FXa0S7iYxbbMHz1ihAikCuir/M6Cpr7wUTD0Dtd9hdsfdd1tMFN6XhzXf7+FvS0S
         ZZppcVCvJtkcNFiRiQViTSaj7/8zRGIk2IhoHpq/xBdFPqrorxaMqNOfot1j6w4GZWhq
         I92/IDVSRmM7dZZ4DaJEVPeF9chhc9pUaFowar8rbUCC8B1bmzNOKJyXWjkkuC6XmVbu
         8pgJ3oGSgPRS/6EMUrV6GtIWiuaemnvjqWnsZ9sYdz9U3Q8zrbMc1aXy2N9AUjd1mNpM
         tyRyROXsXJQqZKWp+kI1FbFMKgXWnJ6mvmT4HSjFR5k3HnzYinUhi/+UJ4Yv9RohuTlC
         UTug==
X-Gm-Message-State: AODbwcAHHBBPVGw6/J4rihUhYNMbiEKMyiynRCPlE9BLI84t73Q6kO5C
        LDAIMpIk10metw==
X-Received: by 10.98.206.131 with SMTP id y125mr33664477pfg.108.1496282779790;
        Wed, 31 May 2017 19:06:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id 15sm29158857pfj.59.2017.05.31.19.06.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 19:06:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
Subject: Re: [PATCH] docs: fix literal quoted spaces
References: <20170531150624.GC18266@dinwoodie.org>
        <20170531160721.4yimitnyy6pdxkq5@sigill.intra.peff.net>
Date:   Thu, 01 Jun 2017 11:06:18 +0900
In-Reply-To: <20170531160721.4yimitnyy6pdxkq5@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 31 May 2017 12:07:21 -0400")
Message-ID: <xmqqy3tc797p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, May 31, 2017 at 04:06:24PM +0100, Adam Dinwoodie wrote:
>
>> When compiling the documentation, asciidoc thinks a backtick surrounded
>> by whitespace shouldn't be interpreted as marking the start or end of a
>> literal.  In most cases, that's useful behaviour, but in the git-pull
>> documentation the space is clearly intended to be part of the monospace
>> formatted text.
>
> Good catch.
>
>> Instead, use + to avoid asciidoc's literal passthrough, and encode the
>> space as {sp}.  In particular, this means asciidoc will correctly detect
>> the end of the monospace formatting, rather than having it continue past
>> the backtick.
>
> In these particular cases, is the space adding anything? Would a simpler
> fix be to just use:
>
>   ...the value on `URL:` line
>
> We've had such headaches with other entities like {sp} between different
> asciidoc versions (not to mention asciidoctor) that I tend to reach for
> the simplest solution.

Me, too (and no, I am not from AOL).  If `URL:` is typeset correctly
the approach to drop the space is much more preferred.

> (I'd also suggest the minor English correct of saying "_the_ URL line";
> that's orthogonal to what you're trying to fix, but may make sense on
> top while we're here).
>
> -Peff
