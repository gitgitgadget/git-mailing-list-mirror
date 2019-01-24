Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34F531F453
	for <e@80x24.org>; Thu, 24 Jan 2019 08:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfAXI6B (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 03:58:01 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33019 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfAXI6B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 03:58:01 -0500
Received: by mail-wr1-f53.google.com with SMTP id p7so5588313wru.0
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 00:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=l/iu68zH/E0+UWOtgFKQ7h+oaTD5/APl2lHIZaRtZCw=;
        b=Zx9O2cs589cW92wL4z12x3EFkqCvsy66fyf8w3y/666gt7kuwGpTzSWrHdeFrXq6FH
         rIn4LOZLB19ejUJWmALpnaDofv9kTFzsfSEhjChZG2zJlgMVb9QdyKecLs45aJIu85Qa
         NvAJGFuk0fsiRRMLe4Oabrzfi1TX4gNGUWQImrs1dUP6YOwPXhqYAVPGaWJh66nx+Cj/
         m1gOoCiuxy/Z4hdOKesmJaCjGAZFwEh4UOKgjhpac05QdPG0Q+TFvgTIIF+8lR6c4Aw7
         nc7hoCqpZUjU7P7gHaejUbneUfBalposeHPZ5o6K2+QdQ1T6LP2zsU/U8C5eiHjYeuzW
         et8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=l/iu68zH/E0+UWOtgFKQ7h+oaTD5/APl2lHIZaRtZCw=;
        b=FWaKS50NLX2pb0DfJAI16KX9X+qquto2UCYRG49M9XbFGIF8lVU7hv1l0QKO2hEUoI
         eQEYOniISbA2Pz0mJzARCQ2ZbRjW8MPEY2bGmSIscM3MNGJMuiM8IZbTgeyxkgS18OBu
         yiUjuAVhT2y21p2J6OL5hv105TMZ0Yi7WF0sb+pEBnr+zYTLWjB8fPyuUmzplWBxYs9F
         fz5hdRwrfUgUgywLRVBQQztpKUNXTtheG798olZxi6l0+ivJd5SbGllFHY2rUrocnEdh
         ZAIJXN5qVv+GN8+7sSwXdvUp6N9OmRrfunE+aTjN4StHQHzMbwHvfC98t+3idkRJsY/A
         3ZCA==
X-Gm-Message-State: AJcUukeCpOnaioli7s72InBML7xb+QZl25KUp74YFuXm6557VTGN2cGT
        sHYbZWYL3AeicLJI56u1k9tfM3qP
X-Google-Smtp-Source: ALg8bN5xGXrQowvYA+ZSlvJnpkYU7kRLp8og1ZN0c61nArrEg5jc/Uy5fILwDVBROcBgA6uOBDggpA==
X-Received: by 2002:adf:e891:: with SMTP id d17mr6705616wrm.140.1548320279831;
        Thu, 24 Jan 2019 00:57:59 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id g16sm92355746wru.41.2019.01.24.00.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 00:57:58 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Contributor Summit Topics and Logistics
References: <20190122075027.GA29441@sigill.intra.peff.net> <4dbbdd75-e71b-d6e4-123d-dddc7a9d8a67@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <4dbbdd75-e71b-d6e4-123d-dddc7a9d8a67@gmail.com>
Date:   Thu, 24 Jan 2019 09:57:57 +0100
Message-ID: <87bm464elm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 22 2019, Derrick Stolee wrote:

> On 1/22/2019 2:50 AM, Jeff King wrote:
>> For people who want to try to join remotely, I don't think we're going
>> to have a particularly fancy AV setup. But there should at least be a
>> big screen (which we typically do not really use for presenting), and I
>> hope we can provide some connectivity. I'll be visiting the venue the
>> day before (Jan 30th) in the late afternoon (Brussels time) and I'll try
>> to do a test run. If anybody wants to volunteer to be the guinea pig on
>> the other end of the line, I'd welcome it.
>
> I would like to join remotely, so I volunteer to do a test run. I'll
> need to wake up early, so let's set an exact time privately.
>
>
> Topics I would like to hear about:
>
> - commit-graph status report (I can lead, if I'm able to join)

While we're at it it would be useful to discuss what attendes think
about making core.commitGraph=true && gc.writeCommitGraph=true the
default.
