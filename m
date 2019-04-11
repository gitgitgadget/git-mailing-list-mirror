Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E40920248
	for <e@80x24.org>; Thu, 11 Apr 2019 21:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDKVDa (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 17:03:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38479 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKVDa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 17:03:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so4033253pfo.5
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TiEE7SChYyDRDdn3v87g8Sd5pLDQsXGE4GuCu0GR2gw=;
        b=F47S2+22dd3he/C+F59KGWS77pG/ifdAylN8+plbf0ASmERJTULFog1mGmmj9BaVxp
         ez00HLld5D5wLQqscaqff8mskwL0mzNagJAMEipLhWa2AoVm2/jNUQKg8v9SHYarC1zX
         IsfonkdrShxvaBetJ8qhFPosPvCGBFsZjENprj4xCTxcd+zXZriSkE/qvCOhCLP9GQFP
         Go5iINxurlDb50XzaZsHzOFS0m5VC/2dFaZgQlmdzdVaSd+Z+k7vNIwm4W7pmVFAR8bc
         r7PwTlT+yVl9YmEbv2dfUnWI6F0jqnnoNxdRLuKSwIWvzqrYvpiFCDr8GDoPuwAIj2Eg
         fUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=TiEE7SChYyDRDdn3v87g8Sd5pLDQsXGE4GuCu0GR2gw=;
        b=fb+mRCNxlo6DVafEYIQ9XFuVfgIpXu6Ypx1F0V/eHQ1CS6elO0a7EiXpOzXB1+jONW
         35zBB+dC0IxD9D99xQIGnv1ttcWvolDsISt294gMdGNp7H6pDoELgppUYJX3agu4zegz
         tIjeCgpCXrQ24GiDRZZxTV5lFSQPjW/hDYqjWckOpQmLjLbsv38QJXhohYMGVQziYF8d
         P4Zhft+kzuH+jkslI3//ga1SWci2zzBAC06gg82kXBdC2dgGvtZWxc0vcm/5FA/Th/O4
         dlUjCsIn7SHMOKfgWlN7Qu+Qil7PTMMU5vHtq9bmfKgxgD+lddVpH6orXlUMpFOHdcyF
         LGqw==
X-Gm-Message-State: APjAAAV+e0ugoNCAuj56oIW9gQu1JkWFK42gU3JYHCZJzQg9tzZPOFJH
        yu0BgTqJU2q/odItPZZY6/BY3w==
X-Google-Smtp-Source: APXvYqweBnlsOESLIGik+TnEyz+RaQO8KZ3otkYwsSxxEift0MQE6AKlHFGl9l+2ykYAWeWYenXwVA==
X-Received: by 2002:a63:e554:: with SMTP id z20mr48634571pgj.234.1555016609067;
        Thu, 11 Apr 2019 14:03:29 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id e23sm55415951pfd.11.2019.04.11.14.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 14:03:28 -0700 (PDT)
Date:   Thu, 11 Apr 2019 14:03:22 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] documentation: add lab for first contribution
Message-ID: <20190411210322.GN60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.177.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.177.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.04.11 11:32, Emily Shaffer via GitGitGadget wrote:
> RFC. I am still working on adding a section on handling refs and objects.
> 
> A tutorial for beginners explaining how to commit to git/git from clone to
> push. This tutorial attempts to explain the GitGitGadget workflow; with the
> review I'm hoping to understand whether it's worth the effort to detail how
> to use git send-email as well. The linked implementation is present in my
> personal fork and I'd be happy for any comments people wish to give against
> that implementation, too, although it obviously isn't destined for git/git.
> I wrote this guide in order to learn the process myself, so I welcome all
> feedback.
> 
> Additionally, if there are skills around working with the codebase that
> should really be included in the "Implementation" section I'd be happy to
> add them.
> 
> Emily Shaffer (1):
>   documentation: add lab for first contribution
> 
>  Documentation/MyFirstContribution | 674 ++++++++++++++++++++++++++++++
>  1 file changed, 674 insertions(+)
>  create mode 100644 Documentation/MyFirstContribution
> 
> 
> base-commit: e35b8cb8e212e3557efc565157ceb5cbaaf0d87f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-177%2Fnasamuffin%2Fmyfirstcontrib-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-177/nasamuffin/myfirstcontrib-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/177
> -- 
> gitgitgadget

Generally looks good to me! I definitely learned a few things.

In the doc, you ask whether or not to cover the 'git send-email'
workflow; I think it would be a good idea.

It would also be nice to have the Documentation/Makefile automatically
generate an HTML page for this; looks like you can follow
SubmittingPatches as an example.

I spotted a typo and a couple of whitespace issues; a fixup patch for
this is included below.

-- >8 --

Subject: [PATCH] fixup! documentation: add lab for first contribution

---
 Documentation/MyFirstContribution | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstContribution b/Documentation/MyFirstContribution
index 9b87e424d6..07c0b3f194 100644
--- a/Documentation/MyFirstContribution
+++ b/Documentation/MyFirstContribution
@@ -65,7 +65,7 @@ https://github.com/nasamuffin/git/tree/codelab.
 === Adding a new command
 
 Lots of the main useful commands are written as builtins, which means they are
-implemented in C and compiled into the main `git` executable.. So it is
+implemented in C and compiled into the main `git` executable. So it is
 informative to implement `git psuh` as a builtin.
 
 Create a new file in `builtin/` called `psuh.c`.
@@ -111,7 +111,7 @@ The list of commands lives in `git.c`. We can register a new command by adding
 a cmd_struct to the commands[] array. struct cmd_struct takes a string with the
 command name, a function pointer to the command implementation, and a setup
 option flag. For now, let's keep cheating off of push. Find the line where
-cmd_push is registered, copy it, and modify it for cmd_psuh. 
+cmd_push is registered, copy it, and modify it for cmd_psuh.
 
 The options are documented in `builtin.h` under "Adding a new built-in." Since
 we hope to print some data about the user's current workspace context later,
@@ -608,7 +608,7 @@ your patch is accepted into `next`.
 TODO https://github.com/gitgitgadget/gitgitgadget/issues/83
 It'd be nice to be able to verify that the patch looks good before sending it
 to everyone on Git mailing list.
-=== Check Your Work 
+=== Check Your Work
 ////
 
 === Sending Your Patches
-- 
2.21.0.392.gf8f6787159e-goog

