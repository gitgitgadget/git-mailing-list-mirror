Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18C31F453
	for <e@80x24.org>; Wed, 30 Jan 2019 12:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfA3MaD (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 07:30:03 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:34878 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3MaD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 07:30:03 -0500
Received: by mail-qt1-f175.google.com with SMTP id v11so25991314qtc.2
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 04:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ansUl5O4WEoARKG94dSzgB8uXzTy/as5++xcOlx5FKk=;
        b=G+Rt/+SBJwR1w0k8LDXQ2MSUvIRM/PlBWaVXaSc5rcfC3wuAqTyeqiUz/qBWAgDrVD
         YIL6z4OqnchLvG+Y8U+/I/K3ZCLF2XgnjySQL3MBHny40rcgAvPsB8TeXLW8jCDGKTXr
         c5NCKrpyulRrwBt1xUhGuaBcwAVcSgfi9VAJ37TRUeTmti6TUs6AZN3nE6y7ydxBUEZX
         MA548NttlhH9GdcfqEsP0tVQdP31pR9Yr1YtR2zyBxvPQ7Y8zRuo3VcVZBtFts1dBTXK
         O9t9YssFp6TWPLW/UtpzTWmDGf3IjamWJtbrn7cUNqAI7gvsnosQSBArDJE7D5ZZ10MK
         VAHQ==
X-Gm-Message-State: AJcUukfEhvDVxoaqmnDnzn9kcnRy14mwlPt5iwOOZRsxenPa/LSfBk/H
        jrzA851oqjtMY8Ov9jXz5og5HepEExipPDhoQMw=
X-Google-Smtp-Source: ALg8bN73ToH5M99xSb+CizfsxNy3vHhj6DVEPATXzhzWhbXLAR0FbMVaFomdIPJaEHeUI8lrYpCQwbHnA+4TshMcB8U=
X-Received: by 2002:ac8:90c:: with SMTP id t12mr29175931qth.335.1548851402620;
 Wed, 30 Jan 2019 04:30:02 -0800 (PST)
MIME-Version: 1.0
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-2-jeremyhu@apple.com>
 <CAPig+cSkm-M7fP=KLOCO5J8OSYCEyjy950AM=VzTnP9C6AcKxw@mail.gmail.com> <534F20EC-2B29-46C3-BAD9-3CBE7312257F@apple.com>
In-Reply-To: <534F20EC-2B29-46C3-BAD9-3CBE7312257F@apple.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 Jan 2019 07:29:51 -0500
Message-ID: <CAPig+cSwMpTY0StCYBaF+oreZebyOUqFRqj1ABukHkdLY9PyEw@mail.gmail.com>
Subject: Re: [PATCH (Apple Git) 01/13] .gitignore: Remove *.s as it matches
 *.S on case insensitive filesystem
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 6:37 AM Jeremy Huddleston Sequoia
<jeremyhu@apple.com> wrote:
> > On Jan 30, 2019, at 03:33, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Tue, Jan 29, 2019 at 3:11 PM Jeremy Huddleston Sequoia
> > <jeremyhu@apple.com> wrote:
> >> This was causing problems with ppc/sha1ppc.S
> >
> > What problems, exactly?
>
> The file is ignored, but it shouldn't be.

But what problem are you experiencing, exactly? .gitignore rules do
not impact tracked files such as ppc/sha1ppc.S, even if the name
matches an ignore-rule, so it's not clear what problem you're trying
to solve.
