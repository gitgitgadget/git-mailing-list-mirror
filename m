Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF5281FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 16:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbcF3QRe (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 12:17:34 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:36877 "EHLO
	mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbcF3QRc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 12:17:32 -0400
Received: by mail-it0-f50.google.com with SMTP id f6so73624148ith.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 09:16:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x+nKf9HMdIZjDqDQBRqOKJNKXT1xpbuepMe33TL7u/E=;
        b=doZ0Gx82RC7egVxD7ieNj+tDUcpsOKFxgN3SDFV65JxIbIOB2rHKK9cR6DrVOhImVY
         E1R8Wla7gEw0WF5rJL76aMtMfbxJRokSUK7+zSMXc8KaNPQl/mcNONc6/0qw6s6yaLaN
         TON/7cj/k5/75QCY1PNwawC9MwCYOeJ460CCyN6RvONK+Mj2CyjSHWFbpRT3dcDuvEnh
         2YQKTqymNrxlFchTkpIZRlHBZLiujdZZhksA1wCuoU3wxAcRq4yhtVE6RfcJINO+pS1n
         uCR6IGy/8REcsS6xQ/cn3DoTAqjAH6hevAyIczc/CAd4BD7V9OwSJHYqug0U2HK96tZ7
         Vdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x+nKf9HMdIZjDqDQBRqOKJNKXT1xpbuepMe33TL7u/E=;
        b=mz0IgMu+uK6g87TwhQo4kaIvfM+SZyGuJvTrLN4rXIS3cD1Go+nm7g78Py8SugeTG4
         5SpMl2P1YQcaTaO6BPGsJFSVeek7MAWxIuPnhmd+mWPUufxAC2p9FmRafWbfHxRMKsUP
         XqetwUTaoM22yWvXq6a0RVZ6GgiOUOer1NxI0WYG0qQyx8vrZ829TaG6Rr7UYOMXq1a/
         0Aa+Z2f3EqSCC5MOagJMcMwPjT8wWKP9iLpNnMlXngjBdxVyrbjRuOTRdvhUlWfdEOPZ
         kiVT1II7DJ2+NKhfFUuG71+hr8TPhPac1yx6pj7ni0HYJCdXFs5fUQXAUvXEdxtbeu2G
         ptMw==
X-Gm-Message-State: ALyK8tKiJXKCNjHZDS7v99094TRXh4PXyFiX+fN8FCPS6lb/lyQUqUZV3NCNqOz7UHGAGPLO4SrCDQf3PUfepg==
X-Received: by 10.36.33.22 with SMTP id e22mr11754998ita.42.1467303399183;
 Thu, 30 Jun 2016 09:16:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Thu, 30 Jun 2016 09:16:09 -0700 (PDT)
In-Reply-To: <20160627184354.GA9594@sigill.intra.peff.net>
References: <20160605031141.23513-1-pclouds@gmail.com> <20160626055810.26960-1-pclouds@gmail.com>
 <20160627184354.GA9594@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 30 Jun 2016 18:16:09 +0200
Message-ID: <CACsJy8DS3n=7sRGztqe16igrsVaKt3Qa-GRVJBMoZvtEJmdmQA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Better ref summary alignment in "git fetch"
To:	Jeff King <peff@peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 8:43 PM, Jeff King <peff@peff.net> wrote:
> I tried it on my most-horrible example case, and the results were...just
> OK. Because the variable-length part of each line comes first, the
> alignment code means that the "origin/$" bit of every line gets bumped
> out. And if you have a single large branch name, then everybody gets
> bumped out very far, even to the point of wrapping. E.g., I get
> something like (with fetch.output=compact, obviously):
>
>   From ...
>    * [new branch]      branch1                      -> origin/$
>    * [new branch]      branch2                      -> origin/$
>    * [new branch]      some-really-long-branch-name -> origin/$
>    + 1234abc..5678def  branch3                      -> origin/$ (forced
>     update)
>    * [new branch]      branch4                      -> origin/$
>
> I've shrunk it a bit to fit in the email; my actual "long" name was much
> larger. And the average length for the shorter ones is, too, but the
> overall effect is the same; almost every line has a huge run of
> whitespace. And some lines wrap that would not have even under the
> normal, duplicated scheme.

I was about to resend with s/\$/*/g and ignored this issue (with a
note) then it occurred to me we can simply ignore these long lines
from column width calculation. Yeah such a line may still be wrapped
around, but it will not push every other line to the far right. We
already have code for that in adjust_refcol_width()

        max    = term_columns();
        ...
        /*
        * rough estimation to see if the output line is too long and
        * should not be counted (we can't do precise calculation
        * anyway because we don't know if the error explanation part
        * will be printed in update_local_ref)
        */
        if (21 /* flag and summary */ + rlen + 4 /* -> */ + llen >= max)
                return;
        ...

we can limit max to, like, term_columns() / 2 (or 2/3 of
term_columns). There's no perfect number, some people will still find
the output ugly _often_. But hopefully the majority won't. What do you
think?
-- 
Duy
