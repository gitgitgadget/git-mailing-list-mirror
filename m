Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB951F424
	for <e@80x24.org>; Thu, 10 May 2018 03:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756555AbeEJDHr (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 23:07:47 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:45687 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756353AbeEJDHq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 23:07:46 -0400
Received: by mail-pg0-f45.google.com with SMTP id w3-v6so306435pgv.12
        for <git@vger.kernel.org>; Wed, 09 May 2018 20:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=arjWQto5mTbmHYaVAnHXjDarBcJA/S0xMwNSodtd4Uw=;
        b=oQ8dZHRwavOHZApCA22/VsQNChRSs4mG3U/3mw8y2M3wESCNsrzth0lwo0nH6Lvr//
         ADI6Xy9W9QrKVoUasB/pkqilPPmAT1lWvN+M7B6lybwPwGljD2WSputheIx6TpDEqqHB
         QHejwJAl0H/fcjV+6BItSlVVdDvg6CaO3ykU3fZRYK5s601W3McW0AJzsPuw8G2XmCAG
         SXYZH5G7m+ahjfhR0YH5Pucfv9DKds5KFCI7tzXb6sj1wCBwMoTF3KVWDhWJrUvvFkmK
         U1Vp+DCdLcBuAuB420zFNiipSd0mJXGYOrZcaY7G4/r7s4zHIM9Kdslm+EZCd92AnTir
         quwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=arjWQto5mTbmHYaVAnHXjDarBcJA/S0xMwNSodtd4Uw=;
        b=fwB0BO8gRAfi1LPfHS8/x+yjFO+SOOfn3FZVdw5y9KZ81rlOnV6MTnbwPQFFv7SKqM
         E6NY2p9sHGhkNAKJAMWLCT6lwAbq51yNa20Uu+/alcsDzOnLHLHe//De+9di9gEI2ikD
         zqFmiIzEVmBthFDROZ7fNTR4jsWgSKg0nfweoPxUTCSiq34TOVMela7V1ioCnw+2UPBX
         KoyX5vuGoRsKhMWxiAumS7NLZpLZZA/lZ2xAVFtGjpS6uqRwwf/pwnYs34JlmGA6wA3E
         uYl5iXassUr3VYIWeolRHszRhXIzG/VQJhYDO6owxjdLfqo3ZRvePrIS2NWEXbMcOEr0
         NnBQ==
X-Gm-Message-State: ALQs6tAb9Xo3oUEAQVNbrab/6PSOZvMAw1ILisGTa3kI4vmlV6t17nNv
        H9dopyLRKH/cYM+NEmn5CWNWVRV0YvA=
X-Google-Smtp-Source: AB8JxZpw19RzPl6NOvfJ+B+zIof7ZNw+jCYp7lDZ50C5ZnwBKnf+6k/ymkFc62om6YbUybKozPRkng==
X-Received: by 2002:a63:6fc5:: with SMTP id k188-v6mr16372153pgc.135.1525921665547;
        Wed, 09 May 2018 20:07:45 -0700 (PDT)
Received: from localhost.localdomain ([27.34.20.20])
        by smtp.gmail.com with ESMTPSA id t1-v6sm16545644pgu.41.2018.05.09.20.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 May 2018 20:07:44 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC] Info: Week 02 Blog Post
Date:   Thu, 10 May 2018 08:52:23 +0545
Message-Id: <20180510030723.32586-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The week 02 blog post[1] is live. This post is part I out of II and this
time it will be biweekly. The part II of will come in 2-3 days which
will describe the current `git-rebase.sh`.

Do give me feedback.

Thanks to all the awesome Git contributors for this awesome tool. :-)

[1]: https://prertik.github.io/categories/git/

Cheers,
Pratik Karki
