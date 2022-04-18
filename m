Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A40C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 10:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbiDRKWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 06:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiDRKWn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 06:22:43 -0400
Received: from mail.eskimo.com (mail.eskimo.com [204.122.16.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B4660D7
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 03:20:03 -0700 (PDT)
Received: from eskimo.com (debian.eskimo.com [204.122.16.15])
        by mail.eskimo.com (Postfix) with SMTP id DBB45504DC1;
        Mon, 18 Apr 2022 03:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eskimo.com;
        s=default; t=1650277202;
        bh=ap3jJITpFoNgPSw2nUWV4+3oMRKCvhmcbEvA0GLmr2Q=;
        h=From:Date:To:Subject:In-Reply-To:References:From;
        b=jZG7mVJnUziAIdSEmD3WogQSWhzSkrXFLVki9bemdtYSFN9agJniic/XKqm7OG4gT
         /xKnzeeD+Nap91F+SJKS5BloH5ubGtGrJfbTsXOzNx9xKn0d6JlrpnS0H8e1LroPBW
         nJX/p3C1xePEKl7BYWRE5fUlHjo9skWXN+MRP7KI+uLVFUy9IQM7bxIwirDhbUbSUO
         G4VW+BuVQFmFZvYg3kGyRB9zbO6U6DFH7V27chzVpTMSpmxWmIOO8ZtPlVjlydq6tE
         KJ3n4Kds9QfhN7gUt9GxnOgzc2XoRBc6VImKamF2AhUSiIrPntHoGAaQ+XBvzoKRmD
         kx83AMYiUCuQQ==
Received: (nullmailer pid 3198865 invoked by uid 10926);
        Mon, 18 Apr 2022 10:20:02 -0000
From:   scs@eskimo.com (Steve Summit)
Date:   Mon, 18 Apr 2022 06:16:25 -0400
Message-ID: <2022Apr18.0616.scs.0001@quinine2.home>
To:     git@vger.kernel.org
Subject: Re: suggestion for git glossary: "ort"
In-Reply-To: <xmqq5yn84pm2.fsf@gitster.g>
References: <2022Apr16.1107.scs.0007@quinine2.home> <xmqq5yn84pm2.fsf@gitster.g>
X-Virus-Scanned: clamav-milter 0.103.5 at mail.eskimo.com
X-Virus-Status: Clean
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gitster wrote:
> scs@eskimo.com (Steve Summit) writes:
>> I kept seeing references to "ort" in the git source code, and I
>> had no idea what it meant.
>
> If the aim is to unconfuse those who are new to the codebase, read
> builtin/merge.c and merge-ort-*.[ch], and wonder what "ort" refers
> to, I doubt it would help all that much...

All I can say is that I am someone who is new to the codebase,
kept seeing references to "ort", and had no idea what it meant.
It didn't occur to me that it might be a merge strategy; for all
I knew orts were things that needed to be merged.

> Or is your main issue is even after you discover that "ort" is one
> of the merge strategies supported by Git, it is unclear how that
> short non-word was invented?

Well, that too, but really, my thinking was much more simple than
that: A glossary is where you define special terminology.  "ort"
is special terminology in git.  Therefore, I thought it belonged
in git's glossary.  BICBW.

> ...I doubt it would help all that much to add a new entry to the
> glossary, especially if they do not think of first taking a look at
> "git merge --help", which has its own large section on "ort".

Call me stupid :-), but I did not think first of looking there!
But you'll notice I added a link to that page in the suggested
glossary entry.  (I doubt I got the markdown link syntax right,
though.)
