Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59EDD1F403
	for <e@80x24.org>; Sun, 17 Jun 2018 18:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933658AbeFQSZl (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 14:25:41 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35122 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934054AbeFQSZk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 14:25:40 -0400
Received: by mail-pf0-f195.google.com with SMTP id c22-v6so7078496pfi.2
        for <git@vger.kernel.org>; Sun, 17 Jun 2018 11:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=gr64oy3cvisDKfCZiVXnDKjMMxzo4IuxUGzormHg/pA=;
        b=ZzpEL7drJoeqQAevrKaBxZc1WsAQ+xKmO0zmlpiJ3PzhP2+FjgRhMBkyuVATz5Cni3
         mBf1LyjW5JnR1GZnCr47YW7tLrDB0V/1VpydW6rZrNVXgHge3CT6KiMX9HnwHnuvdBEP
         useQsSj6Y6d5L+6GAUteuVpQ3YJ0UkiWAJrzpkKK5IKpUbhxP9fLk3e1aFlVU/ATfE9W
         Kb2ptkjPZ9J1ObNUm7ycwKnXIUvA2W3NOMtxurOdAmJ1/v7zoW+ySTM3CiRxP5+EHaWu
         jxi43qMi3PJtEo4yqjXzcSDBx52kiBkNEiBGXBbU430O9vf4Wf17v6O2SKZktcGC8XHO
         4WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=gr64oy3cvisDKfCZiVXnDKjMMxzo4IuxUGzormHg/pA=;
        b=j1sBRXaMXqSTJSf0SM3eDkOlI8Da2u2uQge2TQXcR5zenWCTGYGxGTeZ7MV8Mp1681
         UXpDwKMo6RJr3WuL1o91iSowEqOD7YVxDWlbz34YPeyA3nv2QoXvK9xTmTRrol2b6ErC
         WFnqTXpXLgn+2nFSiiMWO22xADhvKwS/FJcZodOpTvdDBHF6AVtuSX4kqR26pC6mYODe
         e11+lt86FvSBkYcvYfnlEON0LoF0xSyQPjWQEbG+vgjuOxMG1MiIUPZKo0nt4FurwHzL
         tcYBU/zYvov1fwGdULkIm5NVRDHm/5iMbnQVBK5CpkH/DDYDhQ/vr2UzgGX+9lebN79g
         Ubtg==
X-Gm-Message-State: APt69E11HKA8274ACT3IhLtZh8NzKHCkCnENVC+ILRYRHos0ox8kS/ew
        QxcWEv9cYCTubkaRgXSI5XQ=
X-Google-Smtp-Source: ADUXVKI4ABi/Q6Mchkw/C/TPiNlL/1jLps4S5GceU5VGzZ6gxRylN56HguqOSdOJGaXO1Xe4HZsDHA==
X-Received: by 2002:a62:968f:: with SMTP id s15-v6mr10462656pfk.191.1529259939757;
        Sun, 17 Jun 2018 11:25:39 -0700 (PDT)
Received: from unique-pc ([117.209.147.247])
        by smtp.gmail.com with ESMTPSA id y11-v6sm18383001pfn.92.2018.06.17.11.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 11:25:38 -0700 (PDT)
Message-ID: <1529259933.7225.2.camel@gmail.com>
Subject: Doc/SubmittingPatches: re-phrashing a sentence about alternate
 solutions (was Re: [PATCH] Makefile: make NO_ICONV really mean "no iconv")
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     simon@ruderich.org, Git List <git@vger.kernel.org>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>
In-Reply-To: <CAPig+cTMEfu=x2dhUww3x2uk9-ANAK6eepC3hOsx4FE+1jTgBA@mail.gmail.com>
References: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
         <20180615022503.34111-1-sunshine@sunshineco.com>
         <20180615065805.GA15146@ruderich.org>
         <CAPig+cQL8rTg+GASp2tSng7PPPYkfeeV2SNyi0D+6-Ep7JKaGg@mail.gmail.com>
         <a079d636-e70d-f383-ae87-ab890a636441@gmail.com>
         <CAPig+cTMEfu=x2dhUww3x2uk9-ANAK6eepC3hOsx4FE+1jTgBA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 17 Jun 2018 23:55:33 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2018-06-17 at 14:00 -0400, Eric Sunshine wrote:
> Whether or not to talk about alternate solutions in the commit message
> is a judgment call. Same for deciding what belongs in the commit
> message proper and what belongs in the "commentary" section of a
> patch. A patch author should strive to convey the problem succinctly
> in the commit message, to not overload the reader with unnecessary (or
> confusing) information, while, at the same time, not be sparing with
> information which is genuinely needed to understand the problem and
> solution.
> 
> Often, this can be done without talking about alternatives; often even
> without spelling out the solution in detail or at all since the
> solution may be "obvious", given a well-written problem description.
> Complex cases, or cases in which multiple solutions may be or seem
> valid, on the other hand, might warrant talking about those alternate
> solutions, so we probably don't want to drop that bullet point.

Well explained, thanks. (Thinking out loud, it might be even nice to
including the above paragraphs into Documentation/SubmittingPatches as
I find it to be more "humane" than the terse bullets. But I refrained
from doing so as the document is already a bit too-long ;-)

> Perhaps, instead, it can be re-worded a bit to make it sound something
> other than mandatory (but I can't think of a good way to phrase it;
> maybe you can?).

How about the following patch? (warning: patch only for discussion
purposes, might be white-space broken). It might be superfluous,
though.

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index a1d0feca3..565bc4397 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -128,7 +128,7 @@ The body should provide a meaningful commit message, which:
 . justifies the way the change solves the problem, i.e. why the
   result with the change is better.
 
-. alternate solutions considered but discarded, if any.
+. alternate solutions considered but discarded, where necessary.
 
 [[imperative-mood]]
 Describe your changes in imperative mood, e.g. "make xyzzy do frotz"


Regards,
Sivaraam
