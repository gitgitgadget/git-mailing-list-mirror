Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2BB01F462
	for <e@80x24.org>; Mon, 17 Jun 2019 23:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfFQXvA (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 19:51:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36697 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfFQXvA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 19:51:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so6514577pfl.3
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 16:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AxRSdoUTMMDfB637VEVYY9Ona3+7Ufe1ksHli7s8I/U=;
        b=Z/iNQPvm+q2SVovkOyUezVzZQj1HExs8y6wUjS5Ayw0UWvnla2fZ390/qXfilCwKJv
         UYj4NNWeaSEp9wLSmzNevOcGSbiZD9Xe+f0Q+53gHlnrVatDxiqQBP9msbbfbwyVgcMo
         5wIDC3fp2+6YB4hkjTZ5Qo8gEqMws58xCZoAIfZEC6P1ONsc+VA4qlxijZQSlSuKfM0p
         5B/z0hSSYafypPMYGTjerreAvgZ3ZX+8DrB8Y83dTjtYFIcqPXyFhBpCXtLlgtlE9MFg
         nONkOW7OyyTJ6h91RyjobYbD0+ZNYDNiAljg26Q3dTY8v3ED4Gzfj/sTaU8i1oGOwCPL
         YFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AxRSdoUTMMDfB637VEVYY9Ona3+7Ufe1ksHli7s8I/U=;
        b=ZlesqJnBsg/ePqpgmezCdfyl2BDGP1WfOZwshAWJCBdFphjGdiN8VuttF2UwF9kXR1
         zXwc94UO+eX7BPXjELmUHmJMU86JsFfdOzqmVN4EYyt3e/nWkt9Ba3dl2kK0N0IAeiql
         t0s7jM0hI6w2+oDfhi2cPjTrAFxvUCsAyVHRxnbe+JTaanBqMgZ+87oheBFW6qW6pf8s
         r/e862ZSXviEea6qmzGBj/GsyyS76F35REU+J2wxSo0sZnVXqrpHgvXFoM0Ox2atX7Uo
         LjmaUylGG6Gav42BAO5+gseW0jLRsa58Idra4TdMzI35ZDIYtDUXrd7A7qB4UxOJGWXG
         S8FA==
X-Gm-Message-State: APjAAAXjagAQ/7J/k80ardlzrIp2Y5CeXt4G7/krE/1fqMNM8HZ3Q5Vd
        PRzITA6C2eqLPJsdzdk/Tna/bgqAMfU=
X-Google-Smtp-Source: APXvYqzXMcBVMyZisXWLBGpHJlkX2KURhu0sJD7/pvCUJVA/gd8aBotkOgKTfrrb5P2PyTqImpPd6A==
X-Received: by 2002:a17:90a:71cb:: with SMTP id m11mr1821257pjs.40.1560815459000;
        Mon, 17 Jun 2019 16:50:59 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id z4sm12935043pfa.142.2019.06.17.16.50.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 16:50:58 -0700 (PDT)
Date:   Mon, 17 Jun 2019 16:50:53 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] documentation: add tutorial for revision walking
Message-ID: <20190617235053.GD100487@google.com>
References: <20190607010708.46654-1-emilyshaffer@google.com>
 <xmqqef41mbmd.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqef41mbmd.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 10, 2019 at 01:25:14PM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > I'll also be mailing an RFC patchset In-Reply-To this message; the RFC
> > patchset should not be merged to Git, as I intend to host it in my own
> > mirror as an example. I hosted a similar example for the
> > MyFirstContribution tutorial; it's visible at
> > https://github.com/nasamuffin/git/tree/psuh. There might be a better
> > place to host these so I don't "own" them but I'm not sure what it is;
> > keeping them as a live branch somewhere struck me as an okay way to keep
> > them from getting stale.
> 
> Yes, writing the initial version is one thing, but keeping it alive
> is more work and more important.  As the underlying API changes over
> time, it will become necessary to update the sample implementation,
> but for a newbie who wants to learn by building "walken" on top of
> the then-current codebase and API, it would not be so helpful to
> show "these 7 patches were for older codebase, and the tip 2 are
> incremental updates to adjust to the newer API", so the maintenance
> of these sample patches may need different paradigm than the norm
> for our main codebase that values incremental polishing.
>
I'm trying to think of how it would end up working if I tried to use a
Github workflow. I think it wouldn't - someone would open a PR, and then
I'd have to rewrite that change into the appropriate commit in the live
branch and push the entire branch anew. Considering that workflow leaves
me doubly convinced that leaving it in my personal fork indefinitely
might not be wise (what if I become unable to continue maintaining it)?

I wonder if this is something that might fit well in
one of the more closely-associated mirrors, like gitster/git or
gitgitgadget/git - although I wonder if those count as "owned" by Junio
and Johannes, respectively. Hmmmm.

Maybe there's a case for storing them as a set of patch files that are
revision-controlled somewhere within Documentation/? There was some
discussion on the IRC a few weeks ago about trying to organize these
tutorials into their own directory to form a sort of "Git Contribution
101" course, maybe it makes sense to store there?

  Documentation/contributing/myfirstcontrib/MyFirstContrib.txt
  Documentation/contributing/myfirstcontrib/sample/*.patch
  Documentation/contributing/myfirstrevwalk/MyFirstRevWalk.txt
  Documentation/contributing/myfirstrevwalk/sample/*.patch

I don't love the idea of maintaining text patches with the expectation
that they should cleanly apply always, but it might make the idea that
they shouldn't contain 2 patches on the tip for API adjustment more
clear. And it would be probably pretty easy to inflate and build them
with a build target or something. Hmmmmmmmmm.

 - Emily
