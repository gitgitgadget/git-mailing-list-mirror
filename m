Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F94C2047F
	for <e@80x24.org>; Wed,  2 Aug 2017 00:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbdHBAQZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 20:16:25 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35563 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdHBAQX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 20:16:23 -0400
Received: by mail-qk0-f169.google.com with SMTP id d145so18631173qkc.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 17:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=U+cjC21VgIyPlAA6uM+/bizi8lELoUo7EVet9k+zaX4=;
        b=d7qHu5qwgXpB3jiHQXhQjCChBT9rRVazPh7X1RzKb16vX3/pP6zf4zf4UxeCLKlb+z
         gWTPlAjsKoWmXCKNUEMFlRlU+xNf3Rz0gic/Utc25Uo9b2Y5AigusTLwxRgFLqbo8BU7
         oBvumVuG7Uh74syVVjjK1JTIA89h4al6qyp8NkYAIFLO6B+V0Nfrg1CQLwaUTF0j2Qes
         8igdMmwNeZIC6vyKTAh5fQAGYrV7OhEQhPGGW6tVerKiSVTs7qtyvIusXrJdY1U/BE2W
         Wrhcc5erYug/oZ0Ci+I2DFgJWNpvnHWWF+9R1X6GzZpbwDoq2krowRBFdwk8H0NGY6Mn
         JDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=U+cjC21VgIyPlAA6uM+/bizi8lELoUo7EVet9k+zaX4=;
        b=fuIH7bpkvVcqDXRiZ+HhldymhFxvH2NSDHHAbwOt8GIyI6GSgi2JUPb6DmgxMWAAtc
         oCQLC6iUcQjNMkOBISNQ2+0NiqpDb5EKJXBoAiSX5QD9pCFGOWeQb140RRJVrdEFycZ0
         s8EEJN51TBzIWaGtUotiWH3yVlaz4iThxj9Q2Jf+OoqjexIsx4Xr3F3vO3Nf29/0grlC
         4Bk62Z1X5dETggzCCir70465vLPfdJEeFCrlMElNp8lzp+KJqcJapCT5lNtjraa7+EqL
         MQGn+ild2xuuA0TqZYX6652mZXNWClRhAVgOH2D4bsNHhM1rhY9SnKREmy1fTl5vdyzu
         ekxQ==
X-Gm-Message-State: AIVw112OBkn836rDci7FlXHWHyT8Fql6Ls+Oc/GdMU4XLEeFjuLfpjpK
        VTg19a+QjwxeKEUAerUoICmPUzqHlQ==
X-Received: by 10.55.131.65 with SMTP id f62mr26518817qkd.290.1501632983212;
 Tue, 01 Aug 2017 17:16:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.137.236 with HTTP; Tue, 1 Aug 2017 17:16:22 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 2 Aug 2017 08:16:22 +0800
Message-ID: <CANYiYbE+bv21GdvmeefjuARBP_iEH7Xrxp-btNRsq0bjdqabYQ@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.14.0 round 2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Would you please pull the following git l10n updates.

The following changes since commit 91d443d0d8dd942dcfc322ea200edddb9cef2b4e=
:

  l10n: git.pot: v2.14.0 round 2 (9 new, 2 removed) (2017-07-24 22:00:44 +0=
800)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.14.0-rnd2

for you to fetch changes up to 554e8501704f14182562b9df3236bfaacdc53aa4:

  l10n: zh_CN: review for git v2.14.0 l10n (2017-08-02 08:02:37 +0800)

----------------------------------------------------------------
l10n for Git 2.14.0 round 2

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (3213t)

Changwoo Ryu (1):
      l10n: ko.po: Update Korean translation

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Hartmut Henkel (1):
      l10n: de.po: various fixes in German translation

Hugues Peccatte (1):
      l10n: fr.po Fix some translations

Jean-Noel Avila (1):
      l10n: fr.po v2.14.0 rnd 2

Jiang Xin (7):
      Merge branch 'master' of git://github.com/alshopov/git-po
      Merge branch 'master' of https://github.com/Softcatala/git-po
      Merge branch 'fr_l10n_v2.14.0rnd2' of git://github.com/jnavila/git
      Merge branch 'master' of https://github.com/ralfth/git-po-de
      Merge branch 'russian-l10n' of https://github.com/DJm00n/git-po-ru
      l10n: zh_CN: for git v2.14.0 l10n round 2
      l10n: zh_CN: review for git v2.14.0 l10n

Jordi Mas (1):
      l10n: Update Catalan translation

Louis (1):
      l10n: fr.po Fix typo

Ralf Thielow (1):
      l10n: de.po: update German translation

Sylvestre Ledru (1):
      l10n: fr.po Fix some french typos

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi.po (3213t): Updated 9 new strings

 po/TEAMS    |    5 +-
 po/bg.po    |   84 +-
 po/ca.po    | 7572 ++++++++++++++++++++++++++++++++-----------------------=
----
 po/de.po    | 6241 ++++++++++++++++++++++++------------------------
 po/fr.po    | 6260 ++++++++++++++++++++++++------------------------
 po/ko.po    |   69 +-
 po/ru.po    | 6164 ++++++++++++++++++++++++------------------------
 po/vi.po    |  115 +-
 po/zh_CN.po | 6313 +++++++++++++++++++++++++------------------------
 9 files changed, 17022 insertions(+), 15801 deletions(-)

--
Jiang Xin
