Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF88420A04
	for <e@80x24.org>; Mon, 17 Apr 2017 12:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbdDQMRv (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 08:17:51 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36527 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbdDQMRt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 08:17:49 -0400
Received: by mail-oi0-f43.google.com with SMTP id r203so139624610oib.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 05:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fEF7L7K/TFnxYezwB/OPrXnB3wPm/i1PU1ISy1UtdVU=;
        b=Pt//pIIEQkiJzRioIFhgLG9oUXZOQRceW1BXed4CcXfD7qeyiW8m8a4Q6cWe7rwp3n
         H99r4qBmQjXUBno+pH9c+Rh0tuKMSUu2xkUY81xUZWEaJH4qJQqXFnXiGdgPDCZYsZsl
         YM0hb2sW/ysf3bf3+qRAh43hrgV7lN+gbLPcOgYmmpnOO7I4bqioQKcmXLDj6nV5dp8V
         JscuHU/Jt4gR9UY72SQjmBBTcJfet3XSAG2pLOMdM874di0KBZ3e8SIi37WpVpNkmAD8
         93JwBjuxUBTSmq74femLkubjJnw1+qvt2yW/pdEy9+rN7eHdgQzqdb5owBPUP1Fp74WH
         Dlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fEF7L7K/TFnxYezwB/OPrXnB3wPm/i1PU1ISy1UtdVU=;
        b=cFwVAiRVku9+PjcEDfZB0I2oyawTnLrpCn0rmL57Gb/Hz9eRQUhSM12yG0t7Uyeyvt
         ElS4N9L9GCDZqipmbU7FwEKNrgXLYI1ZhnNLfR9dGea9YCDkmS1e1EdMB0xrzqIFFOx1
         7dwjjvC/HHNFqUE6JlOIGTOx08BIykmUXP0c0oBsAWNdpTVsH6rSYJ1k3VSNQF4M6lK2
         dswdxJuAN9238uvR6EtkcNyNpPrm1jLrA15UlgN9kDK77CqJUGNExVHTxtwYxDLz38nC
         DCrxaOuoS3UYbm1L4QY03PpVyTcFo3ktnlMDXEucjhlmvcsKjhL2mxW32/jU/QcVQP+w
         DxNQ==
X-Gm-Message-State: AN3rC/7F0hAqezzM88iRVnx4qlt5NsZIUyfQuy+FNGh7dAJ1WF/R4FTz
        vUiJJUwqcc5dhTvZ9HIzuHMjCQEOrJZy
X-Received: by 10.157.28.165 with SMTP id l37mr4282167ota.199.1492431468719;
 Mon, 17 Apr 2017 05:17:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Mon, 17 Apr 2017 05:17:18 -0700 (PDT)
In-Reply-To: <ygfpogbb711.fsf@tehran.isnogud.escape.de>
References: <ygfpogbb711.fsf@tehran.isnogud.escape.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Apr 2017 19:17:18 +0700
Message-ID: <CACsJy8B5r+Xoo8s9xbwaUrQhEODzN4Uk5z9RjbKXMwM-W5m=HQ@mail.gmail.com>
Subject: Re: How to keep log history when renaming and changing simultaneously
To:     Urs Thuermann <urs@isnogud.escape.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 6:36 PM, Urs Thuermann <urs@isnogud.escape.de> wrote:
> Sometimes I need to rename and change a file in one commit.  One
> example would be a file foo.h that begins with
>
>     #ifndef FOO_H
>     #define FOO_H
>
> which should be renamed bar.h and have the FOO_H changed to BAR_H.
> In subversion I would
>
>     svn mv foo.h bar.h; vi bar.h; svn ci
>
> and then a
>
>     svn log bar.h
>
> also shows the history of that file when it was named foo.h.
>
> This does not work in git.
> ...
> Is there a better way to do this in git?

We could if we allowed rename annotation, similar to that "svn mv"
command. I worked on that a while back [1] then I stopped because of a
design conflict. But I'm almost convinced Jeff and Junio were right
(and I wrong) now so I will likely revive that series before 2019
hits.

[1] http://public-inbox.org/git/1453287968-26000-1-git-send-email-pclouds@gmail.com/
-- 
Duy
