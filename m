Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6494C203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 14:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756190AbdGXOpB (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 10:45:01 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:37449 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753249AbdGXOpA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 10:45:00 -0400
Received: by mail-qt0-f182.google.com with SMTP id r14so37885135qte.4
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=iV2tFeMKZBtqDXlBYu5NSVLg0GoRZA7zynhisn1E44A=;
        b=DOuA/frTZkNePy+jziw36e01r4xrMQaLtTA0LPOWgU94F3ft7v5QI2XV0VpKkWn3pp
         LZfqDeRzi2hzJZOHAzx3Rw6FnepAgG81UVqRcMGD8+/WoHR3NSrGAYB0lKsCNu0U2aYM
         NcrUl0/mvIifr6ZiP7ggc7X5LqXpR65vjmVWEiTfb4hOLGdRw+9h+AheLzIr9rWTCZL4
         89DPUP3iQdO3p3l/P1E+9nZqHUE6vFJ2uEnN10typD1ruuHUIGex4nZpnFxyzoHYfL2e
         WMlA4E4MqFVJQ9IxQ+VWp8eHy1PdXteNJaaK8uniNF4OVnr8DWWivQiuLt7gQI2HnIW2
         1fjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=iV2tFeMKZBtqDXlBYu5NSVLg0GoRZA7zynhisn1E44A=;
        b=n7jUUwbOE13U2p63bjENSySjKg7YQfWYR/qwWybFNqbGzrZ13rvlkFbSSNqH5od8WH
         ZLiNJ1GcVoHMpcePj5Eo5a2t5/paCs31NrWZuXpVa6dXM+ZLsFQb72oeD0L/Kbcw2Xuq
         upu3z2H1Xl94CukAGEfEUmFLdoPtn9JyIdm3LGRVi6Ef6L49Q34I7lU2Gz0oBXI4bi97
         89bu3N+WWkE5CXzdSGtrx4/Kfhsg3Rk0Dved5hCNgcqDLlvGk4MBlTa/ALLNG/RLU5tX
         C8cgZ7zQu0mbe69y6kABM+uz/64HkOAOhZXodTzDJOyVM5Y7zElaRd1Z2BgoO1Y2A3tk
         tjwg==
X-Gm-Message-State: AIVw113aX2D4EiIcNxUoGbslO79ScJKIW/o0pgMEc0HegqamABmmf6zd
        kNRWeDIrx7UVOEoRL2Awp3+x9+YhFg==
X-Received: by 10.237.42.55 with SMTP id c52mr21837860qtd.311.1500907499527;
 Mon, 24 Jul 2017 07:44:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.193.38 with HTTP; Mon, 24 Jul 2017 07:44:59 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 24 Jul 2017 22:44:59 +0800
Message-ID: <CANYiYbEJ3Gw=JvbhLBeFWBD7xLXxd=_fFdH3UX76H97ZU_3zKA@mail.gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.14.0 round 2
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
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In the last round of l10n, some l10n messages from "date.c" are
disappeared because of the l10n unfriendly PRItime macro.  This issue
has been fixed by commit fc0fd5b23b (Makefile: help gettext tools to
cope with our custom PRItime format), so let's start new round of l10n
based on the new generated "po/git.pot" file.

This time there are 9 updated messages need to be translated since last
update:

    l10n: git.pot: v2.14.0 round 2 (9 new, 2 removed)

    Generate po/git.pot from v2.14.0-rc0-40-g5eada8987e for git
v2.14.0 l10n round 2.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
