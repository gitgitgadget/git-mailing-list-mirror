Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAFAB1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 07:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfFZHHr (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 03:07:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40413 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfFZHHr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 03:07:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so1712041eds.7
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 00:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+LcOA9kQdlLOI5jM/xQPDY1r5+ERsjiOWp4fszgmgcM=;
        b=SUlbZSBFrKXTtyGQoObBDDsScaEtL5dgibglfNbNfe5wXaa2fhP/hurEI4Kph6RE1G
         ioiS4r3Kwd2BF9M3jelUsxYsB3ms2Cx/pllXm/KVJ1B7wzqwQeqqKdjALADaRK97Rcnb
         iW9zT7OXnMbbshaIL/06PPnNDmj2v1jNFJQm0kElfSEVXXV3LeBZ6h9UHKKgBhOllamr
         C8gInLaKe4M47ziIV7iWTkyFt8dHtzMHqMl6HedeMzW8dS9PKbaSNp9N5S3IBRTtVmLp
         xOg2B3GJlB3Qjdj4h5xokhEFqQ+YG28fdAilC8r9KUUdo0WXvbLosfnWTOt13X045bmE
         MjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+LcOA9kQdlLOI5jM/xQPDY1r5+ERsjiOWp4fszgmgcM=;
        b=WYnzEOPF5IpXmOHvX2gOkFNP8J/gItEUEz9f0iLH4K2IUk5PIQ5eGEjnkEirkhj0cS
         jYaTVSRVYYBn97GQJWurGFiHVJKFIAoRxWUGADVhV456REU3Ssnrj20cayWpQJPUNeRa
         KyMzWelt6+VPh4Kh0NDPoVDTNyLkYIOTNc1HuizdcMNH9hb9rw9T1qtoIlw7dyyx4d7F
         htoK1ldbA+9NY4WcZQBxA+RRSY7Crv6hrhst/uxdJ4JZj4mPfQOydgjqet8JdIxZXlXu
         Z17i3odSqxgkevwNY9ccoL8Y2jEeILXi4zyC2CUXbNWfGT2aS5Q3/9xHXruSq7AUAaWE
         lR3w==
X-Gm-Message-State: APjAAAUaRLKyDC2sIFXAoWOZcgvxUVzNYGwADq9R6GAtnXuqZjIabUeY
        EfcAL3M+4iS/64g/vj7y7pW6ln1vZnIVw+7yYtIGzEoH8z8=
X-Google-Smtp-Source: APXvYqxO3ilT8DReQXWDINIGgjGaQa+cSoZoWuF5UMkPdeogiEOF/w7bJXKPozuTsOPCw8pt9cbl5x26K6PQcARUEVE=
X-Received: by 2002:a50:bdc2:: with SMTP id z2mr3171145edh.245.1561532865041;
 Wed, 26 Jun 2019 00:07:45 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 26 Jun 2019 09:07:34 +0200
Message-ID: <CAP8UFD0V4MVNm-RxQdaGw+8SEyff+k2sN1SSbPVwDLCYGdRuVQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 52
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-52.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/381

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on Friday
June 28th. Yeah, this is late and unusual, sorry about that!

Thanks,
Christian.
