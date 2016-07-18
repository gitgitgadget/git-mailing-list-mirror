Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49882018B
	for <e@80x24.org>; Mon, 18 Jul 2016 15:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbcGRPJU (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 11:09:20 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:32979 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbcGRPJT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 11:09:19 -0400
Received: by mail-io0-f179.google.com with SMTP id 38so162099011iol.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 08:09:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FxMXIZJSGTKCkEbU8ZPKuHFB7rdRfmLYRikGboIOCxs=;
        b=CaubjdmMBh44RRb2yGwpzXF5qR4zSGbqdso3BrT0YiQjUNAGFg/BcYiq7pMyNFO3lP
         SjKKjv7MNzIEqryXAlA/30ODLiXjLeaxF+ebMOSOHyyZAq/6tEsOWMEaL2ZVkJxO1Qr8
         0tNuVOEivq8hMQrKmp4MCXqf2yJZQRkaqda1HOA/mqG7W7d2z0vG+B/Ru/Ynaw/wUSAn
         IZR0R7qUmfpPs85LvuMJDXqvLaiSYNpJmh5Qo9/Ku4I65RtdT3DGBR0nZMxcLK2aqpti
         ZfrwQjTC5fjCli4CuZ5qXItCQEKeo+45/ksWoG+P+kovX/CVDIfMald/9pqJfPJ/AOPL
         pIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FxMXIZJSGTKCkEbU8ZPKuHFB7rdRfmLYRikGboIOCxs=;
        b=bKCcJamjL3BtGvFvd4LOHPWtkRqcYZ79y3zxYDykiLjTsxI/UE73CJKHKXbTmR4NTt
         idD8UcUZPHbwDZOPqdNwWh9m46BLZy5uTIlkl4Z9LF48XrMj6RTuf+lYXsY9XChdtWXM
         SbR4e/uwYvQNVaUAmhbiHI+WZIZ6gR/XW2qnYyo1zgYka4P2LLpD8r0zrwSX8iO49q78
         YsV5jvw59UQFyiySmqe4e0jvZ8JZQiDgxT0cJEGLL85xMmqy0EfANVquwibr07AoSsPm
         3a0AYYbWdku3j1lgxe58d9ru3/Gbb/IfFFkitiRN55P4FRAh3+Gdq953IFme9iAtiMF3
         j+Uw==
X-Gm-Message-State: ALyK8tIJDtXriOzebx7THl7jYTCDZ8NDzvWOsOTnOAesLsf+hpLRQo09Zfsb4pWoxXeFch+v2Qn7XCSD2jOgsA==
X-Received: by 10.107.130.39 with SMTP id e39mr18410315iod.66.1468854556971;
 Mon, 18 Jul 2016 08:09:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.83.4 with HTTP; Mon, 18 Jul 2016 08:09:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607180905320.28832@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net> <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
 <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org>
 <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
 <alpine.DEB.2.20.1607180905320.28832@virtualbox>
From:	Herczeg Zsolt <zsolt94@gmail.com>
Date:	Mon, 18 Jul 2016 17:09:16 +0200
Message-ID: <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Theodore Ts'o" <tytso@mit.edu>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

>> I think converting is a much better option. Use a single-hash storage, and
>> convert everything to that on import/clone/pull.
>
> That ignores two very important issues that I already had mentioned:

That's not true. If you double-check the next part of my message, you
I just showed that an automatic two-way mapping could solve these
problems! (I even give briefs explanation how to handle referencing
and signature verification in those cases.)

My point is not to throw out old hashes and break signatures. My point
is to convert the data storage, and use mapping to resolve problems
with those old hashes and signatures. A single-hash data storage is
obviously way easier to handle, than a multi-hash mass. (See Linus's
old e-mail: multiple hashes [=meaning database keys] for the same
content is a complete nonsense in git-speak)

> The "convert everything" strategy also ignores the problem of interacting
> with servers and collaborators. Think of hosting repositories,
> rediscovering forgotten work trees, and of the "D" in DSCM.

That's not an issue when we're working with a single repository. It's
reasonable to ask for all git clients of the same repository, to
support the same hash. Yes, you have the need to configure the hash
algo on a per-repository basis but that's all. For importing and
co-working between different repositories, it's a bit harder, problem,
but it's possible to handle the conversions correctly.
