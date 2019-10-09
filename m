Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFF961F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 00:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfJIAWt (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 20:22:49 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:35198 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbfJIAWt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 20:22:49 -0400
Received: by mail-pf1-f175.google.com with SMTP id 205so424997pfw.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 17:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4gPgnOS7RPGQ+dh8fZ0cfopTCWp6V005TQk+gKIOfJ4=;
        b=FKJ3nx8RAJnherCS5XJ0Tslh2aiUON2Ww4hfJ2zM3WF28dUbEUFPEnV1OLnk3co2Bw
         2xGWgZ17eUWz0lq/pOZyF5fNbJo5JIi1RDEgH1kXkW5zAkEMJW8UBvwGy0grGh+Wf7Nd
         e7j6WRnf5PhiAiasKOOFD+QTuNps1XEQHoBWlwrroXiagLJD29aFl3Dch/I89LxwB9bx
         9KZvZerYV7sH3YkH4TzIRf7sMWCmtTpDrn22cZrNF4GW+CfGxwFTawKrwIlu0V7PrKt4
         lvEOM0slYdw8aNvopik2x8RLXTM7LEzyNhhygEhQSdnJwDgJkSfKLZhFK/ITmtZiWWdu
         yo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4gPgnOS7RPGQ+dh8fZ0cfopTCWp6V005TQk+gKIOfJ4=;
        b=ZvHYL96/0TnsKBlLYYgf5xffAVQy4+/YgHlmcDbQD1voy/X9mxm9/cSZ3538r+J44S
         oqYiX+eJbnroE+JM7b8LFnRj+B1z4BgR5LLjA57wOiKUkOjNoyNTlu/8tr8qY38bjk5k
         5vEkDPWH2A82Rna1XBAWPoe2zs491+jTdJSY22d9n7E8q9CezH9He+zZqGXkkTD1vH5J
         AXMCiIks/8GMHNcerkf/1pSQKrA/OvgW4snt2jNj8S97vyf5tFWCALm6PinEr+wi3JcA
         DemnqEDG6i6ujNxcOjQ5vyNZe3bqurWitP5m9B/X+MPGNmymPgoIUX8ysscdaWyBlJ9m
         QPgg==
X-Gm-Message-State: APjAAAVqoWM1sNdXcFk0G/E7SQY/FnT3Xp2VKiewhnWwonjYIkGUatXA
        2b6APc+P2VhJtbGR4uQOLdb7k9vSP/gI6g==
X-Google-Smtp-Source: APXvYqzqVNHr+CpX2tA1fV7L7HgyElO3aI7iQQ3Yn8vettWTYsicc4d+vUhaoCOTX20CvCNM1wSNSw==
X-Received: by 2002:a62:1b43:: with SMTP id b64mr750761pfb.56.1570580568603;
        Tue, 08 Oct 2019 17:22:48 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:1cce:84a6:3473:2610])
        by smtp.gmail.com with ESMTPSA id 37sm286417pgv.32.2019.10.08.17.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 17:22:47 -0700 (PDT)
Date:   Tue, 8 Oct 2019 17:22:46 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Raise your hand to Ack jk/code-of-conduct if your Ack fell thru
 cracks
Message-ID: <20191009002246.GA25840@syl.local>
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
 <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 09, 2019 at 09:14:59AM +0900, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > In other words, the commit message can be augmented by this:
> >
> > Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Acked-by: Derrick Stolee <stolee@gmail.com>
> > Acked-by: Garima Singh <garimasigit@gmail.com>
> > Acked-by: Jonathan Tan <jonathantanmy@google.com>
> > Acked-by: Thomas Gummerer <t.gummerer@gmail.com>
> > Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
> > Acked-by: Elijah Newren <newren@gmail.com>
> >
> > Junio, would you mind picking it up, please?
>
> I trust you enough that I won't go back to the cited messages to
> double check that these acks are real, but I'd still wait for a few
> days for people who expressed their Acks but your scan missed, or
> those who wanted to give their Acks but forgot to do so, to raise
> their hands on this thread.

I'd be quite pleased to join those above with my strongest:

  Acked-by: Taylor Blau <me@ttaylorr.com>

I admit to waiting a couple of days before responding to that originally
linked thread, and that by the time I got around to readying a reply,
everything that I wanted to say in favor of a CoC was already well put
by others.

So, I don't think that I have anything more to add than to say that I
think it's great, that we should have it, and that I most certainly
approve of the direction of that patch.

Thanks,
Taylor
