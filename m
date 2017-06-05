Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30D4209FD
	for <e@80x24.org>; Mon,  5 Jun 2017 11:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbdFELgc (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 07:36:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33514 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdFELgb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 07:36:31 -0400
Received: by mail-wr0-f196.google.com with SMTP id v104so7196975wrb.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 04:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HgqiMdeQAzG4Zr7djyoxtopfoH+Jlormp6xs2rusX8Q=;
        b=UCI/FhnrA5WW1I1h/wuUOnckdAtuR2Zchbt/xBwZe2d2/VwcuMbYKyGQ6Pyn1dYzpA
         +dE4bJ6El0iKfglLNkZWjbcr9NsQ6zCcxRytV79BuaP+9dUwQQbi9OAnl5l9xA31ZscQ
         Uf4I3G1vKdoJ2NI66a6Tdtj3B6oAnvq0RIhY183tbS2POqLL/+ivw7J/jq830SBvl/OD
         QKr6KubaxmsiWfnvOOGH/mT1zuuyXcp4oeFRu2/uCI49PfYT2ECZ0jxuzTtUjZA5yzu6
         Ia0p0a5HMNZMwN7B8qAztKLrjKyErNqH2nyeIVbXaMi9D2t39FR/Q6DL7lnRAog6UUO4
         c4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HgqiMdeQAzG4Zr7djyoxtopfoH+Jlormp6xs2rusX8Q=;
        b=C2xCRbFW+V8eoMvlNzZoLqbzd5ILRn6ZkBv84MrB1ASPlx48f0VCeOMfu5OBOBnpdU
         4JbHI0HnScDz7SQsQymTdniNarL0nQGeOaFfzNhFNjjgrThWrK7+hmR0efY5EgbTx/Bh
         CXAqUAU9nPtrDwNULp/0hEnfDDbK/J8P9sTxv+1PrADt5Ft/FpKZImrJb2XglNi+VQdg
         +iwhv6SsNLlaMBeZPrtmD6rtArOg4s2RhiUlPinav7L5Fdgo96yR6aey7zRum7ISTYrg
         Ve5OtZJ0nPv8TqykKuF6zhaGgl0kDbY0orQhaXvvqDSnKRMAkL5bxLwFX0tzkpGtJMry
         21CA==
X-Gm-Message-State: AODbwcBcjmjlEolur6Mtfr2EviTyh+AuGIdQ6Cr23+04i0nvTGA9dNft
        4PfK+vIrGyd/mA==
X-Received: by 10.223.164.220 with SMTP id h28mr15464295wrb.24.1496662590158;
        Mon, 05 Jun 2017 04:36:30 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB44EB.dip0.t-ipconnect.de. [93.219.68.235])
        by smtp.gmail.com with ESMTPSA id e73sm9840156wmd.1.2017.06.05.04.36.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 04:36:29 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 5/5] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq60gf1650.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 5 Jun 2017 13:36:27 +0200
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        e@80x24.org, ttaylorr@github.com, peartben@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <AD0F28DB-9E33-4F72-A632-3AE5C35A7A1B@gmail.com>
References: <20170601082203.50397-1-larsxschneider@gmail.com> <20170601082203.50397-6-larsxschneider@gmail.com> <xmqq60gf1650.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 02 Jun 2017, at 04:21, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> ...
>> +After Git received the pathnames, it will request the corresponding
>> +blobs again. These requests contain a pathname and an empty content
>> +section. The filter is expected to respond with the smudged content
>> +in the usual way as explained above.
>> ...
> 
> Random things that come to mind (which I suspect has been dealt with
> in code but not described in the above in detail):
> 
> * Using pathname as a "delay key" would mean that we assume that a
>   single helper process is spawned to serve only a single Git
>   invocation (as opposed to be sitting as a daemon accepting
>   requests from instances of Git invoked much later than the daemon
>   started), which is OK, but it is somewhat unclear when a filter
>   is allowed to discard the requests that used to be outstanding
>   from the write-up.  Imagine Git asked for A and B, both of which
>   was delayed, and then asked for a list of available ones and
>   learned that A is now ready.  
> 
>   - Is it an error to ask for B at this point, and if so how is the
>     error handled?  Or will it turn into a blocking operation?

It is no error per se and it should just work. If CE_DELAYED is set
then the filter could even delay the blob. However, I would consider 
this bug in Git that would need to be fixed.

Would this make the documentation clear enough?

    After Git received the pathnames, it will request the 
    corresponding blobs again (and only these blobs).


>   - As A is available, Git can ask for it.  After retrieving
>     smudged content for A, can Git ask for it again?  Or is it an
>     error to do so, without starting over with another can-delay=1
>     request for the same path?

I'd consider it a bug if Git asks for a blob again. How about this?

    The filter is expected to respond with the smudged content
    in the usual way as explained above. The filter can free any
    resources associated with the blob after Git acknowledged
    the delivery. Git will not ask for the blob again. 


> * The pathname does not have to be encoded/quoted in any way as it
>   is just a payload on the tail end of a packet line, so I am
>   guessing it is just a sequence raw bytes.  It is somewhat unclear
>   in the above write-up.  Also, is this considered to be a part of
>   "textual" exchange over the packet-line protocol, where it is
>   customary to remove the trailing LF from the packet?  "We do not
>   support a file whose name ends with LF" may or may not be an
>   acceptable stance (I am personally OK, but some people who use
>   Git may not), but it needs to be documented if there is such an
>   issue.

How about this?

    If the filter supports the "delay" capability then it must support 
    the "list_available_blobs" command. If Git sends this command, then 
    the filter is expected to return a list of pathnames of blobs that 
    are available. The pathname packets send by the filter must exactly 
    match the pathname packets that Git requested initially.

Maybe even "must match bit-exact"?


> * The continued request throws an empty content in the above
>   illustration.  Is a filter allowed/encouraged to assume that an
>   empty content in the request is a continuation?  I am guessing
>   that the answer is NO (otherwise you cannot filter an empty
>   file), and it somehow need to be documented, perhaps?

Correct, the answer is NO. Would "irrelevant content section" be
OK or should I try to find a more explicit way to document that?

    After Git received the pathnames, it will request the corresponding
    blobs again. These requests contain a pathname and an irrelevant 
    (usually empty) content section. The filter is expected to respond 
    with the smudged content in the usual way as explained above.



Thanks a lot for the review,
Lars
