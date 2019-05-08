Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BF891F45F
	for <e@80x24.org>; Wed,  8 May 2019 17:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfEHRTq (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 13:19:46 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:39149 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfEHRTq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 13:19:46 -0400
Received: by mail-wr1-f52.google.com with SMTP id v10so2981598wrt.6
        for <git@vger.kernel.org>; Wed, 08 May 2019 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LOffkLruws4L4jjtyqwPrjt8Z9L/Cl87EDfrLEw+DSg=;
        b=e+778R7DwiCcL/ldVTPnt4I3DPvYW+GZwkI+h4YQOelbrYLFwkD8/vlxRl++ZI5N2a
         Qfzbrq8DPBLRe1/GwU+PjXJ1VMTaaUUa7upgf6iJ5Ws8vmzZOwLdnu9oj1MLlHvfDJ5I
         B4kQ2huvr+Kk4mzIQVp0LflZOLDXklYPo3CHLEeYs8763G86h3P2n9e2fe/lT6pd6R7R
         v7QzqjcX0RVCVS0fYJNIEBxhzeb882M5dI2FdBfcX3fjOgn79aSSorn0oG7H+uvyP0R5
         Uk7xwGty0rK/yl7cCPNx4VPYcsjHbpDyHW+wS8czcSRyN8wFwNhz8d8UO3Ig2J3esj5Z
         z+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LOffkLruws4L4jjtyqwPrjt8Z9L/Cl87EDfrLEw+DSg=;
        b=CytYR9yoNYyWb1YyHbCN3o9n+Nki8GLpoNhNSxqoRDJrwZPF/ZVQ6jKqI8D9JEFd3i
         nTi7Kq8kfRJLH30SBvsfKBmhs2eRyvkqLecEaFTMWipI1U7Mrpah2UqjBbs562eF1iHi
         EyPJukuWNau4EKqup1BOu+yFmdWbtv9sljdDdy30f9X1mNBXyMu09TyG7QX4sdQ0C833
         mO9ZY+Yqhjdr9zYhGh6c9wA3hQgzOOBm6/cQKFBsKYiavXqUmqJRIowreuWFhKbpnaQt
         GMxyhIyeYwsu3abRZlPoyaAOzhxPf7PNE24BazHbqZaIYIHjIZWT0xSD+l+oCxn7eABG
         9ADw==
X-Gm-Message-State: APjAAAWg2FfKALd33Shm9mvhYUTTWayT8iapRpcgyKBAX3AHMZnIiXJ0
        lm7iXEgNniXjiLINSz8lGM2fjGkw
X-Google-Smtp-Source: APXvYqxIFZvXLmGy4KlQc1io05I78ExSA4IWPNjQCSFia2k1vD72ZzT4STUsQfrxuOQf3Bdd9oDbkA==
X-Received: by 2002:a05:6000:43:: with SMTP id k3mr795036wrx.234.1557335984130;
        Wed, 08 May 2019 10:19:44 -0700 (PDT)
Received: from localhost ([2.25.81.3])
        by smtp.gmail.com with ESMTPSA id g10sm4302811wrw.80.2019.05.08.10.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 10:19:43 -0700 (PDT)
Date:   Wed, 8 May 2019 18:19:42 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Subject: GSoC students and mentors 2019
Message-ID: <20190508171941.GC2068@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in past years, Git is participating in Google Summer of Code this
year.  The student slots have just been announced, and we're going to
have 2 students and 4 (co-)mentors this year.

Please join me in congratulating Rohit Ashiwal and Matheus Tavares
Bernardino for being accepted into the program in our organization
this year.  You may remember them from the respective microprojects,
or the project proposals that have been sent to the list.

Matheus is going to work on making pack access code thread safe [*1*],
and is going to be mentored by Christian and Olga.

Rohit is going to work on improving consistency of sequencer commands
[*2*], and is going to be mentored by Elijah and me.

*1*: https://public-inbox.org/git/CAHd-oW7KMrDJ-cyzk63oqW9-QVpag6fKnDp+Mo5bWxg1KfzY3g@mail.gmail.com/
*2*: https://public-inbox.org/git/20190322151157.9550-1-rohit.ashiwal265@gmail.com/
