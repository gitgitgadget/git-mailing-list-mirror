Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2A441F453
	for <e@80x24.org>; Thu, 18 Oct 2018 12:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeJRUuH (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 16:50:07 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:38270 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeJRUuH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 16:50:07 -0400
Received: by mail-qt1-f176.google.com with SMTP id l9-v6so33984925qtf.5
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EeDe7nOM1mb8ga1PkcM2HGsKotB71r4+MNW49iY6Jtw=;
        b=EMzEhSWty7s4D+64E9ca5H0+yP4KOHnmtb3xy2k/kGl8P9yuKv1/boiRabsNMeWyeB
         m1YIxztIez3TDeslbwdGQ3lt5lFXwq0UGI/hIBKO3uFGn8USokL4ipvOnCHbkU34LzTj
         gEY4zl3TTBFoLEcdhK1LVadcWzi5uGYgLsOS9VebYJhctp6H+aGv0pdD2Y1ANHinkBBZ
         pmNFAD8dPTWM6kmh6wLm2zoYjNpv6iqw/HbA0jxd9QE85wjicSGjGdOOGP0gWUqS7ddW
         7RMUrZfJpEaTS+2LQxKsmbZdF9bkbga28e9A760LH+GncEq161laeBga/yZF5BJ3an1W
         M5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EeDe7nOM1mb8ga1PkcM2HGsKotB71r4+MNW49iY6Jtw=;
        b=Sn/jIzpimbkxBG1e1l1pbYOvyXvLg15pCGWN/HP7E0cvFeFreghEzolhqux5PzltQa
         Gh5DQmE6TSjur8xzmQBTyt/CdV1jOCq4ZsdML7Iccq0Ry+hXDItLeM2fa3Tc1a3Dvv+y
         6q9zUhYTSlX0ZfUrkh/y79pcI1KunNaT2Kbiu3lEnv2UTShw45UAaTAgrmYGhvImgCZp
         YgIvjSmnTX5ymgA6BuUQhhcgok76GQWstI9ZL7RWihRYYHt3JXi0xEHJBcWv1ND2ka9k
         NSDi4xY+7RiPFJiWoTpvXRuGs7CUvQOYU7vv1iQL6oSDPwtceNUyEJdzHRV/RfDpEJXM
         K0PQ==
X-Gm-Message-State: ABuFfohd/jhYriDbX1/j6ID4W2XcZFdQRMv0+q6ZXz8cLYPlMwq4BlU0
        LYrQnaGF45000njJPPNFaFNHy+KLGKZXFEwLVFm1wWE1
X-Google-Smtp-Source: ACcGV60ILMz1+lcvQcGDZ4KNG0HIWIT2SaCp2CZo7ssVeyh0hQsF66D487X6gjyRzeBoxIhVQ6t/Ernwulg9S676AN4=
X-Received: by 2002:a0c:f84f:: with SMTP id g15mr23765074qvo.232.1539866954679;
 Thu, 18 Oct 2018 05:49:14 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?zqDOu86sz4TPic69IM6azrnOv8+Bz4DOtc67zq/OtM63z4I=?= 
        <trickygitninja@gmail.com>
Date:   Thu, 18 Oct 2018 15:49:03 +0300
Message-ID: <CAJKt3eP+BZkfK_yn3KYWMgmJB8_18UFr5eizmdGOY_4vM5=AYA@mail.gmail.com>
Subject: How to start contributing
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I=E2=80=99m a computer science student and I=E2=80=99m interested in contri=
buting to git.
I=E2=80=99ve read the GSoC git page with the ideas and micro-projects as I=
=E2=80=99m
interested in participating next summer.
I=E2=80=99ve also read the Documentation at the GitHub mirror.
I=E2=80=99ve never worked on such large project and I don=E2=80=99t know wh=
ere to start from.
I=E2=80=99ve picked this microproject from the GSoC page:

Make =E2=80=9Cgit tag =E2=80=93contains <id>=E2=80=9D less chatty if <id> i=
s invalid
=E2=80=9Cgit tag =E2=80=93 contains <id>=E2=80=9D prints the whole help tex=
t if <id> is
invalid. It should only show the error message instead.
Thread: https://public-inbox.org/git/20160118215433.GB24136@sigill.intra.pe=
ff.net/

This bug is solved using the 3rd option, but I suspect that it=E2=80=99s st=
ill
here because the 2nd option is preferred.

How should I tackle this?

Thanks.
