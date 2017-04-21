Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7944207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 15:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1041257AbdDUPWj (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 11:22:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33155 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1038511AbdDUPV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 11:21:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id o81so5482435wmb.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:mime-version:in-reply-to:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=EzUBqJciEZ7XwrRbceBcjTKBZ4nhAtso4Qk4EHOMR+o=;
        b=hCKzBtla3Uuqh1Fqdc3cmA/kFLypZSVeHXUo7HNwXI6t558H5sibFInfFV+6ASWprt
         0X1C4G8IlzKwDAaKcB7f5w69OIvIQDXmMIPeNegJsBwbbdLaIbBhQtjzklX3Ik3aXS6z
         f9OYGthe4niohPtdbUUia6BuFApT5iyp/Qg5voswlLXL3LxZiZEhcmuNLRfDZWqvIrAT
         jlZlChgXwHSXUEBEiMl3CI0bWsJkOG70eZhFVGZHudsanHokMHMdOSAYBMSjn3+gEqk5
         MXWPiCrvGgns8RtaeVSxByvItkRuR6ZIZEBbzpjvUaRc7Q1A8na+ptc4AzyeF39Bf5gK
         13nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:mime-version:in-reply-to
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=EzUBqJciEZ7XwrRbceBcjTKBZ4nhAtso4Qk4EHOMR+o=;
        b=G+oMIElS1CurIL7+0+l92MBmAuLixsrbAZdkOGq1YsswWuMeVgzk2uTgRIlPh+WW3+
         BdBoCpgr60C+bNZomCuiobDHee6NgRkk8JjJIU6xFFo5sZBG8UMpRdmM4zi+euh7d6m6
         IDLB6InTXHI5xOt5r7v+nup50kfG/OfKpWWAs0/JXnXS40m8A/Jj0i97+XpHSa/ZS0Nh
         RkG1vfxm77kENuKpLfoevgjerVKN7oqq8xMNJp/JtjvKF0kFFX2lAoc2oddFG4BeZJXQ
         fthWSXMCM1VsU4hEwtGAvUTjkVKtrN/QVp4g13/wzuU0OJle2UXjuAM+XWWxE9Zfe23h
         Crug==
X-Gm-Message-State: AN3rC/7FeuVZBAwhv+4E2Pn2tomyY3PMhz3j3V07mBWNb2efvUCW1SVS
        3C+SOF048fVTc0idXJ0aIw==
X-Received: by 10.28.95.85 with SMTP id t82mr8637433wmb.3.1492786487523;
        Fri, 21 Apr 2017 07:54:47 -0700 (PDT)
Received: from [172.16.1.94] ([92.70.185.162])
        by smtp.gmail.com with ESMTPSA id c128sm2573706wmh.32.2017.04.21.07.54.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Apr 2017 07:54:46 -0700 (PDT)
References: <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=6+UnyeMpg8+Q@mail.gmail.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=6+UnyeMpg8+Q@mail.gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
X-Mailer: iPad Mail (13G36)
From:   Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [BUG] test suite broken with GETTEXT_POISON=YesPlease
Date:   Fri, 21 Apr 2017 16:54:45 +0200
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Am 20.04.2017 um 23:58 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <ava=
rab@gmail.com>:
>=20
> As a refresh of everyone's memory (because mine needed it). This is a
> feature I added back in 2011 when the i18n support was initially
> added.
>=20
> There was concern at the time that we would inadvertently mark
> plumbing messages for translation, particularly something in a shared
> code path, and this was a way to hopefully smoke out those issues with
> the test suite.
>=20
> However compiling with it breaks a couple of dozen tests, I stopped
> digging when I saw some broke back in 2014.
>=20
> What should be done about this? I think if we're going to keep them
> they need to be run regularly by something like Travis (Lars CC'd),
> however empirical evidence suggests that not running them is just fine
> too, so should we just remove support for this test mode?

Right now we are building and testing Git in the following configurations:

1. Linux, gcc, stable Perforce an GitLFS version (used by git-p4 tests)
2. Linux, gcc, stable Perforce an GitLFS version (used by git-p4 tests) *
3. OSX, clang, latest Perforce an GitLFS version (used by git-p4 tests)
4. OSX, clang, latest Perforce an GitLFS version (used by git-p4 tests) *
5. Linux32, gcc, no git-p4 tests
6. Windows, gcc, no git-p4 tests

1-4 run the same tests right now. This was especially useful in the beginnin=
g to identify flaky tests (t0025 is still flaky!).

We could easily run the tests in 1-4 with different configurations. E.g. ena=
ble GETTEXT_POISON in 2.

Cheers,
Lars

*) 2 and 4 use the wrong compiler right now. 2 should use clang on Linux and=
 4 should use gcc. A patch is on my todo list.=
