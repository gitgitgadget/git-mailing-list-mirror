Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B76DA20958
	for <e@80x24.org>; Mon, 20 Mar 2017 17:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755453AbdCTRhv (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 13:37:51 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35659 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755414AbdCTRht (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 13:37:49 -0400
Received: by mail-pg0-f53.google.com with SMTP id t143so14873576pgb.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F2YiMmUHFg/M/pJsiecsMmn/tN0ZO3B8rWEkXrI8Ebo=;
        b=sOR2GrhEyZAsujYgkLuDyKZYNo5N4leFe35oTMMm+Pzw0P6zoSix0ekaJ9jc92jkrF
         4tojYRiNH5asbxDchFxRtQwzh7GOJUAE+C11WVMd7t+ior6+ZuzysuUqDUT1WdE2qRA5
         yp+01ldAav6r9a6h7TglQXD97liCSQgKlPAsDqw7+KaX5d9yTHMtoqBfzXihn3Ik1jxv
         Snp0wpOcsm0L4HjS7F6cL0nzXnPJCiNtmDTISIjztrTMb3D3+y1JucLiadrmllrvEg/x
         FqIDh4h8FkrFmMq4eluv1lbeyABsHrSdRQB0fcjmC8ro1uqdUTD320EtDvCv33gCLIF4
         c/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F2YiMmUHFg/M/pJsiecsMmn/tN0ZO3B8rWEkXrI8Ebo=;
        b=Y6+hJEs2WD1boMvvZLIfh8JEIT/glKdxp/9LFFGkVxvO7TPZDZFMngAGbEqR4v09wY
         OhSNFL/o1Ne6rj3xpQjjJYa40hIUZHZTe2XcLFiJZPbb2e/txnuCytd35WROlY6obcpv
         NokiLU/chCvysVieLlasnRAB7idgq+GQDKitu6ir9QR62mQpvvwviSrvawaNZFspRUpm
         jzsYmz7WwXEnNXFx1XSHHtOztbNfFsfxX1BDf5rdCthmBK+DHx7az9XxdLayqXdVyT+7
         ERNRnsv5aKLgOAAYwPR2qGg7EJJ0I4GU+Zy0/Xqrt5vtorybss6jg5NAKKWKgblip6iq
         7uXA==
X-Gm-Message-State: AFeK/H0pfJaHXgP5zPbbXO80VCtiMDjNc6KzgZxeLeEjcmME/i3YtuUr4vRFcVvr6F3K2JS/6rHt1sYSsqSGUp5l
X-Received: by 10.98.48.196 with SMTP id w187mr6834325pfw.179.1490030996753;
 Mon, 20 Mar 2017 10:29:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Mon, 20 Mar 2017 10:29:56 -0700 (PDT)
In-Reply-To: <xmqq60j75psk.fsf@gitster.mtv.corp.google.com>
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
 <20170317225110.13417-1-sbeller@google.com> <xmqq60j75psk.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Mar 2017 10:29:56 -0700
Message-ID: <CAGZ79kayeSxFTJr3Q1atFgOyR74PzQyCLiejuZxh7+wTGGb=ww@mail.gmail.com>
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees on
 the file system
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 6:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> -List details of each worktree.  The main worktree is listed first, followed by
>> -each of the linked worktrees.  The output details include if the worktree is
>> -bare, the revision currently checked out, and the branch currently checked out
>> -(or 'detached HEAD' if none).
>> +List details of each working tree.  The main working tree is listed first,
>> +followed by each of the linked working trees.  The output details include if
>> +the working tree is bare, the revision currently checked out, and the branch
>> +currently checked out (or 'detached HEAD' if none).
>
> I do not think this is correct.
>
> Think of a "worktree" something that roughly corresponds to
> different location you can refer to with $GIT_DIR.
>
> A $GIT_DIR may be a true repository.  Or it may be borrowing many of
> the things from its primary repository.  Even though "git worktree"
> Porcelain may not currently be equipped to create a "bare" $GIT_DIR,
> there is no fundamental reason that a secondary "worktree" must have
> a working tree, i.e. a "worktree" could be a "bare" one (it would be
> the first use of per-worktree config; a secondary worktree that is a
> bare can be made by borrowing from the primary worktree that has a
> working tree).

While it may be true that you can have bare worktrees; I would question
why anyone wants to do this, as the only thing it provides is an
additional HEAD (plus its reflog).

> Now, what does "git worktree list" enumearate?  It does not list
> "working trees"; its output are list of things, each of which you
> could point at with $GIT_DIR and work with.

$ git worktree list
/.../git                   0b47ebba82 [status-short]
/.../git_origin_master     5588dbffbd (detached HEAD)
/.../submodule_remote_dot  3d9025bd69 (detached HEAD)

This looks to me as if it is listing actual working trees. But looking
at the actual code, I confirm we list worktrees here, even bare
worktrees are taken care of.

That said, "worktree prune" (as well as (un)lock) are operating
on "worktrees" as you defined above:

$ git worktree add test
$ git worktree list
# see the "test" worktree listed by its working tree
rm -rf test # remove the working tree attached to the test worktree
$ git worktree list
# see the "test" worktree listed by its working tree, still there
$ git worktree prune
$ git worktree list
# the "test" worktree is gone.

So maybe we need a patch that is s/working tree/worktree/
in the prune section?

Thanks,
Stefan
