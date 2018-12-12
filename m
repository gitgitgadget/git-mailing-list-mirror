Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5E020A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 19:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeLLTbS (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 14:31:18 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38884 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLTbS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 14:31:18 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so8696ede.5
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 11:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYQ1HoXtUBQ14/gbOmWPAMdcCb2uX1GhKb11PGsWa0g=;
        b=HLnqn9Ce/IHqstST1/bVKmrtgPyoY6ZIxYVIA06y0fGcGX5W7nwknPSdW1004IYeBT
         gk+EHBlpkiNgusuMW2jeVzzYjDGvT4/a56FZv6qEkTsCb3l9U97v4SrEfA3tjKN0quBb
         PGiGo0CglR+tMhRqgi1zaQn7++nVydGC8zd1jk9p9aAA7QHDenVJ2t17ycpfGo3XEmcH
         Ix37ZA1oWhklZ+p21T3eXgp1mTfNB05YuWmPUEDwdF4Z50/R7oGC1kgEc1bSWJtUv5w3
         RnCWM1GuFYrId7/hYrdH6Au1AkgXswNIhoqu86rLVbwOkv3PBq+pC37ulGBgV+IuyeLH
         9waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYQ1HoXtUBQ14/gbOmWPAMdcCb2uX1GhKb11PGsWa0g=;
        b=i3CE40yjCzVNOw6xlyrHWxNSUYEVz2JHOu5uUE5XhEezSYuxBjPnv5oL5Ihw0Rm8y+
         Im7LPwqBZIis0UbXKh7Slsq6wnZt2DWfI6CeHkFv0tD8053dwJMvymWQyd9ZDasu1UiM
         y5/4nfLtCdOgmTNiceFOFuV1YpM3t+TO1+OqqyGyUZxPI/992PQFszJ+4pvNNWaq1aX3
         YA2ea1cPXue97YJ6PfnyRPt7J0xsdeZqFt2lEp8hiTsINnw6+xHP3MWHhU+SuwHM3EuA
         PIfoVTDlfO40LYVLgRXyRdXpw5OvT3XK5aa3JE+VDiEfKM51ojEIdj4aiG5/M/C1jCDg
         epfg==
X-Gm-Message-State: AA+aEWbK845zFJLLcBQddlRsGJ8aUx3A+L9Z+xiWFlCUzIMPVkK/BibR
        dRYI/w44N94jtWG3A7viFJ4tAuR48jBjWGrK45Zarx0Yn/CDEQ==
X-Google-Smtp-Source: AFSGD/XtPwi7uS6jNjKZTHUm6ndjpVvWrGm9Ieqer6Ib6Eo3ThzP0BnBftMojgfYY74SWOPYZKNPsv7Ui7uTNInOvkc=
X-Received: by 2002:a50:8fe4:: with SMTP id y91mr19677335edy.231.1544643075955;
 Wed, 12 Dec 2018 11:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20181210224901.GL4633@hopa.kiewit.dartmouth.edu>
 <20181211000859.130266-1-sbeller@google.com> <20181211051032.GQ4633@hopa.kiewit.dartmouth.edu>
In-Reply-To: <20181211051032.GQ4633@hopa.kiewit.dartmouth.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Dec 2018 11:31:04 -0800
Message-ID: <CAGZ79kaka_DTUMkGdSbYW7Vam3XSWcdqxPrzFDXZJSsQC1zHYQ@mail.gmail.com>
Subject: Re: [PATCH] Re: [wishlist] submodule.update config
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> But again, I must confess, that either I forgot or just do not see a
> clear use-case/demand for submodule.update config myself any longer,

ok, let's drop that patch then.

> Probably I need to try "submodules update --merge" to see what is that
> rough edge which makes it different from the potential "merge
> --recurse-submodules", or is it easy to describe? ;-)

I think the branch handling would be the difference. I'd expect
"merge --recurse-submodules" to be sensible about staying on
the branch both in the superproject and submodule, whereas
"submodule update --merge" is too much plumbing, that we'd
expect a sensible branch handling (detached HEAD is just fine,
right?)

The merge result would be the same, I'd think.

>
> I wonder if may be instead of pestering you about this config one, I
> should ask about pointers on how to accomplish "revert
> --recurse-submodules"

What do you want to do in revert --recurse-submodules?
When you have "revert --recurse-submodules $COMMIT",
would that revert all submodule commits introduced in
that commit as well as the regular superproject revert?

This would require either opening multiple editors
(once per submodule and at last for the superproject)
or we'd have to do fancy snip-snapping of the user input,
e.g. providing a template like:

    Revert "$title"

    This reverts commit $COMMIT.

    # The above is for the superproject commit
    # Please enter the commit message  ...
    #
    # Changes to be committed:
    #       ...
    # --8<-- DO NOT DELETE THIS LINE
    # Below is the commit for submodule $submodule:
    Revert $submodule_range

    This reverts commits $maybe_many

    # The above is for the submodule commit
    # Please ...

I guess it may be easier to just have multiple
editors opened sequentially to give a commit
message.

>  or where to poke to make it possible to clone
> recursively from  http://datasets.datalad.org/ where  we do not place
> submodules all under the very top /.git/modules ;-)

Not sure what you mean there?
