Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB0181F453
	for <e@80x24.org>; Mon, 21 Jan 2019 21:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfAUVbm (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 16:31:42 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:46161 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfAUVbm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 16:31:42 -0500
Received: by mail-lf1-f51.google.com with SMTP id y14so16504224lfg.13
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 13:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlOGotgA8AOD/BbSl4mqyiwWRa/TJfX3ytC4hUZLJt0=;
        b=pPRDyV6Ka0OdBQvPuYbgcnA0i55Y72P1MvveABQf+3AzxksE7XUjU9XVWNt9tLK7ZF
         MEyDldDr7HgOvQYh8oWHqFYIf1KGmKc8ikA/v6nHEPgeTrPU6kKIeUzOIr7DKCXFe+4f
         J6gqqVbrnyuRIzpkLexxsRp8cHphVHgTSLv2c9k4IUoO56U37BUMRJX68rbemVwd++CM
         hzca4SaCGuRNKK8Uson4H9qbrFW1JwRB9P8KxzWEy4M37NdKkDcqYmqQZJS9mXLgIgSz
         IMHY6sVqnJ/+gTYhBU3qEuL80Db9Sm9o9etodcV+OMOU3SAt1bJQAWMqs5ryqpHtV4uX
         Eqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlOGotgA8AOD/BbSl4mqyiwWRa/TJfX3ytC4hUZLJt0=;
        b=CC9OAEVfgfC36gVMiF0YsJg34YJqz7BKnX5j7HxY2qIPUdiFELLa6ZsRmrRAHOYd+H
         mzguZ29jdPlBjDYJWzBCIdQJ+OPpYGPtpsNm112XRRLqxSuza3nZh2H9kQzGUTarhD74
         jironB5x9TzZ3o4LEyzYWI3zWGbBuO2B85skRYTvou+u8ZXsnVBPGOG+34G0Y6huT33q
         v5U3/SSZqeW9WnYBrRxCEOEuORgwJCFcRqzhvX7uZ+hFeAbN+n50LbW40pci+rs8XLMw
         TsS32U4ZuzNnl8EN1qu7TcuU8xSmce/93VcYZgMVaWkfmtiFta0yYc+Hp+RSlhEINDDw
         /mjA==
X-Gm-Message-State: AJcUukfD+MJHjO3FXBs6Ea/k5gTyNZhk+Y1AqRMxEGHXOC2Q+IGqOXQ9
        gqEfXrjx8cP6Zw/Fl9FdDI7bLwV7j2Ot883LNr+p0f0SUU0=
X-Google-Smtp-Source: ALg8bN54qIk/5PnhdicXdB+vxOgoPspD4Ue9kctEsG3LL/clXIkGRZUCoMZMBtGZVTfCc7rrjHuVLCj4E8hU48TDI+M=
X-Received: by 2002:a19:5154:: with SMTP id f81mr20070933lfb.96.1548106300063;
 Mon, 21 Jan 2019 13:31:40 -0800 (PST)
MIME-Version: 1.0
References: <CAPL8Ziv9LKBBXnCdWcG6r19zBs6SW-f_OvBbBncMqFjLSyPyqA@mail.gmail.com>
 <20190121202128.am7caicqexcwewj5@dcvr>
In-Reply-To: <20190121202128.am7caicqexcwewj5@dcvr>
From:   Stefan Xenos <sxenos@google.com>
Date:   Mon, 21 Jan 2019 13:31:28 -0800
Message-ID: <CAPL8ZitH4xy+BOEoOo03snJcTi_j10X8oegH7aP9uoQK5kx3Pw@mail.gmail.com>
Subject: Re: Missing patch?
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm guessing the patch was just too big. I'll break it up and submit it in bits.

  - Stefan

On Mon, Jan 21, 2019 at 12:21 PM Eric Wong <e@80x24.org> wrote:
>
> Stefan Xenos <sxenos@google.com> wrote:
> > I've tried to upload a patch twice but it doesn't seem to be showing
> > up in my mailbox or in the mailing list archives. The patch title was
> > "[RFC PATCH] evolve: Implement the git change command".
> >
> > Has anyone seen it? Is there a reason the mailing list would reject a patch?
>
> Who was on the Cc: list (if anyone)?  Any other info,
> particularly the date/time of the patch.
>
> Was it huge?  vger rejects giant mails.
>
> Any bounces? (perhaps in your spam box).
>
> I noticed I didn't get too many messages from vger yesterday,
> so maybe it was down for a bit and still going through a backlog
> (or people were just enjoying the weekend).
>
> I've been hacking on public-inbox lately so I checked to see if
> I accidentally deleted it, but that doesn't seem to be the case.
