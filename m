Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1059B1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 20:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbeCEUXh (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 15:23:37 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35862 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeCEUXg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 15:23:36 -0500
Received: by mail-wm0-f49.google.com with SMTP id 188so18030008wme.1
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 12:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EvPxYJ0OQtus+gYi+S95agvjOl0rMpK/DE/o489j3Yo=;
        b=vh5fhbgJa/0cwacICrkAwYwiqgMSAX9XCFNCGoLxFJ0G6wrD7xu7BVU1myRsyuEcF2
         OdoGmhgawCSaMhDgEkLm5fIc1uXRXU1PPPz+TE3BQWxJgMXVLEwJlC+XcOgVctKEL1UO
         lbYYsr/UK+4mo1zdZ5+EwesCX/VEBD2u62CaBu6Yq1qaALTwlecg48SVs7cE31Cy0vRR
         4GgUQUhpbAm0FklWSceTtr6zOOW9IF1gAaeofSCHDjaG6OXsIdRXZc34QlGnU9nYWmJ3
         OvEhlfObs8+UapvqykpdCtNvOfDufEr0GSEDPHy1k3p5Vl0TS7WDYXVyP4z+baL3oOpy
         Ug0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EvPxYJ0OQtus+gYi+S95agvjOl0rMpK/DE/o489j3Yo=;
        b=jSeczS/Ua83BVcPzwkcMUC5Q8aQt/FQaQcOuMQJ5n7ZRruCcDcvcnNA3xrhD+yVyL3
         +ix3ifqKnu8HWEkNITrAnnXQdL4B6U6943CmyQ26c53eB+OrF/v3Kv9rShvkKNXCXeP6
         tTY5M46hdDAn5TL2q9hou6PgR5CNaCd4gC2vtw4DWLMJ0lp1aG/1KotDhV1xidUT8WPo
         LxpFc1VRIYdx7BhtVy3wqt4s2lTafBsa2TxQoqQk2M7CjuzDP1PvDAwXdPF7WcPSJdsn
         Z2fmXWw9pxbviYx65Eush7iXMbqSBLAAcBrNbb+lqvfgLUqb5PVXDZ2MCRx2y9xk9FqQ
         mnOQ==
X-Gm-Message-State: AElRT7EpOTmy3yKmkNtOOgfUP1Ry0xxLsKktcITZNrQgj+KeQI34nRO9
        sbIhrZiOkj794tRrLWaRmNM=
X-Google-Smtp-Source: AG47ELuLh9aBOHvvaDHCn5VU/nUDE48IuluPIkStHjXcqmtQqFzyVqGygX2idTJuqRstvUnGvkGrxA==
X-Received: by 10.28.131.140 with SMTP id f134mr6918751wmd.117.1520281415451;
        Mon, 05 Mar 2018 12:23:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 43sm14972920wru.40.2018.03.05.12.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 12:23:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC] Contributing to Git (on Windows)
References: <176408fc-3645-66d3-2aa3-30ca3fa723e7@gmail.com>
        <20180302044409.GC238112@aiede.svl.corp.google.com>
        <xmqq606ee89v.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803031721590.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <20180303182723.GA76934@aiede.svl.corp.google.com>
        <nycvar.QRO.7.76.6.1803051711210.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Mon, 05 Mar 2018 12:23:34 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1803051711210.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Mon, 5 Mar 2018 17:42:21 +0100
        (STD)")
Message-ID: <xmqqwoyq8e61.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > "What if they say my code is not good enough?"
>> 
>> Sure, though there is something implied in what is Junio is saying
>> that is useful for such people.
>> 
>> It is patience.  It is the message that if you miss a portability bug,
>> we won't be disappointed in you, and it in fact happens all the time
>> to the best of contributors.
>> 
>> If there's a straightforward way to convey that in the text, I agree
>> with Junio that it's worth conveying.
>
> That is not how I read Junio's statement. I read it more like "If your
> code is flawed, we'll let you know."

I think you are talking about this part?

    In fact, portability issues in a patch originally written for a
    platform is rather quickly discovered if the original platform
    is more minor than the others, so while it is good advice to
    test your ware before you make it public, singling out the
    portability issues may not add much value.

It's more like "Just like everybody else you are expected to be
imperfect, but those on list can and will help spot and fix if you
made mistakes.  Do not worry too much about things like portability
over to a system you usually do not work on."

The other side of the coin is that we are expected to be imperfect,
so even if your code is flawed, we may not even notice, so we may
not let you know.  It's mutual process in which we try to help each
other.

