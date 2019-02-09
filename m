Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3E51F453
	for <e@80x24.org>; Sat,  9 Feb 2019 13:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfBINNF (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 08:13:05 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:44172 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBINNF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 08:13:05 -0500
Received: by mail-qt1-f173.google.com with SMTP id n32so7078342qte.11
        for <git@vger.kernel.org>; Sat, 09 Feb 2019 05:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=SBk7Y04CSHihGSW7gzqfwDgAjwby810Gh7X/gYqH8sQ=;
        b=CevPPEFOOS6phtvxyF+cYMtxRTCqcNiR+TZ9IYgb7a2apohVG3S9HGEYq7zfcOe8IA
         GFInaRI8BIzKtygZQja3QrDBv0BYOzyN9JVnIca4WL09isMUng1mYCt704dgdgz9yEDq
         SYnCvR/mxYxdYJW72kUjuQTHS5SF3wTf7KR5hFl3y3gLazKtpA4a174sROODQ6AIhRev
         QuiPoqmOKJa76rJJrHHmXPR2mjDOrUpysC0EofeC/yel1zJIRcf8mq6RoXK/oueWYbPn
         wC5Wa4+VUBa34MJDz/iZAIKiIulAff2K0lVVF6LEk+1+XqNIQ1qdbCGAvx2Ymk6+LhlR
         IReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=SBk7Y04CSHihGSW7gzqfwDgAjwby810Gh7X/gYqH8sQ=;
        b=SoXaeaNdQMRYRDiX9J0oRr1Q+tieafmY5OelsU67Ch7BZEzMUuYWQLeso/lUYWEmr3
         F2X7/3EwjERhQbcVHjCvPvjqdVQcuhFB3wcjEljaX4+xNnkTo0Imaj56wsJGZ1NYkcSY
         tr0cCVO1dd5om1LSpuvgQ8NDXSIgcWDnU7c1OdCIXELPtjw0v7jc37GryOveWRp7YESk
         NS1kjrA7aS87oAb3XfL6Vh84kRKrX3Ts0a9YLxJ6tcsKnjxkZDqbz+4D+zsstqxMvnIU
         esS7TZpYLF/IUYmTd4Zg9HdQzaxHpqkl5EAyCCwrQjb2wc5TDuSV4UMnZaFZsmt2abmJ
         JTrA==
X-Gm-Message-State: AHQUAuYcq6Yx2J8+a8i1+2F9NYv65sXKbSBy4zky0LbrhC91Oex+nj9L
        yWlickUdIi5NzpVyYU7OP/AYOcpwoQVfpn3RtPI=
X-Google-Smtp-Source: AHgI3IaCAY42JGOxx9Wq87wB3yJov4oabSQfHjJWRV+IXM0WcWub9SAx09p0kjYaRHmiNPz1HyAc9O7FY83RijHgWzo=
X-Received: by 2002:aed:3746:: with SMTP id i64mr19958856qtb.307.1549717984404;
 Sat, 09 Feb 2019 05:13:04 -0800 (PST)
MIME-Version: 1.0
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 9 Feb 2019 21:12:53 +0800
Message-ID: <CANYiYbG=4LccgRQv6xj65LNk1BNvpk8Q=kgkg2hPz__zVFMjzA@mail.gmail.com>
Subject: [L10N] Kickoff for Git 2.21.0 round 1
To:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
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

Git v2.21.0-rc0 has been released, and it's time to start new round of git =
l10n.
This time there are 214 updated messages need to be translated since last
update:

    l10n: git.pot: v2.21.0 round 1 (214 new, 38 removed)

    Generate po/git.pot from v2.21.0-rc0-30-g11ad41d4cb (Seventh batch for =
2.21)
    for git v2.21.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
