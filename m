Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA9B2209FA
	for <e@80x24.org>; Wed, 12 Apr 2017 19:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754767AbdDLTxi (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 15:53:38 -0400
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:16943 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754445AbdDLTxg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Apr 2017 15:53:36 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Apr 2017 15:53:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=emc.com; i=@emc.com; q=dns/txt; s=jan2013;
  t=1492026816; x=1523562816;
  h=from:to:cc:subject:date:message-id;
  bh=wW9Ax7rw+xqhmD10jcx4ErcWGqy/jM3RH76VvmQWr4I=;
  b=nnA5263aiaC0jcffGLxt00Y05Z+h8vQCkFGcw6p9s/xDdSq3Ze3CoOwh
   InqYzfmV6cIv3NRk1m1wlsNBseN5kG3sWJItY1pSzhwTFBDsbjYOBE6vb
   +frnYwepkydnZEg3FiiTs3lc303w/0tKCnVhJUuYNu1RUfkkiI5dbJ+ZG
   w=;
Received: from esa3.dell-outbound2.iphmx.com ([68.232.154.63])
  by esa8.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2017 14:43:56 -0500
Received: from mailuogwdur.emc.com ([128.221.224.79])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Apr 2017 01:42:43 +0600
Received: from maildlpprd55.lss.emc.com (maildlpprd55.lss.emc.com [10.106.48.159])
        by mailuogwprd53.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id v3CJhsRG030533
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Apr 2017 15:43:55 -0400
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd53.lss.emc.com v3CJhsRG030533
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=emc.com; s=jan2013;
        t=1492026235; bh=Z7AWidwmhqFKGyNV0Uul5Ex74QM=;
        h=From:To:cc:Subject:Date:Message-ID;
        b=hpRcKR5DGomJVMNk33l36ff5Fx7tOxHyoDlKpRnhdxJ76PNVM9cRc31/HmPPgXwcJ
         /Wlq5bzHktCKO7pAIwFsTbuvBPyz/e8YptUEVkIQoJVVjoWtN2mrgDSwHIDCLfpo9J
         92Z9YuiJ8n75D+9cYrlRAjR5t1JuJ/MvHeseJttU=
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd53.lss.emc.com v3CJhsRG030533
Received: from mailapphubprd01.lss.emc.com (emcmail.lss.emc.com [10.253.24.51]) by maildlpprd55.lss.emc.com (RSA Interceptor); Wed, 12 Apr 2017 15:43:18 -0400
Received: from usendtaylorx2l (d5170089.lss.emc.com [10.243.146.89])
        by mailapphubprd01.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id v3CJhZ5L022919;
        Wed, 12 Apr 2017 15:43:35 -0400
Received: by usendtaylorx2l (Postfix, from userid 26043)
        id 202A5260792; Wed, 12 Apr 2017 15:43:34 -0400 (EDT)
Received: from usendtaylorx2l (localhost [127.0.0.1])
        by usendtaylorx2l (Postfix) with ESMTP id EFF142604DC;
        Wed, 12 Apr 2017 15:43:34 -0400 (EDT)
From:   David Taylor <dtaylor@emc.com>
To:     pclouds@gmail.com
cc:     git@vger.kernel.org
Subject: 
X-Mailer: MH-E 8.5; nmh 1.5; GNU Emacs 24.3.1
Date:   Wed, 12 Apr 2017 15:43:34 -0400
Message-ID: <9305.1492026214@usendtaylorx2l>
X-RSA-Classifications: public
X-Sentrion-Hostname: mailuogwprd53.lss.emc.com
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

Merging isn't the issue.  Speed is an issue.  Repeatability is an issue.
Disk space is an issue.

If someone does a build on their desktop instead of using the build
cluster, it will take hours rather than minudes.  And if they are not in
Massachusetts, they probably don't have access to the controlled
toolchain that is used to do the builds.

Users may choose to share their repository amongst several work trees
rather than having lots of clones.  Their choice.  Such work trees would
be 'long lived'.

I was thinking of a different use for work trees.  Work trees that would
be short lived -- less than, say, two hours.  Typically less than 30
minutes.

There would be a local repository mirroring the master repository.  It
would be a true mirror -- it would be updated only from thhe master via
git fetch; there would never be any 'git commit's to it.

When someone who is remote to Massachusetts (which is where the build
cluster lives), wants to do a build they will invoke a script (yet to be
written) that will determine two things:

  . a SHA1 that exists in the master repository that is an ancestor of
  their workspace

  . their workspace differences relative to that SHA1

A lightly loaded build cluster node will be selected, it will be given
the SHA1 and the patch file.  A short lived worktree will be created
which has the SHA1 checked out and the patch applied.

Once the workspace has been recreated, it is built.

[Actually, the build target is decomposed into a dozen pieces that are
built on separate build cluster nodes in parallel using separate copies
of the workspace.]

The build deliverables will be delivered back to the requestor and the
intermediate build products and the work tree will be deleted.

[The script will also be used by Jenkins for continuous integration builds.]

    > This presents a few problems.
    >
    > When we are done with a work tree, we want to clean up -- think: prune.  But, you cannot prune just
    > one worktree; you have to prune the set.  And no machine has access to all the worktrees.  So, no
    > machine knows which ones are prunable.

    By "prune one worktree", did you mean delete one? Or delete a branch
    the worktree uses and prune the object database?

As in:

  rm -rf /path/to/top/of/work/tree

and then ideally:

  git worktree prune /path/to/top/of/work/tree

or, alternatively, just:

  git worktree prune

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

Yes, add the worktree, and if there are no errors, leave it in the
locked state.

    If you need to just prune "this path", I think it's the equivalent of
    "git worktree remove" (i.e. delete a specific worktree). Work has been
    going on for a while to add that command. Maybe it'll be available
    later this year.

I'm not familiar with 'git worktree remove', but, yes, just 'git
worktree prune' a specific specified path.  I was thinking do what 'git
worktree prune' does, but do it only for the path(s) specified on the
command line.

[While I only anticipate giving it one path, I see no need / reason to
limit it to just one path on the command line.]

    > If there are no plans, is the above an acceptable interface?  And if we implemented it, would it be looked
    > upon favorably?

    Speaking of this use case (and this is my own opinion) I think this is
    stretching "git worktree" too much. When I created it, I imagined this
    functionality to be used by a single person.

Cloning is expensive (20+ minutes, ~5 GB); checkout is cheap (seconds,
100's of MBs).  This is / was seen as a speedup.

I also noticed during my experiments that git sometimes looks at the
repository when I wouldn't expect it and gets an error if the directory
above the worktree does not exist.  These experiments were with 2.10.2;
I haven't tried yet with 2.12.2 nor with the head of the master branch.

I haven't (yet?) reported this as a bug, but what I did was:

. create a directory for the tests

  mkdir /home/dtaylor/worktree-tests

. create a couple of worktrees (neither locked)

  cd /top/of/repository
  git worktree add -f --detach /home/dtaylor/worktree-tests/tree_1 first-branch
  git worktree add -f --detach /home/dtaylor/worktree-tests/tree_2 second-branch

Different computer, where /top/of/repository is accessible (it is NFS
mounted), but /home/dtaylor/worktree-tests does not exist (/home is a
local partition, actual home directories go elsewhere), do:

  cd /top/of/repository
  git fetch ==> error message about /home/dtaylor/worktree-tests not existing
  git status ==> error message again

and then the real surprise (I wouldn't expect this one to access the
repository):

  git help ==> error message again

But, of course, if I do:

  cd /

(no repository in sight) and then do:

  git help

it works as expected.

I don't know if 2.12.2 or possibly HEAD fixes this.  My testing was done
with 2.10.2.  I was going to wait until I knew before reporting it.

    -- 
    Duy
