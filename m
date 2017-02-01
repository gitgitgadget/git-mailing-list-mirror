Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A20751F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 18:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbdBASGT (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 13:06:19 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35061 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbdBASGS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 13:06:18 -0500
Received: by mail-pg0-f65.google.com with SMTP id 204so34809609pge.2
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 10:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=H9VHfTePnu3QAj9yQd2kKXCAYGD48VgENnx6sRKMFOk=;
        b=F1S5mQ9cOTBmy/0YnPTqgN1M7hsJmJRsf/h/NJQwgscDvcXABrgPV5IEVpNhCnuQEL
         tV5Azq7NUSTRPOi/aLFOpa36e90g1UzBMbayiPtysCKktssTaBvciYZjp7rZBtGXc4Kg
         JYP/OI2I6lndIhkP7jdPfZmg4Zi8XvF3s8h6pIbQwz5NWEDasdXAD5R0bxdj/s5+9+ac
         fWbzCD+qvvW52cxrxkBGCVOXUyEmsUjvSdPv3Lw/+A0b24lU6+a+60wjGhSQKvWXzdtH
         rHIckY/W/cbGPa7US5XmPdAkI8rOuwe2ye0d12OFQW36KoPqB3jHeoAbOOkEJ1sHbzuL
         9B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=H9VHfTePnu3QAj9yQd2kKXCAYGD48VgENnx6sRKMFOk=;
        b=P/rIMe1LV8WQE2+mc+gg/c8bmHPSYcIzj21EjSw/iul+rnXZO3QAKVqEVFlNkGM0FG
         fjB0KHGEWz2FNYUTNV+FyRl9Ee+fMnoyS/lwdqoTBX6CcMl4Yen2gfzIojxeLRUPo62P
         pnUBtUTw3fZg6jyofAR5m+TQK+YWfuHd74fAtDT3H4fdkayNi/RgyPcMHGh33/uIEnYk
         dlU5Q0Ly0yZcY0CGBjdAtTbXfnkc6Z7anmR+cb+dE/IyYxzgl32baZC0HpXiN/5RjybU
         FJthzKrULxsnlcaN0UBv8wnxMP8siYC9Od088QL2sM6pv0nGG7+pPvHZRCWbh94rb1cy
         yhFA==
X-Gm-Message-State: AIkVDXJI8vl3g1369U3Mey/4JXlqObOzzhIrcZhzXLguBgvrL9eDFzROJrpln4Uss/EImw==
X-Received: by 10.84.215.15 with SMTP id k15mr6262542pli.58.1485972377562;
        Wed, 01 Feb 2017 10:06:17 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id u24sm51368618pfi.25.2017.02.01.10.06.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 10:06:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Erik van Zijst <erik.van.zijst@gmail.com>, git@vger.kernel.org,
        ssaasen@atlassian.com, mheemskerk@atlassian.com
Subject: Re: [ANNOUNCE] Git Merge Contributor Summit topic planning
References: <20170131004804.p5sule4rh2xrgtwe@sigill.intra.peff.net>
        <1485941532-47993-1-git-send-email-erik.van.zijst@gmail.com>
        <20170201145300.4pn3faodhdb72jly@sigill.intra.peff.net>
Date:   Wed, 01 Feb 2017 10:06:15 -0800
In-Reply-To: <20170201145300.4pn3faodhdb72jly@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 1 Feb 2017 15:53:00 +0100")
Message-ID: <xmqqh94dpyzs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If you _can_ do that latter part, and you take "I only care about
> resumability" to the simplest extreme, you'd probably end up with a
> protocol more like:
>
>   Client: I need a packfile with this want/have
>   Server: OK, here it is; its opaque id is XYZ.
>   ... connection interrupted ...
>   Client: It's me again. I have up to byte N of pack XYZ
>   Server: OK, resuming
>           [or: I don't have XYZ anymore; start from scratch]
>
> Then generating XYZ and generating that bundle are basically the same
> task.

The above allows a simple and naive implementation of generating a
packstream and "tee"ing it to a spool file to be kept while sending
to the first client that asks XYZ.

The story I heard from folks who run git servers at work for Android
and other projects, however, is that they rarely see two requests
with want/have that result in an identical XYZ, unless "have" is an
empty set (aka "clone").  In a busy repository, between two clone
requests relatively close together, somebody would be pushing, so
you'd need many XYZs in your spool even if you want to support only
the "clone" case.

So in the real life, I think that the exchange needs to be more
like this:

    C: I need a packfile with this want/have
    ... C/S negotiate what "have"s are common ...
    S: Sorry, but our negitiation indicates that you are way too
       behind.  I'll send you a packfile that brings you up to a
       slightly older set of "want", so pretend that you asked for
       these slightly older "want"s instead.  The opaque id of that
       packfile is XYZ.  After getting XYZ, come back to me with
       your original set of "want"s.  You would give me more recent
       "have" in that request.  
    ... connection interrupted ...
    C: It's me again.  I have up to byte N of pack XYZ
    S: OK, resuming (or: I do not have it anymore, start from scratch)
    ... after 0 or more iterations C fully receives and digests XYZ ...

and then the above will iterate until the server does not have to
say "Sorry but you are way too behind" and returns a packfile
without having to tweak the "want".

That way, you can limit the number of XYZ you would need to keep to
a reasonable number.

The recent proposal by Jonathan Tan also allows the server side to
tweak the final tips the client receives after the protocol exchange
started.  I suspect the above two will become related.
