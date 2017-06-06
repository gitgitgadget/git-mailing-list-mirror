Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0672B209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 13:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdFFNXc (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 09:23:32 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:33099 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbdFFNXc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 09:23:32 -0400
Received: by mail-wr0-f181.google.com with SMTP id v104so54171065wrb.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=B1FDtZlClM/NQkZ5bKFwVoPnWMrU4f8hgvz0lZME/ws=;
        b=Lj9PUDRvFH42bDN1OsiiX8Mn8d6/6xgzAVfB68HbMR4X6IfiVY/3JM4WMNa234H8E8
         T+TB+1SsQUeUKnUo+yEH1zLBjY3l74Z9+iZ/Sc81xMScSikYk9S/EQGSXF5kaP3BS6fv
         K4uPJ2LzutPzHbXkqjPwsiJNCabXp6f77REQd/4Bz0JHsH8RoMG200O2Mrem9VMQdJgj
         6F0MJVv/cQtCT90H86+9v7kePbK18RpsioPM2J/vO3mK5oD4RPmjsJkTUJ/giNZWmlj8
         XCXgLrv1lnsanOdFXU/XLBsQcBo8LQtuK2WgCzYch75K/QIMV6SB0+ZWZVJjDoiURPDU
         dOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=B1FDtZlClM/NQkZ5bKFwVoPnWMrU4f8hgvz0lZME/ws=;
        b=eqs4vr+GtTiPwLCJAjdcbLL7dvsYqXHAKVC8BUTQA29np0AGQs/Tk/jXrOuHhmOco8
         k0bKTpXL8AnEEA7lTluybTjt1X7YsrEOQuGDFi9IYOJuTqRT/zmdppngYJVO2O2+IL6J
         BbIsMp6tI4FFaG9BwgLiLx/+RVUOtPxXfcdkmc2LopiHt3m5kEITXKVP7YKXuUsgJLJj
         xnjwof32mxMgkE+8YVL9sd5AUi+PKVq1vA6cAp9Ky2x5rPWPaqmMXO7oSw3DiAx6iJpF
         FLobl/8YM+AfMxEogVGwvgXaQ3ld+RrDG3jGfi81jbgCPtLapwHhjLi4p9DGJMFh+0/y
         2hoQ==
X-Gm-Message-State: AODbwcDcbZjDjwW9g1zPKKMB75eKdPL27ncsgE3LIM4x0d+znwDYzsdK
        oiYGxH9/QJl4pZy0G2cefe35a6/3e2gP
X-Received: by 10.223.152.212 with SMTP id w78mr9331009wrb.64.1496755410435;
 Tue, 06 Jun 2017 06:23:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.214.143 with HTTP; Tue, 6 Jun 2017 06:23:09 -0700 (PDT)
From:   rajdeep mondal <justrajdeep@gmail.com>
Date:   Tue, 6 Jun 2017 09:23:09 -0400
Message-ID: <CACkx65CDzw64wsQ_t3YJUm_UP27fBf50n4r7mcMe1wZPW0TSjg@mail.gmail.com>
Subject: Feature request: Please add support to stash specific files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git version 2.6.3
OS: RHEL 6

Work around found in:
https://stackoverflow.com/questions/3040833/stash-only-one-file-out-of-multiple-files-that-have-changed-with-git

Workaround is not very optimal. Please add this support to git.

-- 
==============================
Rajdeep
==============================
