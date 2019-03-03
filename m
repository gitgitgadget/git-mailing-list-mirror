Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC83520248
	for <e@80x24.org>; Sun,  3 Mar 2019 13:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfCCNdq (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 08:33:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51844 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCCNdq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 08:33:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id n19so2150533wmi.1
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 05:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OdGI3RMgw5oe1KkNn7e95Ogah2I0xw8hCVpcMbBxSh4=;
        b=JQWbq1NpLsVSAAQD1oJIj59nyM4teZwewlVHdw2aiFW/hKzaJ9dWsmsIglaMklZqip
         BhwfNDe3HBgAZ67daJvqgSrp9b9aTWGvWiql6KxD1qGiueoOqMvHi7mwEfkQblyf3/pd
         O9oOuGge/PFFfbzlxINnS5TZbWWblJA2ZjaW9AGBWbyLA7gfpshdCRNhtEQZbTFrCk7M
         nI0lLrCJRphua+0AT+bQushhq5qFyHpZvEskXQNi+OArVIhwFO9AE4sI3zskL87hrhaN
         gPyNBlZt93sgyG7oOxKLWsKo2D1/VhCkO4dN8Ol1Hvf1HQ46hbV+Mao3OsSBvWkWQzU0
         XhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OdGI3RMgw5oe1KkNn7e95Ogah2I0xw8hCVpcMbBxSh4=;
        b=aS56mWk3QZ45gG2UT2+SY6x6B9o24ibbRswqXZ0n6QFw6+FZTl5rjU1p40HZVlspom
         UqJ74wPj0uoLULj28+qF9m1QAwP3279uHKB5O1/9Zj02MF6uA4Xo7ibZqRDTW877cPZ+
         NzQAzAHstl3fdSuBFYIiP7Wf28OK+mGknI/qvIbNms8GZrh2A7WOHy/wH42iIQgA+1uo
         Et/gde04MSQyt91YhyFW65FuNA2dccihjgvC5ftFXP4gu4gyYJdWoNbG7PX/J7lFFmhM
         DbdFNco9qV8x+VSVcmwXbr9sPyMi10FPkU6RzvX73MyZltq4mEJMsBxCAtCMYDvdqcxE
         rHzA==
X-Gm-Message-State: APjAAAVCD3qrYHSd9Lem26GPpGSh2nGjAA547UdM74q9TPpRRE3gznwC
        Aqx/gA1oGK02H1HrEg6NQkA=
X-Google-Smtp-Source: AHgI3IY7sKcrp4dqKR42YzidQWl0oyX1Sh39IMJqblISlxVNvChI2GHJywaGNXHtkxVhI0GQ147qNw==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr9197175wmh.153.1551620024076;
        Sun, 03 Mar 2019 05:33:44 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x11sm9712937wrt.27.2019.03.03.05.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 05:33:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, t.gummerer@gmail.com
Subject: Re: none
References: <xmqq5zt014du.fsf@gitster-ct.c.googlers.com>
        <20190303132900.4618-1-rohit.ashiwal265@gmail.com>
Date:   Sun, 03 Mar 2019 22:33:43 +0900
In-Reply-To: <20190303132900.4618-1-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Sun, 3 Mar 2019 18:59:00 +0530")
Message-ID: <xmqqo96syte0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> Just to be clear of what caused the error:
> 	1. Path not being file, or
> 	2. File not being empty
> I am checking for both.

test -s <path> makes sure <path> is file; if it is not a file, then
it won't yield true.

So why do you need to say test_path_is_file yourself, if you are
asking "test -s"?
