Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92BF4211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 03:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbeLBDRg (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 22:17:36 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:43457 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLBDRg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 22:17:36 -0500
Received: by mail-qk1-f173.google.com with SMTP id r71so5477884qkr.10
        for <git@vger.kernel.org>; Sat, 01 Dec 2018 19:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=GIIXMhQYfzcXUFbpQQ0KpHGeqxcxcV+ENK8zTLjp4kM=;
        b=LgNXvw4ZnAEQB/PJudNa5ha+4eXbpM1BVgIGaK1tVbdIuUInLa2LlrLkVZfGnsiF/p
         aYP/OZpYAmYNQuGKfdHsb+gMCLt8eKV5jPsGKOZDA8rb6SWOF7R8aue3a/JuWt5a6sQL
         raK5qec/Gwf54Uay3hLN7YLFKXOT8pxi8cxCoae7Te59OMMl/jWZWp41xt3hc3TIX8Sk
         ay2ibHzHWdE9Yy03MJYoI90iMSWOXjL+vxWUg8+GTYoX+KBoRXN+ulGefbk2LewTaD/f
         PdSmA5P5zatuVy8xMrtC6LbGjTyTe7X7UxbJkqXnkf10lES1EOUWlKf3W/+JeET3ty5b
         SPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=GIIXMhQYfzcXUFbpQQ0KpHGeqxcxcV+ENK8zTLjp4kM=;
        b=W4rBfPpA2AZy6NTNXsDTdpFwhBiCqMJC1iFOmRmtDeqCvl8WOny0Ooo+/TvS3l6xs4
         zBZR3Pjou4Xt5Rjl9wKE2e8KLGIyhksVe27xAEIUAb0Gb9qx/9u6MfjLBQPInrhCX1tE
         vM5K74Fi+OsOMtperp1oqWcOXgVcBSGu/PGCZj916ZPc/7dKXyoxmK9i3C8YV7p70Axj
         pK0w4c7XxPp/yrTv0qMZdoEP90BYbInR/LvCX/0p1E0d55/o2Fh08RvafgDN5bezrAy/
         un+QFDSFLyCaR0Ad2PQYSRuFeyteDwntmRMsS5A/kpd+7y0BON8aemNDMbeNMR379tzH
         mLEw==
X-Gm-Message-State: AA+aEWYCMvwAgV3EJnoe7p88SMBTnJRowz9rnlHzRaRUt16dQXJereMF
        gQmOvLpr77NhLelaPd6E2B9ZY+yWLtuPGhAQR48=
X-Google-Smtp-Source: AFSGD/Xw6pS6zMOlyjKFEvIbrnXz0/pwtEUwVsGCAgZHgFtd+W0H37Rt/4rX7wj3t7gbr9Kfe0Ol9/aqZh3mzjYpLlQ=
X-Received: by 2002:a37:8e41:: with SMTP id q62mr10873742qkd.290.1543720654135;
 Sat, 01 Dec 2018 19:17:34 -0800 (PST)
MIME-Version: 1.0
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 2 Dec 2018 11:17:22 +0800
Message-ID: <CANYiYbG6X4Z02bQNJzWr73DbyR58Wd6yq+z0KngTNfhkHZ6txw@mail.gmail.com>
Subject: [L10N] Kickoff for Git 2.20.0 round 3
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

Git v2.20.0-rc2 has been released, and there are 5 new messages need to
be translated. So let's start new round of l10n for Git 2.20.0. See commit:

    l10n: git.pot: v2.20.0 round 3 (5 new, 3 removed)

    Generate po/git.pot from v2.20.0-rc2 for git v2.20.0 l10n round 3.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
