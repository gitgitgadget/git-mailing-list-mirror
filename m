Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDBB71F4B7
	for <e@80x24.org>; Sat, 24 Aug 2019 21:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfHXVAQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 17:00:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41201 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfHXVAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 17:00:16 -0400
Received: by mail-io1-f65.google.com with SMTP id j5so28245497ioj.8
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 14:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CXUl8h5TDdX/4lO7lqeOCZskIcrmdoKRmW+le80xinE=;
        b=LQinJ8RsuibJxZUdOb9EiqoOUeFXI6EMY1izrGFZfp8/ELtp1vcKrUQx95wx/X+U3x
         f9Zsf7UEHpRypa2vaKXNky+gJ7o/VpxynNcneKJ+aHoGzbo+gn4RGPefK4ouh28iqAcQ
         B4gpVBKRr96rWvR0l1RNN/XW3DiNd+JfIbuINFGTv2NiDrLvyemdjoTNbapY7mVQkznf
         9YU5tuM2fIlQ3Hf7qjTydu8sqakWm0pe6OLlcZqwdFaz3+VMIdmQaGwyG5IiQt/QDAhe
         rVBQTOJV34SDpDov1HUcmbsAasyW6qTNqL94+5w0NptX3fkovmzLUIwYoCs9hZj4Y/Hs
         I7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXUl8h5TDdX/4lO7lqeOCZskIcrmdoKRmW+le80xinE=;
        b=RSU5Y0ZSF1aLjxINYf6aDKxKG4Ka363/qodtCH/qCwGX58qIRPFcLYA6k/9hIIzb3z
         LEPYAz3uQVZl50CAMZxLdO0EECIwKy4KqwN2zjHOVUVxlOsjGie4VLmTAXW+NcOHY5IT
         WQV5tjC6QYYRrHWgbrJv8WXB29CiMwOVQynwABIHDHEH1TCcRmsj4eEu8CdjzvT/2V73
         vvaCFDYNnDnLbukripiZ9+sZ2N7/0Cg07tuyImKlqziYj5cMB+/b5QE0YzCwZUb7yCey
         lac9cId27z6kKmP2PHclE/8iFU0IH/X9aVJ5Nb/7ZiH9Lgmg4mDZRfmFU6Y/w5smqOQw
         NOww==
X-Gm-Message-State: APjAAAXFpn98gZtOTPNVeSZnRc/wd39/PVXScvf3ExLpepOx94jDYUs2
        CN3kLjyHvZ/lPqSqFhm8qBbi7EICpfsvXFxu/E5Opg==
X-Google-Smtp-Source: APXvYqwT3X8ilCJG8GD1VysWarHpbnfwQouzbJSYGltPr9vOf6BGKg9mfOAC4IdKBdBKAgsO2HVuDfUcHtLGwO5FCjM=
X-Received: by 2002:a02:10:: with SMTP id 16mr11233255jaa.96.1566680414957;
 Sat, 24 Aug 2019 14:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <005f01d55a1f$88e2ab20$9aa80160$@rogers.com>
In-Reply-To: <005f01d55a1f$88e2ab20$9aa80160$@rogers.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Sat, 24 Aug 2019 14:00:04 -0700
Message-ID: <CAGyf7-HyJGVX51YMH0uqah4dkwkwfs6pLR5eSVBCeRQ1Ou=ZjQ@mail.gmail.com>
Subject: Re: [Question] clone performance
To:     randall.s.becker@rogers.com
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 23, 2019 at 6:59 PM <randall.s.becker@rogers.com> wrote:
>
> Hi All,
>
> I'm trying to answer a question for a customer on clone performance. They
> are doing at least 2-3 clones a day, of repositories with about 2500 files
> and 10Gb of content. This is stressing the file system.

Can you go into a bit more detail about what "stress" means? Using too
much disk space? Too many IOPS reading/packing? Since you specifically
called out the filesystem, does that mean the CPU/memory usage is
acceptable?

Depending on how well-packed the repository is, Git will reuse a lot
of the existing pack (and a "perfectly" packed repository can achieve
complete reuse, with no "Compressing objects" phase at all). Delta
islands[1] can help increase reuse and reduce the need for on-the-fly
compression, if the repository includes a lot of refs that aren't
generally cloned.

Another relatively recent addition is uploadpack.packobjectshook[2],
which can simplify caching of packfiles so they can be reused on
subsequent requests. Whether or not this will be beneficial is likely
to be influenced by how many times the exact same commits are cloned
and how much extra disk space is available for storing cached packs.

Not sure if any of this is helpful, but I hope it will be!
Bryan

[1] https://git-scm.com/docs/git-pack-objects#_delta_islands
[2] https://git-scm.com/docs/git-config#Documentation/git-config.txt-uploadpackpackObjectsHook
> I have tried to
> convince them that their process is not reasonable and should stick with
> existing clones, using branch checkout rather that re=cloning for each
> feature branch. Sadly, I have not been successful - not for a lack of
> trying. Is there any way to improve raw clone performance in a situation
> like this, where status really doesn't matter, because the clone's life span
> is under 48 hours.
>
> TIA,
> Randall
>
>
