Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB3AC1F404
	for <e@80x24.org>; Sun,  1 Apr 2018 17:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753764AbeDARkw (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 13:40:52 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:46773 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753743AbeDARkw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 13:40:52 -0400
Received: by mail-io0-f175.google.com with SMTP id q80so15737843ioi.13
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Bm4ae2nyi3NNUIaDsw7iy+oBiAlKxTeuIyMkeffGGJY=;
        b=YCLiMqHMq34NpxDDJf0BypzEqzBvsC+Upx52jq5EZLYgiP1FaIAwL7HaDzKznEQFu/
         8HBRjJ6DwyRGUOwpDe+qoT1pl/fkPeSu+cnuGcyGxb3WW65/b6L/1ztdY1I9c9Xa9iEV
         NfCEpIvFiVpKBbUnfdKp10rIEIRZW0UjGn1Zfxy6hZjQkG21koIBzcN46vIKYbU4UHpX
         G4F8utkRGbTHYXfzvgJGxn+I+dT3QzkMyKvPLj4MXnbZJncQRFZSkijT+CRgrKhH/5UO
         x+r0E6CRgyi4hqIf9aC21D9WDgF78naOF+IGDFuWmlchXJU37aPoLE9VgHwLCa+HOzpw
         gfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Bm4ae2nyi3NNUIaDsw7iy+oBiAlKxTeuIyMkeffGGJY=;
        b=WHS7/c3TH+AHcV5bN3FYZxcQut8iDhgzpvdCER/1aPwGSX34PM1H9goZIrMh5IXy0B
         oqcwI3tXEP1g9sKcBQSUNrrzy0VS3XA/smrrNmUvtjayvyxO+l+IrDg7k1y65KNqW0hb
         gazPgmE9jeV/SHaVpnr9YO8U1Ovt7dj5HWD/Frmh/C/fSNCdwpSpcPkBpOr2u17MjLDQ
         cJ4f9Ocd3n07oxauAQOcPfhAExPBqAkgzjAOGo6X7wabve6T1uzHu4R52/d5ySNYP1Kv
         uDdVpPfxwKuBBpCsac7GJmtJP2OqYXqfdx0/+C+IMEHzHl4GFwo6+nEYsmwAgpLVMB2U
         LqIA==
X-Gm-Message-State: ALQs6tCfer41K6ayyIBCXrOTSi4+IrXO7V8hRFFL5xYazXgZikW9os0x
        wjnzEaxNDpRlQWj2EwOlew6Y0Qn4Rc8MA+I7c/bsGKa6
X-Google-Smtp-Source: AIpwx48wTvAHzik/q8kQSisWRq5Vnor7Ng/TWv3gqkZqCynRVpJ4prdLuAzlz6jVtXhtddFd93P4bSGdMgs19nfdACY=
X-Received: by 10.107.144.197 with SMTP id s188mr6387009iod.147.1522604451025;
 Sun, 01 Apr 2018 10:40:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Sun, 1 Apr 2018 10:40:50 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 1 Apr 2018 19:40:50 +0200
Message-ID: <CAP8UFD0WZ07EVER_HupcFLw4w-4H2hb2cp8wTaj2i9jOc_+pTA@mail.gmail.com>
Subject: [ANNOUNCE] Git developers contacted by an advanced alien species
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@sfconservancy.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Members of an Alien species that have a far superior technology have
recently privately contacted some Git developers. They said that they
are amazed by Git technology and mostly wanted to thank us all for our
hard work on Git, as they are surely going to use it due to its free
software nature.

At the same time they expressed that they are a bit appalled by the
state of our free software operating systems like Linux, though they
told us Windows might have been used by them if it was not proprietary
and especially if it was faster at running the awesome Git test suite.

The Git developers are all the more amazed by the fact that Dscho, the
Git for Windows maintainer, had written just a few days before this
contact (https://public-inbox.org/git/nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet/):

"An alien digging up ancient Earth history in the far future might be
tempted to assume that Git was developed to develop Linux which was
developed to develop Git, and then ask herself why humans bothered at all."
