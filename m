Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E108E20248
	for <e@80x24.org>; Fri,  5 Apr 2019 10:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfDEKXv (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 06:23:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34996 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfDEKXv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 06:23:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so2815676plp.2
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fxlB+8y3RWuMVqMshZsswE/m0nInTPKgXJKW3fOIWgA=;
        b=pjhfdOz6ljvz3RgOfvd2i7n5ou9Gh/hqoKSLzzFIVjgr0TrtwqfOEM8AEUQkhBkuf6
         REVLqxDxTZaK2OL08TqlQTN1WqPK/tcvJvx9Ge29rGCrknebDZdhLqS13MXKikxNcm7I
         gxgdhunsLZEyK8BFkP9HEVO+rhRousKjBJoQM8GLJNm1mKSL45tq1ih9KLc5hglOl/Aw
         50J6I+ElGI1Jq6mx9K7Gk5sA6SM7n+8vMFoAaU9MlTFgItvQN4bIF6WLjpsZbmOkBlW4
         RFMaZyNc2itMHK4v2imhXMSYq0HyHF+JSYyYqW8egobnYnRaTyGAZi5OVQe9pVI0zOx3
         uUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fxlB+8y3RWuMVqMshZsswE/m0nInTPKgXJKW3fOIWgA=;
        b=OTRqKg6CADbiGvnw0cImTPxkCABwWwv7xsQmcwvSV2BJ9RHlOWaYIS9tR7JyczVP70
         HawfidUnj5DIfNqOGHynKoHZz4D4/esx0rehbDw3PQM+z/kTSi7dFSF1kBcyPnCe9R8h
         S4P4dI+AjvNgr0FgY+fJzJi5hWtvoRpcKvNNui5hWmcEvOrejsN9DbU5rd7nlAiv6INa
         tyK//m3cNkycRDIV0aQOpPddDSWc1DKXsjZIL0ZJzZvco34xDCXGQ2XMV6dg5n++JI6E
         ONpat1zbf/k/FGkisXYB41J3P+5e/ERitgcIagnGGaC9T30C94qPX0/rGvtIC8jOHm2x
         FF3g==
X-Gm-Message-State: APjAAAW8gUohWL13GwLq/P3vEnilEXI1LsioSqZAROOm0rCjz9HfV+N5
        OWMn67G1dTUiUTPTY9F3nryf1iNxqO2zCtBCwJw=
X-Google-Smtp-Source: APXvYqzHWPr+Yh5JTbMKTBCO7HnF9gNpraCMJq9lZ/Pb5VXBchjh0M8Mh9hXaZI/rlUozeZvmk6sWUwXfkqo2anMHoU=
X-Received: by 2002:a17:902:e407:: with SMTP id ci7mr11930109plb.219.1554459830641;
 Fri, 05 Apr 2019 03:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190330183001.16624-1-tmz@pobox.com> <CAN0heSpB_0Hi2zCA+gmiaARpSYM7fKayB2rs6wFi_VeXevqd+Q@mail.gmail.com>
 <20190405014040.GR4047@pobox.com>
In-Reply-To: <20190405014040.GR4047@pobox.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 5 Apr 2019 12:23:36 +0200
Message-ID: <CAN0heSrbjRExHwch0K_W+xwpERnFUJmaiHhCkAaK9nnxFnXEhw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] minor asciidoc/tor formatting fixes
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Todd,

On Fri, 5 Apr 2019 at 03:40, Todd Zullinger <tmz@pobox.com> wrote:

> > On Sat, 30 Mar 2019 at 19:30, Todd Zullinger <tmz@pobox.com> wrote:
> >>
> >> Just chipping away at the remaining differences between asciidoc and
> >> asciidoctor.
> >>
> >> Todd Zullinger (2):
> >>   Documentation/rev-list-options: wrap --date=<format> block with "--"
> >>   Documentation/git-status: fix titles in porcelain v2 section

> There are two other changes I've got queued locally.  One in
> git-show-branch.txt removes the last use of {apostrophe}.
> Another in git-svn.txt is a bit of a work-around for a
> difference in the way asciidoc and asciidoctor parse the
> second paragraph in the CONFIGURATION section.  That may
> well be an asiidoctor bug, but it seems like one we can
> adjust for without much effort.

The second one looks like it can be fixed by using `*` instead of '\*',
which I think is more correct anyway. I don't know what your local
workaround looks like, but I think a patch like "use backticks
consistently" (both change to them, in a number of places, and add them,
where we currently have nothing) would be a good change by itself, and
we could note that "BTW, this fixes ...". How does that compare to what
you have?

Martin
