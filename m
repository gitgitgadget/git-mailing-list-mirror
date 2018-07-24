Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E42DA1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 20:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388974AbeGXVzu (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 17:55:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33738 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388765AbeGXVzu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 17:55:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so3701660pgv.0
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VTFakPJKHxiCmjECZ6FUeIFumDFCPisWDWjWHPITxR8=;
        b=gZng0jFLX0jTetH6XEFSHG0baweDQwMwkGU4Pua7j4aS4JLvdM9rjBVbvvhqcC9qlV
         /AfdNmc130gX2jf9J8FJLE7d275VibBNX9A4wpVC8EQzSKNXinPWOMKi/8b6nzXL1O93
         CV+ILOb78wX7T32klkm/vbmSLLGklSmzza0UPgvKebnfsZEij3DF92vhC55t6lu2fWH3
         yQjl8CtqoE2h+SQe1WdEzK4ukD7EMHfCsTuGrhjd5PWMyknIaHOVhaEr+xbspWGHn+KE
         G7HORLGPv1e82gg6IIVhMGHMIuC6zEtoNYsm7ZL3ObaY9wHc/CzpUFRD3iqYgqKKOMFE
         GE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VTFakPJKHxiCmjECZ6FUeIFumDFCPisWDWjWHPITxR8=;
        b=EjvsVLT1JS7HPb9Bj5kehV+SqgqWzrKsE1BBMQ11bcgS2gyPhup/TwInpVyg6v1BLY
         mOUbnDD9HU3WbuIg/8L6foT4xZlvZFCkqcn7J2nUoupY/XCvfwrNG+YvFQGDZc5yjg8V
         3Cmh7xnvHIf29GKygXOIGI76hJJIzyCnLBx9YEUVsFNiOM2LdeuQ7KkKwrpZCQog0Gjg
         6O6jyb6vJ44dO2XuzkP89XSHRIxl6/m0WHRfp7KHU96ejg7xoGWLvXjjAXEvqBoFgYE1
         bCMEL6PxQSTSlxJhFVlAv/ODnqnNoiwppw7UNokWUGF72SM4okYATQ3unGZmjmyTTxx7
         I2gQ==
X-Gm-Message-State: AOUpUlGglbo7QaImS36HYJ8V6Qxih1RUF+vE/6VD5SYD0V/yeqq8H2NG
        o7LUB97lk3A7iNNyQd9V2YlhaA==
X-Google-Smtp-Source: AAOMgpcAHUapXTc0amCLCr7AwNm9bxrTRUt5rHhFWCLXzPiCwmhTQzn4wwYW+fnhFawUhSGOhi41Ug==
X-Received: by 2002:a62:87ce:: with SMTP id i197-v6mr19237945pfe.62.1532465255565;
        Tue, 24 Jul 2018 13:47:35 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id t76-v6sm20647753pfe.109.2018.07.24.13.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 13:47:34 -0700 (PDT)
Date:   Tue, 24 Jul 2018 13:47:33 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] pack-protocol: mention and point to docs for protocol v2
Message-ID: <20180724204733.GE225275@google.com>
References: <20180723174807.28903-1-bmwill@google.com>
 <20180724045233.GB208393@aiede.svl.corp.google.com>
 <20180724181913.GA225275@google.com>
 <xmqq8t60xv7l.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8t60xv7l.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/24, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> >> Not about this patch, but I wonder if an organization along the
> >> following lines would make sense?
> >> 
> >>  1. Rename pack-protocol.txt to protocol-v1.txt.  Rename
> >>     protocol-v2.txt to pack-protocol.txt.
> >> 
> >>  2. Make pack-protocol.txt self-contained, and remove any redundant
> >>     sections from protocol-v1.txt.
> >> 
> >>  3. Add a new protocol-v2.txt that briefly describes the benefits and
> >>     highlights of protocol v2, referring to pack-protocol.txt for
> >>     details.
> >> 
> >> That way, newcomers of the future could read pack-protocol.txt and
> >> quickly glean the main protocol in (then) current use.
> >> 
> >> What do you think?
> >
> > I dislike the idea of renaming protocol-v2.txt to pack-protocol.txt.  I
> > agree that we should probably have protocol-v1 broken out into its own
> > file, taking the parts from pack-protocol.txt, but what really should
> > happen is that pack-protocol.txt could describe the basics of the wire
> > protocol (pkt-lines, the format of the various transports, etc) and then
> > refer to the protocol-v{1,2}.txt documents themselves.
> 
> WRT the naming, are we happy with the idea of (1) pretending that
> when we say 'protocol', there is nothing but the on-the-wire
> pkt-line protocol (i.e. that is why we call "protocol-v2" without
> giving any other adjective---are we sure we won't have need for any
> other kind of protocol?) and (2) tying the "pack" ness to the name of
> on-the-wire pkt-line protocol (i.e. that is where the name of the
> original pack-protocol.txt came from, as it started only for the
> packfile transfer---are we happy to keep newer protocols tied to
> "pack" the same way)?

If so I suggest we move away from the term "pack" protocol.  Mostly
because maybe at some future date we don't only want to communicate to
transfer packs.  So at the risk of bikeshedding (and because naming is
hard) I think we should begin talking about the over the wire protocol
as just that, the "wire protocol" or if we need to be more explicit the
"git wire protocol". Thoughts?

-- 
Brandon Williams
