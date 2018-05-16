Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D4AF1F406
	for <e@80x24.org>; Wed, 16 May 2018 12:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeEPMcN (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 08:32:13 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:52576 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbeEPMcM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 08:32:12 -0400
Received: by mail-it0-f43.google.com with SMTP id y189-v6so1340312itb.2
        for <git@vger.kernel.org>; Wed, 16 May 2018 05:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QYuTIOzcrPRhwA70BMZuFha377Rmaun0d+1H/BNTHpE=;
        b=f0SfzxrCCvGRoLAdtJHaKjmZOYKl3gKNboZXrWhH0PsYbWLsDLYSEfURftsvTSu1ta
         h276pvPUfCiTo1ZCzqgrJGO08u0d/P0Gq4Zhm6xKPY8UmzjaPsk6JV3pM55C83LSYSuI
         VgQMaRKf/uCHaoVK7EFaaMzz37HB8WTSpvnlhzWQD7L3j1T92y9fE7cIrQ8A2FfzNsxy
         rzvJgEujmFbfCZKWNIPM4NwtzuARN1pk0/02cWdfIGJ8UxosVHPZdR2psW5ZOUKIdgej
         kh36gwOhcw5lBcM2gS54KXaS8pl9nlqEgdhoPyFX4ksLzDIjTZMDh1f5b7unb2vCY7xm
         4qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QYuTIOzcrPRhwA70BMZuFha377Rmaun0d+1H/BNTHpE=;
        b=Z82cyF8c/f92inVD50F3ajdZmlkDmrrp+A4O53L2OHhiulpcH1vR6R+ZwZvtE2Gz95
         I5bgrV4RogmBpSlhCOHmaEo8u3HfCPF1j5fQ/3jaGQJsGySLpOtBkjaanMNcvZ3Ef+rh
         kQ3z7L1fAHCuFodsdhT0nRefL+z5YmYoxXcPQL4REMaOb8lsWt0MZqKk6KRfQbIa7BbO
         AMY7YssGAO6GI/JuX1ka6mpSFmgQq+7fYeUqBj+PtDt+6AFmx3XrLtBhScjcBhJQ0Rmw
         ofMIfT2f5hCNvq+nGZAn0AFaVHJeaJHLNLI2GhN8HQecFG/pmFv98tOmiCFoPISHzjTO
         qX4g==
X-Gm-Message-State: ALKqPwf4Mscph6I7jU73Wu3l+m4pD72rkPSZ49AlMIZWAX7VvT3+0ACE
        ETdOV05+ibfRlmlPdkYaCGR/ydh3kH7eyZ8CcWzjGmRo
X-Google-Smtp-Source: AB8JxZqQIISa1Dc7FTYLtpPix1oEBxntj1M7W5QJQHIWeAeC6ulRzAdE7nftiZnNdxxGoP6NCwYKv61aur8m7y5JqcQ=
X-Received: by 2002:a6b:ca46:: with SMTP id a67-v6mr744173iog.53.1526473931776;
 Wed, 16 May 2018 05:32:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Wed, 16 May 2018 05:32:11
 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 16 May 2018 14:32:11 +0200
Message-ID: <CAP8UFD0aug1vwqDLTA9Qx0OvzYje5crBgKBpc_COgggaVd6F7g@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 39
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Ed Thomson <ethomson@edwardthomson.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Stefan Haller <lists@haller-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 39th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2018/05/16/edition-39/

Thanks a lot to all the contributors: Johannes Schindelin, Elijah
Newren and Luca Milanesio!

Enjoy,
Christian, Jakub, Markus and Gabriel.
