Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E19D1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 01:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeFHBWC (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 21:22:02 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:46781 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752202AbeFHBWB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 21:22:01 -0400
Received: by mail-qt0-f174.google.com with SMTP id h5-v6so11915043qtm.13
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 18:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=b2EtXhXQp/N4klu6iCtwBUR+Ts65BlG9QOOf+P1VZGo=;
        b=f3cc8Fc1M1OgXhlW7Rmac/B08OzhcJVxHgsEbcdaasLnF304EAtg/a3nc/mBBQWC3D
         R8Pn6VKe7eMZ1A1/QVsgSi7ztWuV2A11lGy5fpRcDPPKqkH7Eq+tCKCN4NraUXN56+fn
         2zDdqJ1+KDpJbmPpHZXgO1Lc5euId1F3iV6RJPX8lSSvW7FTAwOw4Ai1zLCkHJuDiyPk
         Mwy7bWcVEsk73mdMcViDjD4TlP1sYhkrxKzFGKOSVrRWyC3MLrB/vqlrM3ZqjbO4Hudi
         M/v6eM2n2wzcN7Qdj1PwG4d7qWIHlscAWC4PivOzx9JBlWvNPOZtVqUPokLBju5f7oGd
         oW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=b2EtXhXQp/N4klu6iCtwBUR+Ts65BlG9QOOf+P1VZGo=;
        b=lnLeyVS/mGRT6DdnVcsgM9SkI8tn/o/yEur8yYsNVsAbxUm5gzSsG2uXczyWnzkdBS
         TFPtGFZiumxaKW9BKSTQOOTPwL6mFuS5/kbxT5HPu9RZN2/zIsUYlNrXKGTQrxpuRZNH
         A0cGx2BWphH8L0lnVyyT74rI60DVV7xm3sx7I85Dptng2GLEU/HIbBu0LfywKun3ajtl
         hnml1tIzJwkWCOLQKKYBufl/ch/049D2YS52qR7iZJIlhkCDgjRxaS5PAUJcdVap3cS6
         tY02wZ8OQvVSiBkNt3DrGyq0aiIcxJ0i204VYLn6jvomxUEwujGQtcKewB3y289I2xHx
         DYxQ==
X-Gm-Message-State: APt69E1VgQYXNF0MJZIxjUmhKeo293zkAqvJht5SQDsA3o0d3N+sTgVQ
        hgHKn7B8glqbx9fQZPHMs7EjP7ghRPcYa9kffiI=
X-Google-Smtp-Source: ADUXVKJrbtysOFMxfKnXg0wMOy08gkka4x6EgCgDlSPEm0ldWS81kPqSFe//ruhR3LPLu41AlK2lI+vtyuNIYp1RFzA=
X-Received: by 2002:aed:3ec9:: with SMTP id o9-v6mr3909020qtf.242.1528420920789;
 Thu, 07 Jun 2018 18:22:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:b490:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 18:21:59 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 8 Jun 2018 09:21:59 +0800
Message-ID: <CANYiYbGF=jr8EoUg-0sMDP-c6N8kN41NRJtGHGXOUOQc7aRPQQ@mail.gmail.com>
Subject: [L10N] Kickoff for Git 2.18.0 l10n round 2
To:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git 2.18.0-rc1 has been released, and introduced 36 more messages (144
total) need to be translated. Let's start the 2nd round of l10n for
Git 2.18.0.

The new "git.pot" is generated in commit v2.18.0-rc1:

    l10n: git.pot: v2.18.0 round 2 (144 new, 6 removed)

    Generate po/git.pot from v2.18.0-rc1 for git v2.18.0 l10n round 2.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
