Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3250420248
	for <e@80x24.org>; Sat,  2 Mar 2019 14:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfCBOqw (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 09:46:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36190 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfCBOqw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 09:46:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id j125so768139wmj.1
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 06:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LH24FY7/+qP2gibUhD/erfbJWnP1OlSvOW0v2k+UE5c=;
        b=LoU0DhAThIWkw2hJ/QtGVChZXjk9lakkgtFThxaa4jtBEOJRlVl++DT2gyG2jkwnfK
         LzVznwiXt6BPeTElxhYftWH4EM8Sth5DsCgF8c9S0FwpRRTjYs8haxqsCwXjN50AZdMc
         ZX9RL1aBlSEO69R0JNrvcwd0Ljt44vv3dLjASxgKb976LmQ99VhKc4qXMxGGR174f3yo
         NRcyvR1EW3dQOS1HRlQBA6odQ/02CIe9S/OztwT+tAhQMivgBUIpCXUJU6XmMs3hjDBL
         9RZ1AhuO/kmNU6meBRXyJVoJYgp1NbMmcrxn0DwVjNPeZtmivLDC3N0boUN943JRpheJ
         FhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LH24FY7/+qP2gibUhD/erfbJWnP1OlSvOW0v2k+UE5c=;
        b=LVe9S3pppyl1GTIUbSlqoSmU9d6JCQq98d5VwxELY0GLNvyL3WpMuk8g7gnmnF3BB7
         vvTdtnUWeJeg4fE1v9fgMBvpCUQ271jQvNleQ5JXkOh4uJb0s069J/BeXTCoWCUzY+9X
         3GQ/kjx3JP+3GHrD2ZprPJwIIBFhsff0O8G4y8gZQUoBtKjTL9+BUMAhF/jGJrLgz8Y1
         Hq2Se/sSA9JYMVEADZHX7t58qaPn91dOv9/5HxOJsj37pZprQQb+V85ANXtXvwuQtBYw
         5TmkuoT7CsFh6YRtgqT1Lhac+QOc6L9NV/f7wYpUpYa++NNNbarMvPySmXnAtOBF3hri
         bwjw==
X-Gm-Message-State: AHQUAuYskoEh0Q8dxK6oFkyT2lXmVnfMiOp+kPnymME4TU7MhRZSukIu
        +py7xH7Krge3VMddBUz0nz0=
X-Google-Smtp-Source: AHgI3IZ8QgyJv7/s6S04YMZNd5tuqwS1reJnPAGuu2xqpBbH8AArmVRBOSNiv/LalTpMTxgKdksXPA==
X-Received: by 2002:a7b:c457:: with SMTP id l23mr6130474wmi.2.1551538009504;
        Sat, 02 Mar 2019 06:46:49 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id p5sm1031260wme.14.2019.03.02.06.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 06:46:47 -0800 (PST)
Date:   Sat, 2 Mar 2019 14:46:47 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, git@matthieu-moy.fr,
        git@vger.kernel.org, martin.agren@gmail.com, pclouds@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: Re: Feeling confused a little bit
Message-ID: <20190302144647.GT6085@hank.intra.tgummerer.com>
References: <xmqqef7r9uil.fsf@gitster-ct.c.googlers.com>
 <20190301131326.7898-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301131326.7898-1-rohit.ashiwal265@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/01, Rohit Ashiwal wrote:
> Hey!
> 
> I'm a little confused as you never provide a clear indication to
> where shall I proceed? :-
> 
> On Fri, 01 Mar 2019 11:51:46 +0900 Junio C Hamano <gitster@pobox.com> wrote:
> > I think you are talking about t3600, which uses an ancient style.
> > If this were a real project, then the preferred order would be
> >
> >  - A preliminary patch (or a series of patches) that modernizes
> >    existing tests in t3600.  Just style updates and adding or
> >    removing nothing else.
> >
> >  - Update test that use "test -f" and friends to use the helpers in
> >    t3600.
> >
> 
> Yes, this is a microproject after all. But I think I can work on this as
> if it were a real project, should I proceed according to this plan? (I have
> a lot of free time over this weekend)

Yes, I think it would be good to make those changes, to try and get
this merged.  Having the microproject merged is not a requirement (its
main purpose is to see how students communicate on the mailing list,
and to get them familiar with the workflow ahead of GSoC), but it can
be a nice achievement in itself.

That said, I would also encourage you to start thinking about a
project proposal, as that is another important part that should be
done for the application.

> >
> > If we often see if a path is an non-empty file in our tests (not
> > limited to t3600), then it may make sense to add a new helper
> > test_path_is_non_empty_file in t/test-lib-functions.sh next to where
> > test_path_is_file and friends are defined.
> >
> 
> Since my project does not deal with `test-lib-functions.sh`, I think I
> should not edit it anyway, but I'd be more than happy to add a new
> member to `test_path_is_*` family.

It is up to you how far you would like to go with this.  If you want
to add the helper, to make further cleanups in t3600, I think that
would be a good thing to do (after double checking that it would be
useful in other test files as well), and should be done in a separate
patch.  Then you can use it in the same patch as using the helpers for
"test -f" etc.

> Thanks
> Rohit
