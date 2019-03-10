Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 901C020248
	for <e@80x24.org>; Sun, 10 Mar 2019 15:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfCJP7q (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 11:59:46 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37005 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCJP7q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 11:59:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id b3so1890365otp.4
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=LhSmPif3TqRVNrxSaHaW2hRC+/vaqau7nV1kK0y+Frc=;
        b=rw8PrDcj55O7y5/6GAeo6sUGSAx2yS4Fs2wAoLhGPRr3wilqM8wuUAbf4DzI4xtZGI
         3Ykm7PMczFrdwiR5quXNkzlgxT0xqOGEkFbHySSFrY7QvoTtQjylh7TMMOb1dNyvPyMU
         WTZQU4QgFumCaPvb+Tdh23RUCrAVGyut34GpYfo6mHMTkWAo4SJzei3Dp+OCDi80NLV6
         Ob90Ws7RHmiglNAgblTnOd7biOl/vDO37R5fi5KWaC15An3VRndqXsrRcz875fLD2xY4
         C4wr5w0HcwaIHFbAQNq/ub9WqCoabZmT6VdCQ43BxnHrM+rXuu/IKurqGeoQJS7/tG6r
         +u1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=LhSmPif3TqRVNrxSaHaW2hRC+/vaqau7nV1kK0y+Frc=;
        b=gv8osUY+D0NA8j3e2tAaanTYyAZCGmHLPvHUMX+w1hoJDB/w1328u+hby+zt/ff2RF
         qj5L2Fwgt5dY84gwifD6G7vrzTCXC8EU46S2hQNSu+6EPLXEslZvb3YKRH8YP9mDpyId
         rkT4diSiqP0hAx0FyD5dlXjGuvTJyv0PU+Lt6VD478Qt1T80o7FXWPfHvFlbso/CkokG
         60p5rYI24vWWvlpJOBCoDkPQkV71JXoi54nncF7i5cTYEy1YpPUVIkx6zVrddSEDd9F6
         Wsn+ZSbR8t+WxsohJKxYvZcShmPF5RIeNxY3NwEPWAUCmJDLzYtpc3oujhTdOrsJjsr8
         575g==
X-Gm-Message-State: APjAAAWY4P2cspDHGJlDYYr5JEyfboC6+BwGQJ0qKmIjXBfD6UaD1WU/
        gwY0El0NbePAEv0hfLvvOuzJBJse3IX2gj+oip6GTiR0
X-Received: by 2002:a9d:630f:: with SMTP id q15mt17307560otk.153.1552233584698;
 Sun, 10 Mar 2019 08:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYENWOW0mj6Bn9OooqKg-sZi9bZUO461Gv1F00=phNwLFQQ@mail.gmail.com>
 <20190308174314.129611-1-jonathantanmy@google.com>
In-Reply-To: <20190308174314.129611-1-jonathantanmy@google.com>
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Sun, 10 Mar 2019 21:29:33 +0530
Message-ID: <CAMknYEMP73D=LSKKvYKpmTdR3LAxc5UMgT3gxiQDZBghkLFo_g@mail.gmail.com>
Subject: Re: New Ft. for Git : Allow resumable cloning of repositories.
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 11:13 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> This is indeed a nice feature to have, and thanks for details of how
> this would be accomplished.
>
> One issue is that when cloning a repository, we do not download many
> files - we only download one dynamically generated packfile containing
> all the objects we want.

Since the packfile is dynamically generated specifically for a client
request, and is destroyed from the server as soon as the connection
between them closes.
Is this the reason why we cannot pause it in between like we can do
with download managers ?

I read through the progit ebook 'git internels' chapter and the
following thought came to me:

Assume a pack file as follows:
---
$ git verify-pack -v .git/objects/pack/pack-
978e03944f5c581011e6998cd0e9e30000905586.idx
b042a60ef7dff760008df33cee372b945b6e884e blob   22054 5799 1463
033b4468fa6b2a9547a70d88d1bbe8bf3f9ed0d5 blob   9 20 7262 1 \
  b042a60ef7dff760008df33cee372b945b6e884e
.git/objects/pack/pack-978e03944f5c581011e6998cd0e9e30000905586.pack: ok
---

Here 033b blob refers b042 blob, and both blobs are different versions
of the same file.

Before this pack was made, both of these blobs were stored separately
and thus were taking more space.
Packfile is made to save space, by only storing latest version and its
delta with earlier version. Both delta and latest version are stored
in compressed form right ?

Now, here is another approach to save space without needing to create pack:

Earlier both the blobs had their object files as:

.git/objects/03/3b4468fa6b2a9547a70d88d1bbe8bf3f9ed0d5
.git/objects/b0/42a60ef7dff760008df33cee372b945b6e884e

Lets say b042 is latest and 033b is its earlier version.

what git does in packfile can be done right here by:

storing latest version in
.git/objects/b0/42a60ef7dff760008df33cee372b945b6e884e and its delta
in .git/objects/03/3b4468fa6b2a9547a70d88d1bbe8bf3f9ed0d5, with the
delta version we can add a header that tells it to check for
.git/objects/b0/42a60ef7dff760008df33cee372b945b6e884e and apply delta
on it to get the earlier version.

Doing this, eliminates the big packfile, and all the objects are
spread into folders. We can now make this resume-able right ?

Please point out what i missed here.
Is it possible to do the above ? if yes then what was the reason to
introduce concept of packfile ?

> You might be interested in some work I'm doing to offload part of the
> packfile response to CDNs:
>
> https://public-inbox.org/git/cover.1550963965.git.jonathantanmy@google.com/
>
> This means that when cloning/fetching, multiple files could be
> downloaded, meaning that a scheme like you suggest would be more
> worthwhile. (In fact, I allude to such a scheme in the design document
> in patch 5.)

currently reading through all the discussion on this strategy.
