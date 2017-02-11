Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2AD51FC44
	for <e@80x24.org>; Sat, 11 Feb 2017 03:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbdBKD0D (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 22:26:03 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35635 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbdBKD0C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 22:26:02 -0500
Received: by mail-pg0-f66.google.com with SMTP id 204so4402774pge.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 19:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QW4TPhUn7Pgv6MhmU1wacd9nEQ0j/y/jB81bhjkZ1Oc=;
        b=D4JQd3H+CzY+odre+kTLc6M/dKVPH+QLB8beNByyl/i3RTJ+AWzueiUubqMHe/UfDo
         /OUbG5rmaKyLjvyXQZhX5KM4mdNh5rG+rOp1vQ+nursA/FnWMOJCRCFjEB75H5MPWkUT
         5OV6O65xiH4wKC/WXnEEwUCQgHlqfOA2qxaydJZtssRrAGryo/GNyEeLxVuHDPe/Lm5m
         5BbKXpGETSeM0uCZCpiBPzLsQOOLawgiNYE1N+fHxP4makz13uvtNIzUV8f3iiSnSEd0
         dUFvZINi4EIuLw5jiWXrbi/KQMWVuMgM2myuU/4a3TXfwWWBjGS2Ei7CuGmTXUJCT6cK
         Yt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QW4TPhUn7Pgv6MhmU1wacd9nEQ0j/y/jB81bhjkZ1Oc=;
        b=JiUqcNw9BfNqxHWWsJoTuMVNNqb+kNPw3D1dYjPa6kGRUafq8RgiAwEg1/EghmePh3
         ZrMIGp20evyrRbdnX/XqXmsjscJeGdtkR4gWJmDwy1jQV/6l8ziF6tW1JnEH1oUUz672
         MZxmK5qi58p2MrezPAbpkx1BtLO0Vguccepzqnc3IOY67ZKKIdbzi4M/GYPO9AZiZT5s
         5KU441SEgcyVuAFnYPoKXuLrDTv/4s8tqdSS5JcrQpBkNYCrO+BbIXLCVraXWVp4666T
         O98eVAGkpgOlJtTFJLX1EGR6Bn1yc39GiOPuwrCfYtxhjYu7hAuBny4M3eVUAMW3Qt5l
         XYWA==
X-Gm-Message-State: AMke39lxrDrEjcn5NOyGxVIl3+RKiyhrdSGXHXht3XOEdcCAQkpWMlK1OzlEk+A4sJK+VA==
X-Received: by 10.84.129.2 with SMTP id 2mr15996083plb.108.1486783562045;
        Fri, 10 Feb 2017 19:26:02 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id m29sm8000268pfi.54.2017.02.10.19.26.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 19:26:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Google Doc about the Contributors' Summit
References: <alpine.DEB.2.20.1702021007460.3496@virtualbox>
        <xmqq7f4zqiyj.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702101658010.3496@virtualbox>
Date:   Fri, 10 Feb 2017 19:26:00 -0800
In-Reply-To: <alpine.DEB.2.20.1702101658010.3496@virtualbox> (Johannes
        Schindelin's message of "Fri, 10 Feb 2017 16:59:33 +0100 (CET)")
Message-ID: <xmqq4m01if1z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Technically, it is not a write-up, and I never meant it to be that. I
> intended this document to help me remember what had been discussed, and I
> doubt it is useful at all to anybody who has not been there.
>
> I abused the Git mailing list to share that link, what I really should
> have done is to use an URL shortener and jot the result down on the
> whiteboard.
>
> Very sorry for that,

Heh, no need to apologize.

I saw your <alpine.DEB.2.20.1702071248430.3496@virtualbox> that was
sent to the list long after the event, which obviously no longer
meant for collaborative note taking and thought that you are
inviting others to read the result of that note taking, and that is
why I commented on that.  I've hopefully touched some "ask Junio
what he thinks of this" items and the whole thing was not wasted ;-)

