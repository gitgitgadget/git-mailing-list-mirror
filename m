Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3B921F803
	for <e@80x24.org>; Thu, 10 Jan 2019 19:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfAJTEI (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 14:04:08 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:38100 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfAJTEH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 14:04:07 -0500
Received: by mail-lj1-f177.google.com with SMTP id c19-v6so10695406lja.5
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 11:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dBdjpBSjpK0sGk1/8VhFWIq3O8T8GQngJl/P0p+t/Ig=;
        b=TZMempeQr78c9niU1fLQJpW5u9BUQhOTOdEPA2J8Q8lHj4hcdGzlCmLiYU/YpBwplD
         GcOQ8VMTdLMK0EXAHk5RPyTuKD9bfBia2Sx7iQYr/0UaEv0W4X3zJANFc7RoEC6iM7KH
         gI1wJiBX3j+gzzgwA7A14CxWCRE8CHFQfxrLNc6wny064GMnUAxjn9gIFOac7RmRAuHP
         eQT2T35TzNAwenu7IB36mm0kilK8Kj9wgfsaC+Yybl66G27k4cDHWZiIswz2+GRQnyys
         4pk2HbMpdUCuV+0RVRBRTxZym7MpiGtpoJGNpPJgMddJ+CKxPjVFk935cnTbHNm/h+Ne
         ydPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dBdjpBSjpK0sGk1/8VhFWIq3O8T8GQngJl/P0p+t/Ig=;
        b=dHxUOvOYQWlAeoGMKHJQi9XzgwyvGIgvoiLA4m5xLopQbl2H0S6Rko8Pi+9YSf9GjI
         MOGoKySGCz8UkMY7yIb/gaBOuhWRx86/WSI6M16HMSTrRl6gqP86kWnXy+PpJ7a6L5D8
         O8HeIIE4WNKnS/wsm3lHdBaK129G7QEH63BGeKWLJAz4cdHJ/6umYdS4uJ7gNKpPV6ue
         4+bnfXdSuJ7/l1TXsamlpCvitnEg2dsje+uq3K6g1ro+mLAeHKs/6cp3E7hMXBJAc3cH
         g87qxX4fdDVm3EmNHK447Wrcmo2Fh2n0NQnIgIBs3bVfw2Jd1bayTowurSX1zQdZPePQ
         rvpw==
X-Gm-Message-State: AJcUukdie06GlUrJvRo3Hk6qozPEZj9JdcxBFISGLuHQyq2mH8KVv9jU
        PDvVs2oggKg+gQKoNhtlUHJ/SnZuIcDJlutclyA=
X-Google-Smtp-Source: ALg8bN5eTkxpLFQBCmVfCChBJmxkbv8rAGwjJyM/1ysugFKMW+gUqYT0Wdz2712uDN1UWkK6sGlFJY4t2ZLs8JoBbdw=
X-Received: by 2002:a2e:5703:: with SMTP id l3-v6mr7480463ljb.106.1547147045464;
 Thu, 10 Jan 2019 11:04:05 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com> <CAN0heSoRYYS3-UAamE9nibhORPoD+_TRHu5-ZTeYxYMS4BAnrA@mail.gmail.com>
 <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com> <20190110010238.GK423984@genre.crustytoothpaste.net>
In-Reply-To: <20190110010238.GK423984@genre.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 10 Jan 2019 20:03:54 +0100
Message-ID: <CAN0heSowybpM6BULwkjXVWSegGd0cM3LLfmXqGjj5qh3Ev9ArA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2019, #01; Mon, 7)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 10 Jan 2019 at 02:03, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Wed, Jan 09, 2019 at 10:06:08PM +0100, Martin =C3=85gren wrote:
> > i.e., we copy sizeof(struct object_id) (=3D32) bytes. Which is 12 more
> > than what is known to be safe. For this particular input data, we read
> > outside allocated memory.
>
> Anything pointing to a struct object_id has to support at least
> GIT_MAX_RAWSZ bytes, and that code doesn't, because it's a tree buffer.
>
> I ran into this later on in my SHA-256 work and have a series that fixes
> the tree-walk code, but it's a bit involved and requires copying the
> struct object_id out of the buffer.
>
> I thought we were going to be triggering this case only with some new
> code I was introducing, but apparently somebody else got there first.

> As for my series, I'll need to run the testsuite on it, but I'll try to
> get it out tonight or at the latest tomorrow if people want to use that
> instead.

Cool. I should have known that you had something in the pipeline. Thanks
for working on this.
