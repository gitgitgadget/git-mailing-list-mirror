Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51041F404
	for <e@80x24.org>; Sat, 24 Mar 2018 04:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeCXEcQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 00:32:16 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43742 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbeCXEcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 00:32:16 -0400
Received: by mail-pl0-f68.google.com with SMTP id f23-v6so8651020plr.10
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 21:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ykfC03L/OGft4KJ/RHI8Ds/IgpS2ZKjPmK6azZkfZHI=;
        b=seGXi1AUo3fdE99DewuNXTDEQPMFV/rprlHx1SaSETiRErLo954s0OmsMx3WbCrTlR
         lWdC12hTggSUTqTILiQXM5emo1A2eRL9kET/UM2Mdd/WrJK9XkxlJYLW2XpGK6UF9zAv
         fyZHRn2saNAmoOvTP+1T/eN8Lttt8qEv5wLfgRWGDD2KV9gSlzwXv9mlCAEVvCBGekaz
         I76Gf11ZZt634JgrbCLZO9ZFAJ9lfz++Tv6rTrsc1It7Q0vMXJRYk2tiQ2ASEVk/F1DQ
         4IQAtgjou8P23wTCRCNHLV6tyYb2FfRunSKUDzAGbTq9V64QFDtkKlghLZ5Orh1Eu1yV
         tyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ykfC03L/OGft4KJ/RHI8Ds/IgpS2ZKjPmK6azZkfZHI=;
        b=uTXVayL5oSn89T5hrWvvsPg7yuZjC+Ql2u+jc27srm8gOYEaOI6dxWOV13sMPullvI
         EgSkAweUka3eOMV9EpYq2bBQp2WneEENfB/x+8Ajm6mv6dThNKS+tj0Tj3FMPaR1xua3
         BiZ4CmRwjEsadgFkF3gYsyoJj02+mGIjfdfAVHK/CFMDiKRL5o/g1MJ9YIQcTCfkSjJX
         ZCNb9avjJooqx/gbE/SmUKLKJTjylCGMKLGON5DedN4F2uqYXEvvD3vfjST2GMYL0hT+
         tAyN9WPA20QkegX9hHCXJb3TNFJDyURpZe39yuZ6Gzfgx5wjwNJFLFf+cBDz22BBIzsn
         KrAw==
X-Gm-Message-State: AElRT7GCm0MR/R6V8+QGgubcfWtg6chfG+tveqr0BbM7rNiP+nZqwrtP
        ou0RPZjkQs0ayP+VXNJe3xqo+iw/
X-Google-Smtp-Source: AG47ELuvN1RNKeZNSEdl/oykxGAnsQw5Qif4cMKys2mT7tQPd8QUvrCe5iGOPN0ZZFqBXw5Kyi3Qaw==
X-Received: by 2002:a17:902:b485:: with SMTP id y5-v6mr1447889plr.91.1521865935224;
        Fri, 23 Mar 2018 21:32:15 -0700 (PDT)
Received: from localhost.localdomain ([27.34.20.189])
        by smtp.gmail.com with ESMTPSA id f5sm18188292pgn.56.2018.03.23.21.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 21:32:14 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [GSoC] Info: git log --oneline improvements
Date:   Sat, 24 Mar 2018 10:17:05 +0545
Message-Id: <20180324043205.31976-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Christian and Johannes,

I will like to send another proposal on git log --oneline improvements.
My first proposal[1] was on "Convert scripts to builtins". Can
you provide me information about "git log --online improvements"
and point me to resources where I should focus on my proposal.



[1]: https://public-inbox.org/git/20180321061605.27814-1-predatoramigo@gmail.com/

Cheers,
Pratik Karki
