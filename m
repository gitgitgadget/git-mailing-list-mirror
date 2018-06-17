Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4E601F403
	for <e@80x24.org>; Sun, 17 Jun 2018 18:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeFQSAj (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 14:00:39 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:44071 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeFQSAi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 14:00:38 -0400
Received: by mail-yw0-f196.google.com with SMTP id k18-v6so4388759ywm.11
        for <git@vger.kernel.org>; Sun, 17 Jun 2018 11:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+gwuZFOPJQO7JM+HkLtyobVB9Jzt8DlqQbS7zFaC0lQ=;
        b=Cve+Zl/TD8mVZpCMtTk8dMtw2PaTWa/NyEpKgwAHxbLM+HOv9DZ4quOD7CdKAD6DDI
         jou1agmYkrwnixWm3M+CKkgb8OUbC/2taz6gkn51WHF8tHpg7XEvA1RfGa4Jq0psj4HQ
         2YJVWdZzswZB8xIwZjLTR4ql5BVvP76IFdhtZVMFO8tDRCc+ab72llAvIAhY8mt5csNG
         p55u1NTyYkj1imz07+z4L2TOWXWl2xWYhyO0K3d3PKwrUcJmYOtAMUCjJW4uqTCm05CP
         WsXmm5zbSyIao/1x2pErtpIOmUhvgGwYlmO07YrcHdZQlEd/md9SxRA9r5DduQyXCTJV
         ZExw==
X-Gm-Message-State: APt69E3CHXYe2mwJXFGwshFF/KC/SdY5WUdEeT47LnrGFCBvwp+ad+Ab
        o1qLB3xP6bKs98pSgzNSuqcQlaN+QBQx5ioIlt0=
X-Google-Smtp-Source: ADUXVKJlvakGqdArpnB0lr6/ZrKKBcjrG0K1At1TO9i69PQSKxJVQzuV+t1zdVMfvr06UPv3AXK/q/qAjHNrZV2qp6k=
X-Received: by 2002:a81:4517:: with SMTP id s23-v6mr4818076ywa.74.1529258438054;
 Sun, 17 Jun 2018 11:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
 <20180615022503.34111-1-sunshine@sunshineco.com> <20180615065805.GA15146@ruderich.org>
 <CAPig+cQL8rTg+GASp2tSng7PPPYkfeeV2SNyi0D+6-Ep7JKaGg@mail.gmail.com> <a079d636-e70d-f383-ae87-ab890a636441@gmail.com>
In-Reply-To: <a079d636-e70d-f383-ae87-ab890a636441@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 17 Jun 2018 14:00:26 -0400
Message-ID: <CAPig+cTMEfu=x2dhUww3x2uk9-ANAK6eepC3hOsx4FE+1jTgBA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: make NO_ICONV really mean "no iconv"
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     simon@ruderich.org, Git List <git@vger.kernel.org>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 17, 2018 at 1:32 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On Friday 15 June 2018 01:13 PM, Eric Sunshine wrote:
> > On Fri, Jun 15, 2018 at 2:58 AM Simon Ruderich <simon@ruderich.org> wrote:
> >> Should we put the part about MacOS's make into the commit
> >> message? Seems like relevant information for future readers.
> >
> > No. The bit of commentary mentioning MacOS's very old 'make' was just
> > talking about a possible alternate way of implementing the change.
> > That alternative was not chosen, so talking about old 'make' in the
> > commit message would be confusing for readers.
>
> Interesting. Documentation/SubmittinPatches reads:
>
>     The body should provide a meaningful commit message, which:
>     <snip>
>     . alternate solutions considered but discarded, if any.
>
> The consensus has changed, maybe? In which case, should we remove that
> statement from there?

Whether or not to talk about alternate solutions in the commit message
is a judgment call. Same for deciding what belongs in the commit
message proper and what belongs in the "commentary" section of a
patch. A patch author should strive to convey the problem succinctly
in the commit message, to not overload the reader with unnecessary (or
confusing) information, while, at the same time, not be sparing with
information which is genuinely needed to understand the problem and
solution.

Often, this can be done without talking about alternatives; often even
without spelling out the solution in detail or at all since the
solution may be "obvious", given a well-written problem description.
Complex cases, or cases in which multiple solutions may be or seem
valid, on the other hand, might warrant talking about those alternate
solutions, so we probably don't want to drop that bullet point.
Perhaps, instead, it can be re-worded a bit to make it sound something
other than mandatory (but I can't think of a good way to phrase it;
maybe you can?).
