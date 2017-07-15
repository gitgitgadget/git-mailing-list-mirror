Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA4C20357
	for <e@80x24.org>; Sat, 15 Jul 2017 05:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbdGOFGV (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 01:06:21 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36246 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbdGOFGU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 01:06:20 -0400
Received: by mail-qk0-f171.google.com with SMTP id v17so83847106qka.3
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 22:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=WcVEMUHRQIxpjA1Be1cPWSVpQ5v2H8ljxFFYBJDPJiQ=;
        b=Crm4weX+mhpR2toig2mNj8xmkKx8RCHjIOzu7jgo5eEDRt+mKTFijruAvz2ApH/aJ4
         PeYfxmWkxeIxKMWsY6VsVXwY4gRzOuK4a6scre9pM1tbTFugWbnI81PHHn5iK8p1gQjb
         ymncNvRnKq6SNjj+T50CZaf5s30wwGX3YcZ5erUkN7VgKzx4JCmX0sN33Ba64F+BXZMg
         iDy1cQqfQ+8Ox796ZzhMNBhFx+JcfFeFoxGCXmNsXiZ7724cMoLEKZSOF0aLV/IITGJY
         9OhwrrRrn+CHkYlmCTUFoCEsNfMaATW93kXjLNF5t4tIYPsYR4hWZ9/+oY+/EwgTa1Va
         QsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=WcVEMUHRQIxpjA1Be1cPWSVpQ5v2H8ljxFFYBJDPJiQ=;
        b=SgXZ7ClTaOChmt8JDFJAZODIuRl4uSPPitg3s0/l0qu9iEhs2fOTyeXy+PstmU65Bj
         pNCmtqSEN7dz0CgXp9QNI5Vt01ri6tTON1jHDDfjIuCz7Y+9KLY6TzoCIVd474tLbnkx
         /JGtmtauJB3YSUyCAi+O18mU9Lkp9HQ+AkeudTkkfvaLvXo3RE6EbeQ2Xtt2r02Lw6wu
         qsov6it54dlxBDRNXGGZHj1GVbt/kksNUhaCRrc5avY4VUzvYd0GALVWFaCgNvSMKMTH
         ymIdJSooWaWfNKSb2N7rBJHZJY/XVUpRNbMHoJ6MgLlcNgMS532ayrX2EHBcDx+DNfTL
         8HLQ==
X-Gm-Message-State: AIVw110J+EGuzLpqztYQeHDgwcetAVCBs7sJkFeFCmlE+DN1u9qgov6Z
        238R7guLhLfbjXjq6BoU/YusZOVLKg==
X-Received: by 10.55.191.7 with SMTP id p7mr10135799qkf.223.1500095180082;
 Fri, 14 Jul 2017 22:06:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.193.38 with HTTP; Fri, 14 Jul 2017 22:06:19 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 15 Jul 2017 13:06:19 +0800
Message-ID: <CANYiYbET27mNrZZTNmn_dKBHLLEb4wJiznZ2O1X=WQ_GtamN7w@mail.gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.14.0 round 1
To:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Nelson Martell <nelson6e65@gmail.com>,
        Brian Gesiak <modocache@gmail.com>, m4sk1n <m4sk1n@o2.pl>,
        Vitaly <vitaly.gorodetsky@gmail.com>,
        "Ying Ruei Liang (KK)" <thumbd03803@gmail.com>,
        babycaseny <babycaseny@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.14.0-rc0 has been released, and it's time to start new round of git =
l10n.
This time there are 30+ updated messages need to be translated since last
update:

    l10n: git.pot: v2.14.0 round 1 (34 new, 23 removed)

    Generate po/git.pot from v2.14.0-rc0 for git v2.14.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
