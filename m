Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3649E1F78F
	for <e@80x24.org>; Mon,  1 May 2017 21:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbdEAVLO (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 17:11:14 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35265 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbdEAVKh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 17:10:37 -0400
Received: by mail-pg0-f54.google.com with SMTP id o3so44790493pgn.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hBT8Z/9YaE9FXhkIYEM1zMYWzvsulo6YdZSVG4nK/ic=;
        b=RlGDuvhRAKet7gG3h9HeCX151CvhnGKHbIDbddrup2JD/25hjJM7eWJ4h/wOt7trj0
         VGN0TGafYYKuYEENgIc2+zNoHR2Wkke7cKQHgam76Im6xxZ5HOPeSLd1P6U+Cq9SBPHS
         LxsBv/G+8WgFkEmM3w5wN+Gu4Bjl1Y4PvEM/eahRgnULcNs4RL7gtFH8IJwMkiRmi9A9
         BLvqXq2iHNXjrSWgj82CuthpVnKDIbfFgSfCTa+E9nS6EpbANjV/WgyMe4uPreWj9pKk
         Uf2Vbsv39SEww2Atxhx2bEhZGGbgN6gzTXJIo1LU2kphn2ZqYF9IqQ8M8yrJNMlthJp1
         Tvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hBT8Z/9YaE9FXhkIYEM1zMYWzvsulo6YdZSVG4nK/ic=;
        b=m2vveKlLyRNyu0KZ+5V26I7gI2FLhTG+NLezUSoTgn7Wd9Aq52S6/YMBaEU/umIkb9
         rigKeVdv/AOk8rGJezHhUKOPW6FzQgNGwUjphxIZDOVIeH5MIB0FYw2SyINzeaqjDEOj
         QIpL4wSBzwlWZ8Fq5CpQCttGWbJmtR6zfc88D7rRQB9F0vQqz66nQjLuoNnIBJC+EtTy
         7ntpHe0cOU3WXhv528vGGL0L2rDxlwSnFxSjSEjVPV0iwX2vXn4Wdb5dWQq8FAREy563
         nl5as7pAs1JcpnCyriwN6UL2p1Ctarh2DqlX2nq4pHfGE0nPXHDpoS2VNFNYzqICEIJL
         ZIUg==
X-Gm-Message-State: AN3rC/5FxkYNVySYVPOFYROymLfMm1q87j5rJNeuY+bENVldIe4lNy39
        EjIvhXWBNVrI6wUw3MMMrBoGhXLw3VuwZLE=
X-Received: by 10.84.142.133 with SMTP id 5mr36779616plx.52.1493673037130;
 Mon, 01 May 2017 14:10:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 1 May 2017 14:10:36 -0700 (PDT)
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 1 May 2017 14:10:36 -0700
Message-ID: <CAGZ79ka5jbV++Q1s1xTeKLSL=TGm3t2jeFSYjmLQB=9TgJc7pw@mail.gmail.com>
Subject: Re: [PATCH v2 00/53] object_id part 8
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 30, 2017 at 7:28 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> This is the eighth series of patches to convert unsigned char [20] to
> struct object_id.  This series converts lookup_commit, lookup_blob,
> lookup_tree, lookup_tag, and finally parse_object to struct object_id.
>
> A small number of functions have temporaries inserted during the
> conversion in order to allow conversion of functions that still need to
> take unsigned char *; they are removed either later in the series or
> will be in a future series.
>
> This series can be fetched from the object-id-part8 branch from either
> of the follwing:
>
> https://github.com/bk2204/git
> https://git.crustytoothpaste.net/git/bmc/git.git
>
> Changes from v1:
> * Rebase on master.  This led to a conflict with the ref-cache changes in patch
>   39.  Extra-careful review here would be welcome.
> * Undo the needless line rewrapping.
> * Fix the commit message typo.
> * Use GIT_MAX_RAWSZ instead of struct object_id for the pack checksum.

Thanks,

this addresses all reviewer concerns from last round.
I'll give my eyes some rest before reviewing it unless
someone else reviews this series as I find these large
cocci patches very tiring. It is like being a goal keeper
of the winning team in soccer, where a lot of the time
nothing really happens, but then there are these tiny
critical sections that need high concentration.

Thanks,
Stefan
