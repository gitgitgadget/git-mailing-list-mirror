Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39321209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 15:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbdFFPMu (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 11:12:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36777 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdFFPMt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 11:12:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id k15so35391338wmh.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03CDSYMCIiT6QRNC64UFYDsDOTdWB3FhPsvt7u8UmYs=;
        b=DewEtDMNFHfEEAFYIla5DsBrWX5fjhVVgG6+GGJUGrgFTMGutfWq/wxDlahCxbhcAP
         ZbiAmaSPK+2/VvBeDYYVfsNKNKXY0It83xkxbMDlJjKSApZ47kQT99hSmy9tTmvlf0/i
         deVAn5I7XKf3dDlDtE9v9jGI0nzPje8J2K/XvAI46YdJ499SYLP5xOdQcIgPbtjuvX0k
         /jDPkyRrfyNO4rtHvw05lTUTJWq6Hh2Xcl1Tbyg2/yi1JWM44Pf0tjJGr+zdW1b4qJHF
         KxmONDqhHodNncSzckjlRrt5OHSIGvtPm+AqJ/oshF0+FzZ0UolmRUsgQZhUEC9wpVc0
         c4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03CDSYMCIiT6QRNC64UFYDsDOTdWB3FhPsvt7u8UmYs=;
        b=KFgnxwIpmB8Iw3QpZ8VKX/E2orGOQ+y8ncP2U7+C3MJD7G5nD0kmlXoCgRLwXm632N
         tOeZkItuUKlsJLBV2KyZ7DO4H6BBI1VfJ0h7mhHG/01wPKJzDfd+93kX0AUr2NA/VGg5
         +Z5OzXXkngTDxtZ2ounfZaOl0cx3m0eSb1NVyuisVKygiW63koguv1VFrmAMGFTn4cPw
         6bKDIM8HRh1xqyNuBxvJ8zhkCRLC8e1nGXp/V9qYteP3sk03oL2m7qn1nDV7BSQt2KPn
         YoZmtrKE6+ucJQ03WbbmGtOlbrtRaXx2clmm6GSu1+mga1ugg3VT1V4xQcayieLhfLdm
         L0EA==
X-Gm-Message-State: AODbwcBjZuln4DFr1LhnzRO//obOHpa6dFHcjJf5UDQoP/pJWt1fmrBJ
        3NtfVQW2X+aMzIs+uNg=
X-Received: by 10.80.144.132 with SMTP id c4mr20056004eda.139.1496761967581;
        Tue, 06 Jun 2017 08:12:47 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d37sm2250632edb.54.2017.06.06.08.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jun 2017 08:12:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Michael Kebe <michael.kebe@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] update sha1dc
Date:   Tue,  6 Jun 2017 15:12:28 +0000
Message-Id: <20170606151231.25172-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd
In-Reply-To: <20170606124323.GD25777@dinwoodie.org>
References: <20170606124323.GD25777@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This updates sha1dc fixing the issue on Cygwin introduced in 2.13.1,
and hopefully not regressing elsewhere. Liam, it would be much
appreciated if you could test this on SPARC.

As before the "sha1dc: update from upstream" patch is what should
fast-track to master/maint and be in 2.13.2, the other two are the
cooking submodule use, that's all unchanged aside from of course the
submodule pointing to the same upstream commit as the code import
itself does.

Junio: There's a whitespace change to sha1.h that am warns about, but
which it applies anyway that you didn't apply from my previous
patch. I think it probably makes sense to just take upstream's
whitespace shenanigans as-is instead of seeing that diff every time we
update. I guess we could also send them a pull request...

Junio C Hamano (1):
  sha1collisiondetection: automatically enable when submodule is
    populated

Ævar Arnfjörð Bjarmason (2):
  sha1dc: update from upstream
  sha1dc: optionally use sha1collisiondetection as a submodule

 .gitmodules            |  4 ++++
 Makefile               | 16 ++++++++++++++++
 hash.h                 |  4 ++++
 sha1collisiondetection |  1 +
 sha1dc/sha1.c          | 30 ++++++++++++++++++++++++------
 sha1dc/sha1.h          |  6 +++---
 6 files changed, 52 insertions(+), 9 deletions(-)
 create mode 100644 .gitmodules
 create mode 160000 sha1collisiondetection

-- 
2.13.0.506.g27d5fe0cd

