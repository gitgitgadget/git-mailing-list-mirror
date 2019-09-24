Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02C431F463
	for <e@80x24.org>; Tue, 24 Sep 2019 17:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406258AbfIXRHw (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 13:07:52 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49787 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732478AbfIXRHv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 13:07:51 -0400
Received: by mail-pf1-f202.google.com with SMTP id i28so1932036pfq.16
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tCdK3dU6HrYl0V6np884KdAHnm+g+dnD06sPeeY3IkI=;
        b=beR65cHRGLKEsVlUW1yzo41i1qP9jKLqUw6wjDvtg9hJxMYm78SQ2D6ateUo/RwfcX
         BbxOWq08N7TPD+bnhykOY9J5bYG2qfKs4a4O3BTzONUJJeIj3UoT6EqahQLBYVq5poHr
         4zvlryH0TfBVGnVyMZHRU/Deg3xx9cBXHnJckhA2e7begFh5UdJHTQx15sA5WnWb4aOV
         QUdscTcTuXF3vMLI7FGBB1sQT5TbTzZ+cvFl7/fy3FPdVfKm/suZ+OP2tDL1oBL5pPG0
         dvvssaT40YK9G22WdPDcyKZheOB2dqFCF9c0B3V+gSz31lXEapobC7PeIuBrvnK+RjXX
         6W6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tCdK3dU6HrYl0V6np884KdAHnm+g+dnD06sPeeY3IkI=;
        b=Td7nAZ2PeDzjZfUt0GIRu2Ifnz65V2ZW6zKNqTIAIzYuk2eB4BQdiGn+Lqc2p9v6Y3
         SMgtsydAIq8mKCWGPLfg3MJMu8iEyOGkejLXx58TjQ5c5UupeWQpnxMyuk2cTbJHfK4z
         oADE+B9C0VZ0VwwUxjerEzhosUzWhdgmCKtlQON4FDWB8QAABqQiXh4j72JeeCAYTeun
         KPNdTGzjzCvVz3NsYw+91sdIX0BZFGpY5cCfLVg46kfJ9aqqrCCJl+j0msKkEVo9vTsX
         lqbdkgFrxcZeZNTs6e/UT4Gf3JPmBE254UGENkhNnt7+uHYCXdndSC7gLqaIiEKEf0Fv
         wD+g==
X-Gm-Message-State: APjAAAVcGyXE0WX1f3m84yzaSaJ4SoT+nOhyH+6+dA2ttXRP/q65ECOa
        tfzP4XlXfn9QYeAXTb30TeG4RTUKyZ5SmMioR/9Z
X-Google-Smtp-Source: APXvYqxYrZLpTFu+H8GdT61MpS4iEAtsHoIzE9ReYJZnaxtD7umfagLuTyhQutnquY+UaG0OblL5e+O08Dmy6gEi7RPO
X-Received: by 2002:a63:e5c:: with SMTP id 28mr4092322pgo.133.1569344869862;
 Tue, 24 Sep 2019 10:07:49 -0700 (PDT)
Date:   Tue, 24 Sep 2019 10:07:46 -0700
In-Reply-To: <20190923212834.GA19504@sigill.intra.peff.net>
Message-Id: <20190924170746.100302-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190923212834.GA19504@sigill.intra.peff.net>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: Re: Git in Outreachy December 2019?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, Sep 23, 2019 at 01:38:54PM -0700, Jonathan Tan wrote:
> 
> > I didn't have any concrete ideas so I didn't include those, but some
> > unrefined ideas:
> 
> One risk to a mentoring project like this is that the intern does a good
> job of steps 1-5, and then in step 6 we realize that the whole thing is
> not useful, and upstream doesn't want it. Which isn't to say the intern
> didn't learn something, and the project didn't benefit. Negative results
> can be useful; but it can also be demoralizing.

That's true. I think that libification is in itself a useful and
non-controversial goal.

> I'm not arguing that's going to be the case here. But I do think it's
> worth talking through these things a bit as part of thinking about
> proposals.

[snip]

> >  - index-pack has the CLI option to specify a message to be written into
> >    the .promisor file, but in my patch to write fetched refs to
> >    .promisor [1], I ended up making fetch-pack.c write the information
> >    because I didn't know how many refs were going to be written (and I
> >    didn't want to bump into CLI argument length limits). If we had this
> >    feature, I might have been able to pass a callback to index-pack that
> >    writes the list of refs once we have the fd into .promisor,
> >    eliminating some code duplication (but I haven't verified this).
> 
> That makes some sense. We could pass the data over a pipe, but obviously
> stdin is already in use to receive the pack here. Ideally we'd be able
> to pass multiple streams between the programs, but I think due to
> Windows support, we can't assume that arbitrary pipe descriptors will
> make it across the run-command boundary. So I think we'd be left with
> communicating via temporary files (which really isn't the worst thing in
> the world, but has its own complications).
> 
> >  - In your reply [2] to the above [1], you mentioned the possibility of
> >    keeping a list of cutoff points. One way of doing this, as I state in
> >    [3], is my original suggestion back in 2017 of one such
> >    repository-wide list. If we do this, it would be better for
> >    fetch-pack to handle this instead of index-pack, and it seems more
> >    efficient to me to have index-pack be able to pass objects to
> >    fetch-pack as they are inflated instead of fetch-pack rereading the
> >    compressed forms on disk (but again, I haven't verified this).
> 
> And this is the flip-side problem: we need to get data back, but we have
> only stdout, which is already in use (so we need some kind of protocol).
> That leads to things like the horrible NUL-byte added by 83558686ce
> (receive-pack: send keepalives during quiet periods, 2016-07-15).

Sounds good. With this, do you think that there is enough likelihood of
acceptance that we can move ahead with my proposed project?

Besides discussing the likelihood of patches being accepted/rejected,
should we record the result of discussion somewhere (or, if only the
mentor should give their ideas, for me to write in more detail)? I don't
recall a place in the Outreachy form to write this, so I just mentioned
the benefits in outline, but maybe I can just include it somewhere
anyway.

> > There are also the debuggability improvements of not having to deal with
> > 2 processes.
> 
> I think it can sometimes be easier to debug with two separate processes,
> because the input to index-pack is well-defined and can be repeated
> without hitting the network (though you do have to figure out how to
> record the network response, which can be non-trivial). I've also done
> similar things for running performance simulations.

Hmm...that's true, but I think this is a matter of degree. The input to
a lib function for index-pack can be similarly simple and well-defined
(a C interface that we can exercise using a throwaway patch to
test-tool, for example), but I agree that it usually won't be as simple
as input to CLI (but this is because of limitations that the CLI
imposes).

> > > [dropping unpack-objects]
> > >     Maybe that would be worth making part of the project?
> > 
> > I'm reluctant to do so because I don't want to increase the scope too
> > much - although if my project has relatively narrow scope for an
> > Outreachy project, we can do so. As for eliminating the utility of
> > having richer communication, I don't think so, because in the situations
> > where we require richer communication (right now, situations to do with
> > partial clone), we specifically run index-pack anyway.
> 
> Yeah, we're in kind of a weird situation there, where unpack-objects is
> used less and less. I wonder how many surprises are lurking where
> somebody reasoned about index-pack behavior, but unpack-objects may do
> something slightly differently (I know this came up when we looked at
> fsck-ing incoming objects for submodule vulnerabilities).
> 
> I kind of wonder if it would be reasonable to just always use index-pack
> for the sake of simplicity, even if it never learns to actually unpack
> objects. We've been doing that for years on the server side at GitHub
> without ill effects (I think the unpack route is slightly more efficient
> for a thin pack, but since it only kicks in when there are few objects
> anyway, I wonder how big an advantage it is in general).

This sounds reasonable to me.
