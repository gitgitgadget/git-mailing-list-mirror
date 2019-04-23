Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE29F1F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 16:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfDWQLO (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 12:11:14 -0400
Received: from mail-it1-f179.google.com ([209.85.166.179]:56169 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWQLN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 12:11:13 -0400
Received: by mail-it1-f179.google.com with SMTP id y134so1059049itc.5
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=KBWCeGFxXZD1ekMbv5eLz67Q15kQGZjQPxL+8zyHXf4=;
        b=ZX+6tSmRpQ1+8+3407uKrHywv0oJcCPo8Zz4bhD2LKX45rAF/0fSe8hDIzQbZH6PMp
         Dj3tDYO+j8z5ObNFX7kfaopd+d5Ng7jOC4JK5BmAnZcjiqmhD86oqGu/REbpaUEGbzz9
         vkXHUENjXxirwouLZW/rYHABAqKRuwnMd15mvbtI4yIrH30deSLyzStmr/jw24qpuAXo
         yZqerGDwitPmaIR6biK5hNSoQd6ylPRFJJLSQ83zweZvpUmrBPSzxjsO32z/DWwNQYnJ
         wImt3rD0DNSa7UWdG3VckNyK7kjIiCG3mCTXhEZN81wQGmCWSd2uPBd/NvkWc418L1Ub
         nN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=KBWCeGFxXZD1ekMbv5eLz67Q15kQGZjQPxL+8zyHXf4=;
        b=pS4MweLizzEmmd3htsQ9ai0fIc94d0sj0olWn0VMiuzBTPvj7guRua7SCeEib6XQWg
         czDdg+thePeDwZXGBpEqFrM6k1k48n1llcxArivK9M9QcyZ/72g/sctvrb9NghacFWhz
         vzQyMjZrCE2y9qHjkFR0AtCDUK+8k0q9j26gjJP/7Xy1XJTso0ptKel7lATDA9M6nHlF
         +NQTTXlFirf28PAWJX6Ue9T0p1sJpDvCNhrXFRjTT4UE9NDSoeH0OJPJeZmfZwTYjRcn
         GCQFmRuA6JRGrbYmvOXs73EECiIyZsonoFN2Fv/czgQeMRGdA6SvLyKAOKTEfftIpuru
         BuyA==
X-Gm-Message-State: APjAAAVV/HcUVU5XdnU2C0MxiCSg1nXLWQ+0x9fE5rh/5cNJ7qKYcJKb
        Owt4AS3ZZnqfd2N4Gk6w1XZ6IL4VlKHsu9EuE/2tEFff
X-Google-Smtp-Source: APXvYqwYR6qK7fjOYL1uTPBbWIu+m4FeSrQ0K0ADjUE2rGikhb2p8PG8RP5aVrxQPzb+9ui2YPpGVHTL+jW00DbdfWU=
X-Received: by 2002:a24:5493:: with SMTP id t141mr2384294ita.10.1556035872810;
 Tue, 23 Apr 2019 09:11:12 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 23 Apr 2019 12:11:00 -0400
Message-ID: <CAH8yC8=TNp2V9YkVxhmBoHAucZiEtdHJ780SSajYPXWAh6=aCA@mail.gmail.com>
Subject: Select/copy/paste from Git Terminal not working as expected on Windows
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

When working on Windows I often use the Terminal provided by Git to
SSH into other machines. I've noticed select/copy/paste does not work
as expected when there is a lot of scrollback. It works, but it takes
minutes to select the text and copy from the terminal.

For example, clear the terminal with 'reset', then build Git from
sources. There will be a lot of scrollback, on the order of several
thousand lines. Then, Right Click -> Select All. It will take a couple
of minutes to select all of the text. Right Click again, and then
Copy. It will take a couple of minutes to copy all of the text.

This has been going on for years. Cygwin terminals on the same machine are OK.

Jeff
