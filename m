Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE9DC207D2
	for <e@80x24.org>; Tue, 27 Jun 2017 02:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbdF0Czc (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 22:55:32 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33837 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdF0Czb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 22:55:31 -0400
Received: by mail-pf0-f176.google.com with SMTP id s66so9275460pfs.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 19:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=azyYsrIlscR8suJHoVDwlUUd62S2go/M465mG6plFw0=;
        b=Y5gerJyXQnixk+uFwxqA465NhFYjlzVEA4aqhMA7q5o+Vb2KCIMSyw9m8VItm5KHHi
         bbRY+QTsxi84hBOhgCiDgXwqBx/pFaQemBdPjwG2ZcyhlkkXfGDi1U+5EU6Juc/7LFlH
         5AOIcV6zGRmGYg8GMmmW6cSkIcZRztXAALR7CEwwx8fAWrjX26sJ2e5mbLHFgarDS66o
         +AdvLRW8EP+hHp4p8u0AHNDDOHKV7fEkci3y4PkwDrJlblbFumoKtvdscf6gYM1K4RnB
         dPXKoVZCspiPmnxnUmYo6rJyAZ8ASjZKaoXyyCp2FX/cfldqZwTIPFXrSerOJpdvJI6E
         Abbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=azyYsrIlscR8suJHoVDwlUUd62S2go/M465mG6plFw0=;
        b=JnRd1l5CG//vhEyke3RRyRKkojlJSX9uh3ZU3F4bqqhtjnC3pC+fFnAOTxHu63NZs4
         /NP0bt2MHLU8LtQPky6IKcjvERFdDICnUxRL5ODQt+9ktDRfn/xO2ERBQ9m8RuDda5aM
         fEdmIwiu+uVESwBlBAcSfrdfJU6loJqHntluP5eksv4MAUEmVp4oDjIjs8DE/Cq+mWDY
         eIOPGqYZ1gSQ/ATSmJEcFN8ddSoEaE+NGfoXjhHcDGfJc1wsoxyPxjJmKegFFq9KdXzT
         r/kdqz4TSX5LtBPm1UNg39ojkJH5DnCS5DA+ZITNjMtOkZaG7tTTpy2rKOgvs166LJoV
         pDsw==
X-Gm-Message-State: AKS2vOxeONqOqtzEEOa3/lf2t6I2UoSbSja73phjXyi9rDH3Qx3+t55x
        4+OW7ebehIFkjEzGi9Xk2IctmCh6WZti
X-Received: by 10.98.19.136 with SMTP id 8mr3062693pft.105.1498532130493; Mon,
 26 Jun 2017 19:55:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Mon, 26 Jun 2017 19:55:30 -0700 (PDT)
In-Reply-To: <CAHaNChecHzZqzafe4P85Kz4BtJuisO+krCvm=yPW9wGMXWJK_A@mail.gmail.com>
References: <CAHaNChewK_4a7sPgZqWTNSmchiSbKOJUrpCrGLmcnR+cw6J5qw@mail.gmail.com>
 <CAHaNChecHzZqzafe4P85Kz4BtJuisO+krCvm=yPW9wGMXWJK_A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Jun 2017 19:55:30 -0700
Message-ID: <CAGZ79kYR_Vw454RBw7A7ygJdiOauzepVZXBb_CvsCoN9AGE-sA@mail.gmail.com>
Subject: Re: Bug: Cannot kill Nodejs process using ctrl + c
To:     Gyandeep Singh <gyandeeps@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Which exact outputs of Git are invoked?

Does it change when giving slightly different options e.g. --no-pager?
