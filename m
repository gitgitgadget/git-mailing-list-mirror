Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D161F406
	for <e@80x24.org>; Sun, 31 Dec 2017 13:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750913AbdLaN32 (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 08:29:28 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41577 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdLaN31 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 08:29:27 -0500
Received: by mail-qt0-f195.google.com with SMTP id i40so58543582qti.8
        for <git@vger.kernel.org>; Sun, 31 Dec 2017 05:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=2MVk+euhcelE4qvYwGiBe8N6yGdQoLrVVa9eO0yYTAM=;
        b=uOnHCqDsFueJRa8/nOdf6oRj1eUjTeEfhXiN9g9jsx+KAgUXfFTSOmyYy3eXg7ra58
         Mp3JqMY6A/DXmLkZ7Ch7kihzAuS97nVT/+Dah7g7GIEoha+mJhAjDEjoifgfu6NIFbL8
         sULWBJaPpRRPb0HGG/K3TaI4OBXHbMqtoz/CRnSw2TCK1vI4T0WcEZWU3upHcDMBTjED
         8ck2eVOjEoU5aolPOZplN26HBzhhEfbm/kKOc8fZjlcrk5l7iRagOZeVETFlC43Z8JGP
         nviGkUBxzKFVDmwJYSHNqKXZg79B/7GxQU6jrOb39eMIgaK64AAfbwMdoNps7O14iCwN
         /iQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=2MVk+euhcelE4qvYwGiBe8N6yGdQoLrVVa9eO0yYTAM=;
        b=XGsfzb6TKBSq38NBHviYesY54IfNSEhDxoFsFpWwF0wTqfiv//enDkHwT8fp1tvtDV
         fRgOhehIqKwDbXw0+WrBuP5UkujDtfG9ceCh/yIHd4ROYMDfR80eynBa8ki3uXAvmM4J
         uVNC+DbVxrcy/VilVu6N9w2xNWnXaYito6s0qLtKrfWGUPafY69KUgzNhy+hnUz6fnPD
         xCrYSydrCZY0pmPQbd/FVi3S1wK9BKSU5feJrfXp3hlP9fqjTXrCUfE4B9CjaHvReBdP
         RyJgXZ9r1Q5s7LboMbpDqlxZg4YaanqbQb9XBL66rxDfZ/CxdVv1gMnUqFpK4LINUfE7
         QLew==
X-Gm-Message-State: AKGB3mLlsULnld3kcI8fFNKwc22Z6Q43gAbq13UCkGYjRtf8JrtO7Igz
        5I+FrKj0u0J+Vn5Ub0FrdDHSO0Eym2xbiJd4n88=
X-Google-Smtp-Source: ACJfBoue4ywHgqlXHIskFGVroS8BUiEzJgZSpmzboMGDeXEO1LgtoBM37JuKYid2kJz/Uev41fJV9L9MM5yN7yMvZOk=
X-Received: by 10.200.37.253 with SMTP id f58mr50797985qtf.60.1514726966927;
 Sun, 31 Dec 2017 05:29:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.208.108 with HTTP; Sun, 31 Dec 2017 05:29:26 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 31 Dec 2017 21:29:26 +0800
Message-ID: <CANYiYbFPADn6LFawQoR+r9tcrvJccpCDG2UYHtJHT3j5w6E7JQ@mail.gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.16.0 round 1
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
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys,

Happy new year.

New round of Git l10n is coming. It's time to start l10n for Git 2.16.0.
This time there are 64 updated messages need to be translated since last
update:

    l10n: git.pot: v2.16.0 round 1 (64 new, 25 removed)

    Generate po/git.pot from v2.16.0-rc0 for git v2.16.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
