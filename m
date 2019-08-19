Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D16171F461
	for <e@80x24.org>; Mon, 19 Aug 2019 20:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfHSUXO (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 16:23:14 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:50574 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfHSUXN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 16:23:13 -0400
Received: by mail-wm1-f48.google.com with SMTP id v15so691936wml.0
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 13:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxkspoYsFqMQf58PPc0amr4+iA46wVhcGi0uAglCgQw=;
        b=gEfoKyQg5Xr0F+g675GBtaXb3qsNyBSm5DFQbkIcK/F03iuq4dk3IzCap5I1EzdJS8
         3GTd7DfNAy0XmeWAIfi74d1cjKUNbVqI1T2Y5pczHnVrlNGXsic3yYagChrx/u459XMI
         4qRRsZN1TUqIyhYoyY6E5JUAt1M+gQ1S2LBE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxkspoYsFqMQf58PPc0amr4+iA46wVhcGi0uAglCgQw=;
        b=qo0OAfB2Og9TFqeXXNN/DYlcfHKW51mIQwzWZUhf5aX0714jwQyGv3oOH5rp6eBdhB
         f4SLFJS/DuVRFEEdArYyYwC9alRLybgR17CcvMsKf6Zf5bVZ+Ye5Lgl5Nxj9imAHomDQ
         oLzZPoQlUVhk04chkVUxyiVRyINphuZXO+CHd/em0Sd6G7Ftl+6AxIpDQTF5v04AatXo
         EUPOGL+A1WU2GeeYFwPq02SveBHFQi8i4gAtJ9HOzyID+SGTPsXurF8u/NtU2qBSSLnq
         CmOw0R/Ub2cPkWcRFh8cJiJyvKijWriBtTW7f0XBSjUR36YoH6mpFCK0TqgdqYj5UkJ2
         REkA==
X-Gm-Message-State: APjAAAWeFUZZciigYmvVimYzjUz7DfQLenW2XL1p1uMRtG6+Webupz8x
        RNfE8I/vXM+Jblku5Bmz2vMMRAISQtFlCF9K9hwdaw==
X-Google-Smtp-Source: APXvYqwFSwwEWRyaXFnkiv55DnNvjJlXZSjKZuwGj7ci9ImxVCewAuA5Cnz0B7OfjoH65Gwh1OATNehiBov2eajcWF4=
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr21649834wmf.47.1566246191784;
 Mon, 19 Aug 2019 13:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <CALSvhyb7Td-ugzze9cSLXRjF78w=zE5=3yuMFZVeuXsCWLSjHg@mail.gmail.com>
In-Reply-To: <CALSvhyb7Td-ugzze9cSLXRjF78w=zE5=3yuMFZVeuXsCWLSjHg@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 19 Aug 2019 21:23:06 +0100
Message-ID: <CAE5ih78UOor3XT_hDofanoGUPLD1BC2y=pCbzF-Edm2mpRvjyQ@mail.gmail.com>
Subject: Re: git-p4: Clone p4 path with bidirectional integrations
To:     Aaron Miller <aaronkmiller@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 19 Aug 2019 at 18:30, Aaron Miller <aaronkmiller@gmail.com> wrote:
>
> Hi all,
>
> Is it possible to `git p4 clone --detect-branches` from a Perforce
> path which contains bidirectional integrations?
>
> I've tried a bunch of things to get this to work, but here's an
> example which hopefully illustrates what I'm trying to accomplish
> and the issue I'm having.

I have to admit I don't use the detect-branches code myself.

It's possible that running with "-v" might give a bit more information.

Can you write a test case, or even just a shell script, that might
help figure out what's going on.

Unfortunately Perforce doesn't really know about branches, so git-p4
has to make a guess!

>
> Perforce setup, assuming PWD is mapped to //depot/... in your client spec:
>
>   1. mkdir -p testing/master
>   2. touch testing/master/test1 && p4 add testing/master/test1 && p4 submit
>   3. p4 integrate //depot/testing/master/...
> //depot/testing/staging/... && p4 submit
>   3. touch testing/staging/test2 && p4 add testing/staging/test2 && p4 submit
>   4. p4 integrate //depot/testing/staging/...
> //depot/testing/master/... && p4 submit
>
> Now try to clone with git-p4:
>
>   1. git init p4_git_test && cd p4_git_test
>   2. git config git-p4.branchList master:staging
>   3. git config --add git-p4.branchList staging:master
>   4. git p4 clone //depot/testing/...@all --detect-branches .
>
> You end up with a failure like:
>
>   Importing from //depot/testing/...@all into .
>   Reinitialized existing Git repository in /home/amiller/p4_git_test/.git/
>   Importing revision 1205832 (25%)
>       Importing new branch testing/master
>
>       Resuming with change 1205832
>   fatal: ambiguous argument 'refs/remotes/p4/testing/staging': unknown
> revision or path not in the working tree.
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
>   Command failed: ['git', 'rev-list', '--reverse', '--no-merges',
> 'refs/remotes/p4/testing/staging']
>
> I'm using Git 2.22.1.
>
> Thanks,
> Aaron
