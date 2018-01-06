Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929271F406
	for <e@80x24.org>; Sat,  6 Jan 2018 18:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752919AbeAFSqg (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 13:46:36 -0500
Received: from mail-pl0-f54.google.com ([209.85.160.54]:43555 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751509AbeAFSqf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 13:46:35 -0500
Received: by mail-pl0-f54.google.com with SMTP id z5so5113225plo.10
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 10:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1hF6+c2d6YmV6VN9Xi69RUi+P4mZ4JUQL31kgC+3ac4=;
        b=OOirGwXFDkENmIsY+2DDV8GaVH8TxSYG3Njtgxt6Q4n7dSIOYkGPQpezthIjVGuUDc
         9UUmFx/7Aygh+exhlIlMWBoQ2Dhf/BMBVr38fDIzgn1PIY/oZ95/oIXF/8Jtv5323gJ2
         I1o5oacEhF2TRlq4fy8zsp75iG1R+vKus4e7y0wt9uA27sAZoBR6vp5Lqsz/CfP7jo1Y
         O4m4jFbFOExSBthw1Iusb3aKDXF4Q3gIi8f5jrKUDFEcnITCpkiR7PQ0TXu2FMHMKRHw
         z8rrvaFG+yGkir8fw/n/0dvolvYwrTHyQR2MvC84kzyxUbhaBoLvH004ksGTf6eC0bzB
         im7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1hF6+c2d6YmV6VN9Xi69RUi+P4mZ4JUQL31kgC+3ac4=;
        b=GnIV36sB3XMgcXUww3WSzzBOflnKZUfBkAH5KmvlKrcj3moIqsMdk8vV/6hRd1e8dV
         FbNlbwF/bV0+MnhY8do/VJGT9tjOhwGqKfL7qvaq0DuV2YMTV6mY92Cef2XWlt8I5Khr
         WyCAhOwkfuKTL02PHCquAchsxxbmBjmpzSxW/Sal9AqWp3+01D1TfJ6ujogAsBtPtdAj
         gePyW4Mdagb0LcBwj5UbmsJvF7EK9W9qODRq4qGqHzTkiW7cd/JFWRB2pp+xK6ofi5sf
         UDq1q4mmworyKK6J1cFwd9sDc3D0NzyOsP++dQPehRMUgle/Ocsi1rzYxhAt8Hs3sZ75
         vhoA==
X-Gm-Message-State: AKGB3mKOEF142gsM/QHnwS8X60H/na30y7hXqTgDK2gkrSXmAPQj2DoE
        kYKhs/EVY1romnMeXEgiRGpxPa7V
X-Google-Smtp-Source: ACJfBouSnt//mGHh2ML4g4aBEkf0ditJk9Si9Mk4tkcoIapSPArKwmIGTpnDPmnEKDqJSzH2aKQ2ag==
X-Received: by 10.84.215.198 with SMTP id g6mr7215368plj.223.1515264394614;
        Sat, 06 Jan 2018 10:46:34 -0800 (PST)
Received: from localhost.localdomain ([117.246.198.31])
        by smtp.gmail.com with ESMTPSA id j14sm21141273pfj.93.2018.01.06.10.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jan 2018 10:46:33 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/8] Doc/submodules: a few updates
Date:   Sun,  7 Jan 2018 00:16:06 +0530
Message-Id: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac8367
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are just a few improvements that I thought would make the documentation
related to submodules a little better in various way such as readability,
consistency etc., These were things I noticed while reading thise documents.

Sorry, for the highly granular patches. I did the commits as and when I was
reading them and tried to keep them focused to one particular change by rebasing
them as needed. In case they need some change, let me know. 

I based these patches on top of 'master'.

Apart from the changes, I saw a few things that needed improvement/clarification
but wasn't able to do that myself due to my limited knowledge of submodules. They
are listed below. I'll add in patches for them if they are correctly clarified.


1.

 man gitsubmodules

       ·   The configuration file $GIT_DIR/config in the superproject. Typical configuration at this place is controlling if a submodule is
           recursed into at all via the active flag for example.

           If the submodule is not yet initialized, then the configuration inside the submodule does not exist yet, so configuration where to
           obtain the submodule from is configured here for example.

What's the "active flag" mentioned above? Also I find the phrase "is recursed into at all"
to be a little slippery. How could it be improved?


2.

 man git submodule

       update
           ...

           checkout
               ....

               If --force is specified, the submodule will be checked out (using git checkout --force if appropriate), even if the commit
               specified in the index of the containing repository already matches the commit checked out in the submodule.

I'm not sure this is conveying all the information it should be conveying.
It seems to making the user wonder, "How at all does 'git submodule update --force'
differs from 'git submodule update'?" also "using git checkout --force if appropriate"
seems to be invoking all sorts confusion as "appropriate" is superfluous.

How could these confusions be clarified?


---
Kaartic


Kaartic Sivaraam (8):
  Doc/gitsubmodules: split a sentence for better readability
  Doc/gitsubmodules: clearly specify advantage of submodule
  Doc/gitsubmodules: specify how submodules help in reduced size
  Doc/gitsubmodules: avoid abbreviations
  Doc/gitsubmodules: use "Git directory" consistently
  Doc/gitsubmodules: improve readability of certain lines
  Doc/git-submodule: improve readability and grammar of a sentence
  Doc/git-submodule: correctly quote important words

 Documentation/git-submodule.txt | 10 +++++-----
 Documentation/gitsubmodules.txt | 28 ++++++++++++++++------------
 2 files changed, 21 insertions(+), 17 deletions(-)

-- 
2.16.0.rc0.223.g4a4ac8367

