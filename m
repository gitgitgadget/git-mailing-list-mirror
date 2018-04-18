Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB741F404
	for <e@80x24.org>; Wed, 18 Apr 2018 12:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeDRMP2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 08:15:28 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:34910 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeDRMP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 08:15:27 -0400
Received: by mail-io0-f177.google.com with SMTP id d26-v6so2136249ioc.2
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 05:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=u6tvA4EvtNTA8u7PW3C4iYZs4O+5JRKo56xjwrphuw0=;
        b=HaC/xFqEdSjBXbIduSvedlsjr313pxXkXEy7R62DfhB1Tj9mI5C63qQxEO7mKNakCd
         moWg4/hpehjz/e5Ht/pt2dFTaZh5g6wtwtimGXtFtI76vNLXdI+yj75qUHk0r85wwyns
         /BODzq9BgSWhWtz80SGow8Z/s3T3TtXnmCmpAmXhdGF7cD+T9chYYf7h+N5PLhaarvAb
         Ddv3DicdrB5IV84L0/ZjCe+/xU1QQT6XVH2gc3R5PNIenqE06cWP3he2pTL/KL+4tjAD
         GiEQEFPXy3g0cYpZkfAYG4Xm2dquIBa2Wz0sqn5h8moJC28wWFoM+mgn+WfECB4TxRij
         jdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=u6tvA4EvtNTA8u7PW3C4iYZs4O+5JRKo56xjwrphuw0=;
        b=T3oOFk7gaBpfRjAeIHPcVOTJJZ5f9IQYPQdmhBL1denIT27l3ceCnvncoUa1CNZ3le
         qkAGZrhRjwRwQca8Le/5fAjJw1XiYin+lAq/vqqUQOlWVHF1M84LJmfS0VXziTT70ZzW
         HZPGufHBZVVNN7A2VqsrE5ouxHX6F8yPnTvO6GBGuMkzUorwEL6wL9iMSSZHeogF+s8e
         g5CktgoBjWq3Y5HBC8rcyZh35bhbRkBrgorcmVUubEmgtvK8D5e1n60wSWlTHsNcsgbh
         sqb75b1LHcgTfYbR9HAAgvm6EbdMBmwxPb/wL1gNxLX9FJ38OL2wVxES42csLZayoXiG
         H16g==
X-Gm-Message-State: ALQs6tA6SDv1zeQPexAE+/mMllqOXR6XQqBr+dODPgrrtuTOaal96Gtu
        qmT6g5nt695K1BUcNyld1Rz50xxQRQgm8mxWcf/O7i4d
X-Google-Smtp-Source: AIpwx49odeLYH0a/GiNxY+TPZoRtRi5zS8k+GXle3QoeHQPST7MxCjTcLIec8lOhcokKHHQynj7y2ZtxUQEAZr+/o4g=
X-Received: by 2002:a6b:5009:: with SMTP id e9-v6mr1817070iob.147.1524053726701;
 Wed, 18 Apr 2018 05:15:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Wed, 18 Apr 2018 05:15:26
 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 18 Apr 2018 14:15:26 +0200
Message-ID: <CAP8UFD2S6iZwGFF+Tv-R3=iv7j3qrLtFBms7kXhyOtu1a2VZjQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 38
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sergey Organov <sorganov@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 38th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2018/04/18/edition-38/

Thanks a lot to all the contributors: Jiang Xin, Jacob Keller, Luca
Milanesio, Sergey Organov and Kaartic Sivaraam!

Enjoy,
Christian, Jakub, Markus and Gabriel.
