Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34081F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 19:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbeKVGER (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 01:04:17 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:45137 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbeKVGER (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 01:04:17 -0500
Received: by mail-io1-f53.google.com with SMTP id w7so4886929iom.12
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 11:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzJ2PR4t22/eOX1QLcqmonZpfZKDN0slt0bQugQQgXQ=;
        b=oPgLFgMF1mLVN2i/WXDRgWyDKdwczLEi8AVzfGYrVI2n6DDp5VDOtp0Q95h0kkQwme
         y/Wf5XYRLzWHAd1/FEqNxfyBeO4nGg0T+gpxXTqZU6Jb6PWwLba8SAO61/bWl+RCpsuK
         kybt0TICEKIGifdhv7kx9k0t9u7skTQXUtAQknxIVtdVoihdJfqhBD7JWD4s+iEeH9bp
         KXlv3hw8ctaCq2ntDraeQafKpwN0HTxwFPsIoC8hmX5PcdITdxl5a+4qUdmNhL9pFZ8s
         CLxAlOM8BVUNjByKRWI02UYF/NZRFccF/l99Qd3LwnofwjGCPrbpMHF4Z6EOkp+M1Zsh
         e5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzJ2PR4t22/eOX1QLcqmonZpfZKDN0slt0bQugQQgXQ=;
        b=VdB8FvUoeLViNuEhPl11Nua2PCSIiN47iI5tsWa/eantHL/MPD1/6zJw+pTs3U8I4v
         21YfzO2pGsy8LtQeFYiP0vtdyGsSw6rgjW+d33nqZcyP7MVedd/YrE8DauLGi30cdxCN
         4tTGKe/CWBsSSg6cZNmLzIEsPIZU58N+Cw2HFXYmGGHcm9L35UYLS+bpb+u4hRfLw/Sk
         DcXXjVO3BqJ66BOo8xJAc+XeuIeTCWxlwB/CWWqr8VIqELEUd8IunwfYqyal5kzZM7ii
         RS/6/Q3pYHmHarjuPnclxc9fYmR+3ZJlnSXGlIVSLxq59TPhRHZznBdHIRvEMUWgsArT
         Nzzg==
X-Gm-Message-State: AA+aEWbDENxn0f6/+Sf7/RSiyH719pyMFNurDJ06Xqne0Y+QM2yujWSj
        jq8bMIZ3Na84QcUbYwpEcfg2xBQy6uiHaQdNhudQew==
X-Google-Smtp-Source: AFSGD/UXBuftKvvUDLg79/qjrj7EGie22nguGdtlZwdGbvCVUNefBWLknppZyRiKqOka1XNRrlKOVJv2fVSKQcnnYq8=
X-Received: by 2002:a5e:870e:: with SMTP id y14mr5839576ioj.253.1542828519877;
 Wed, 21 Nov 2018 11:28:39 -0800 (PST)
MIME-Version: 1.0
References: <xmqqh8gefowy.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1811202152290.41@tvgsbejvaqbjf.bet>
 <CAGyf7-FALWBEfcu4OOsrQEKZJ=ub0=exM_f-Y7=avPqiwOeH7Q@mail.gmail.com> <20181121142026.GA10324@sigill.intra.peff.net>
In-Reply-To: <20181121142026.GA10324@sigill.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 21 Nov 2018 11:28:28 -0800
Message-ID: <CAGyf7-FDZxCTfXV_HwHRS3PiWnLR08F5B=whxAizOsjJFUCi+g@mail.gmail.com>
Subject: Re: Git for Windows v2.20.0-rc0, was Re: [ANNOUNCE] Git v2.20.0-rc0
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        git-for-windows@googlegroups.com, git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 6:20 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Nov 20, 2018 at 03:17:07PM -0800, Bryan Turner wrote:
>
> > I've run 2.20.0-rc0 through the test matrix for Bitbucket Server on
> > both Linux and Windows, and the only failures were related to this
> > change:
> >
> > * "git branch -l <foo>" used to be a way to ask a reflog to be
> >    created while creating a new branch, but that is no longer the
> >    case.  It is a short-hand for "git branch --list <foo>" now.
> >
> > Since this is an intentional change I suspect there's nothing to do
> > for it but patch Bitbucket Server and move on, but I'll confess it's a
> > little frustrating that the option was deprecated in 2.19 and then
> > immediately removed in the next minor release. Such a
> > backwards-incompatible change seems far more apt for a major release,
> > a perspective that's reinforced by having the change follow such a
> > brief deprecation period--2.19.0 was only tagged September 10th (in my
> > timezone), so it's been less than 3 months. (Looking at the git branch
> > documentation for 2.18.0 [1] shows nothing about this deprecation; the
> > messaging first appears in 2.19.0 [2]. To be honest, I didn't even
> > realize it was deprecated until now, when it's gone--our test suite is
> > automated, so the deprecation warning was not visible.)
>
> We did go a bit faster than usual, under the assumption that nobody's
> really using "-l". It has been the default since 2006.
>
> Can you tell us a little more about your invocation?

Our invocation is... A little difficult to nail down, if I'm honest.
Bitbucket Server code does not use "git branch -l" anywhere in its
_shipping_ code, only in its _test_ code.

But that test code exists because Bitbucket Server provides a Java API
[1][2] which allows third-party developers to easily build arbitrary
Git commands to invoke for their own functionality. Setting
`GitBranchCreateBuilder.reflog(true)` will trigger adding "-l" to the
assembled "git branch" command. I've changed the code now so that it
will use "--create-reflog" instead; however, because many of the
Bitbucket Server add-ons on Marketplace [3], whether free or paid, are
not open source, and because there are a significant number of
in-house plugins that are not listed there, it's difficult to know how
many might be affected. If I were to hazard a guess it would be
_none_, but I've been surprised before. The end result is that the net
impact is hard to predict--especially because Git on the server would
need to be upgraded to 2.20.

(In case you're curious why we used shorthand options, it's because of
our Windows support. While "git branch" commands rarely, if ever, get
very long, as a general rule we use shorthand options where they exist
to keep our command lines shorter, to allow passing more options
without hitting the hard limit (generally 32K) imposed by
Windows--something we _have_ had issues with on other commands. For
commands like "git diff", where it's not possible to pass in paths via
stdin, every character matters.)

To try and protect against the unexpected, we have a Supported
Platforms [4] page which lists Git versions that we've _explicitly
tested_ with Bitbucket Server. 2.20 won't be marked tested until a
future release, so the majority of installs will not use it with older
versions of the system--but there's always that subset who ignore the
documentation. (Since we do text parsing on Git output, subtle
breakages do happen from time to time.)

I would say it's _unlikely_ that we'll hear of any installations where
all the conditions are met for this to come up:
- Git 2.20
- Bitbucket Server (without fixes)
- Third-party add-on using `reflog(true)`

It's really just that a) I was caught off guard by the change (my own
fault for not reading the 2.19 announcement more carefully) and b)
it's impossible for me to say with _certainty_ that it won't be an
issue. I'd imagine that latter point is true of the change in general,
though (it's not really possible to know what scripts it might break,
and that's going to be true regardless of when the change actually
gets released), and I'd agree that that shouldn't hold Git back from
making useful improvements.

Thanks for your time!

Bryan

[1] https://docs.atlassian.com/bitbucket-server/javadoc/5.16.0/git-api/reference/com/atlassian/bitbucket/scm/git/command/GitScmCommandBuilder.html
[2] https://docs.atlassian.com/bitbucket-server/javadoc/5.16.0/git-api/reference/com/atlassian/bitbucket/scm/git/command/branch/GitBranchCreateBuilder.html
[3] https://marketplace.atlassian.com/addons/app/bitbucket
[4] https://confluence.atlassian.com/bitbucketserver/supported-platforms-776640981.html#Supportedplatforms-dvcsDVCS

>
> We still have time to avoid the change for this release. And this early
> testing of master and release candidates is wonderful exactly to get
> this kind of feedback before it's too late.
>
> -Peff
