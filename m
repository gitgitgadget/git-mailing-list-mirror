Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2721FE90
	for <e@80x24.org>; Sun, 23 Apr 2017 02:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427463AbdDWCtb (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 22:49:31 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36167 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427460AbdDWCt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2017 22:49:29 -0400
Received: by mail-qk0-f172.google.com with SMTP id d80so31701011qke.3
        for <git@vger.kernel.org>; Sat, 22 Apr 2017 19:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=mKGatjybY0njfnsEJRcieBnn/Em14PpI28vMWzX1Hyo=;
        b=V3jyp1zD8UghZjxfSWZZwLZnvbahOsLcSEZWy1KLkueGRQyLgAbKgaOYCmB7ZVKdxn
         lh41EADY35F8AntTl9krezS6BTHEsdXCfsVdStyjVvCtp3lPOaVniS3u8l/UVDZ0w6dU
         /BARzMN2NR2XVJhUiVR09nvoHiUnbvmD3OOH+uAIOqowd9nGKYJvso/a7W17vb63wMs8
         II+ZshxXg3uep3KwVPRzqQ9L5F132Li28QYl9DkNgjBEE03vNGMH+f7OSR0fT8iP2uqX
         Vsng0Ik28rAor1noVntTfpG9RAXvw2r91q/2tZvjhkJM/mDewX5ETR4z2Ie3UOBnbOWv
         hezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=mKGatjybY0njfnsEJRcieBnn/Em14PpI28vMWzX1Hyo=;
        b=ARZYpo9618LZgVPGkNY857Oyp3X3kq/SmK7uMCotuEJg1vSFT9+mPIgE4Y1bnCJhFN
         lDnLTInabi/YgxNTiqWTPoOigCTKLBM6Hqsdip081iIaGGoz/dmOXusmleq4O/BFJQ1I
         euRyZix3INWGgcwY2XcWaAtCMmQ3/muknu3MwleFQvwviOCbDCIQESPEoImDJumnphx5
         fMepcHXOM7j/xsoTAUHUEHmRuoPFdxtccxWMhPTd52PGVfszv2dB8JHwF4eT8ml5qiy7
         kW8JhzXRXsrl9+1xvD/GSBMaDbq/E8Cjb0wSMBMaWt7HMtA+7ArrD332Kwrt0uIssw4S
         kelA==
X-Gm-Message-State: AN3rC/4qAwixkMBF3Peyqab53Wsyw1e8Gl+I/qt8HaZvFgqR3DzHV3Yn
        uEH39liXD7tepRpNknhqvYS7L7mi+Q==
X-Received: by 10.55.104.80 with SMTP id d77mr8404144qkc.56.1492915768485;
 Sat, 22 Apr 2017 19:49:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.175.36 with HTTP; Sat, 22 Apr 2017 19:49:27 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 23 Apr 2017 10:49:27 +0800
Message-ID: <CANYiYbFPjHqjn-wdPUghLNZ2nsKggUWe3j=JwKXaYdbJqSy9PQ@mail.gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.13.0 round 1
To:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.13.0-rc0 has been released, and it's time to start new round of git =
l10n.
This time there are 96 updated messages need to be translated since last
update:

    l10n: git.pot: v2.13.0 round 1 (96 new, 37 removed)

    Generate po/git.pot from v2.13.0-rc0 for git v2.13.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
