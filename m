Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE8F1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 13:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbdFMNHQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 09:07:16 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33108 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752515AbdFMNHO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 09:07:14 -0400
Received: by mail-pg0-f50.google.com with SMTP id f185so60585332pgc.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 06:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=V15tvjxT1OuC9AwDU+cfhbg/f3dOgWoGD7brHwld/co=;
        b=P2YbQMma6ROHtFiJEvuHq9OUrT9GaLcjDk0Hxp+oImQQmImD8j+DeDCrVPdd8EMlex
         nZMVknyANYLz/jPCpot64zV+mZTVxo/O8UHjiYfW/2/SurH7JKFIk5orKU+eHU4FYBSh
         zEt2ImIvIlS/BrhyX+0WvTxQmZwEBlANKadkMolpfbF7D1WDzlxSlvD4s3VwD0cYkI2Y
         5OBtWTcwiBU7En2dAOjxpGjClLAA5GrrGfA39D478fYXtS1K7MuSQoamUiWY4t9tw0vL
         XX5uY3yS47RNcyQwyf1lKlbSgjmOKyIRFwGDgIshZJWJwvh5jmnvjG+LJPeZUSTfktJp
         uHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=V15tvjxT1OuC9AwDU+cfhbg/f3dOgWoGD7brHwld/co=;
        b=f8M4ukLf8ZVyM+vSIMyXZPZqn9TKNl+WgxdgWgSZnGbQ9l3FIag4fB58FfzP8fuLb1
         MtvnJW5ivhfg/HOkSewJzFyV9M1cYrSo8RPa4HJBLtIaNhokE+0HottYgDAuVB8imXvn
         N+ztOXbDXHa7GfQYvb48BjMRT0ilGeMvl7fnD150CbYokkistcESJ5uDMHQsD1uLeguq
         0cJx1/C96eGFytuZwEYMDLKxvzgQwcNuNuxeAvb0YosH7aJFRetL3ktyb83AQkvvS+I0
         BHa92bhRjSwa3xTm6PDQ4Xo+TnkXwErmqwmOxp79Z3Rwf0mNqVUWfKDPnDg8lz70C9G6
         HMNQ==
X-Gm-Message-State: AODbwcBD0ybCYVeIbnZHzi35EKJ3h84bL7EfrmMKgCgrbHxoTGT2X43y
        ylWa5UGTwyzv/Q==
X-Received: by 10.98.31.215 with SMTP id l84mr46716012pfj.179.1497359234204;
        Tue, 13 Jun 2017 06:07:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id v8sm24287839pfa.10.2017.06.13.06.07.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 06:07:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: fix location of index in worktree scenatio
References: <20170610090719.8429-1-asheiduk@gmail.com>
        <20170610173824.19460-1-asheiduk@gmail.com>
        <b4906d3f-7e4d-f4dc-dc39-7eac5da8292d@web.de>
        <xmqqfuf5p4wk.fsf@gitster.mtv.corp.google.com>
        <04ad4189-8575-2f0f-2c99-c98672513293@web.de>
Date:   Tue, 13 Jun 2017 06:07:12 -0700
In-Reply-To: <04ad4189-8575-2f0f-2c99-c98672513293@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 13 Jun 2017 06:29:09
 +0200")
Message-ID: <xmqqzidc829r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> That's better ... here is my attempt to improve

That reads well.  Thanks.

>
> doc: do not use `rm .git/index` when normalizing line endings
>
>     When illustrating how to normalize the line endings, the
>     documentation in gitattributes tells the user to `rm .git/index`.
>
>     This is incorrect for two reasons.  Users shouldn't be instructed
>     to futz with the internal implementation of Git using raw
>     file system tools like "rm".
>     Second, when submodules or second working trees are used, ".git"
>     is a not a directory but a "gitfile" pointing at the location of the
>     real ".git" directory, `rm .git/index` does not work.
>
>     The point of the step in the illustration is to remove all
>     entries from the index without touching the working tree, and
>     the way to do it with Git is to use `read-tree --empty`.
