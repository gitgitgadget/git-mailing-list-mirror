Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D32231FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 13:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbdDLNgg (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 09:36:36 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33456 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbdDLNge (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 09:36:34 -0400
Received: by mail-oi0-f50.google.com with SMTP id b187so31512488oif.0
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 06:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oWTmEkvoKTx+t77hXAb8zC3zDohUEurFVH4fBY6/WZU=;
        b=a/E/FbFRCV2MTlXNwSfUnpxMyhir9T8qMmA+Np4sTt6GWvYUCcBbhkURTBzN7KzHNT
         z1afZoNY/pothx9nSZXRtFVEEBMI4dat4nBqQtToexZdO3YomLP1gNcgXrfDfnAcL4vO
         cUog0XviYTQ8b7DhOz9LNHwNFvDbJ1zxUt/0NOA6QgvCWUijB74n7BnCjvNNQBKoejoe
         IzatXqnk0JT48BcIJ/GDhXPG34ygNjxld9pzaD4R7698Tf3fxOSSGPB4r6bYWq2boud9
         +uWCux9gpibLjDn3bDWPYbn4dH2cQLRE6ehZfMksGovx8VmOP2LtcMl+WjYcrWQ5N6iR
         aNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oWTmEkvoKTx+t77hXAb8zC3zDohUEurFVH4fBY6/WZU=;
        b=K8oTj8QjLinIxQqXm07qzAU7Z2chz8PXYIc5CvGAbdPFfh5CyUQzQfAvncGDnffPPB
         3HGKS+2QELiTAvOAwJ/4IX2vtre045eqg+ACv48zl+XXOzcgskt8I6AHRoXGe4sruX33
         tfkYVlihHqjTRhOVYpQfYzzDJy7y7mUy+wTYy/ClK1Xrdvgo6pl7s4q++YX1rC48xCc2
         Nu+UKrEPzH8cDxdPZCEmiYOcoa6h5tyrsGp2ilhtoAPcoBo7tTH8U7z/K1A5JLe6jY8r
         H0EHFHdyCkr0qJK+2GfVacHkcvi172Ur5sH3BWQMuW2ZIG2RBQ34L+EaZ96w1Nl+fN2K
         zYgA==
X-Gm-Message-State: AN3rC/6Dr7k8KxtCP7nrGgHyavFIndFlwOsZQ/K55sjZQBxsTtClgRJDDms2IuejyzImzvnvfhSwy8tYjVHfnw==
X-Received: by 10.202.214.141 with SMTP id n135mr7435337oig.186.1492004193933;
 Wed, 12 Apr 2017 06:36:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Wed, 12 Apr 2017 06:36:03 -0700 (PDT)
In-Reply-To: <63F1AEE13FAE864586D589C671A6E18B0CFBF7@MX203CL03.corp.emc.com>
References: <63F1AEE13FAE864586D589C671A6E18B0CFBF7@MX203CL03.corp.emc.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 12 Apr 2017 20:36:03 +0700
Message-ID: <CACsJy8CBjO+Wg187LUTGs1nna1trV2nukgS9uK74PcY-dEFGaA@mail.gmail.com>
Subject: Re: git work trees
To:     "taylor, david" <David.Taylor@dell.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 10:14 PM, taylor, david <David.Taylor@dell.com> wrote:
> We are using Git in a distributed environment.
>
> In the United States, we have the master repository in one state and a build cluster in a different state.
> In addition to people in the US doing builds, we have people in other countries (Ireland, India, Israel,
> Russia, possibly others) doing builds -- using the build cluster.
>
> The local mirror of the repository is NFS accessible.  The plan is to make builds faster through the use
> of work trees.  The build cluster nodes involved in the build will have a worktree in RAM -- checked out
> for the duration of the build.  Since the worktree is in RAM, it will not be NFS accessible.
>
> [Cloning takes 20+ minutes when the network is unloaded.  Building, with sources NFS mounted, takes
> 5-10 minutes.]

Using worktrees in this scenario kinda defeats the distributed nature
of git. Cloning takes long, yes. But what about just "git pull" (or
"git fetch && git checkout -f" if you want to avoid merging)?

> This presents a few problems.
>
> When we are done with a work tree, we want to clean up -- think: prune.  But, you cannot prune just
> one worktree; you have to prune the set.  And no machine has access to all the worktrees.  So, no
> machine knows which ones are prunable.

By "prune one worktree", did you mean delete one? Or delete a branch
the worktree uses and prune the object database?

> There is no 'lock' option to 'add'.  If someone does a 'prune' after you do an 'add' and before you do a
> 'lock', then your 'add' is undone.
>
> Are there any plans to add a '[--lock]' option to 'add' to create the worktree in the locked state?  And/or
> plans to add a [<path>...] option to prune to say 'prune only this path / these paths'?

So this is "git worktree prune". Adding "worktree add --locked" sounds
reasonable (and quite simple too, because "worktree add" does lock the
worktree at creation time; we just need to stop it from releasing the
lock). I might be able to do it quickly (it does not mean "available
in the next release" though).

If you need to just prune "this path", I think it's the equivalent of
"git worktree remove" (i.e. delete a specific worktree). Work has been
going on for a while to add that command. Maybe it'll be available
later this year.

> If there are no plans, is the above an acceptable interface?  And if we implemented it, would it be looked
> upon favorably?

Speaking of this use case (and this is my own opinion) I think this is
stretching "git worktree" too much. When I created it, I imagined this
functionality to be used by a single person.
-- 
Duy
