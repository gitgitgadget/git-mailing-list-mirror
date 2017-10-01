Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA02920A10
	for <e@80x24.org>; Sun,  1 Oct 2017 13:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbdJANXZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 09:23:25 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:44805 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdJANXY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 09:23:24 -0400
Received: by mail-wm0-f46.google.com with SMTP id b82so1815533wmh.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=q3E/Bqm9Gz6D2beKaE/V6ShU8nEwsmDSldR8cKyl500=;
        b=sB9H0fAY2xjkYCEKPdr/to7C+wb6lM7cW9F8MMCogKTh/FtABzobl5avhw/Z2Y64TA
         aynvi9LEzJ5pSnLyfMAW+BM/Vj99d+jGAXHAmHfdKoLZUwUIcdRG3LbxLyLuLdo36j7t
         yZW6kLXUnNgUeSOROznSO3RoE+jiEZXA9HcOk7aHaG52pM2O1xCZCEEzENKCdUxeQY8B
         GU4SJR+yJwubMVvVFh4QYiHeurcdFRlrzIXW+HJYnJQHEEpdERJSv9Lo4ndpQkiVGp/4
         b7PIWMECwP3fEwJD9DdwKiW5Wg9V4IAhriG2BycphBAGk9ranjzmCdT+iqQGb3nNb1Vz
         3Kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=q3E/Bqm9Gz6D2beKaE/V6ShU8nEwsmDSldR8cKyl500=;
        b=iYCcUcPBYA9K3HSWMWFS/eVOio9OFftE8sge8qcLXzqYuFrOcbnuDYMYy3bcVXl1cd
         +HZV9Xqdxx0fgI9xUnBDg7UZ7C0mVz1UZqIQU0MYtyAP1ydFO0IzP1B1uDQ1ViejYRr4
         0gt29PkGjIeGO1mNajKzrMMpzGhiB1Decumwa+Lv8eE7AmmCuECBnWIS5ThgH0JfHoy7
         M3S55CZaTB5WG94tMaAFXnzOp0QBqqd1cCwn+f54tmS1PPLz+3mkMv/KKlWwmWuawBxb
         sMg+GjG+kgk0Xk6EJ9Daa3QrYAFn+BvUhp3OuFhtgV2fTbotaGfzzidzbS4R5Tz4D1In
         Ka/w==
X-Gm-Message-State: AHPjjUhAjG+nnXtMDX350OZKEnTkwA4Q21QJgSJCXPciWV8db7dwKjUM
        AnyK981PJWOh2yZE4tQSqVB14UNisTcCX0w2+g==
X-Google-Smtp-Source: AOwi7QB0xbG2ySCoOH44xcA1a3DLKOmk8wuygoJ+g6v1uge6kc9qkbHaCA8G0SocwJjYLxt6w2Zz8Vpk23LILz4ufWE=
X-Received: by 10.80.188.2 with SMTP id j2mr17204943edh.128.1506864203425;
 Sun, 01 Oct 2017 06:23:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.146.166 with HTTP; Sun, 1 Oct 2017 06:23:23 -0700 (PDT)
From:   Yubin Ruan <ablacktshirt@gmail.com>
Date:   Sun, 1 Oct 2017 21:23:23 +0800
Message-ID: <CAJYFCiNj22McSaKcCVMDVgah5cAqHYHja_b2jj6VAaAA=zSM1g@mail.gmail.com>
Subject: will git rebase has side effect
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suppose that I have such a history of commit locally:

A --> B --> C --> D

If I then add a few more commits locally

A --> B --> C --> D --> E --> F --> G

And then I do a rebase and squash F and G into one single commit H.
What side effect will this rebase have? How will this affect "git push
origin master"?

Yubin
