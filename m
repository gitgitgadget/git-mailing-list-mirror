Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83924208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 08:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeHHLJv (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 07:09:51 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:38770 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbeHHLJv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 07:09:51 -0400
Received: by mail-wr1-f45.google.com with SMTP id v14-v6so1282524wro.5
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 01:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4MITf+WQ/ZE2gqCpjMir9Ti8Ypwc6sOpnX4vPZ9qkow=;
        b=aPczkl2jmJi/R6PntGqzZ8bTTAo6SD87m/nIG0pYECkA1L9PQEx16m+Xn3UHse9nds
         ehj8iC90Dckh27jzLJYimUG6U6KSC2EbzBEHSB3YuL7vAhKFxx1LvoRcWCwMjGGNuJGe
         aVJcoRl3Kx2oy+0V8pbxG4sqo0/3p9892mY11mZIaH4XgP5msqrF6h+nTIlrX9EqUT+T
         VwuD16Dnib4pPjL7nJmKLPL5Twt6giQknaUIn92iqjpG7HezaAy4+CH7n+G7cC4msw4F
         15A13LXj0fwqlEs7p2g2Q3ywyJNKovRmqynPdt8p18eWfHdxLoLgadcWAyopHFiIXvcm
         I/Aw==
X-Gm-Message-State: AOUpUlF/SIZayY0dejUa78rqJMBbcWVvEhsmUrYEJk6uRZNbUqT5TUhX
        gFcWlKm3sXALwWziUAzieqSGnqNkI7Q4IQ==
X-Google-Smtp-Source: AA+uWPwODIW3rZpjfhVXAU8x0fj3swbhzrEVaCdfD5t/QlUVl5t8dUeP+jRMHhPJu6Kbf0Y3DFo75A==
X-Received: by 2002:adf:f210:: with SMTP id p16-v6mr1301693wro.184.1533718267120;
        Wed, 08 Aug 2018 01:51:07 -0700 (PDT)
Received: from skisela-redhat.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c129-v6sm6440173wmh.2.2018.08.08.01.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 01:51:06 -0700 (PDT)
From:   Sebastian Kisela <skisela@redhat.com>
To:     git@vger.kernel.org
Cc:     skisela@redhat.com
Subject: [PATCH 1/2] git-instaweb: support Fedora/Red Hat apache module path
Date:   Wed,  8 Aug 2018 10:49:17 +0200
Message-Id: <20180808084918.3424-1-skisela@redhat.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <xmqqftzpkesb.fsf@gitster-ct.c.googlers.com>
References: <xmqqftzpkesb.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio thanks for the tip! Your suggestion definitely looks better.

BTW. I apologize for polluting the git mailing list with the recent
email. I am still new to git-send-email.

