Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56E8B207D2
	for <e@80x24.org>; Tue, 27 Jun 2017 03:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbdF0DMi (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 23:12:38 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36385 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdF0DMg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 23:12:36 -0400
Received: by mail-pf0-f179.google.com with SMTP id q86so9404967pfl.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 20:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zmIlVTZRYIO1wtaAWQZWY+VYHcAkXUvGAKVeY2hpVm4=;
        b=E0COAzf3hlEOqNQ9aX5I0ifunMx9BTMOdfHCw2ohJZcQhQVYhOzR5JNvW/eJ61mOpW
         Qp2onwU6l6egHHXmD1je9VijJp2+hvfXY2I+tiZO5vXY16aNzce7qb+Q7DTH+Pd7RT04
         6Ql9DOpeGvlAQJOnP6P3gs5GW15QeqMUiv6d1NqM/kve4wsuj4Xc4Nj3XIGzVBZtq1GU
         5uIkR6+5A6M/cFNF7DYXg2ghp0KSd4BNe11DYvl3CDmVxiNmiGfp4g+LzV7mUjzYUltG
         TkGXKepKXUP44x59Vf3mI2mb+qT3A8pVhjul4PEFmq4gCjUt2FnCnbbeke14n0mAV8dR
         prEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zmIlVTZRYIO1wtaAWQZWY+VYHcAkXUvGAKVeY2hpVm4=;
        b=uE96+RfQQa0J7zGd8x0r4P7U6ppds1fBmHkdRS9xAe+MwBiqA2ViFHUFm9AjlpDdRW
         ajVn+vOyGFuX3sZrFEDlUK5eLuIr4pVhjGo1e1JbtT/nhYT7MnJKYNkB+PE4xUAyyExg
         HgbesPQpQ1NCQvKM/DkdmpmILIMqPWHrMxwqPh9/TJcWHeT3asNBEVv3Xr+PwPLZt3K4
         UetEuwIbhv1GRrpbMuNbJkiYi5Ku4dTWNZyVrGEppnH2Fpi38CsNqZPxeDYz8uJmwAs8
         peHUicRTbIwjJtRL5WMF8LBTadqsbMD5iT2n3IoE49OaMYwgLWsRiUQ0V1LUz5GJg1fg
         m4zg==
X-Gm-Message-State: AKS2vOzS/KMGjAg9Zl32RQK+y8o0eIByTEe1qeu8jxpOhRKr7Dao7xRQ
        bMtlqdfnsWPYjV9LA9eNMoEDdfoT9B4r
X-Received: by 10.98.69.76 with SMTP id s73mr3112011pfa.94.1498533155245; Mon,
 26 Jun 2017 20:12:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Mon, 26 Jun 2017 20:12:34 -0700 (PDT)
In-Reply-To: <20170624011018.lvw3rm6x6or7wt4s@sigill.intra.peff.net>
References: <20170623201020.24zus6tsnf2i62d3@sigill.intra.peff.net>
 <CAGZ79kbKB0hWOHCWsa0k1z=QXeRC2Ab1sSOeQ7pApB7+o6mdFw@mail.gmail.com> <20170624011018.lvw3rm6x6or7wt4s@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Jun 2017 20:12:34 -0700
Message-ID: <CAGZ79kabSPr8aOwCwOeU4QWCkP2fmGibhdGRjR050U1GQyqtGQ@mail.gmail.com>
Subject: Re: --color-moved feedback, was Re: [PATCH v2 19/29] packed-backend:
 new module for handling packed references
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 6:10 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 23, 2017 at 01:23:52PM -0700, Stefan Beller wrote:
>
>> > In the end, I just did --color-moved=plain,  ...
>> > "yep, this is all a giant moved chunk, so I don't have to look carefully
>> > at it".
>>
>> This is dangerous, as "plain" does not care about permutations.
>> See the 7f5af90798 (diff.c: color moved lines differently, 2017-06-19)
>> for details. You would want at least "zebra", which would show you
>> permutations.
>
> Ah, I see. I think what I'd really want is some way of correlating two
> particular hunks. That's hard to do with color, though. I guess that's
> the "you would need a ton of colors" discussion I saw going on before?

Yes. And the real question is "how many". ;)
and if you want to optimize for the fewest number of colors, or rather
"best user experience as defined by me", or something else entirely
different.

>
> It would depend on how many hunks there are, and how close together they
> are. For instance, your 6cd5757c8 seems like a good candidate, but I
> have to admit with --color-moved=zebra I have no idea what's going on.
> Some things are definitely colored, but I'm not sure what corresponds to
> what.

That is a good one indeed. My take on that:
If you use "zebra" alone, you do not care if it is cyan or yellow.
*Both* indicate a moved new line, and adjacent lines of the same color
indicate that they were adjacent at the source as well.

for reference http://i.imgur.com/hQXNlga.png

Look at the two lines of the first cyan->yellow transient
(closing the function prepare_submodule_repo_env_no_git_dir)

What it tells you is this:

  There is no matching paragraph in the deleted lines, that also
  end with two braces.

The yellow->cyan transit (prepare_submodule_repo_env) tells us:

  We did not have a empty line and then that function signature
  in the deleted lines, so we flipflop to the other color to tell the user.


>
>> > That feels more dangerous to me, just because the heuristics seem to
>> > find a lot of "moves" of repeated code. Imagine a simple patch like
>> > "switch return 0 to return -1". If the code you're touching went away,
>> > there's a very good chance that another "return 0" popped up somewhere
>> > else in the code base. A conflict is what you want there; silently
>> > changing some other site would be not only wrong, but quite subtle and
>> > hard to find.
>>
>> I agree, that is the danger, but the scale of danger is the size of the moved
>> chunk. A file is usually a very large chunk, such that it is obviously a good
>> idea to fix that. Maybe we'd introduce a threshold, that the fix must not be in
>> range of the block boundaries of say 3 lines.
>> (Then the moved block must be at least 7 lines of code such that a one liner
>> fix in the middle would kick in)
>
> Yes, I'd agree it's really a continuum from "one line" to "whole file".
> I think right now the --color-moved stuff is too close to the former to
> be safe, but pushing it farther towards the middle would remedy that.

Yup, I agree on that. I just wanted to state the principle that this would be
"move detection done right", because "file boundaries" are rather arbitrary
w.r.t to the very valuable content that we deal with. ;)

Thanks,
Stefan

>
> -Peff
