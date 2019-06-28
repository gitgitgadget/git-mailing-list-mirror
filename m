Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF0A61F461
	for <e@80x24.org>; Fri, 28 Jun 2019 15:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfF1PD2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 11:03:28 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:35822 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfF1PD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 11:03:28 -0400
Received: by mail-qk1-f180.google.com with SMTP id l128so5083564qke.2
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:date:subject:message-id
         :to;
        bh=ucRMkK+qUq0sxQdW7z+qb9Z2tz/softnV9/kecpmKtU=;
        b=MIxxeiJfORCkxYoVpeb+0gJ88tllzw8E75yOioq4M/CtuE4QlRBilCLJGI+LZoKGF0
         nZU82F0x4nl+sAFZtfVlBSacIUrRpb93js9ipWT0R6qedt2nr+FiG2eRxOda3zmBkzJZ
         G4CKxJKDfIoLXnbloXRwC4htO13W7vnA/dw4BOAoGjoQG0C1G+q4qd8KkFjoC3l1ZOjG
         nM15t6JfddJ4MZcmwSf4V1Zw9gaeAaIQCQ2I6TvqaW4iz5bMZ71n8Uy9h910GqgIwWHt
         CM5sVdQVxIn49QJcoA3Sj23IWB7yXfLn6wJ++N2ucykvjqv0nIWLCFmWHbCMbcBEy7Pl
         XuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version:date
         :subject:message-id:to;
        bh=ucRMkK+qUq0sxQdW7z+qb9Z2tz/softnV9/kecpmKtU=;
        b=JFDPGt0MSE5fxc04erqVl3svAcueP0m4kJA0DC1noZj39d6TtZ1MZT6E05Vqbvk4C2
         h5W18lxTuyRJ9Kklz0FZVqkO5NoCouFOsluu5xUvyg1ELLBCi4fA8Lp4CIZK35p7oAI7
         /heQkPLcHqC8G8ZGLKTpRPDmrJdSLTUshUaCFRLGWqUJHsk7gFYU3YNDwtq/L29vGt4a
         S7mYgN4c9UxgUTEwYZik/dDTNYR+XN7jS4diVLOc/lyq8tRHJUX3o9tQBqXdhiJj1TR2
         icTGKjrASSJiRrvkE6OnY+T8K0DyxfHItT9eSM75MC3pc7gDY51mG6Ft3BYVtrFflg7m
         b3uQ==
X-Gm-Message-State: APjAAAUrVPLing775ORh5c1wzYuWMsWQr5qVhZb/epErorCK8c6cXh6O
        psbgO+Jf9jxu9X2pCNE20unaXJ13
X-Google-Smtp-Source: APXvYqzTY5874a21ZA1Qc6+u+em+IIT9hf2F9jm18XZneMWLGYjNakbiZGTcqJhNtx8b858+uP7Xcw==
X-Received: by 2002:a05:620a:5b0:: with SMTP id q16mr9068525qkq.212.1561734207770;
        Fri, 28 Jun 2019 08:03:27 -0700 (PDT)
Received: from [192.168.101.5] (c-73-187-182-60.hsd1.pa.comcast.net. [73.187.182.60])
        by smtp.gmail.com with ESMTPSA id f5sm999736qth.35.2019.06.28.08.03.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 08:03:27 -0700 (PDT)
From:   garrett dean <gdean229@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date:   Fri, 28 Jun 2019 11:03:26 -0400
Subject: Git installation
Message-Id: <E35719A6-FE2C-4D17-B491-6309D276C037@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (16F203)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=20
I have been trying to install for on my PC for Windows ten and at first I wa=
s having a hang when it reached the end. Now pop ups are appearing saying th=
ere are configuration problems.=20=
