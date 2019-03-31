Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD8720248
	for <e@80x24.org>; Sun, 31 Mar 2019 18:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfCaSpF (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 14:45:05 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:35381 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfCaSpF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 14:45:05 -0400
Received: by mail-ua1-f53.google.com with SMTP id f88so2330368uaf.2
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dCg3dV1vAzgb1dLpsJx3BDGW2PJsY/mREYBiNskE/dU=;
        b=htpRlOol2KxIEge+dqw9Fv/g+faovrdtfUg76ncrVlglwLKv8oIX9XOB5jnBSbLs/e
         oM1b1lMQZWXICpiMC0YguMHQaKyJVZUkQs6Uy70jm7JLZRKAzJt01n303AH7S2kstF1g
         VDSE8NAMOlMDGd4TbU3hOXXf5RUXsZ1JmKY+yKXGP4YudQqD/ESbaQysuoi/7MF8DCvx
         ktubQRJQh75El5Laq6EpJY4Es3IzkMIsGybFTHWFwyIrQo7WBpju/mjtKnJtcWN6wvBA
         CNApY3QLhdb6Sj6S6NzbsFKFRg8Y1I+LAECDEgT08sGWqyTGye4y4EkjJA6gdKeX5bHj
         oOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dCg3dV1vAzgb1dLpsJx3BDGW2PJsY/mREYBiNskE/dU=;
        b=cjT25Y9PtGkaYz25xTYfhb6ooJpfeOIFdiDEwNXE/TGHuAzgeiti/l1EajI3GR2PbY
         /Vqobuzy6KDH1yp1EqtzxC6rUhYmrd8Xhj3qLnrefo5BnBLG3vZLJ7rqkOvZ/+Wbsi5r
         /2xs91szANrBvgo6LbuY4blb+TAJlg4S8/JmbDMcCiNArvhI5m5Iv9Owhm3i6cILN8Dc
         guCQRbOOF9rJWjNq7DDYXlEO/lJ8mSGlkk7VUJ/WmV0bSjMSbhgiCww6wklIwa5JhWB4
         FlQrcuxCCpM1c632pjIqiHWYMAmDly7nUvOhlSo6l8DYh2azfsVAuUcLV4xdx7BPqVO1
         wGjg==
X-Gm-Message-State: APjAAAUaI0TKdfyNSvNcp1wDhWvMOtkOL8vCws5FXKl/GyWe5OyfsDw+
        ygEvIGW+mNVIoL+0jkkdGqFiD30a1oyaDDZArXb6BD+N
X-Google-Smtp-Source: APXvYqzT3wlFtvHxVWr1mqDr1vgL5GmcTjPQOEqzOrykKqlX0scB4VcRX1cuREtGJLKcZ+TSZbhjybgahOOVaw4ayqM=
X-Received: by 2002:ab0:70d4:: with SMTP id r20mr30293737ual.67.1554057904525;
 Sun, 31 Mar 2019 11:45:04 -0700 (PDT)
MIME-Version: 1.0
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Sun, 31 Mar 2019 20:44:53 +0200
Message-ID: <CAODFU0qcwZm=2YnGm+rccDT2e5yZU3pyYGUGTwr9izod+e0s0A@mail.gmail.com>
Subject: git-gui: unstaged changes windowpane resets after unstaging a line
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

After performing "Unstage Line From Commit" action, the "Unstaged
Changes" windowpane is reset. The reset does not happen with "Unstage
Hunk From Commit" action.

git version 2.21.0

Sincerely
Jan
