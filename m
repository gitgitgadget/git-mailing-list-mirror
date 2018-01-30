Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94E721F404
	for <e@80x24.org>; Tue, 30 Jan 2018 19:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeA3TAu (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 14:00:50 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:47009 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeA3TAt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 14:00:49 -0500
Received: by mail-qk0-f195.google.com with SMTP id l64so11511680qke.13
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 11:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+Pc+uhPPJNLTeR7Y7g06pBQ8YPZWbeYOPTgSa630HGQ=;
        b=W2oEGGzPzYYaRIwNXpqwkpT96h2FsSnQupSZ/kAxjvAuENcKY1HKWfpDublq52wJDy
         /1GgxobIHU7ICG3P/P9tutx1xwgfe1UgASVPemEMY1fIPcDCzKrMGa5ewCj71imLKLzx
         /WBjaObydQ9AfmfIHh2Op7ds5fXddgHU5WOiqxxuBlbLk+qm6h4i4TtxAeVR1yEFO2hs
         cmT+rSLfp7NKHmpqq6pR9Cn5G/XWZ9SksPYp7eYZ8dpSVR5VVJI3d2/DewwLbLOdZksx
         byLTOfuBxkrRxMATbldFokFPmCR/c4EViu2J4P2zsYx8yDLBnqDfYBVutiszZO6BruT0
         GN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+Pc+uhPPJNLTeR7Y7g06pBQ8YPZWbeYOPTgSa630HGQ=;
        b=rgz0o932roDKgX3y0vJJxQKny4Z0015kDLfcZ6sS2Q4oAd32K+kjxXxM33x9ol6Xo4
         ADPu5gd2Jcqjy5h+AsN8E4WVwAvUjJQUJzPc8HHkJ4jWJPALsMXCIps9Dpv4sE3a0BUm
         k7uyFTBhHBmyPxlY8UonYE6HoiH7XfnnbkPJY/eg72KRIlG6dEuNtex/dOlF44/SCtzW
         Z55xPuvWtmXpJCxGTgu9MSgl5XJosKRKgGzp4bgMXPBXY1sOzuwzFA1y2IRyrkidwfC9
         bxDNPuDGQ8q4HAujXZZ8VdLonuv4EpRd38IeCCLnhD7/iOyc2pDbKxcfclAz6/YdiZTk
         iq6g==
X-Gm-Message-State: AKwxytdMZWjl/owX+axGR9t96xWkTo9jcvbn8oUtpbYAvwBucRMc256C
        yKQcdU9xTVfTm9EKAEjroxHpzMbNqV6nFuXwpi2cTg==
X-Google-Smtp-Source: AH8x227wW6I0GLi4GM08GLJ0TRNuptK+pjQWfAdo7n3WOquzdZ2h2buEPiu7ScrQWIua8py+0NmHMtrjipFbcoPU8Hg=
X-Received: by 10.55.204.18 with SMTP id r18mr42836337qki.212.1517338848668;
 Tue, 30 Jan 2018 11:00:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Tue, 30 Jan 2018 11:00:48 -0800 (PST)
In-Reply-To: <615c04025165d0dff9d6e6b66bf11a41.squirrel@mail.jessiehernandez.com>
References: <615c04025165d0dff9d6e6b66bf11a41.squirrel@mail.jessiehernandez.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 30 Jan 2018 14:00:48 -0500
X-Google-Sender-Auth: TGRa8rFTc0nqTHn4GqHzHS0j-QM
Message-ID: <CAPig+cRiyterpyJfayVmA5Ra_zzyVp6GGSNqe2Tx-Hrrif+U8A@mail.gmail.com>
Subject: Re: Creating sparse checkout in a new linked git worktree
To:     git@jessiehernandez.co
Cc:     git@jessiehernandez.com, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 9:25 AM, Jessie Hernandez
<git@jessiehernandez.com> wrote:
>> The sparse-checkout file is specific to each worktree, which allows you
> to control "sparsity" on a worktree by worktree basis. Therefore, you
> should create $GIT_DIR/worktrees/<id>/info/sparse-checkout instead
> (where <id> is "new-branch" in your example).
>
> Would it help if this was added to the documentation of git-read-tree

It probably would. Would you be interested in submitting a patch
(mentioning 'git rev-parse --git-path info/sparse-checkout', as
suggested by Duy)?
