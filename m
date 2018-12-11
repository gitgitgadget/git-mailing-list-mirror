Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2FE120A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 01:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeLKBk3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 20:40:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36119 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbeLKBk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 20:40:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id u3so12445560wrs.3
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 17:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oQstzT9XqMqEK1aJKKiTLW7W+6UUeMPT7O6X9Z1cwRI=;
        b=LbAIHUx4heJj5IgvIhh8lLUUIqvOIGz0P0F/HImBMZFkht4Kup2Dof7+BJ6Pp/Cw3K
         yQqYSj+7Rj8RWC5kFzwgH/ehi0n+De9vnhOTmup41KKemB0TWaHhOSrnOwzbWMrz7Jlq
         sHg8uuZETA1qn9p7oGONnwSMnR2WKyhR1IrVYP+Bk/2+pj+KzPXBDShGEOEbWYFRghCR
         fLkxQhZCCw3PNNdv64sJweAaxZqoyyFXwO1XeQK37oF/6md1V2BJmkN9DZvVfG3Rwetw
         nY7igWB5eKjH6Mz7963HKkkzN7SAJ6splOWs8uYynwCmZfOnLKi0VTNHdU6rBvgfknRz
         2m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oQstzT9XqMqEK1aJKKiTLW7W+6UUeMPT7O6X9Z1cwRI=;
        b=n/Mc48pC5Qy8HRGXyFjrn/0d2FF6YQvVWnOvEqjjfioianf0m6LAUsS5Vxv1sLfiuZ
         XgY1vCZ1tNf9x5/WJ2Lh+oSvFPtsiziTQyctkIlpBAkMYSRT5IckxFrXxTJFkXHxn3Cy
         N5uCEZFjP4DUwZ7LpfZ3PKGnMesM7omLBQNSypSyfQhdwzeNN2qJmRO4nYSd+d7CAfAn
         /pQTo3Yx80pOJyUyn/6DeMFT2NseYbr3Nqsf9dGpWAIqzvrM/NYBRLWt83c2wt/BCTz2
         2cd2q7aUbm22SgTBsrxIOXmCd9ynM7yhNyL6zbP6RW6+zO0kWJQqqceSfB984qJCIKxq
         EssA==
X-Gm-Message-State: AA+aEWaVjYgLCE6ILQC1EPRt2FHn6SdN3hjsAVUKfqvAHNmSNuzkBPF0
        GtVmA3VUVKv9K1SEOggedHQ=
X-Google-Smtp-Source: AFSGD/WUK8WdjxFDMAbAWbFg9TdRWq/iFKnhUU2ITlqjdznCwZ8zFcf6GJBMwpAqT/S/JHBWvetv0g==
X-Received: by 2002:adf:c44a:: with SMTP id a10mr11802478wrg.145.1544492426185;
        Mon, 10 Dec 2018 17:40:26 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f192sm444606wmd.12.2018.12.10.17.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 17:40:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrn@google.com>,
        matvore@comcast.net, dstolee@microsoft.com, pclouds@gmail.com,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] terminology tweak: prune -> path limiting
References: <20181206213315.64423-1-matvore@google.com>
        <xmqqo99v5vnc.fsf@gitster-ct.c.googlers.com>
        <CAMfpvhKh3xewUY-g9oVJq1o=G3w9EspoQUHc1edHUx3AD4OWfg@mail.gmail.com>
Date:   Tue, 11 Dec 2018 10:40:25 +0900
In-Reply-To: <CAMfpvhKh3xewUY-g9oVJq1o=G3w9EspoQUHc1edHUx3AD4OWfg@mail.gmail.com>
        (Matthew DeVore's message of "Mon, 10 Dec 2018 10:57:28 -0800")
Message-ID: <xmqq1s6oon7a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> When I tried to figure out what "prune" and "prune_data" ("data" is
> quite vague, so these two fields read like "prune_1" and "prune_2")
> referred to in "revision.h",...

It was unfortunate that 8efdc326 ("rev-lib: Make it easy to do
rename tracking (take 2)", 2006-03-10) had to rename "paths" to
"prune_data" when attempting to generalize the history
simplification mechanism by introducing "prune_fn", which can be
used instead of a fixed function, and as one half of the pair, "data
used by the prune function" made some sense.

When we partially reverted that over-generalization with 53b2c823
("revision walker: mini clean-up", 2007-11-05), we probably should
have changed the prune_data back to paths, but we didn't.  Worse
yet, when we made prune_data from a void pointer to struct pathspec
at afe069d1 ("struct rev_info: convert prune_data to struct
pathspec", 2010-12-17), we really should have renamed it back to
paths, but we didn't.

So I think it is a good idea to get rid of prune_data and make it
clear it is no longer a generic thing but cannot be anything but a
pathspec.  I am not sure what the bit should be called, though.  It
is a bit to enable any history simplification and not limited to
pathspec limiting (e.g. simplify-by-decoration enables it, too).




