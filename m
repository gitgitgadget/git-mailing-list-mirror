Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C403620A26
	for <e@80x24.org>; Thu, 28 Sep 2017 01:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbdI1BV4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 21:21:56 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33068 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbdI1BVz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 21:21:55 -0400
Received: by mail-pg0-f68.google.com with SMTP id u136so74794pgc.0
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 18:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=l3nfHo52klbVlOqerPgukKTE2cqOQAt198VOjFUM4Po=;
        b=ba7mOQOHoB2ljdb3bfg5jSfWDxpPvBeySZ8Pvfe9nlFULGoNz1rasobQlPbb64mKiK
         Bl9YwtskJiAemZSqXziWdaA0RD+aPQM6KuySVjSfJr6c9DkQHsQP6uCKTvVzl9Qhwknh
         HqfR6RHw6buOOkps/2HbB7G/Hp2w5k0qMICZJ+PNnpcOIrWctnbvSYaIQhSAmFjXDyfw
         vosRpat/VbtA5mB5xDXDU3F3zHPbQS5fMzUPSuCkTkdrwhPgX7Akhqp2Oar3l7Avjaoe
         wa4C/lgGMsdJ4V0emuDN45hRDZ+drRMwMKrSxMpJ4YMCeklfqxAkp/zagmtx4qAK+Haf
         gYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=l3nfHo52klbVlOqerPgukKTE2cqOQAt198VOjFUM4Po=;
        b=ihU0DJJxuX30cLXGQUcn1Y7YmnPJhIRJHLxWB/G2uOwOENC4k4Q7q96NFyHOF8hRxF
         L6lpDrZED6utum7rz4798jRqCy3+jfE4S7HOtniNQ6XxU96qb+g8AR/oXhLcha3LRbpi
         +QacLIKgiSK2UUsy870iA1iH9Mn1bG2t9nBvF16iChdy4/O8u448cZFdfNrScZVp2Mfu
         WZytSs1pxYhHnf8hZVQUUfFG3zDf1DFeV4W7mnMrEr77IVS8PgTrepSplZWYJUYZvJZX
         8D4+NYDstpVzZFVmwzWdgKt8GCv/SrWrZcCXNGbxCCHkQvLpy8okguESJr/gJ/HXojZ0
         nnlQ==
X-Gm-Message-State: AHPjjUiuLD68mksE9SbRsAnwbO5B7aOhHWUYirJs2BrSC9U86VBBI9nZ
        uQpSY2qPQ9dT7SzL9ITID7J9rdMai73RrQ==
X-Google-Smtp-Source: AOwi7QDBaoEHncYBE3bbIOvTCDBx1aIC79A0UZZJHBxTcFF9smpeCXK4baDCoPSE6RaDn5MI5MaGyg==
X-Received: by 10.98.149.69 with SMTP id p66mr2843247pfd.199.1506561714005;
        Wed, 27 Sep 2017 18:21:54 -0700 (PDT)
Received: from debian ([101.210.209.208])
        by smtp.googlemail.com with ESMTPSA id j68sm302486pfa.93.2017.09.27.18.21.45
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Sep 2017 18:21:51 -0700 (PDT)
Message-ID: <1506561693.24644.2.camel@gmail.com>
Subject: Help
From:   Nityananda <nityanandagohain@gmail.com>
To:     git@vger.kernel.org
Date:   Thu, 28 Sep 2017 06:51:33 +0530
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I am new to this community. I am facing a problem while using the
"make" command inside the "t/" folder.

The error is 


"1..31
Makefile:49: recipe for target 't5551-http-fetch-smart.sh' failed
make[1]: *** [t5551-http-fetch-smart.sh] Error 1
make[1]: Leaving directory '/home/nitya/projects/git/t'
Makefile:36: recipe for target 'test' failed
make: *** [test] Error 2"

It will really be an act of kindness if you help me out.

Regards,
Nityananda Gohain
