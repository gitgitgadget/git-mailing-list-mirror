Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C90C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 19:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbiHRTRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 15:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244440AbiHRTRk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 15:17:40 -0400
X-Greylist: delayed 442 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Aug 2022 12:17:38 PDT
Received: from mail.cs.ndsu.NoDak.edu (mail.cs.ndsu.NoDak.edu [134.129.125.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2A26ADCC2
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 12:17:38 -0700 (PDT)
Received: by mail.cs.ndsu.NoDak.edu (Postfix, from userid 50631)
        id D004F3F2E0; Thu, 18 Aug 2022 14:10:15 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ndsu.NoDak.edu (Postfix) with ESMTP id BB8123F2C5
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:10:15 -0500 (CDT)
Date:   Thu, 18 Aug 2022 14:10:15 -0500 (CDT)
From:   Michael Hennebry <hennebry@web.cs.ndsu.nodak.edu>
X-X-Sender: hennebry@mail.cs.ndsu.nodak.edu
To:     git@vger.kernel.org
Subject: There is no tracking information for the current branch
Message-ID: <alpine.DEB.2.21.2208181407290.2645@mail.cs.ndsu.nodak.edu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a git repository I use for all related work.
I cloned it for two reasons:
A backup.
Allow testing whether everything needed is under version control.

This seems like something that should be easy.
If I cannot do it, I might have to give up on version control,
as git seems to have conquered the world.

To be clear, by "cloned", I mean that I made it with git clone.
I want to maintain the clone as a more or less exact copy of its mother.
The clone, of course, would remember its mother.

From git help fetch and git help pull , I gathered I could do this.
Nyet.
No combination of git fetch and git pull seems to do the trick.
Eventually I got
[hennebry@fedora sqrt-g]$ git pull
\There is no tracking information for the current branch.
Please specify which branch you want to merge with.
See git-pull(1) for details.

     git pull <remote> <branch>

If you wish to set tracking information for this branch you can do so with:

     git branch --set-upstream-to=origin/<branch> master

[hennebry@fedora sqrt-g]$ gvim /tmp/git.txt
[hennebry@fedora sqrt-g]$ pwd
/home/hennebry/sqrt-g
[hennebry@fedora sqrt-g]$ git branch
   corrections
* master
   split1
[hennebry@fedora sqrt-g]$

I am not happy.
What happened?
How do I do what I want to do?
Will I have to process each branch one at a time?
That could be difficult, since at the moment,
I cannot even process one branch.
git fetch --all ?

The mother is on an SD card that through USB has
been continuously connected to my PC at all times.
The clone is on my hard drive.

[hennebry@fedora sqrt-g]$ git remote -v
origin	/run/media/hennebry/data2/mathprog/sqrt-g (fetch)
origin	/run/media/hennebry/data2/mathprog/sqrt-g (push)
[hennebry@fedora sqrt-g]$ [hennebry@fedora sqrt-g]$ git diff
[hennebry@fedora sqrt-g]$ git merge
fatal: No remote for the current branch.
[hennebry@fedora sqrt-g]$


-- 
Michael   hennebry@web.cs.ndsu.NoDak.edu
"Sorry but your password must contain an uppercase letter, a number,
a haiku, a gang sign, a heiroglyph, and the blood of a virgin."
                                                              --  someeecards
