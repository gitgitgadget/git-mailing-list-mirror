Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5DF211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 02:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725734AbeLBCwE (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 21:52:04 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54978 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725727AbeLBCwE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 21:52:04 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so4327746ita.4
        for <git@vger.kernel.org>; Sat, 01 Dec 2018 18:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Kpch7sCoPjDNRa7LvRDMP+nrH98m8/TFJkQluF8LJFg=;
        b=VtNcFnIvg7AWiyw32yLsNt17+Rg5Vg/Gvw9yngckrv1pHDjJwnjbOEjJ+/bjlQ/6VM
         zysNmF/0QF3ZWN580vx5sm0ZBIJT+2TySXnz/6geOVYdLRRlxeCmby7Ib6uRh61obemH
         ZSz3nA4VLhnrf/wrjPjViTCKpD3YWSSragEaXlk1ayJqj+sJUnR5VlhU39MDyTN/+THj
         fQXGPOh4YVaDZFe4I8Y2UMM9NSwdKtXQYP0sg7hd3bcufNH82qQcUqcGfmKOQFWmN6Cb
         /79Xz2TL5Ba4mp2MHfY/TMM73TMTZvFoMEXwsOm0wNcDFTlYEcar3Z+dmxuCDqayQPwX
         ydtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Kpch7sCoPjDNRa7LvRDMP+nrH98m8/TFJkQluF8LJFg=;
        b=N87z1xseS5ekq79SUgybwZbxesvActgBIEp5ABrj8PYqD6rwrvP0/6HSgjl8wlFmYM
         cLadFG5Zwt7nkS5DWdW+3sXw6z0Y1Zm53qlxCL2JtUPZ/NryL4ZeOxybZh0vR6FJ3z64
         dLZOFhObxZnc5MYt92DidKHxiAryqLz/4ppP61ssUwyTj20QAxDBsNVcPvwSP0bR7fWI
         GfiWUw0x/irZQn/vdLrDoLWaJRw7x6G6lGDElfTqwuo3WPfIS+Rp0kwLSEUCWKwuSwr5
         X+aAMEL0+xxeS4zMTaMiJ9qS2G6XgtjUfrQHh43LmiA+Qq2Sd0aMFVh8S2vUHw3DKizS
         Ntkw==
X-Gm-Message-State: AA+aEWYK0cAFioMow8hpPJcBlYUN9sfkvsY+DWvb/Qt6l68obRg5dRMh
        Ws+hAwKpX4uvzvRQh6p1V9cIG7q7i5IoOpYoQGe+/Q==
X-Google-Smtp-Source: AFSGD/UmOYQ8fPloTIl07IAXB+BPGNCCrEjZTfIEUqICX/UdVHJqbwJkPgMm3VZC+yDfKzyQuXa8FmbBLQR4uIEMsuM=
X-Received: by 2002:a24:19d5:: with SMTP id b204mr3850056itb.6.1543719122767;
 Sat, 01 Dec 2018 18:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20181202024320.65160-1-carenas@gmail.com>
In-Reply-To: <20181202024320.65160-1-carenas@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 1 Dec 2018 18:51:50 -0800
Message-ID: <CAPUEsph8fseNOZ-CvWOfpNq4ujaNz3oYfYafEdF8u_YVk5=o-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] config.mak.uname: OpenBSD uses BSD semantics with
 fread for directories
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FWIW this patch doesn't have any other siblings and subject should had
been just [PATCH]; apologize for the confusion and the spam (including
that other duplicated email, and most likely this one)

Carlo
