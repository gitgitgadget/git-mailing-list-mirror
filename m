Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9241F403
	for <e@80x24.org>; Sat, 16 Jun 2018 15:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754133AbeFPOzH (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 10:55:07 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40372 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754004AbeFPOzG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 10:55:06 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so6173921pfe.7
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Rqb+BwsjPJKo19sTNMLI4ohOOMNF2pzaeOEfznsyNnY=;
        b=VRLVfwmUppW97G+T/YwASN+smS3CNdjHmayeNdAfe3y9xMIfl6EJb71AkQDL+n/A/Z
         wUgj1wC7mzkTv3o0yWeb/2Bpr5xrU4p1OqYH5mk36dZyKeClC0sJb0SGKZ7OZFCSEYzk
         y9KDjAhTVmIq2NVjgd/ewyy7ShhBWUSEsh9iODaNTGo6xk9S4eN1BUXrMLfUebNv77Q5
         ER4vwPTrWJj1ShferllkBXHQawMiaPgwOTsNliuIGkJSK4xOZsdGUGkxBenRtQvvUgNe
         iRFjqvhN6JKQokOSkHOA5/ThdEHl93uEXv4krBUbqYztFSy53dto4b5F1Gqly93uQmGa
         /jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Rqb+BwsjPJKo19sTNMLI4ohOOMNF2pzaeOEfznsyNnY=;
        b=QS+iX8sdx9SIo476ppxo88ECPRzMPFSIBBMMNqXpU2jIu8s47mi70jvKc16pDy6ZI/
         gyvTzoqsDEBhSeUnh90fZ3S9Bha4NkVS9qqv5YxCI4ljaQ/I5NfACk5Gd8EXpPwCUHs9
         2sFvWISXj7qIxOb9ya7LOIQPoyvO4zYxJ7tSsEud1cTOsbIEh+8yQ1OCshWTIVO8t8Ih
         UftKECHEAWPlCSBSpR3zsYLCDbX9NeqZbpMl7ZBAR6GHHLEltAfXo+9/jB6BSOgemhyV
         3WW4JjpEVXKRhPHDFtK3xEYcMnXNi1AoqT6dLVT5HtDtB1zo+EHeu/EOGHXcvM72x76+
         XBhA==
X-Gm-Message-State: APt69E3yZQwDEqyZC6FFLWwq8glTCcPP1gBHvbsEkrn4YDjAGl9F/Lj8
        goxRCmO1IRMvq+F0Dy8XfgGyGaNcLNcoIvTa1Og=
X-Google-Smtp-Source: ADUXVKKKzAykCYBiKdsduMWtP/juqipJF4YoXx4wjqxQChW1oCxQvu3R3Bt7/79Ahj8eDkiinv94AJpFzaNVRygVX3I=
X-Received: by 2002:a62:f705:: with SMTP id h5-v6mr6651933pfi.169.1529160906439;
 Sat, 16 Jun 2018 07:55:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2167:0:0:0:0 with HTTP; Sat, 16 Jun 2018 07:55:05
 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 16 Jun 2018 22:55:05 +0800
Message-ID: <CANYiYbFKuDepsrC7Xqi4O3RMiXZLaE_kWAAChEN6K16UrfyjEw@mail.gmail.com>
Subject: [L10N] Start l10n round 3 for one more l10n update from v2.18.0-rc2
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
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.18.0-rc2 introduced a new l10n update, and it's easy to be
fixed, even though there are only two days left for the release of Git
2.18.0.

There are too many l10n updates for Git 2.18.0, and some l10n teams
may not have enough time to update.  Not worry about that, we can send
one more pull request to the maint branch after Git 2.18.0 is
released.

Find and update your translations from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
