Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EA331F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753286AbeFHWmu (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:50 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:44513 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753221AbeFHWmt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:49 -0400
Received: by mail-pg0-f50.google.com with SMTP id p21-v6so7010198pgd.11
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EctzQA5YYDKuWdePhUZ6VsH8jl/z3M7oBlqMAQz0KhE=;
        b=rkyI1/veVOKgdIxf0jRG3AzlzXAlKmpyG1qz1Yn8rBaXKbjI+M2vd5VhyyFcw+RDq4
         5Gxbda4gPuUgjHEeJG4H1d0MMhS5fgBhqZ67aawxpVsiPzogCZ0/TdzyigQWZtD9wM5U
         hsDUJpjz93E0rIsDrcYpYaxd9UlBP/xKg63Hu/mWq2cKzCXvWZmBT+fH0TuM5N9K6Ob/
         0osEKDNWr7e1dhIb7qeB8tzLcLcUajansbAOFhlG8fUigv0sb9qW1JbGH+sEogTFQVpn
         iyp16FD/R15aCeRaQlZJfjSje1upYtQhvZvv9LkGlYl34XBTlUu3uVUYhrrD6+cUrRTv
         Bz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EctzQA5YYDKuWdePhUZ6VsH8jl/z3M7oBlqMAQz0KhE=;
        b=jKH2aD+JRIACU8FWRAaPkDnQqhDsF2qEnaJ4IO08DnojtbWRM82LEfssLsZGJSvc2K
         dQrhXQ/A/FnJ4o56qX5K5tVCZe8Yl00//spwd1GyrIVfymbIZj1yPDfUtrFZmKRS3H2m
         fJQTTGQV4YkmL7Q1Ue6Jl9tv4Ba9hCNJAMEpeUgHtBUXzqiVJUQSQstbO4jHrokp2aVy
         +ZG3qUT9vW8XyhNymaIu/b+DKoy61QGM4DFdnSOMk8tPOgidVu1E+7G7hbuVjBOxUJUi
         5cA9RPcoRGgPCwyP7k1tXKBVYoJAAt03HzIZCUqMb+9YuINf7RzQYMTxhJdC59Z/FqY2
         XQPQ==
X-Gm-Message-State: APt69E2IuGk8W2g3m9AFMLEC1xkORlXLtnZcCQp+NcC4/9n0csBLccfX
        0hDVRK76gtCoUTlVTAoSyH8=
X-Google-Smtp-Source: ADUXVKIiFmIJMbz/joBJ2Ks1FrvpD22iBXF3MjWGXgmxcP21DhpRPFiz32l/sCDHD5YeiKqYqAkw7A==
X-Received: by 2002:a63:740c:: with SMTP id p12-v6mr6742153pgc.259.1528497768415;
        Fri, 08 Jun 2018 15:42:48 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b15-v6sm41961464pgu.54.2018.06.08.15.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 15:42:47 -0700 (PDT)
Date:   Fri, 8 Jun 2018 15:42:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180608224246.GC42503@aiede.svl.corp.google.com>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Peter Backes wrote:

> I'd like to ask whether anyone has best practices for achieving GDPR
> compliance for git repos? The GDPR will come into effect in the EU next
> month.

This is a reasonable question to ask other Git users on this list to
share ideas, so thanks for asking it.

> In particular, how do you cope with the "Right to erasure" concerning
> entries in the history of your git repos?

Later in the thread you discussed some changes you would like to make
to Git or in front of Git to ensure that people can erase their
authorship information from a repository after the fact in a
non-disruptive way.

I have no opinion about how that relates to GDPR requirements.  I tend
to expect any legal advice a person gets to be situation-specific;
it's much harder to get legal advice that is useful to share.

Separate from that legal context, though, I think it's an interesting
feature request.  I don't think it goes far enough: I would like a way
to erase arbitrary information from the history in a repository.  For
example, if I accidentally check in an encryption key in my repository
as content or a commit message, I would like a way to remove it,
assuming that others who fetch from the same repo are willing to
cooperate with me, of course (i.e. in place of the object, the server
would store a placeholder and an _advisory_ token allowing clients to
know (1) that this object was deleted, (2) what object to use instead,
and (3) an explanatory note about why the deletion occured; clients
could make whatever use of this information they choose).

I've seen some discussion on this subject at
https://www.mercurial-scm.org/pipermail/mercurial/2008-March/017802.html
long ago and have some ideas of my own, but nothing concrete yet.
Anyway, I thought it might be useful to get people's minds working on
it.

Thanks,
Jonathan
