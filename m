Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B64B31F461
	for <e@80x24.org>; Thu,  5 Sep 2019 19:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389036AbfIET23 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 15:28:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44641 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731527AbfIET22 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 15:28:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id k1so1783671pls.11
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=kJFGc/GoZeBeQvythHqTRkNekJ354f6VPeMGYmwQxs8=;
        b=PIz5QrfVHIra7u9eXwR1mQieVkO0yQcYIIrR6cUi58KImC0G7uWb1D2GjkM87UnrYs
         btwcnpxYD6f/unOakQoWrCsB5wuKYLBpgo7noNZpwfmNXfbhq0XJrKtNlWFxf7FUy/hV
         gfzbGlFZOHFm16IwOHfjpbxPLpfKxK6GwfBACXrioqUMlkTla4QJdhPi0lhPncPPq8bX
         HvOVW4f3lk7s2lo98pb4OMMBV1Jlwc5cOHrAPlGfL4tDXilFpVUgoY3vuWLgntLYuMMh
         RX3DSPCh65+VSptzbMYKsECPGXpUZ1G6+2XFool1Qx460ZXl/qkhHJcX6tLv39xZM3Ul
         8KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=kJFGc/GoZeBeQvythHqTRkNekJ354f6VPeMGYmwQxs8=;
        b=lHn0Tvisq1drsVGJ67SdhZ6yQVhUgATgLrs7bOENoxxzEQ5rMJf96KjbczPcSgereF
         v3VV9famod9w1Jqa467PonEk89EwdkE80PYSWcM7cxQCnNmR3kaOO/ufreTf6gA9912T
         bKo9/uQJntE5O80kj2Y35bprcwVbbkCW+LIuquG8C8LzHda/HHCehQ6cFqr4klaPviJi
         iJNuUPL+2ze6iUKDYmx4TzVC/+LUwYYvx9BFF/HPFMC6B9sj3x8snhv6i4f3MBuFD9ZG
         ZthJMpfPPV/W+fDfqG2OTS2CvcudaLRr8LF/h0h8t8bGFTfIPe/UnNyuFOnp/4ddQc1S
         NWvw==
X-Gm-Message-State: APjAAAWq0kIZsUT32Phabc6tS6SCcytkxztLcrUwoS6arN+vaPHXcXHs
        Ag6eHo4IyN6D99aQPx3SkslZbsOBbsVz/MOAnfw=
X-Google-Smtp-Source: APXvYqzTxc216ri19R4s3bzNN4Vkyq6icctkdFsFK8/njA7vl6qPXW24iTTbpGNK9NuQUkjTWcnAMcrqFNI22dysSFA=
X-Received: by 2002:a17:902:b60d:: with SMTP id b13mr1528441pls.197.1567711708014;
 Thu, 05 Sep 2019 12:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAN0heSr2zCQMM6wOM0UnD28qj_VygQ5CQHGHhMR9+H23snpt5Q@mail.gmail.com>
 <cover.1567534373.git.martin.agren@gmail.com> <20190903231610.GI11334@genre.crustytoothpaste.net>
In-Reply-To: <20190903231610.GI11334@genre.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 5 Sep 2019 21:28:16 +0200
Message-ID: <CAN0heSrQAHtjJa88utUNEqBsX-gwjp7nWA_QskDDQ8FawD8mag@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] asciidoctor-extensions: provide `<refmiscinfo/>`
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 4 Sep 2019 at 01:16, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> I looked at this series and it seems sane.  I agree that adding a
> dependency on nokogiri isn't really desirable.  It is an extremely
> common Ruby package, but it has native extensions, which causes problems
> for some people if their distro doesn't support it.

Ok, nice to know I wasn't too far off with avoiding the added
dependency. I saw statements like "oh, it's available everywhere", but
also more nuanced ones like "not necessarily...". I'm glad I have a
trustworthy source now. ;-)

Martin
