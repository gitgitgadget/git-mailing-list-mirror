Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C886D1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 01:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbeHUEb1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 00:31:27 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:45975 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeHUEb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 00:31:27 -0400
Received: by mail-qt0-f178.google.com with SMTP id y5-v6so18429563qti.12
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 18:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=RnnBBa3c8t+u1ENTfTBGWVRy7MYQj0WNUpUTYPKRKTg=;
        b=Y3DgPSRxkcncIcCsdy7w6KoO2KY2y6X9JuXEoWzeysBRkeKsvMz2R9VtLkVWlLEFf5
         8frqTQim/73rvPXezQHMdFe9ovSc/yA3Nn4MaduTfnDAD6SQHFGmzKnJ6tIixDQDahzq
         nEmboykzGHzwzhlVRQn6NEd+OwhZhJgJoq68Ozk/Mf8cEro9OzOKbD+H/UQai/5MscDc
         +fpTj+fVud5O+X11vM6Rqj0vyYG8a2ALBcC4N6t0hc0WhgpJknjQiIBPzpP7Eafra5Li
         hgIv5moZCDR2eg6OLAL4V/dvSgmcM16KFjW68NGgJoaxpS6GuVkb1USA7Fcxwae53L1A
         NwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=RnnBBa3c8t+u1ENTfTBGWVRy7MYQj0WNUpUTYPKRKTg=;
        b=Dddx8IpBHTAw7caBfR1viOHuYapKRA3BmnWxCsJTmkDzFaFkVdwH8DYBy58tbwvOxB
         lKnSrG2TuHrn41hGXczy9i1Lnriq92LOYL5LqBR2WOV3Tb1rpuAZwhNCg3uGnUAv0/+o
         M/9vlRof5t0Dg0VMqFJ3bu5VoKvJAHLp6UO5hNqN+Rh+MolPEc8YsU1Bwd90WxB0dCog
         klYDSaxhMrzTzIaY5PIZoobp4b+kt/7HuibpMcixb9qovhMR1vnzdcf27zqDCEHCm4/F
         7buHljaWxuOnc3Mt+QnX3i+2qzs827s+7S9px+BvRKze3JZoQ9uRZy7atyAvo+wlEglv
         EP4A==
X-Gm-Message-State: APzg51Bvu9HEszGyWfImJuvgRBPjtRW3oFqGwmuT0xJALADzbYWvvFIE
        LtqOBDhwn+oNmkr/1KQaXJLgzNc7I0Bg5OPhjvA=
X-Google-Smtp-Source: ANB0Vda5pUH5wJo9b9qeKIjC6s2oD+xzCljAxZyohb/gjnmL3pcR/J2ok6jFJ9VOgDKT0+WMYk3crAqonZKH+Ncdn4I=
X-Received: by 2002:ad4:4089:: with SMTP id l9-v6mr4823839qvp.160.1534814011519;
 Mon, 20 Aug 2018 18:13:31 -0700 (PDT)
MIME-Version: 1.0
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 21 Aug 2018 09:13:19 +0800
Message-ID: <CANYiYbG=PCiObEWJV0Qk_Hra70+1t0wCMbjDO5ArrTBa2njQjQ@mail.gmail.com>
Subject: [L10N] Kickoff for Git 2.19.0 round 1
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

Git v2.19.0-rc0 has been released, and it's time to start new round of git =
l10n.
This time there are 382 updated messages need to be translated since last
update:

    l10n: git.pot: v2.19.0 round 1 (382 new, 30 removed)

    Generate po/git.pot from v2.19.0-rc0 for git v2.19.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
