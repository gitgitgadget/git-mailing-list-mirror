Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C531F404
	for <e@80x24.org>; Fri, 31 Aug 2018 09:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeHaNey (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 09:34:54 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:46440 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaNex (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 09:34:53 -0400
Received: by mail-ed1-f51.google.com with SMTP id k14-v6so8539058edr.13
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 02:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=avBv3yMe9+7R68qUmsbT6fn6R/nrBnwVJxU4s6YqNNE=;
        b=bItuEkmbUgA/d6h3pWBzsmtcSTTWnPo3UFUE7QwbuzC6jKQmDAV95gKaMTdDeeFxOg
         E5dRy4t6zi5eyYpwEKdTQ6i9qQKGvmsj0EEew2r3T967UX+/thaiwCBH3fdphjxrjywd
         2/KOXF2wuvIpFt3hzx2cyg7zRbj6dRVsdUe1ivqqcdYb2P1MKwHSbjCLkURZMv2bEHfr
         D4TtNrRqW5QQjS3oz47U3l8yR7uF+l8j7nroQT6aGfXtLkQG8zjXtKiffgUpEmieZRwo
         oqpmdxocSpQhrcS7maJsV3lBIKjvzSYVYVX6WPy2kS4dXqlM88GbxAHTVkXdzr1TxiO7
         PHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=avBv3yMe9+7R68qUmsbT6fn6R/nrBnwVJxU4s6YqNNE=;
        b=LlopVW95ZWPG8tG6DIOL7lwGcywvPJ29+1C0fjCMQT3maTb8AJTxq49eV+ts51sun0
         127kRBlfjnYTpxYRRWpuEJ8Pw15BdMZJ+sJQLohKnherBp9Q1iT8Fv7YyWBBEVYrHewm
         tixozlp4VbtYXUpLmzs71Vy13q2lOzLk1S8PE5I8PbEptGbY33lwnDg1radgx+R3iedq
         CCys7+JAu7OlQEle08WOecSIdBCRABysw1TVGAYx9K9AFv9ZjTtMJJ0p6DzmgCfbMcRQ
         j2NguXqr9YN7g5QV3VCOsSdHibiVRyKV5tCkKIGPIbtS2U7I0xoORpUoWZymflyBmKvj
         3j6A==
X-Gm-Message-State: APzg51C2wXxkdSJhwlGyjv1A2UYsfPaamVsppUYg5TUmEjAH5ZtCbcZu
        jNdLtiJUybRjfN9306RfCT5n5WKk+tc=
X-Google-Smtp-Source: ANB0VdZp6D0v192ShOGZBmeMPhYdDCGZt7MKreliOm16RVjDsh9Ywwe+U07AsYZLawCA1ryUuGEfgA==
X-Received: by 2002:a50:ee03:: with SMTP id g3-v6mr17329953eds.66.1535707697252;
        Fri, 31 Aug 2018 02:28:17 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id w20-v6sm6001978edc.12.2018.08.31.02.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 02:28:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Piers Titus van der Torren <pierstitus@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: improved diff tool
References: <CAJmvCd1BwPNgZM+g7c6An-EESMHDOSGQe7RjkAAz36eNY3fvGA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAJmvCd1BwPNgZM+g7c6An-EESMHDOSGQe7RjkAAz36eNY3fvGA@mail.gmail.com>
Date:   Fri, 31 Aug 2018 11:28:15 +0200
Message-ID: <875zzqdgwg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 30 2018, Piers Titus van der Torren wrote:

> Is there interest to incorporate this algorithm in the main git
> codebase? And if so, any hints on how to proceed?

This looks very nice, it would be great to have it in git. I think it's
more useful to focus on getting it into the git C codebase, the user
base of gitk/git-gui is tiny by comparison.

Aside from what others have mentioned, maybe this commit helps to get an
idea of how to do stuff like this: 3cde4e02ee ("diff: retire
"compaction" heuristics", 2016-12-23)

I.e. it's one of our previous diff algorithms being ripped out. Grepping
for the various --diff-algorithm=* options in "man git-diff" in the
source/history should also give good ideas of where to start hooking in.

I see from your name / some brief spying on you via Google that you
might be in the Amsterdam area. I'm not very familiar with the diff part
of the codebase, but if you'd like I'd be happy to meet in person
sometime to help you get started on various other stuff in git.git if
you'd like.
