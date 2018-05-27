Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAF7E1F42D
	for <e@80x24.org>; Sun, 27 May 2018 21:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeE0VHw (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 17:07:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55928 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeE0VHw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 17:07:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id a8-v6so27069358wmg.5
        for <git@vger.kernel.org>; Sun, 27 May 2018 14:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cQqO78hNdpWJk+cCs1pTiYMXEgXSYLwNTSn71kV1szo=;
        b=RuCgO5cwcq5a51weVxYwAmigS5/y4oDc0IOt2iuXANYcfeXje3V4/LnwAKKq/f7JZf
         Q0FXPTiq1LnFGu402UHmIDo9g3Lzbb2IyKmdK6hmy5XhYs6omMSDRuMU9JujPag/JdTa
         iG4noKIWqd8kFancY8TsFIeDd9nP/m7XavmS0hFMwxWpPNM9Aex719NiGcoYk+1wQzTz
         DRW8NaFGSxNxVPGaAEZ/a9KL8FN5wustwZGGKAOTmPdYcemx/9RBcqXVIw/Jecwm1qkC
         rAl9XTrq8PaviMp26TQYiqCiO7w22y5yOuCVfMsiEIJUKU0wfuUGRvbUDM6q8Yw98lRe
         V1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cQqO78hNdpWJk+cCs1pTiYMXEgXSYLwNTSn71kV1szo=;
        b=RWMu6uKTmpa/T/E4lCGBnd5BPfNEH4mXJpSvLK+dJX4013IHJ56G44PpiTsy9tykwD
         syQhvdScMKrKy0ZziaDHSO47SJsEZUabms1rD20BWgRln5yFVVFnsoliCXPcFN1eDEQl
         qc2OZiqMEvMtU1/c7O/oq9lTcDui1uGAVw3d9sl0hA9eluhtzBFuxKGMH9Ota/mDgH1z
         Sgi/snCv/mQ73oqtojn3+ZOetZyuQrIcqSS2Y7RQ7tB3OIGYWOGdsEhp+jdgoUE1A8Dq
         cIiyvgcbIlmhqysGZkUZBdk3Dip0V07h0XQ+51X79axzFqf85uvHkOW42yKzGhjgLZLW
         Y55A==
X-Gm-Message-State: ALKqPwdMWR9msjEtDfmLQd2eDe0bv8v2ycXOuNySpXXtNTBpSJ8qrtlI
        nDZSOcVG2b9TDj6sehBlj0M=
X-Google-Smtp-Source: ADUXVKLvJSZJU3YonYA1eVu33hi9WJNx+fIM0to5rgLgv9qm9dBRUK9qbidtl4rm5LuF1h2e5gtmRw==
X-Received: by 2002:a1c:6f52:: with SMTP id k79-v6mr6281520wmc.38.1527455270446;
        Sun, 27 May 2018 14:07:50 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 60-v6sm18721309wrc.42.2018.05.27.14.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 May 2018 14:07:49 -0700 (PDT)
Date:   Sun, 27 May 2018 22:08:22 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 2/1] SubmittingPatches: not git-security@googlegroups.com
Message-ID: <20180527210822.GB8868@hank.intra.tgummerer.com>
References: <20180527140433.32277-1-t.gummerer@gmail.com>
 <20180527153418.GG207547@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527153418.GG207547@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/27, Jonathan Nieder wrote:
> Thomas Gummerer wrote:
> 
> > Add a mention of the security mailing list to the README.
> > 2caa7b8d27 ("git manpage: note git-security@googlegroups.com",
> > 2018-03-08) already added it to the man page, but I suspect that for
> > many developers, such as myself, the README would be the first place
> > to go looking for it.
> >
> > Use the same wording as we already have on the git-scm.com website and
> > in the man page.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  README.md | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks!

> > 2caa7b8d27 ("git manpage: note git-security@googlegroups.com",
> > 2018-03-08) also mentions SubmittingPatches, but I think people are
> > much more likely to submit a report of a security issue first, rather
> > than sending a patch, for which I think the README is more useful.
> 
> I don't see a mention of SubmittingPatches in "git show 2caa7b8d27"
> output.  git help git tells me:
> 
> 	Report bugs to the Git mailing list <git@vger.kernel.org>
> 	where the development and maintenance is primarily done. You
> 	do not have to be subscribed to the list to send a message
> 	there.
> 
> 	Issues which are security relevant should be disclosed
> 	privately to the Git Security mailing list
> 	<git-security@googlegroups.com>.
> 
> Do you mean that the discussion around that change suggested updating
> SubmittingPatches too?  The "Sending your patches" section indeed
> mentions git@vger.kernel.org, so a mention of the security list would
> indeed be welcome there, even though typically the discussion has
> already started there before a patch is written.

Yeah sorry, that's what I meant.
https://public-inbox.org/git/20180308150820.22588-1-avarab@gmail.com/
is the reference I meant to put there.

How about something like the below?  This is tested with asciidoc
8.6.10 and asciidoctor 1.5.6.2.  I'm also happy to squash the two
patches into one if that's preferred.

--->8---

The previous commit added a note about the Git Security mailing list
to the README.  Add it to Documentation/SubmittingPatches as well, so
developers trying to submit a security relevant patch are pointed in
the right direction.

The wording is adjusted slightly compared to the git-scm.com website
and the README, as they are talking about issues, while
SubmittingPatches is talking about patches.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/SubmittingPatches | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 945f8edb46..aeb7948d98 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -264,6 +264,11 @@ people who are involved in the area you are touching (the `git
 contacts` command in `contrib/contacts/` can help to
 identify them), to solicit comments and reviews.
 
+:1: footnote:[The Git Security mailing list: git-security@googlegroups.com]
+
+Patches which are security relevant should be submitted privately to
+the Git Security mailing list{1}.
+
 :1: footnote:[The current maintainer: gitster@pobox.com]
 :2: footnote:[The mailing list: git@vger.kernel.org]
 
-- 
2.17.0.921.gf22659ad46
