Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 237241F404
	for <e@80x24.org>; Wed, 18 Apr 2018 19:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbeDRTjU (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 15:39:20 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:46789 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbeDRTjT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 15:39:19 -0400
Received: by mail-ua0-f172.google.com with SMTP id a17so1896388uaf.13
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 12:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xKXt9MXkanCrbMIMK15b1ZmYAk+kPi416hu7kqd2kTg=;
        b=rn3U6Ne8MRs72tixIV5nv49Nl/orgYxZvy1xQBNp5QyNRQ37cikwK8CiypHWSI1zSv
         8qMW80ZYzhGjotjrehpBxm4Gl9F38ob1vmoBjK9Asu0Dt+OIImQ4ZMxEEueAht5bveOb
         nzMEqsSVVBd9Oy3x+ojLLj0OXxnZ9p6THx6aIIs2B66PMmqAD3bh5JeBJqZnBQxeFjRh
         wrQa9H477UPuX696qbyTe+d59roRxquwxJh6akwhUSkEV0+vpWAwzpKPTvxiYuOGVUYb
         uzrUnxPDpLVeUvyzT4pcHnv23opiiLTTMwkRekicvxQZJarTmyltqVgysPf5AyKINfNT
         vSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xKXt9MXkanCrbMIMK15b1ZmYAk+kPi416hu7kqd2kTg=;
        b=h2Akjnr/v8SvTlFHL0jOgUSCLCNB1p2+4hzzZK652/knpTEZC81LasLJOc8W8Y9lmn
         FajaE9RVz6RpPYCF/v62iAlMtqO/dvCUp1hXa/Mgz5ffDYEQdwGFxQErd/u7uim5cdkL
         /2KcMtzydkDtcmG2+xdhk2NFLMCL4obzmLx/j+rurulCeV4H34oBjdN4aRo+YpjnKUtf
         fXXKA14Qe1U1eCKe10kKw9zUYEtBHSbi0MOcKc03Yt74PZUqCq/6BryCkE2BkTmUd7Kg
         Hgjcpg4RofTK86uANdPvY4hBuPQU1pwsE0ilXiILH0wgx4rK1KjDjwdetfIa/hXiD6Yl
         3X/w==
X-Gm-Message-State: ALQs6tBPB2GtiOj+BZr7C/mtGS0+qL+meLoMql2vlGGmYsAstEa7AHRF
        7LZ1IiMTQx7GikB33oP3XyMZslDza0tO9gE7xkA=
X-Google-Smtp-Source: AIpwx48Pz7IKMTgq7/BXO2zyacoYKH7gtliRbj48SvLwSIvFjp61UU6l2qfXomSzo/w0uqURrVPvrEFAzl7wzdBIRpo=
X-Received: by 10.176.83.38 with SMTP id x35mr2019695uax.29.1524080358154;
 Wed, 18 Apr 2018 12:39:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Wed, 18 Apr 2018 12:39:17 -0700 (PDT)
In-Reply-To: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 18 Apr 2018 12:39:17 -0700
Message-ID: <CABPp-BEKe1u_e=5V471PzoJjdvuYZ2n8H=h7mVa8fOR7XsoytA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 11:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * en/rename-directory-detection-reboot (2018-04-16) 32 commits
>  - merge-recursive: fix check for skipability of working tree updates
>  - merge-recursive: Fix was_tracked() to quit lying with some renamed paths
>  - t6046: testcases checking whether updates can be skipped in a merge
>  - merge-recursive: improve output precision around skipping updates
>  - merge-recursive: avoid spurious rename/rename conflict from dir renames
>  - directory rename detection: new testcases showcasing a pair of bugs
>  - merge-recursive: fix remaining directory rename + dirty overwrite cases
>  - merge-recursive: fix overwriting dirty files involved in renames
>  - merge-recursive: avoid clobbering untracked files with directory renames
>  - merge-recursive: apply necessary modifications for directory renames
>  - merge-recursive: when comparing files, don't include trees
>  - merge-recursive: check for file level conflicts then get new name
>  - merge-recursive: add computation of collisions due to dir rename & merging
>  - merge-recursive: check for directory level conflicts
>  - merge-recursive: add get_directory_renames()
>  - merge-recursive: make a helper function for cleanup for handle_renames
>  - merge-recursive: split out code for determining diff_filepairs
>  - merge-recursive: make !o->detect_rename codepath more obvious
>  - merge-recursive: fix leaks of allocated renames and diff_filepairs
>  - merge-recursive: introduce new functions to handle rename logic
>  - merge-recursive: move the get_renames() function
>  - directory rename detection: tests for handling overwriting dirty files
>  - directory rename detection: tests for handling overwriting untracked files
>  - directory rename detection: miscellaneous testcases to complete coverage
>  - directory rename detection: testcases exploring possibly suboptimal merges
>  - directory rename detection: more involved edge/corner testcases
>  - directory rename detection: testcases checking which side did the rename
>  - directory rename detection: files/directories in the way of some renames
>  - directory rename detection: partially renamed directory testcase/discussion
>  - directory rename detection: testcases to avoid taking detection too far
>  - directory rename detection: directory splitting testcases
>  - directory rename detection: basic testcases
>
>  Reboot of an attempt to detect wholesale directory renames and use
>  it while merging.


Thanks for rebasing/cherry-picking the series and applying my newest
changes.  It looks like a couple of your squashed fixes in the rebase
of the old commits (designed to deal with compilation errors from the
tree entry functions having been converted to object_id) went into the
wrong commits, breaking bisectability.  When I send out my next round,
I'll only replace the top four commits, but I'll add in a few commits
that can be squashed to fix the bisectability.

Also, the newest patches can still be fooled by a specially crafted
rename/add conflict, but I believe with a small restructure I can both
simplify the code and cover all the cases.
