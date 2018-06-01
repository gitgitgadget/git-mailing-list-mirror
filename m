Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECDAC1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 01:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750914AbeFABqv (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 21:46:51 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34682 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbeFABqt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 21:46:49 -0400
Received: by mail-qt0-f194.google.com with SMTP id m5-v6so30359169qti.1
        for <git@vger.kernel.org>; Thu, 31 May 2018 18:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hcJ982fehKz2uZyjoj5jrjuEvTeBVhLrASGTvdI6A8w=;
        b=PhAMirZCJc3a5dr6luo4G8Tpu3srNHgRApqan+kQa0qHibMTxEquvdGeheqSFu4Wzr
         4jg74Lv3taaBe3oyWI3h5N9dDZvlKW3AbSsHfEt6pup7aseHxjNUivTJ5K4eduuh9Glr
         2QyoPKG7fbqWYfvJk2fxXcAgZPHm15sYtYe2u2CPctPujqvOCce57U0rVA0GWyir1oQC
         42wmuxFRk+uo7QiYZdnsDTdSInXdroRhBv2hv/Po0rv90UmIWWi2ZrPrV/oFGwmGmAjA
         DLwm35xiw93TPYqPQ9d2GSBkse5EN58AZAFT2y16ydd9RuDiMadfBcFvXNm3Rd2uGTi+
         0e8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hcJ982fehKz2uZyjoj5jrjuEvTeBVhLrASGTvdI6A8w=;
        b=enal8Nytj57refv2Z9Z20mU7wQhyAzDvxgUGu4gmZerAAOQEsTT3qol4pUnzfL8sf2
         hDPrSEZv9da83KDWi5lYd6+AE312oTGmd39SF3X/PAf9+iBkxaJFr+nWfIde2NrG1y8f
         CdSGbioH9ZffxG4sKJkIJ24FZKCdlQoPSNfBzNVUjYfDgZM2HHGU6sS12aPM6eE0KMD/
         TVh53PYMdGmNxsDDs1/H4mG8Lz6tAFD7x8xy9l2bmROW8e40iwPnBsxd//4AJTq/yik5
         Xv6rrHyfj5sMfbkFDx9yw0hgQ06xM6h1xplWfWM5ZIe0SOo5wS9JViLRFGLrpmLxFh0o
         Lzvw==
X-Gm-Message-State: APt69E0Rowp7C+jV8BxTa9lSbeeP4G6Uu5PDAc5pW4edrJ/iIIkQF7bf
        NpJISE+74uoXfaG2n41mp9cDV0RpHYb5iIK///4=
X-Google-Smtp-Source: ADUXVKJQwd1/3yRvO8UkIvOqMBaZieIg2U6TQ62nBvtoMNLMJBuT7eUVnQCgLRPLM56RqSrQ4w1gkQM3l2oFNKLbDGg=
X-Received: by 2002:ac8:43d5:: with SMTP id w21-v6mr9010395qtn.137.1527817609357;
 Thu, 31 May 2018 18:46:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:b48d:0:0:0:0:0 with HTTP; Thu, 31 May 2018 18:46:48
 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 1 Jun 2018 09:46:48 +0800
Message-ID: <CANYiYbG=eGa08LKh_D4a0xDx6vY0wJ53Y8HuAzbZzVfuSim6pQ@mail.gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.18.0 round 1
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
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.18.0-rc0 has been released, and it's time to start new round of git =
l10n.
This time there are 108 updated messages need to be translated since last
update:

    l10n: git.pot: v2.18.0 round 1 (108 new, 14 removed)

    Generate po/git.pot from v2.18.0-rc0 for git v2.18.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
