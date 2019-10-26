Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 595771F4C1
	for <e@80x24.org>; Sat, 26 Oct 2019 11:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfJZLiG (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 07:38:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41766 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfJZLiG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 07:38:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id a21so3979465edj.8
        for <git@vger.kernel.org>; Sat, 26 Oct 2019 04:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Gy9ZCEufdIRx7kgkrtprc2eE9ZHWmS29kdshj1GGCRk=;
        b=CLspM0VeaSfbDo1frUQOH+vIcAvWRXqkm2Nbt4rBfYiynDMHfQiLqfpD+ywqXqfAC7
         20bHaWTT1i4sfk6JG4UeGl2C1L9RACK8Q0d7gcD2Mp9kJvQv6cAXQ4o0FKPPstQaEibx
         rCQpVirHaRcFcoTbu8GuGYWp4kbBqEHXreioMzRkCVd2TxX8ZhWJS39Af01g5x9q0OHK
         C1coLPj8StEmmCcXKMwo4w3wuL7Adwhjy5mbSAx+w6KQNLGyIxuyaLvwqbtRSA9ZhsOr
         K4ARDAaj/Yg9RYLzjL+Gxhr+PexZBcS8vtH0KoB651E80+tuwjYLZumocFCBZt/0RVC0
         w8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Gy9ZCEufdIRx7kgkrtprc2eE9ZHWmS29kdshj1GGCRk=;
        b=AYsdh+QOTlOy3aKw2r4LFTMpEgpJr1cHVKX7hcr/ED/SeMoz3QtB5P49mij4Xj21La
         wk/WZfjV7odQgDb+5uJi5epqJU1Gup6hOJQdin74GuQ/mtrFqxJdyF/X4S/RjSJXbGcE
         PWJ6CWvTB3sAMw7sWIzeGMkN+20EHWt6rAwr6vyumxi31KbJn4T2SCeTYJeSWNeyjjKx
         /ITmesy0u/v9H7IJKVfLcx2o5FvbjvXRvubeQKs4tcUgBjFQMlw+x8RXZHTASY1IzhzK
         XGThlnSvJ0oGMLfFXs0dpyfMqF3K3HOrQQBWKSCweGf/FHVuxGfDMSxOrVMbo87oa1mB
         il+w==
X-Gm-Message-State: APjAAAXIVrfrPAMoY/UGXfRO8wmb5s8ulQU5hvcSBJVkEG+H7azBG8z6
        gSoYz2QL4qeD0xGloI0L2OxTVq6378OYJk9ulAVS6/UwFWw=
X-Google-Smtp-Source: APXvYqzCbuJrGUu0i8T5bV5Gs4brYA1zxiAncyEDIc8wkeClwAEB4W3Be0EWHmBkzT62B617q2Y+oAqZ8hqYGoufdc4=
X-Received: by 2002:a50:eb81:: with SMTP id y1mr9101648edr.119.1572089883911;
 Sat, 26 Oct 2019 04:38:03 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 26 Oct 2019 13:37:48 +0200
Message-ID: <CAP8UFD0Bh=bkf=Mp6SBFi=z=bXwHWm5gD-p8yUjZBMcF=DoVbg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 56
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Elijah Newren <newren@gmail.com>,
        Garima Singh <garimasigit@gmail.com>,
        Pierre Tardy <tardyp@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>,
        Luca Milanesio <luca.milanesio@gmail.com>,
        George Espinoza <gespinoz2019@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 56th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2019/10/26/edition-56/

Thanks a lot to Emily Shaffer, Luca Milanesio and George Espinoza who
contributed this month!

Enjoy,
Christian, Jakub, Markus and Gabriel.

PS: An issue for the next edition is already opened and contributions
are welcome:
https://github.com/git/git.github.io/issues/404
