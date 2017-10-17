Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99BE202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 02:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754267AbdJQCJR (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 22:09:17 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:49287 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754069AbdJQCJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 22:09:16 -0400
Received: by mail-qt0-f170.google.com with SMTP id k31so472535qta.6
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 19:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=MLiJJPBgwurlkEe29BfEhs1QoP0VZ6kEg8bGWVb6ESg=;
        b=rkkyJrAptrB9kpUjiq9UF2h6tHiPRuJ2q/CpLcOigHeADPXr40g031kdYiVareLS2e
         Es2LQ8da4bMNZzNrYSCJ9DV/W4btsf83IxYI9z46G66MPMHtMYu8UzrnkAMfvIgbPvrC
         hPGXzT4Eg5N8BzyVX1vidb4sIQpYDWgb7hU3mPlZqfh4mwuTi2qqZYplpmv2G6zj45dq
         xS1ciMMnqdDem5xW/E7diNpk02sb7OmFJWi77vUBu0u7CUgcHA9nTgKcgO1kFTW83bUz
         Kn046XtzSiFzYuZxya2mMoVgYoxioRUOWdxQn3uo71KtaoikDOgmTpYZjbK5PY+HyLVq
         WHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=MLiJJPBgwurlkEe29BfEhs1QoP0VZ6kEg8bGWVb6ESg=;
        b=kD1bR5244srG9J7uhx7RV7VChS1FCrS8bHWwTZ5Hj9fnliR13RM0ZM+ZVycL2UsSzx
         ypw8qp2dnyhQLuWQDzpwRGHArDwA5kSn+JDljODV2LIwuhHSrXpM4hgLm21W502u9B+o
         4bYwh2Qir1G4sfcs6HLyB8d8+0vL4FRKfu8Sb00vvXEjFOTCvIS6ux/H8xWD0sHlQcci
         IW+jvbVgUMEU2CYh5sMcv7ul+dBKJ8Wvhhh5pFbto5VXVmHBZ+JZdPvgbLOC8r/BQhgU
         6hIg6U1qpJqt4NAcH/sjNVFYDM5EzLnCVWU4d7OnsfsUc0h7XfpVlXTgnA2jxULx77Pw
         TwNQ==
X-Gm-Message-State: AMCzsaUJBfEfj+VrAHzE4RszcUAwVdeJ5tIat6QnBoDsHLI96QVVDlVG
        I8JLtbYmQc7YfsDT78ygHcj/1BNs9PWC/jVPvRU=
X-Google-Smtp-Source: AOwi7QCDqaGcRPccoOAVR8exUHJrFg2qwmZwSzgS8rMDUXo7EKbbBYdOYOlk4qOgYFRy6Gg3C1JFFQqNU5fy5bjMAbo=
X-Received: by 10.237.53.176 with SMTP id c45mr17986657qte.311.1508206156170;
 Mon, 16 Oct 2017 19:09:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.138.51 with HTTP; Mon, 16 Oct 2017 19:09:15 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 17 Oct 2017 10:09:15 +0800
Message-ID: <CANYiYbEojz6P5BmN4bmQ-VuwsVf7RX1sDqiwnEsXN+M4-PXZtg@mail.gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.15.0 round 2
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
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.15.0-rc1 released with a typo fix from commit dfab1eac23
("i18n: add a missing space in message", Sun Oct 8 14:18:39 2017 +0200).
This time there are 2 updated messages need to be translated since last
update.  Let's start new round of translation for Git 2.15.0.

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
