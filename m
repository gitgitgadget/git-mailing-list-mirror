Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A651F463
	for <e@80x24.org>; Wed, 18 Sep 2019 22:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfIRWhs (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 18:37:48 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:48160 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfIRWhr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 18:37:47 -0400
Received: by mail-pg1-f202.google.com with SMTP id w13so898194pge.15
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 15:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NQfWdQQPxBy4Bju9Knx6zhWooTuz1GAa/U1ffowqcR8=;
        b=fM+Htzh24y0Fl7TSjwDNhQGklpWJso2q6rFNCtn+ozhs3TvAyCuZww3L/S/DsrhWON
         Hwr6TcAXtgWC06XtpAgKwQBN+FEHexvcp/wgeE6a7vgWgMP5LEpIcynEJruvX6NOFJjc
         77MPnL5ZxliKyvMNHt28qRLdLoxOzBmRDxLjQ04ztWVmqdspuSxtzkDua6zyYacgIYxA
         OucEqf/a+9mah2aYo+o0FQ/rmdImbtxSh9pn+wqVYgfIpxJUB9liFmY2Raj5yGistvcd
         8Q0EuFDvCtUzLEkmpyzbppvBrj7ftnvQ4wMNIz/0DI7XWZM1NLqHiITN1C6q3oQSCKWf
         3wBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NQfWdQQPxBy4Bju9Knx6zhWooTuz1GAa/U1ffowqcR8=;
        b=SysKFHkuKqATq5hzz3oL0UZQUE3Lesg17yCuu08J1WFHmSGoaSNwinrRTF80M9pYd9
         YVGl5PlBEDZhh1K+YxPvv/a8SUxK+FVJtZ/f2CDa6AfghhfNMPWvABwncqblp3hBplt0
         qc40E6nDUQjah0iStbqqmquJ7Tc6/b69j1MQwBPMyDGaCPFp9Mq1gRS61sYDycx4J8Ha
         0+P8iA7vhG30mhLPgeWBtQ5bsn9gc1LMe35uoy51K9cKuJ0o5KDvdn33lEATGzUFhbi4
         bC9K2wGJcxRjiCj8BK62XJfkt/IPJCJa239HxGciOKpQpQxEjoH3pqEO8yLqAbBEppr3
         SLtw==
X-Gm-Message-State: APjAAAXwWW7vfT6Tt5SEQ6Cgrunlp6Dx0koTelTb6lm7rB9UcguUO/zl
        0uACDVMw+cqvDiyzDvxnROhY7FeAQIIXx0Gg0rV7
X-Google-Smtp-Source: APXvYqzQyYxh9IpTnkTrh4+WYh1QuKx+jGDM1AlCTwq+9VokWogmg9qPd78bTDEj2Pf2cfDa2/k5tdvBS4T1zQAS3aus
X-Received: by 2002:a65:5689:: with SMTP id v9mr6151570pgs.228.1568846266637;
 Wed, 18 Sep 2019 15:37:46 -0700 (PDT)
Date:   Wed, 18 Sep 2019 15:37:41 -0700
In-Reply-To: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190918223741.79215-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: Re: What's cooking in git.git (Sep 2019, #02; Wed, 18)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * jt/cache-tree-avoid-lazy-fetch-during-merge (2019-09-09) 1 commit
>  - cache-tree: do not lazy-fetch tentative tree
> 
>  The cache-tree code has been taught to be less aggressive in
>  attempting to see if a tree object it computed already exists in
>  the repository.
> 
>  Waiting for a response to an updated log message.

I've responded here:

https://public-inbox.org/git/20190910181534.134890-1-jonathantanmy@google.com/

Let me know if this response is sufficient or if you were expecting
something else.
