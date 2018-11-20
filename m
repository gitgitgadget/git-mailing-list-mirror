Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4C21F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 02:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbeKTMta (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 07:49:30 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:42289 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730445AbeKTMta (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 07:49:30 -0500
Received: by mail-qk1-f182.google.com with SMTP id m5so553249qka.9
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 18:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FjOXbyReoTfBlDrwJYrpAfMH8+mz0LsOpWeddDMq3B0=;
        b=GfSUrfb+wWcE6oK4sYe5s7UrATCGCw+QyPM2nc6BrbmCCV072/IeUCpybn6iWd08tO
         VZcXh2fYr2qJexXbu3RC3Os0/uN+GnSgJHmF+FI86iPhXzMDuvOkutPPa/vhX3Fw7DK4
         CAZZnvUgLXhWbdoFDb82aWYyAF19oFIxhOeVsHjRsJYuHqJZf2fG4g8WdPxkI/g94WGZ
         TVQxs19Z4Px8anb/qyRlYngTxAIBbqFgjj5cWRn3PJMTvpIhp68fc2PDegUpo/05RLaM
         QFdLEikYhZQE1WaetsBFwQtKDsoRPExU4j2KWHC+xPJ/1Z/fR7y2WC9muiYXalJk6wgA
         Xsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FjOXbyReoTfBlDrwJYrpAfMH8+mz0LsOpWeddDMq3B0=;
        b=ZQeIoL0ral1Y2PMsM21i46LorDAYjXm5OotTj7TfuvZe26801gSuss8otbraY/3e76
         Qrintib57T7k5mq08X2PxVwNECQDOw6+d4UenUyEPfIcLWr3Th/hwqwjX482LtBmkghI
         0r8fDJxtPCBnijmFLA4ePD0XDunetfrGpbdXKLo7Ie7tv6sxdNR0MtWg9MJVIfu7rL2Q
         RcfZxy9+vMDl87QoupzrAgnmseVoaNvBDhAsHHmUAs26ESt+UP4PPvAMrWmBvu543ogv
         emMeZx3kDtXXAmAAotwxhX8l3U89RGEOjsz2dDjhfHfhSsDogRGuaKQGe+6FuI5w2w27
         kVqQ==
X-Gm-Message-State: AGRZ1gIsq69sUoPjoTwtWMNDCaAbpXbQX0lhyahNwb7PVv9iKfP9J8j4
        pDvl/FyziE8btgYd7GF9G4OFpDPGxmlHSgaIt9A=
X-Google-Smtp-Source: AJdET5cKO2V19wNcXFU6AG9nf50RcIWrnJhAuWBLqiPwgteKPZorG+HeZJvZ2+cPXemN440/vFlKJlRQAou2yhZbaeY=
X-Received: by 2002:aed:306c:: with SMTP id 99mr162839qte.61.1542680565636;
 Mon, 19 Nov 2018 18:22:45 -0800 (PST)
MIME-Version: 1.0
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 20 Nov 2018 10:22:34 +0800
Message-ID: <CANYiYbGGniYBUjNWCTE5z8zP6QUL9GwwMyqWSYCs9wW8vmNmjQ@mail.gmail.com>
Subject: [L10N] Kickoff for Git 2.20.0 round 1
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
        Alessandro Menti <alessandro.menti@hotmail.it>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.20.0-rc0 has been released, and it's time to start new round of git =
l10n.
This time there are 254 updated messages need to be translated since last
update:

    l10n: git.pot: v2.20.0 round 1 (254 new, 27 removed)

    Generate po/git.pot from v2.20.0-rc0-23-gbb75be6cb9 for git v2.20.0 l10=
n
    round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
