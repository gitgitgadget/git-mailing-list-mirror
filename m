Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41D921F794
	for <e@80x24.org>; Wed, 25 Jan 2017 17:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbdAYRUc (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 12:20:32 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36509 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbdAYRUc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 12:20:32 -0500
Received: by mail-lf0-f65.google.com with SMTP id h65so21653370lfi.3
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 09:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vqqJezXciKZPpgscwPI8p1tGttfFz5bjmxz4Wd6NlRY=;
        b=jY2oy8ZC+49eNe3ra08RslbAHlnT0b6PV4Fo+Rde7biDNhaX8zcwRA9/L7EZHRAfRu
         W0g+98RcK3SNyLDgietLNxF/HwxgmGMBqdtYqGQimz+Fhvy6yrXWKBRAT8dOcpRYeHH+
         nt7rv5BYFuIWzMHQuXGfKczvHKjZh0rvWTQLO9BnRUze1u1G93njLePujmAMjrC7l/PG
         2GObwk30wnrY65R4uN9m1PkhhC7w4X6+kNTNyf+80vmu1Ha3tz/REfqRjg58F4GS7fjS
         p6HDQfQmDlVwAX28juWfefQYoz0JAB42mCJtt0yjU9A096k1zvPfs+kM/rJgHNpnuTkJ
         qspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vqqJezXciKZPpgscwPI8p1tGttfFz5bjmxz4Wd6NlRY=;
        b=hGoYOvzblyXzxEyrQUeBirK50X7ru8JHEK8nHskRxYcXxwY9VF4/ICDzjWkMXXbWgU
         Tw/UJapqzqwQrAeoCj2aw2+BDMJmInDkWq/bdAIojQKB4N58aW1bViAgb4Fy7w+mipDa
         ALQTFvbhODjH8GP/0eAvPv9of+CQ20DFV8Q0i5ac0pBo7zfXgsUc8qYW4vc1dqX9xV6P
         gUfSEnkTnJHyv1pNkWnObpqgXCidIyc5u6lyMB8L8rxikjXPMYKBHPopiwo0lAPwC/rf
         L15HzfbSUinrkoK8A/JujuASoWD8JbQAAtjFGhLxCh8qErbztGrj+RyJZexPUY9bEzcY
         yLGw==
X-Gm-Message-State: AIkVDXJrW1ntvBwEIMFSudXU9ytzlg6DOCYuwmfQ11tNJzIUdiWQmtlVnYqHaC4rlj66Cz6KeQ4QHYe9x/0+NQ==
X-Received: by 10.46.69.139 with SMTP id s133mr16261029lja.56.1485364830509;
 Wed, 25 Jan 2017 09:20:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Wed, 25 Jan 2017 09:20:30 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 25 Jan 2017 18:20:30 +0100
Message-ID: <CAP8UFD2egjS5mjOCbC5dMGyb8LVzKjkBgdd5bGT-9Rrbb1uUHg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 23
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>, Eric Wong <e@80x24.org>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Javantea <jvoss@altsci.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Philip Oakley <philipoakley@iee.org>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 23rd edition of Git Rev News is now published:

https://git.github.io/rev_news/2017/01/25/edition-23/

Thanks a lot to all the contributors and helpers!

Enjoy,
Christian, Thomas, Jakub and Markus.
