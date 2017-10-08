Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D81820372
	for <e@80x24.org>; Sun,  8 Oct 2017 07:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbdJHHiG (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 03:38:06 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:43774 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdJHHiF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 03:38:05 -0400
Received: by mail-qk0-f181.google.com with SMTP id w134so21274878qkb.0
        for <git@vger.kernel.org>; Sun, 08 Oct 2017 00:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=89hsohG+C7zG1+Jcq2YIpmC4JM3RwW3yJ9nCJd69zow=;
        b=bhZERMzcLei55ZnaOJrcdErjGAU/ob1UvH90LigKBYOh/eQL0OgvgKYMJ0TsADiY7T
         hRpH7AFghqHDh4lf3wKZ5CuH5iQy8nkLMjAIzutrP296bOnxnVrlQixiUPlvDjK0zm4g
         2Q3Li3wFbhy/eUMOK2HUfwFMniFwfT9R9YYm8J6enqblU00jAmOiDh0UiR3ctPsDHnGK
         K3EhoGQUa1hLdYskXk+NQa5o8IAGwedR09I0Sr5qK0KzkiGZKFP8x50RbkQ6yFeGkpdG
         nT2jiebcQCiIdvCVPqYihUdkJM6nRwXDwOWfzk0UWjnZKDajQ7OMPEG/qMo+UsMTkPps
         XOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=89hsohG+C7zG1+Jcq2YIpmC4JM3RwW3yJ9nCJd69zow=;
        b=BK4dUX5ofFpyf4UhQQ97bvN7mTlV+yT2Tot0P8pefnqhvDQzM9j3JnoB0BH2Lm9Fvc
         ySo/bP/FM3DSltIVywox8ZKtburq8iU6cOzsp5pwpCUy8eTurXI+N3+Y0FLFGaCwOC4u
         an9reifv5DzK+SyP8c25ARyZYMxISRPUygGhSiLSNSMCxLRdZBtPcepe50eNY2I5lyHX
         7re3x6dcdba5TiPKr1JoNsd4hINQ2OrLnD2LDJlSDi0IY/8jJl91Ud/3BlKfZRy4tens
         UpnpDdH5+aw+j+nz6TnLKPo+2+bW0emnn5z5qN90Tf62fX4/oxCpN3XEp8axyw72wHxg
         tZng==
X-Gm-Message-State: AMCzsaW3aFtv2cJdKNuimQBkN9AOwIGHUtdSjWJ0S5tZT0SS8kY2JowS
        TP4+pu6dus11KwztLjJ+ONQD7kBtMNjcaly/tExsZxt/
X-Google-Smtp-Source: AOwi7QBPgSDllObAe0paOrKpLo0HdVTG8XM9A4u1VbRjIgQCffvEEyksYP3+otobMFqVoFmLGtjzBEENzjrzQg+nm/U=
X-Received: by 10.55.101.4 with SMTP id z4mr5096503qkb.114.1507448284975; Sun,
 08 Oct 2017 00:38:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.138.51 with HTTP; Sun, 8 Oct 2017 00:38:04 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 8 Oct 2017 15:38:04 +0800
Message-ID: <CANYiYbGHBDGMEjbrvX_ayXkXkciT3GgL4seM_X1NmWtud2upcg@mail.gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.15.0 round 1
To:     Git List <git@vger.kernel.org>
Cc:     Alexander Shopov <ash@kambanaria.org>,
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
        Jiang Xin <worldhello.net@gmail.com>,
        Jacques Viviers <jacques.viviers@gmail.com>,
        m4sk1n <m4sk1n@o2.pl>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.15.0-rc0 has been released, and it's time to start new round of git =
l10n.
This time there are 68 updated messages need to be translated since last
update.

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
