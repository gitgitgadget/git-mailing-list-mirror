Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 206D61F453
	for <e@80x24.org>; Tue,  5 Feb 2019 22:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfBEWAn (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 17:00:43 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:33854 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfBEWAn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 17:00:43 -0500
Received: by mail-ed1-f42.google.com with SMTP id b3so4289531ede.1
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 14:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoJJO3aKjCpY5/CmhBUra4gK5XBTHI/LTZdUhjp79Bw=;
        b=gzXbU0vPW78nBqbdC9Lih9fmZJUolkWDqwMrYn/BqFNuuIJFx46Ao/gWxe8Hq8BMAp
         7RzpWWfh4/pgDbejlf0QbinOIZCIQgBK30pHsJWfTuo/KrXA/NdrghwC2tCK/55+I4VB
         I1qWUuKEirHy3u15hR4xUHPr91XAlRlL9d9b4u8uAMviiQE4Yr6lyfPy3Gm9dSWl8dgL
         ellmpUzJP8u2G+Fd6szQt/0YkfKzGXN87YwfvNQex15l0g/W8F7M97CMNkIgC8xCY88i
         uNp0tGWQ+FtPAsiy5G0P4U5gNB0+lFH6rAR5tAm+cnUoG0u6qyDMKIweRefK1tbGhyk1
         w2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoJJO3aKjCpY5/CmhBUra4gK5XBTHI/LTZdUhjp79Bw=;
        b=ezQ7WhF+MravlckoPsuS11rpH1LTUeoAjBCe+yvCJIA0DbtaN1HcvCdOE2ptl5IS/Z
         TG1BL1PexRF7mGS+S4LptA2AqPDgUUVtF7jR+1DqVbksK9e23MqJ+jzL+ZMSBYLVVNt/
         8WT658slZCJi8H9vMOJj+1tqxA8QBvAONh8B2hilaae2aheNFg87384IQ3e+1J4W3gcQ
         gmy83emqsfz48ydHo5t8Rs15hz9Zj8G6zCDg1vUr4cqz0OMqTWXdf4/7ruUAY2qunKT/
         84w6KT+T0fKWSjNXboitBfxIMUb2YWjo6za+aoGwWzCkCp4itBUMPKfWEDmtF5ehFb1l
         iWSw==
X-Gm-Message-State: AHQUAuYuMJndWn8FFXG0fjEE3uYVmxR9pgIWgbp024iOS0Hr3WlySd3E
        tyatTOsFGh04O+3gTmnbW8bw1eKwWXusJcUJqI8=
X-Google-Smtp-Source: AHgI3IbGZNgGNFF5Sh38u6myj4WZaiVScL+LbVPxDZ+t65viI1/2gjbZeMsvWZHAT2fv32moUVHlhhyNWhIbnkix3mU=
X-Received: by 2002:aa7:db0e:: with SMTP id t14mr5705797eds.292.1549404041388;
 Tue, 05 Feb 2019 14:00:41 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <20190204215251.GB6085@hank.intra.tgummerer.com> <20190205211736.GD6085@hank.intra.tgummerer.com>
In-Reply-To: <20190205211736.GD6085@hank.intra.tgummerer.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 5 Feb 2019 23:00:27 +0100
Message-ID: <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 5, 2019 at 10:17 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> [Dropped Stefan from the Cc list, as his email bounces]
>
> On 02/04, Thomas Gummerer wrote:

> The idea is to add an option to 'git stash push', so it can stash
> merge conflicts, and restore them with 'git stash pop'.  The various
> stages of the files could be represented as commits, and the stash
> commit would be an octopus merge of those commits, so they could be
> re-created later.  The same idea can also be extended to store staged
> vs. unstaged changes, so we can re-create the index state as it was
> before creating the stash.
>
> Thoughts?

I think it would be an interesting GSoC project indeed. I think though
that over the years we have been favoring refactoring projects over
possibly more interesting projects, as the refactoring projects are
usually easier to do step by step and to get code merged step by step
which is encouraging.

In general the refactoring projects are worthwhile to do even if the
project is not finished at the end of the GSoC and if the student
stops contributing after that. In those cases it is often a good idea
to later finish the refactoring either by ourselves or by proposing it
to another GSoC student or Outreachy intern.

With a project that implements a feature, there is a risk, if it's too
complex or too difficult, that the feature will not be finished and
that nothing (or nearly nothing) will have been merged during the
GSoC. There is also the risk that another way to implement the feature
will appear later in the GSoC and all, or nearly all, the work of the
student and mentors will have been mostly wasted. It could also appear
that the use cases the feature was envisioned to be used in, are
better addressed by other improvements or a different workflow.

Another potential issue is that a new feature might be prone to naming
or user interface discussions which could last for a long time or
could not result in clear decisions.

So I think we should be very careful if we propose a project that
implements a new feature to a student. We should at least consider the
above potential issues and see if they can be mitigated before the
project starts.

Thank you anyway for proposing this idea,
Christian.
