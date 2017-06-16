Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29DD20282
	for <e@80x24.org>; Fri, 16 Jun 2017 10:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbdFPKQ5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 06:16:57 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:36487 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753296AbdFPKQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 06:16:56 -0400
Received: by mail-ua0-f170.google.com with SMTP id g40so23021852uaa.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 03:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=G/sskIJL7Y/cI9X9m1bPyNbDJQ/O5BCo9MCuQManK4I=;
        b=TA0E0lfFPGSVGIRRXoLfJ2cM/LpTEXT9fntEET6DV9B8S0/gfPGruzrWXNxdFIZeq2
         dfa9ZkYBs/GWbqWP4BFvc1u3/PQsQn7GKCkkMhyJT911DPKO+73df4HVbJ7KfaDgRi9S
         CjONCwbaDmFVRVYYK++19giGt9lnnxMhHYA5Vpf9Qfn1a+lXS9XQ6PXhr/f2pNFrdVEo
         D71cx7WSjJPU7GIXXnVGdNug7cHz8c/oZighbuWdroxzcsIQ8tHx6PVBEgoSgggXDFnM
         xxUVuH0kfjXiPRHYWB+dXSZE3FyUNBHR5VtzmDrYk6qoLMoT07fIeR4y3inGX1RofJao
         Zwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=G/sskIJL7Y/cI9X9m1bPyNbDJQ/O5BCo9MCuQManK4I=;
        b=PEW8U8zmYXPPPqbUt5BTkS2fhAPC2O5tBY/chgBGr1RNsUSVOv57nfrMQxp46dbxfE
         KZ6LvZm51K4Xskzs6KMznbQY2zzog3FcXoFg2769LzNPl6PD/4rtLQTMS//AjSrNZRhz
         XHPvUoOtPoUCIPB3D/x/2I3j2dcPjJKzQkOLymy2AHgPaeEHQ3VvtotuUse642qizFP9
         W5LJ0EZmVHQRa8ezy32eVaakkkF7pdK+aeL+OFiN7+BQZVkm3GLzvVIXoK1ccoOnS3w6
         1GWoIwSrWXUeSmHCUoTmRIzskomf+CS+uaqi8ZR1ExtKBVL/juN1+xxJRLYXb+BJEJbU
         OkKw==
X-Gm-Message-State: AKS2vOzxvLfhiXrsCZsBYohMhxGP/sJBdUXKW2uR/hfjPVrQhqHn+EG/
        b4ncp312HFJVdlijDZFsNXwHsYR8OA==
X-Received: by 10.159.38.66 with SMTP id 60mr6198574uag.0.1497608214523; Fri,
 16 Jun 2017 03:16:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.113.197 with HTTP; Fri, 16 Jun 2017 03:16:54 -0700 (PDT)
In-Reply-To: <CAGUfqurYdFJDT4+XzyPvo3sxeT=zjXqZGCPpDbUFwjqG1B3pBw@mail.gmail.com>
References: <59432BCC.2040901@eagerm.com> <CAGUfqurYdFJDT4+XzyPvo3sxeT=zjXqZGCPpDbUFwjqG1B3pBw@mail.gmail.com>
From:   "Michael O'Cleirigh" <michael.ocleirigh@gmail.com>
Date:   Fri, 16 Jun 2017 06:16:54 -0400
Message-ID: <CAGUfqup7aVzoYq-1h=u8ONTT7VvL05x3-Svm1e4d0XfYjnv3sA@mail.gmail.com>
Subject: Fwd: Best practices for updating old repos
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Sorry I sent this originally last night in gmail but not in plain
text mode and it bounced)


Hi Michael,

In git if you don't merge often then you get these merge conflict hell
situations.

In my experience the main conflicts come not from the unified diff of
those 130 commits but from differences in the surrounding code.

Merging/rebase/cherrypicking directly to the latest upstream sounds
impossible to me.

These conflicts come from the distance between the local fork branch
and the upstream branch.

You need to merge through closer commits first to have a hope of
getting something automatic to work.

Something like getting the list  of releases made in the upstream in
the last 5 years and merging them in order into the fork branch.

i.e. merge v1, merge v2, ... merge v300

I went through something similiar with a subversion repo we converted to git.

In subversion they were cherry picking done work into a release branch.

In git a feature branch mode was being used.

It turned out some commits were never cherry picked and bringing them
to the latest release was hard.

We tried many of the approaches you outlined, took what git would give
us automatically and in the most hairy cases recreated the changes on
the latest upstream by reading the diff of the original commit and
rewriting it on the latest code.

In terms of how the history looks after the merge conflicts are
resolved you could internalize the fixups into a single commit applied
onto the original fork branch.  So that history would show the 130
commit branch directly merged into the upstream.

You would use the git-commit-tree command to reuse the merged tree id
and then use it as a merge commit between the 130th commit id and the
upstream commit id.

Regards,

Michael

On Thu, Jun 15, 2017 at 8:52 PM, Michael Eager <eager@eagerm.com> wrote:
>
> Hi All --
>
> I'm working with code that is based on a five year old repository.
> There are 130 local commits since the repo was forked.  Naturally,
> the upstream project has moved on significantly.
>
> I'm wondering about best approaches to updating the repo to the
> current upstream version.  Here are the approaches I've considered:
>
> - Rebase from upstream.  Likely almost every patch will fail with
>   multiple merge conflicts.
>
> - Merge local branch into upstream.  Likely many merge failures, but
>   fewer than with rebase.
>
> - Apply individual patches from the old repo to the upstream repo.
>   Fix merge conflicts, rebuild, fix build failures.  There may be
>   some duplication and additional merge problems created, where a
>   later patch from the old repo fixes the same conflict or build
>   failure.
>
> I've tried each of these approaches on various projects.  Each has
> problems. After resolving merge issues there are build failures which
> need to be resolved and additional patches created.  The result is
> that the patch history is a bit chaotic, where there are later patches
> which fix problems with early patches.  I've tried to sort the fix
> patches to follow the patch they correct, so that the fixes were
> together and I could merge them, but that can be difficult.
>
> I've used Stacked Git a little, but don't know if it will make
> any of this easier.
>
> On some projects, I've reimplemented changes in the upstream repo,
> abandoning the patch history from the old repo:
>
> - Create diff of old repo and upstream.  Apply only the changes
>   to add new functionality, which are in the patches to the
>   old repo.   Fix problems caused by API changes, renamed files, etc.
>
> - Re-implement the changes on the upstream repo.  Some of the old
>   code would be re-used, but modified to fit in the current upstream.
>   Some new code would be written.
>
> One other variant of the rebase approach I've thought of is to do
> this incrementally, rebasing the old repo against an upstream commit
> a short time after the old repo was forked, fixing any conflicts,
> rebuilding and fixing build failures.  Then repeat, with a bit
> newer commit.  Then repeat, until I get to the top.  This sounds
> tedious, but some of it can be automated.  It also might result in
> my making the changes compatible with upstream code which was later
> abandoned or significantly changed.
>
> Anyone have a different approach that I should consider?  Or maybe
> offer advice on how to make one of these approaches work better?
> What is best practice to update an old repo?
>
> --
> Michael Eager    eager@eagercon.com
> 1960 Park Blvd., Palo Alto, CA 94306  650-325-8077
