Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2999B1FF40
	for <e@80x24.org>; Fri, 23 Dec 2016 10:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760477AbcLWK0U (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 05:26:20 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:33726 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753195AbcLWK0T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 05:26:19 -0500
Received: by mail-io0-f179.google.com with SMTP id d9so251033897ioe.0
        for <git@vger.kernel.org>; Fri, 23 Dec 2016 02:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=meN9QRhHJTwEbT92GXc1rv35OHjL7r6SkFJWrRKhVJw=;
        b=NQCFeGsI83xTR8Wvq7Cjyu+K2HgRm5MbhN1CSOYGXASkYUUvQRdlVQE4mxmjQn+gcl
         GVRvIaX4P/QmG5z9wE6Zxgqvsqbfq1uOMCm+2HFBBmIOlh6iymwTnhuGyFd7mekDkUf+
         WVOq1/RPzJ06DfOe2CYTCeysDBI4WxFVYD5TPiipmI1IGl+djYN6FKbDFmL/vpmvLO4q
         1s4Eoyvv25pFsOEjdY74WqJRLxFR8+TEgnkHgATps+iYUSIHMdM36YqFa4/XgtWC4YH6
         V5xNXrcrHSZLhFhoYlcg9Dvpn2IeXMmfWvn9hbE+KOeLsQSSp4mW4U8k8b83U8Zr6Rss
         NZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=meN9QRhHJTwEbT92GXc1rv35OHjL7r6SkFJWrRKhVJw=;
        b=LEfstn9YfcdH2J9H2WM3pUoGL7j2c9WgGVj47FUNRTcVF3fyF5Ql89IuRrBOBdrMkR
         Mli5Jr1vjvKhs00gbAylK0qnya1rFPFI0IbRsqG0rJIeSA5NbAxYChwvvSUrXpmW8EFl
         T5bUlcGXIO38c8kIdPYxdVJ60farWYUOMDwpy9IMvoEUXuR3hXQsWIyNd+mzTvMQAn5h
         8oFXJt8aQzVQwsWwv6Xtmjrqv+2twKI9RcC2mimeBsTmgpY11yBIm66lLxjxqhWQF+bZ
         0FonGciG7PQyKrJskVxi5vAfBSboLK+UH+8GqrxA+3kJMwWtFLOH5o3UW0afQilK/QXp
         Td+w==
X-Gm-Message-State: AIkVDXLDnpKK35OOmi7tLvnO++8qt2BjiP5pOnVBWoM+GsdPqShPEmMU7IsB/W2L8y1QyxLr78qrj6HEw8FJhg==
X-Received: by 10.107.198.9 with SMTP id w9mr2632166iof.19.1482488352652; Fri,
 23 Dec 2016 02:19:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 23 Dec 2016 02:18:42 -0800 (PST)
In-Reply-To: <xmqqzijnehgb.fsf@gitster.mtv.corp.google.com>
References: <xmqqzijnehgb.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 23 Dec 2016 17:18:42 +0700
Message-ID: <CACsJy8CEKj6Lbn++NHhyB7J8HBrMW4F37SHi2soCH1z=RJz4GQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2016, #07; Thu, 22)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 23, 2016 at 5:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Will merge to 'next'.
>  - nd/config-misc-fixes                                         12-22          #3

Hold it. You made a comment about rollback lockfile on uninitialized
variable or something but I haven't time to really look at it yet.
-- 
Duy
