Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DC231F609
	for <e@80x24.org>; Wed, 28 Nov 2018 19:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeK2GFK (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 01:05:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46850 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeK2GFK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 01:05:10 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so24421373ljh.13
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 11:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ph2V3VwqJrRE5/AMcfJ6dKWJ+Xh5iqrE+rc6a7Utxvs=;
        b=U4Y/GmeGN2Yvjuiy0HSFZ3JrbcqvvuC7i1tWNUajl3rCD7emowibHvSzNTR/iJE2x+
         eJ4XpSVAQwWiFnK7ObyWVdUKyxB6dmYYFooTPHYgzcGZJGz30PyUNABQfGFpjdhTCgxv
         7w8zovc27s30kejkRXZDybaCkKB2wCmZu1xrrcpCYWYRJzLb62eB4AZqoEbTq9JYU1Vd
         6+X5ESBm2aEC2PuUQ8Nwb7/l4MbBTZbQsJ+U406DCzzHqU8xpFyWSzGzEajQ9BjW2b0u
         obc43yxu0HEautJ0SZmHkzHxdQJDiof8baCDwU4eUnM8DKQG7S/rpyVoSn9nua7gjvmo
         KioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ph2V3VwqJrRE5/AMcfJ6dKWJ+Xh5iqrE+rc6a7Utxvs=;
        b=KwuxYr4StCCwr8imZfgWQxjEs6O+KHg6QmoaJn0r88B+YcGVakZWKk10nDOuVhpJut
         pNKnPoNc7t7gTLrANwpICJsdQFDf5plP1gHlqs20RHZN2qTm8emJ49C9bH00ikSPUjY1
         bGeqFSDD377ULrUkcc/Mz+wXCVNDg5paiLUQ7Ak5Dqp7gq+cts402SzpfTOAif1TUx24
         XjGZ+lAKOiyWGD92zxm9Ek6tFUz5Vs13PrETAc3+Q5vhQsLa8XzkBscsltxTsmZi+xH4
         lFCuFwCU0m6WaqkJUFx2xMWvBar8KnyKW/eGYn1eB7DkbV81VK/l2PV8fbmnjiCnnB9O
         QWGQ==
X-Gm-Message-State: AA+aEWZVUlYRENm+UGA+yZEpabx9w3SQJQRj2C2R5I+Lo90QYygtpe4s
        byqpQGKE++469JSc1dAptNjtp3Hd
X-Google-Smtp-Source: AFSGD/WGNI829nkf9Xu0SjN4lVwUrJRA+RCZhSdn6VV+/euZRl+4KWE73aoTMw9HBPNdrey2sgp9OA==
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr4127611lja.148.1543431749101;
        Wed, 28 Nov 2018 11:02:29 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 15-v6sm1407330lje.18.2018.11.28.11.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 11:02:28 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Pawe=C5=82=20Samoraj?= <samoraj.pawel@gmail.com>
Subject: [PATCH 0/2] Re: Broken alignment in git-reset docs
Date:   Wed, 28 Nov 2018 20:02:08 +0100
Message-Id: <cover.1543429054.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.8.g46351a2c6f
In-Reply-To: <CAN0heSph-a08AzsihqqxfC=nqmUQLsqx-rKGULXQ-gmT4+c10w@mail.gmail.com>
References: <CAN0heSph-a08AzsihqqxfC=nqmUQLsqx-rKGULXQ-gmT4+c10w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Nov 2018 at 13:02, Martin Ågren <martin.agren@gmail.com> wrote:
>
> On Wed, 28 Nov 2018 at 12:42, Paweł Samoraj <samoraj.pawel@gmail.com> wrote:
> >
> > The git-reset documentation page section which is accessible via URL
> > https://git-scm.com/docs/git-reset#_discussion is not looking good.
>
> [...] The correct fix could be something like 379805051d
> ("Documentation: render revisions correctly under Asciidoctor",
> 2018-05-06).

Turns out it probably is, so here's a proposed fix, followed by a patch
to typeset more of this document in monospace. That should also make
things prettier, but not in such a dramatic way as the first patch.

This is obviously not 2.20-material. About where to queue this, I had
expected this to depend on 743e63f3ed ("Documentation: use 8-space tabs
with Asciidoctor", 2018-05-06) just like 379805051d does for proper
rendering, but from my testing, somehow it doesn't.

Paweł, I'm hoping this fix should be in v2.21 in a few months and then
eventually trickle down to git-scm. Thanks again for reporting this.

Martin Ågren (2):
  git-reset.txt: render tables correctly under Asciidoctor
  git-reset.txt: render literal examples as monospace

 Documentation/git-reset.txt | 277 +++++++++++++++++++-----------------
 1 file changed, 147 insertions(+), 130 deletions(-)

-- 
2.20.0.rc1.8.g46351a2c6f

