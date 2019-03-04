Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D973620248
	for <e@80x24.org>; Mon,  4 Mar 2019 16:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfCDQit (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 11:38:49 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41799 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCDQit (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 11:38:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id z25so4889570ljk.8
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 08:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbBWbuE1edVXJnLQgvuq53PkVD41kbL/YvA+F0OimsY=;
        b=BqPwYNbYRTBU2e/ks/YQcgAqEo6zWG+d7XMGaW/6Ym8P0IKJ1igjd6vEigERz9t3zc
         XLWtNgnejpCQe3jFjWBiEB2IJD237oM9WSwFLLnFvh9y+2iCttKWvs/W/ZfM+lNbe4AR
         7qwlEHks6IrnLAzc1F92g6dW6WcEAgMjkHlnAH5wNDhN95PqCOTURMmPB5tPbqtSvC9E
         Zxwbtn03fGpOMqG2IqTBqXhmwn5tYIno4sNExA55FHO3RyWyCyFKDlIOB/4waXweq23e
         YlnoxIssZL5x0ypexhCYE5cxx4NmIMst1OchmSLNzKQRLKDlmd9VvMzEDbCXIZW4PA3+
         bE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbBWbuE1edVXJnLQgvuq53PkVD41kbL/YvA+F0OimsY=;
        b=Esm63jNPqRhKtpWfK2Upht+vEYGNJv4A3eQ2hGHvgZddYUnq7CzfPUKR5fnO3O6jbP
         Bm+GKzjIUPqyOqBilkIMBuIw1NC40ihBYXrFQdkpZjSIVuDfu7/uMjn4iZaK4EBvSj3P
         3fm05IFEAv9KZF2NpgRC05zQ1V2apNsQYTeOumgqIdNGc3qYjsVUjaZwq/J6qCEdJuD+
         2v36D9pvoY5E1VI7HWTz2yyg3i/NuUOoiCA7m7fA8tg+T5qorfyowLKIU0azrXt5bW2L
         WXFcDBOS8MkAswR5qgZmyCHUqT+9PV7b7bsCq/eIlEcY/ePDG73N+09e3sbba6ek8jW/
         WDbQ==
X-Gm-Message-State: APjAAAXEQDncAcreBgB9XC4rGOOyJDcK52zFY0mWhGCOLqOkYc5oVuTV
        OMIVCVb8LfquI5+fJPGFUnwSKXiQLUgkYAl0gPs=
X-Google-Smtp-Source: APXvYqyHGULvP4rjIa+7c165U6acCPYHPPDjQ8FEWqiiS6OjkskCy/QJzXW6aUNiwT24HCnq+bV33g/QHY3Oknyux50=
X-Received: by 2002:a2e:12da:: with SMTP id 87mr11120002ljs.181.1551717527215;
 Mon, 04 Mar 2019 08:38:47 -0800 (PST)
MIME-Version: 1.0
References: <47CA9077-E8C1-4093-8B36-2D5D3DE2D886@gmail.com>
 <7D21A788-5E38-466F-B3CC-F6A5CBEB2E2E@gmail.com> <D9CFD250-26D4-4D1F-B0CD-01E24E8606D9@gmail.com>
 <D4829D84-9192-4C7A-8487-0374DAFC324A@gmail.com> <C678086A-93E9-4F0B-AAAA-FBBBC27F2BFC@gmail.com>
In-Reply-To: <C678086A-93E9-4F0B-AAAA-FBBBC27F2BFC@gmail.com>
From:   Kenneth Cochran <kenneth.cochran101@gmail.com>
Date:   Mon, 4 Mar 2019 10:38:35 -0600
Message-ID: <CAJ145vVvFowZXFGZE=MB+DiC0n_dnqm3vU_YC-80aA0_7kUcbA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] Add alias option to git branch
To:     Kenneth Cochran <kenneth.cochran101@gmail.com>
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Phil Sainty <psainty@orcon.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding Phil for comments
