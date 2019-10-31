Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1E21F454
	for <e@80x24.org>; Thu, 31 Oct 2019 20:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfJaU6L (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 16:58:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32786 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfJaU6L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 16:58:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id u23so4889616pgo.0
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z7rnOlds+7W4o4xaDuiErdUi9LKYwqb1zvrw+qGV/ao=;
        b=jFANL0duBfAqBNJsit2LZ5aKbDiv3uf1jSvtred0VD+X4mf/rIsVnoxkxYrMTq9n/G
         D8hGjDbD7+X2Jys6hU5AusHnKDfvvMKkey0SmJ53aPdIN7ROH1uaF5No3Z1Su2l6gVtg
         7hsP/CTLOofGAhAfTV4FufISMLZJpHmB2Iydg/Z41ejQnGuRVd2dfU/PXtviVottQbUI
         jj7b+95eBy1oaM0fTzjnpQ/fQwMx8ROLi0kWZ/C/Gjm7A4BQ8I5zAls2wI82ZvUFduS+
         MZ5Bpibp+VJGTEor+/GCNXArC9zDnajgbbHKNlvk21V4xA6SlwbJZJZCffkZI1Ew+Xuu
         os+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z7rnOlds+7W4o4xaDuiErdUi9LKYwqb1zvrw+qGV/ao=;
        b=cLIz3c96L2m1B1VQ6Y6XO7VaZHzAXofhcbCl3Rfg8xjWKpMqLQcf0pG+69GEYLx7ur
         /HeVww7KC4G+rX2Ute8GUpG0b0O47O8egAklpICWoGiSUL37PbCJZoeMFVHCSKaY4T/S
         4xATsLxMXrUevsB8fpkf7W2Dzz2X+4KicknBNbibrfi60oPUI5sBlvWWEmmPXetUDdRM
         8etsSzlncFLoiPWa+o0N5fujytOCProyzqEPFiJXJfPL9rpc1a2xT8pLLl43DbeSqJxN
         nP6nWPs9U9TdGaYlZYm8tB2jOYTJq3xsAgQdJRVv+eQ2saldnb9Yo4B69lQ+FUgbB8fa
         b/wg==
X-Gm-Message-State: APjAAAVFG22gi33XlyiKXy8pw3LFzYN0HkDCRabV/8RD1Oe/SZZb+db4
        NLABbH1ko6R1vUdU5zl5OyT50Q==
X-Google-Smtp-Source: APXvYqySCqeLA6ouQVYbJAx+azBFMK3wVzZAhwrtUZALautvRKDxGX7nzy7vN7Pr+6o6Q7R/hmKaTw==
X-Received: by 2002:a17:90a:7309:: with SMTP id m9mr2758313pjk.10.1572555489701;
        Thu, 31 Oct 2019 13:58:09 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id i102sm6347954pje.17.2019.10.31.13.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 13:58:08 -0700 (PDT)
Date:   Thu, 31 Oct 2019 13:58:05 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] myfirstcontrib: add dependency installation step
Message-ID: <20191031205805.GC229589@google.com>
References: <20191026005159.98405-1-emilyshaffer@google.com>
 <20191026005159.98405-3-emilyshaffer@google.com>
 <20191026011250.GB39574@google.com>
 <xmqqimo9bqwy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimo9bqwy.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 10:27:25AM +0900, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Hi,
> >
> > Emily Shaffer wrote:
> >
> >> Indicate that the user needs some dependencies before the build will run
> >> happily on their machine; this dependency list doesn't seem to be made
> >> clear anywhere else in the project documentation.
> >
> > In theory, this info should be in INSTALL.  I wouldn't be surprised if
> > it's missing some info, though.
> >
> > [...]
> >> --- a/Documentation/MyFirstContribution.txt
> >> +++ b/Documentation/MyFirstContribution.txt
> >> @@ -38,6 +38,30 @@ $ git clone https://github.com/git/git git
> >>  $ cd git
> >>  ----
> >>  
> >> +[[dependencies]]
> >> +=== Installing Dependencies
> >> +
> >> +To build Git from source, you need to have a handful of dependencies installed
> >> +on your system. For a hint of what's needed, you can take a look at
> >> +`ci/install-dependencies.sh`.
> >> +
> >> +To install the dependencies needed for a basic build on Linux, run something
> >> +like this (or replace `apt` with your distribution's package manager of choice):
> >
> > pedantic nit: s/or replace/replacing/ ("or" would mean rpm is an
> > alternative to what came before, but "something like" in the phrase
> > before has rpm already included)
> 
> This section, as you hinted at the beginning, should be a single
> sentence, i.e. just "follow INSTALL".  Any clarifications should 
> be made as a patch to the INSTALL file.

Thanks. I ended up with a little over one sentence; I don't like that a
newbie following INSTALL file would end up with their locally-built Git
installed (and they may only be interested in a one-off contribution,
and never fetch again, or something) so I tried to highlight the
dependencies portion of INSTALL:

  To build Git from source, you need to have a handful of dependencies installed
  on your system. For a hint of what's needed, you can take a look at
  `INSTALL`, paying close attention to the section about Git's dependencies on
  external programs and libraries. That document mentions a way to "test-drive"
  our freshly built Git without installing; that's the method we'll be using in
  this tutorial.

  Make sure that your environment has everything you need by building your brand
  new clone of Git from the above step:

 - Emily
