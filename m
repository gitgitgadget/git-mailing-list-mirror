Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C7971FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 17:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754818AbdDLReJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 13:34:09 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34843 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754887AbdDLReH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 13:34:07 -0400
Received: by mail-io0-f169.google.com with SMTP id r16so48453365ioi.2
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gUy9vL5+0gSI8zhH8Q3N2agZ2C8AGq9Ese8XMyDDK8A=;
        b=atsXVLayX0UJ7boJeLfawCOJnWWkw4+nwsDEb8pX8V8nYxr0CRZIyNS/v78y+UiXlJ
         A12H7mmMbP4iX8TMsmFpc2pOC4fRanuDOZXnsZBd7Lf9/R5RmYa3y6TwBhfeYRlGsHNR
         SrADllSE9A4hNOS6oI+0pR809wLHLW+ObjbGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gUy9vL5+0gSI8zhH8Q3N2agZ2C8AGq9Ese8XMyDDK8A=;
        b=o88JEjnsXzdVCQQWL64puPf7Lsy3V3WLwi6q7To2Ev+t0flImq0steazOZyiTjepd0
         37y7s3cZtaVTubXO+rHaEbGnZDeuwaY3Wztb5s7u5zAtCLqNYe8K9J9uFAoqO/rhysLO
         m7i6sxUxYd6TIWerQLaZaTj7Pqo9aaMsIU8sCuKLlPi6gBibod2Ltuc4XEHSXEJQt8Dv
         /cZmq7eHFb995sGvEtP1ssH+zLLomft2zkWp9jUJfwdeI3AEpiweghAIpfGQkDRvqeSE
         FLNapCS8YLnZk3xl2+jk8h5Ts819s32oRm3x37ukHT3zgOdBWXNxZb4ufuZtwpx3t0Yl
         DiAA==
X-Gm-Message-State: AN3rC/44+RHn1vO/GgBm3KmT35DMSIhmohRbUT4t6ZjF5Tt4ma+U6Wjc
        //Xp7yVX2tKWUGh2
X-Received: by 10.36.117.5 with SMTP id y5mr12705676itc.19.1492018446079;
        Wed, 12 Apr 2017 10:34:06 -0700 (PDT)
Received: from localhost ([2601:401:c500:7dd8:212c:7f4d:6af3:f7a7])
        by smtp.gmail.com with ESMTPSA id j193sm9730775ioe.59.2017.04.12.10.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Apr 2017 10:34:05 -0700 (PDT)
Date:   Wed, 12 Apr 2017 13:34:04 -0400
From:   Taylor Blau <ttaylorr@github.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net, e@80x24.org
Subject: Re: [PATCH v3 4/4] convert: add "status=delayed" to filter process
 protocol
Message-ID: <20170412173404.GA49694@Ida>
References: <20170409191107.20547-1-larsxschneider@gmail.com>
 <20170409191107.20547-5-larsxschneider@gmail.com>
 <a7fd3bef-49b2-0b0a-8ca4-89e41a402661@web.de>
 <388C3F2A-AC77-499F-9C74-216F5DC00FD8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <388C3F2A-AC77-499F-9C74-216F5DC00FD8@gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > (And at this point, may I suggest to change "delay-id" into "request-id=1" ?
>
> If there is no objection by another reviewer then I am happy to change it.

I think "delay-id" may be more illustrative of what's occurring in this request.
That being said, my preference would be that we remove the
"delay-id"/"request-id" entirely from the protocol, and make Git responsible for
handling the path lookup by a hashmap.

Is the concern that a hashmap covering all entries in a large checkout would be
too large to keep in memory? If so, keeping an opaque ID as a part of the
protocol is something I would not object to.

> >> +packet:          git> 0000
> >> +packet:          git> 0000  # empty content!
> >> +packet:          git< status=success
> >> +packet:          git< 0000
> >> +packet:          git< SMUDGED_CONTENT
> >> +packet:          git< 0000
> >> +packet:          git< 0000
> >
> > OK, good.
> >
> > The quest is: what happens next ?
> >
> > 2 things, kind of in parallel, but we need to prioritize and serialize:
> > - Send the next blob
> > - Fetch ready blobs
> > - And of course: ask for more ready blobs.
> > (it looks as if Peff and Jakub had useful comments already,
> >  so I can stop here?)
>
> I would like to keep the mechanism as follows:
>
> 1. sends all blobs to the filter
> 2. fetch blobs until we are done
>
> @Taylor: Do you think that would be OK for LFS?

I think that this would be fine for LFS and filters of this kind in general. For
LFS in particular, my initial inclination would be to have the protocol open
support writing blob data back to Git at anytime during the checkout process,
not just after all blobs have been sent to the filter.

That being said, I don't think this holds up in practice. The blobs are too big
to fit in memory anyway, and will just end up getting written to LFS's object
cache in .git/lfs/objects.

Since they're already in there, all we would have to do is keep the list of
`readyIds map[int]*os.File` in memory (or even map int -> LFS OID, and open the
file later), and then `io.Copy()` from the open file back to Git.

This makes me think of adding another capability to the protocol, which would
just be exchanging paths on disk in `/tmp` or any other directory so that we
wouldn't have to stream content over the pipe. Instead of responding with

    packet:          git< status=success
    packet:          git< 0000
    packet:          git< SMUDGED_CONTENT
    packet:          git< 0000
    packet:          git< 0000

We could respond with:

    packet:          git< status=success
    packet:          git< 0000
    packet:          git< /path/to/contents.dat # <-
    packet:          git< 0000
    packet:          git< 0000

Git would then be responsible for opening that file on disk (the filter would
guarantee that to be possible), and then copying its contents into the working
tree.

I think that's a topic for later discussion, though :-).

> > In general, Git should not have a unlimited number of blobs outstanding,
> > as memory constraints may apply.
> > There may be a config variable for the number of outstanding blobs,
> > (similar to the window size in other protocols) and a variable
> > for the number of "send bytes in outstanding blobs"
> > (similar to window size (again!) in e.g TCP)
> >
> > The number of outstanding blobs is may be less important, and it is more
> > important to monitor the number of bytes we keep in memory in some way.
> >
> > Something like "we set a limit to 500K of out standng data", once we are
> > above the limit, don't send any new blobs.
>
> I don't expect the filter to keep everything in memory. If there is no memory
> anymore then I expect the filter to spool to disk. This keeps the protocol simple.
> If this turns out to be not sufficient then we could improve that later, too.

Agree.


--
Thanks,
Taylor Blau
