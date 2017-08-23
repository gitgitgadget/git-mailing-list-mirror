Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AC01208DB
	for <e@80x24.org>; Wed, 23 Aug 2017 05:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbdHWFN5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 01:13:57 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:38804 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdHWFN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 01:13:56 -0400
Received: by mail-io0-f176.google.com with SMTP id g71so3691122ioe.5
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 22:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZnMYV8jczFZJ2WNeteR7Lo8ADNR7Sl5ql/ahFNuMQJ4=;
        b=IYqNfBDG/NnK1gUgL+58m0Ggb5kdf84pjDfUObRDPo0/OIxDZ0u32EqFxDyFj9CsI4
         f7URg9ESjumzcgNtCogNtI0cfcoWIIa9E9CTWEg6+ZkvZw8d952J8HX3FdXpGns++F9x
         Gy4BMJs6slA2H2YAf8YAdbSwmo3xwAaKDyGmiFWulRnxAiDxf0vNCbxoejmksswiuBbD
         kw+3RIemPkgrGWjG0R02IqMajcyWS+Wp5wfiNkwfhDMw2xtQeW+V0bE/+cVSR+UiwHB2
         IfOlsmgq6eJ85ZUyV6RJ12ij656R9sud/QldLE+Yl7CrcytTHVjheqDr2d4OlieQtlXg
         h6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZnMYV8jczFZJ2WNeteR7Lo8ADNR7Sl5ql/ahFNuMQJ4=;
        b=quGEUGKYUkmLnrNMIDmwaqHEjn+DY+FZ9na7drhsen0E88HlRcN7TP/3xcrTAOVDqj
         5eSwekTeLfsZA3zTYnW1WiTwsrgWO8zBe7ZivrdvSyzv6QHTMDtgbrpJTzYoU3JfiuBU
         Adtrdm/ro2DbOz7Md5xsBXH+Z++enAsf+ZJdveVMaDRxUwnahSe9Lt4+HB3awDZBO5TE
         0QJYIuX+i3X4PcLZFOr2v8eOpFh5Iy/pPQyDc7w0HjyZUN2ZkCYVzAuatbqUoJBfIVt2
         1/w5A60kli+Fa9pT3WGFQsYLy+fjYXMmWR83GMW//tyQgCBcIryQ3X1FupQQr4IFl3ev
         xcmw==
X-Gm-Message-State: AHYfb5hrYrB9wyHjjN8jKsJ5MzERlspedRuNg9CbNJFfnh7NEKfDgMFW
        OT6w0kB4rJJbURk1JGfeuX2pAd+wS5tW
X-Received: by 10.107.57.135 with SMTP id g129mr976874ioa.73.1503465235795;
 Tue, 22 Aug 2017 22:13:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.127.85 with HTTP; Tue, 22 Aug 2017 22:13:55 -0700 (PDT)
In-Reply-To: <87o9r7z7jp.fsf@local.lan>
References: <87o9r7z7jp.fsf@local.lan>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 23 Aug 2017 07:13:55 +0200
Message-ID: <CAP8UFD32=67Cfq6ke0_7SFBEL20TqpFVtq8LXou9WuKOti59ag@mail.gmail.com>
Subject: Re: Advice needed for basic setup for home user
To:     Harry Putnam <reader@newsguy.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 10:11 PM, Harry Putnam <reader@newsguy.com> wrote:
>
> I run 5-10 vbox vms' on this host with various OS's involved.
> With each host, I've kept a local repo of some key OS rc files.
> and a couple of hundred home made scripts.
>
> They all follow the same pattern of setup, but over time each repo
> becomes different from its cousins.
>
> I've never taken the step of centralizing the assorted local git repos
> into a central repo that keeps a branch or directory or whatever it
> would be called of each local repo.

You should probably decide first how you want the local git repos to be merged.
The result would be quite different if you have a branch or if you
have a directory for each local repo.

Maybe tutorials or books can help you get more familiar with Git so
that you can decide based on what would be best for your use case.

My wild guess would be that a branch in the central repo for each of
the "master" branches of the local repos would be the way to go. But I
don't know your use case much and cannot suggest you to do that based
on a wild guess.

> So that all the local repos would become a checked out module from the
> central git repo.

Git doesn't know about "modules". It has "submodules" but this is yet
another different thing and I am not sure at all that it would help in
your case.

> Or at any rate, something along that line... not even sure how I would
> set that up with git, but would like some overall advice about how to
> do that. A step thru or an outline would be very useful.

As it is not clear what end result you want, it is difficult to help you.
