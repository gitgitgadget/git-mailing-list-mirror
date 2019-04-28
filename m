Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BF451F453
	for <e@80x24.org>; Sun, 28 Apr 2019 09:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfD1JdZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Apr 2019 05:33:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38891 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfD1JdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Apr 2019 05:33:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so3725909pgl.5
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 02:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PXFqpjiwNqFIJeRlquwMXhOacPit4uTYrQwhvptlV7E=;
        b=TKE2XtxmByGuXHiQrFFWe6ihv0aU5kQN9uOgDkdEaPqyWo7Ay3LqkxLOBgHBJaTd37
         IMh6G2+M1ADnFUx2pKv4+ZbGMNWDBXOOcxKqTJNNE2cCDdy9v/IwlHaDFjL+xq959g9q
         3L5gzIRaNRnhhKHUyilmouWSnQUT3Cxw6F+f1x24wbHDQel3YHTuR16X5V6MKFwra2ak
         QNOUmZ/kZ8FgYUWAmJcyYqhzOwBB/21GdEbT6YjM3HsCogwig4nNGcniAkLMMXyoyCVb
         RR1oQcbv0BkwJWne4yNUA3DYef+R8VVHsH9Y3xS3Rgviw5NUEAH3ryW3MFf3z2f1MSpj
         mdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PXFqpjiwNqFIJeRlquwMXhOacPit4uTYrQwhvptlV7E=;
        b=kBm7QlTylCu9/e33HIzmctgrH5Cxn0mGjwdvR5Iinrk3khICmyjjvsybxZeNzkDtoy
         M3CDTx27xULzsnDXDCCttLY7ON7Bon2hX1+8S4dSWnpf4er9aZPX2Ha+FhTovq09ST6E
         fKWBbIW2y2+5WQB8JN1hpqDhQQQXQFtZbro7EMNXl4ialV0j6ZE/R7ij2KNFoAzHrbjU
         6Vvr7/1ReXyCKJWmi3ZzWxR2kiJU+IB+FV3snIfFJKzb8FXjkRANd216+iOokDfbcTGd
         HLL00mho4dxP7rePpsFQQjyCVrDUjZoTvg7PFtZwulRVHdK5XFk/2h14HVjv9HT7GvpY
         IwJw==
X-Gm-Message-State: APjAAAXAuROsvKuCZB8rWyOlixu1Ea/CljcVCVLenFcKWKJxbeV7M4I1
        a1OyOorvDjkJwYpXjJ2ze6Q=
X-Google-Smtp-Source: APXvYqzg2sqivnKkiiylhQghiXspyoIkg6FFt+UNjOy+1J9zLf3G7UegJ+JAwCXMVWAekYrni+Uogw==
X-Received: by 2002:a63:d10:: with SMTP id c16mr17415677pgl.156.1556444004860;
        Sun, 28 Apr 2019 02:33:24 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id e193sm49493117pgc.53.2019.04.28.02.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 02:33:23 -0700 (PDT)
Date:   Sun, 28 Apr 2019 02:33:21 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Philip Oakley <philipoakley@talktalk.net>
Cc:     _g e r r y _ _l o w r y _ 
        <gerry.lowry@abilitybusinesscomputerservices.com>,
        git@vger.kernel.org
Subject: Re: if YOU use a Windows GUI for Git, i would appreciate knowing
 which one and why
Message-ID: <20190428093321.GB21060@gmail.com>
References: <1b8a01d47466$9775c130$c6614390$@abilitybusinesscomputerservices.com>
 <2f1855a2-58c4-d7d6-cd62-41ce877f11b6@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f1855a2-58c4-d7d6-cd62-41ce877f11b6@talktalk.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 05, 2018 at 12:26:08PM +0000, Philip Oakley wrote:
> > [2b] What is your reason for your [2a] preference?
> Many of the other Gui's hide the power of Git and its new abstraction of no
> longer actually being about "Control" (by 'management'). Now it is about
> veracity. If you have the right object ID (sha1/sha256) you have an
> identical original [there are no 'copies', all Mona Lisas with the hash are
> the same]. Management can choose which hash to accept upstream.
> 
> Most other Gui's try to hide behind the old school Master-copy view point
> that was developed in the 19th century for drawing office control. If you
> damaged the master drawing the ability to make things and do business was
> lost. Protecting the master drawing was everything. They were traced before
> they went to the blue print machine. Changes were batched up before the
> master could be touched (that risk again).
> 
> Too may Gui's (and their Managements!) still try to work the old way,
> loosing all the potential benefits. They are still hammer wielders looking
> for nails, and only finding screws to smash.

Hello,

Here are a few reasons why you should try Git Cola:

- Git Cola does not hide the power of Git.

- Git Cola extends Git in the UNIX spirit by providing a convenient
  frontend to common Git commands and operations.

- Git Cola's Diff editor is focused around the Git-centric idea of
  creating small commits through partial staging.

- It has a keyboard-centric interface with vim-style navigation hotkeys.

- Git Cola is Free software and has the same license as Git.

- Python + Qt is easy to hack

https://github.com/git-cola/git-cola

https://git-cola.github.io/downloads.html
-- 
David
