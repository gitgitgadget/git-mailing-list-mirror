Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBE561F404
	for <e@80x24.org>; Wed, 21 Mar 2018 13:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbeCUNBK (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 09:01:10 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44437 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeCUNBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 09:01:09 -0400
Received: by mail-io0-f196.google.com with SMTP id h23so6528893iob.11
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=f8B5joQoAOZxhw9hRl30yos1x9Pbz7EHDw7Z3Zj3iiU=;
        b=kDm1bE04Emor8zrAuh4EPW3/hh5BBHO79j+MtkPPr2OMDzxF2G1P8lyBSPAFxNxfBh
         80azUfIlkUfKWXe6l745UxPoffM2WpM357pTALX9WT5hHh/OzsE6seFspRq3ngaUwllb
         ax54ptcwZsWQw0wCErPKEqYEecfyzicMuYgX7EcO9P9EyDPSY8SB2DamKwIjIafpwwMC
         3q7Q0MLD4Row/xknn31FS0tz8xsi5r09CLECjhp8OKRUuYiB15jTPut17bSTnxYZ9HQ+
         nQ6aRRr/StHNuDFo5+dl8eSObOqEMYfAs91M0mzJFSKWo8XGezn0zPt8BgStiHed4XqZ
         tzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=f8B5joQoAOZxhw9hRl30yos1x9Pbz7EHDw7Z3Zj3iiU=;
        b=dxzqzneKxkIYPFwMOPiGTalhF3yG53SOgYQtHmrsmtzcAGrv+THjvag75sYzJfXd7g
         Xv4QTLWVGIovWjDR93zBvek7Yt1aDcdExgAyYk0UKboc003YTaaBbwEKlTm0Wu8kwaoE
         4dwgCfaTmldW5GyOjopr8MS2J0ugFEfFs+V5al9yDO0HeXl0FisW4yCwJLxJ1b9U+e7M
         DOC2taQP7E383h7qQ41KnR4Yv2bXjj15SjpFpyZwdWuXPgY0JIYsMwaKmX8n75yhDc1/
         Xybah6Hu70fXvbSiVZkTdvJdtukFQ97cvOfWoCEycYHM9vx71/vwEudNS1wlAW/o33Hm
         XLnQ==
X-Gm-Message-State: AElRT7Goz0Xs4/oYKNQh9OagBD7XvcIAVaFDwTvcHfJ4PP9UDTFOKWSu
        urKog7q6/NJQV+mNYkeLB8On24bgV2ho4LkQsSV4WsV9
X-Google-Smtp-Source: AG47ELtrn+6bieBeu5Yj7FziX+TVAPdodNuJMo+pmvZCnuAhULjQgVv1Sm491xZxbFpCaFIiu9H+r2vignOcMKmYLQc=
X-Received: by 10.107.144.197 with SMTP id s188mr21820669iod.147.1521637266871;
 Wed, 21 Mar 2018 06:01:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.146.25 with HTTP; Wed, 21 Mar 2018 06:01:06 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 21 Mar 2018 14:01:06 +0100
Message-ID: <CAP8UFD23Xku__TDkT10SRFF7oW8fozWo=WwtZ4aMdjS7WDBwRQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 37
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        William Chia <wchia@gitlab.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brett Smith <brett@sfconservancy.org>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 37th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2018/03/21/edition-37/

Thanks a lot to all the contributors!

Enjoy,
Christian, Jakub, Markus and Gabriel.
