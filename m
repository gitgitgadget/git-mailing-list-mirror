Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DCE92022D
	for <e@80x24.org>; Fri,  4 Nov 2016 23:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbcKDXe4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 19:34:56 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35724 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbcKDXez (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 19:34:55 -0400
Received: by mail-yw0-f171.google.com with SMTP id i145so5998566ywg.2
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 16:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gEdRl7/rr0d3tEL5VQpOXsmr61UAIOI1rwEj4We0du4=;
        b=a0hRg+7TiFgy9RZTrCHovN9HakU0qtWh3X9GQ5uvYFdwXeb+pKrkdtIjrwq80zt1dy
         S6RM4Z14jIf6QDxClSD+7AneA4OCd9koUNAsbLN356Lw11ZuIMNv8vCa6SjrTEXngROZ
         02j3yTFDkIv1AOVSqL3eZ4god85aOmkKCAHC6xIk5Rws5s/OcYYpWljQapPIupifEC4Z
         oAcRHYlAuqGMssJTD+MhGH6xnY3QiMSUiUls0z1B6yyCUsqHwMSwUi8/aBFORMMGPKRx
         phGpbE/eooWk6Kc4IoNOZSlTx8LVecm9+To7dYgDa+Ueq4ENIW8IDPJfQMdfO2tkU4gj
         R1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gEdRl7/rr0d3tEL5VQpOXsmr61UAIOI1rwEj4We0du4=;
        b=S9qLYvKLHAbqKCWoPWTltYp2BRqxZ14hSE7a11FSvM96nkgJ1ZbVpu+6VLCFAb1glU
         HixbAWJXdvdYAfXjGlIWD4QqkkNSlRmVorI5EOa7RVkZGXNAAm0M+tLAlAU4/4QCvTgj
         WpB52X07BS7TvwHKI9zcbZqzkAO4IC5yvpX/vkUBZSv4bh55pJkl2NXUGklva9pGVucP
         VBXEQ6LKTNNEEHUF7k+W9MFo2+sEflWg2OG32Fz2wrFGmltmB5OEPVVCiX4Kcy+W1R3h
         aWloX5+FaQaoGMFAX3nef/atz6ajK9/vBfnXFb7HOEL/ZsCupiBlO1yLg8A6aP2Iu3yx
         Vt4g==
X-Gm-Message-State: ABUngvcyblZCF+D3Wny2PMkRZnecH3wG0kBo59AK8psq+z+CkHZivaTQm9rx5iI0lzjKyDG3dcAlpDy4rnyd8A==
X-Received: by 10.129.130.193 with SMTP id s184mr5521488ywf.276.1478302494550;
 Fri, 04 Nov 2016 16:34:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Fri, 4 Nov 2016 16:34:34 -0700 (PDT)
In-Reply-To: <20161104194907.3yxu2rkayfyic4dr@sigill.intra.peff.net>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com> <CA+P7+xq0LLFBJRNNvCMQ4QR7XBg9H7NSsifiqOYqr+PUBqYRGQ@mail.gmail.com>
 <20161104194907.3yxu2rkayfyic4dr@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 4 Nov 2016 16:34:34 -0700
Message-ID: <CA+P7+xpwUZscpgzLJYf5vkKKsT6SFkC3TrsyBJXJjGo9cF94nQ@mail.gmail.com>
Subject: Re: Regarding "git log" on "git series" metadata
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 4, 2016 at 12:49 PM, Jeff King <peff@peff.net> wrote:
> I think the main complication is that the reachability rules are used
> during object transfer. So you'd probably want to introduce some
> protocol extension to say "I understand gitrefs", so that when one side
> says "I have sha1 X and its reachable objects", we know whether they are
> including gitrefs there. And likewise receivers with
> transfer.fsckObjects may complain about the new gitref tree mode
> (fortunately a new object type shouldn't be needed).
>
> You might also want fallback rules for storing gitrefs on "old" servers
> (e.g., backfilling gitrefs you need if the server didn't them in the
> initial fetch). But I guess storing any gitrefs on such a server is
> inherently dangerous, because the server might prune them at any time.
>

Is it possible currently for a protocol extension to result in "oh the
server doesn't support this so I'm going to stop pushing"? This would
be a rather hard transition, but it would at least ensure that pushing
to a server which doesn't support gitrefs would fail rather than
silently accept objects and then discard them later? I think this is
the only real transition unless we can make a change that old servers
object to already.

> So perhaps a related question is: how can gitrefs be designed such that
> existing servers reject them (rather than accepting the push and then
> later throwing away half the data). It would be easy to notice in the
> client during a push that we are sending gitrefs to a server which does
> not claim that capability. But it seems more robust if it is the server
> who decides "I will not accept these bogus objects".
>
> I haven't thought all that hard about this. That's just my initial
> thoughts on what sound hard. Tweaking the reachability code doesn't seem
> all that bad; we already know all of the spots that care about
> S_ISGITLINK(). It may even be that some of those spots work out of the
> box (because gitlinks are usually about telling the graph-walking code
> that we _don't_ care about reachability; we do by default for trees and
> blobs).

Right. I'm assuming tree objects don't get checked for invalid mode
already? If they do, we could just change the mode to something
unsupported currently. But... that seems like it might not be the case
because it requires checking every tree object coming in?

I'm not familiar with what sort of checking already exists... Thoughts?

>
> I'd be surprised if all such sites work out of the box, though. Even if
> they see "ah, sha1 X is referenced by tree Y and isn't a gitlink, and
> therefore should be reachable", they need to also note that "X" is a
> commit and recursively walk its objects.
>

They won't all work out of the box, but it shouldn't be much work to
do this part.

> -Peff
