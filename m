Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53BDB1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 13:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756610AbcK2Nag (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 08:30:36 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34276 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754909AbcK2Naf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 08:30:35 -0500
Received: by mail-qk0-f194.google.com with SMTP id y205so17505070qkb.1
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 05:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=MrTioOrA+fi5Dy7X5TyqGuayiF0VPR58BPGBSoza7Dk=;
        b=Lt8ro+FRVM2xEamJB0ztYnRpvPFLe/VPfhVC1xs3CGOZK6YAsk+TFexJpE/VjyR2Do
         NEacnDSzwZB+cumIkD2aEb6slxDBhUATaF4E72ytkRpWI6H1vnibs/bi5sXZ1cYhm7hM
         iWw1LvkKtzwVhDbBZNKu0zyfh+qT6Ap1Z1GSOn7A112uNf7BgQdYvqeamaSCEE6ET8hK
         FE48yiCFPT1UHZayLcdZDfsUi1QpgKbJGfYvh9Y453hIUNEweeslV85wGAjJK/i2bPWk
         X2643IpAZmQl1erKPjADx4eQDRQ6C7nYSQzIn1ihxmkrzD2lazt7qaA4jBbMPKKQS0as
         h5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MrTioOrA+fi5Dy7X5TyqGuayiF0VPR58BPGBSoza7Dk=;
        b=Txry1XFY7ehWBb9OZ1vgCMeWxiZQTMsLXABVo+n5FBAo09sy7AuZY9zyN0o33BBtsl
         63JqZLEun0EM4ssNvQjeKvy0z8SujrAMn8i2cUTQZE7Lc3E3dA/JyNa0m/6+DT8ey1TY
         4P1KK2yj4QWNGkeAB5QQoR83GSjyi9o1rto1bqesNY/2ObX8HbRScuGA/RtVGge6Z+dy
         4c/5lR4yk9W8Ksr+cjSFGzw4diBfS4SPnUQKpMcX6SGgxixPdMV1TqcfyN96plddZ2a9
         boR8T5pW7cg9aDa2q4gx6YeMuvt67jUuXZ3rD3hMYFn8kAXHmmB9EhBggJK4e0GF07w2
         rplg==
X-Gm-Message-State: AKaTC0286ZCslwGpKuRE9ag5e9vUWJ2iIRtecp30czEk9KbBMOawzgvKSXI93T/dK16+itNL4H8VosOVHyuceg==
X-Received: by 10.55.68.80 with SMTP id r77mr26266223qka.318.1480426234196;
 Tue, 29 Nov 2016 05:30:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.150.2 with HTTP; Tue, 29 Nov 2016 05:30:33 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 29 Nov 2016 21:30:33 +0800
Message-ID: <CANYiYbHYaOUwJo_8Vc4vAYatC+Xu09fWLw5q+T7W_7_xwuD7Nw@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.11.0 round 3 with ru and ca translations
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Final l10n updates for this release cycle, please pull.

The following changes since commit 6366c34b895613482fa32f1abe1c3ca043905ad2:

  l10n: de.po: translate 210 new messages (2016-11-28 18:49:25 +0100)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.11.0-rnd3.1

for you to fetch changes up to 082ed8f8706bdb0645ceb13f8ba3cb8ccfb58d5d:

  Merge branch 'russian-l10n' of https://github.com/DJm00n/git-po-ru
(2016-11-29 21:19:43 +0800)

----------------------------------------------------------------
l10n-2.11.0-rnd3.1: update ru and ca translations

----------------------------------------------------------------
Alex Henrie (1):
      l10n: ca.po: update translation

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Jiang Xin (1):
      Merge branch 'russian-l10n' of https://github.com/DJm00n/git-po-ru

 po/ca.po | 8907 ++++++++++++++++++++++++++++++++++----------------------------
 po/ru.po | 8340 ++++++++++++++++++++++++++++++++--------------------------
 2 files changed, 9473 insertions(+), 7774 deletions(-)

--
Jiang Xin
