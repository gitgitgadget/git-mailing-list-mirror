Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594261F453
	for <e@80x24.org>; Fri,  1 Feb 2019 14:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfBAOAn (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 09:00:43 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:47055 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729885AbfBAOAl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 09:00:41 -0500
Received: by mail-wr1-f41.google.com with SMTP id l9so7146058wrt.13
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 06:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NexgS791zbz61FiIHesnD9zIPyKczFTlBgyJuiFkJls=;
        b=aL81ytil610KBL+YbAZuhNZ4qMMETWEHL+8c71yppRBQQ/9zQ13k3c2jA1Q5v/BbUb
         cTfiHyKdl3vLKI1rnc53wZuhOIhegUyQdjy0HNgvr8ewqO9Aayo2oLJBf9C6/irndE6z
         aLUBjw6M/5cQR1ck6AFgPJq1gTYJGv7iUE8yta2BsPjd8Bfpu+opHga5Jca4JfMUZGu7
         /v9UktLucC+xGRFB3pVFDhvYwJDMcn4T27xjKwvBjTU9fTaLvbxx6FugX4mLttJyJa8q
         w1VixqTocTdtYjTUOGNSkh+no7JbgmKjgdTOq8Nh39uw8WXbJX/sYc7RdlygzFgrKmpZ
         WGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NexgS791zbz61FiIHesnD9zIPyKczFTlBgyJuiFkJls=;
        b=BqPazYo6yhv9QE/GSbFg08eaA8ka0c78nsv7r+48S2xkQwKNa26909ymvyRcm+kdAR
         bk9RDhOyZvwqls/Xf0LrPco9jVQ3zLCCjA/Yrm2JlmwZ+uiIqeLzSc/Z/U7qZ8UVOiRX
         jonFBJ3sAfwTO16mpJN5CXaJfsea4TXNIzwuPN5eKajzvdopQN3y9fzkqVeovOc/F8UR
         29qcTnLcLwVThT0LFXQFePuXPOhf5uXjK/cb9nXKRr+bLgSNGn601bVAbiy4CtzSqQiH
         4Ev4IyrFE4lxFgbxkc2WNbaFtgSpELx5z5NLS/8q3TmSyCkcmcFBemxaPC8xpDt2cJgs
         NY/g==
X-Gm-Message-State: AJcUukcy5VY+kYtu0zyKwdI6t5ZpLyGB4dQZcgePjEQlD3kVQal0lHFc
        Dzp3HPxKQwt8nawaDlrg8gf9NW3SyYo08O1QbSkV6uDY
X-Google-Smtp-Source: ALg8bN7u55EzeKOxqQaBpWOKPkjIqHBeo/2uVULOgbN8i1xahVKIBGcDk0/a37lZU5nEPxabIgyXcFWuSf/dgiuCdcw=
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr39822809wru.177.1549029639525;
 Fri, 01 Feb 2019 06:00:39 -0800 (PST)
MIME-Version: 1.0
References: <CAKQS2drF+CQTiKtXD6Kx1ZbH9ZTekWmbfiiHTCJV_BrT5-gAFQ@mail.gmail.com>
In-Reply-To: <CAKQS2drF+CQTiKtXD6Kx1ZbH9ZTekWmbfiiHTCJV_BrT5-gAFQ@mail.gmail.com>
From:   Ole Pinto <olepinto@gmail.com>
Date:   Fri, 1 Feb 2019 15:00:28 +0100
Message-ID: <CAKQS2dqx9Nux11ot7a-Wxd2qpcdAAWw-e7Li+X3bw7TxJS=Kyw@mail.gmail.com>
Subject: Fwd: Submodules & worktree
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding a worktree from a working copy with submodules doesn't work.

In the config file I have
    [submodule]
        recurse = true

It that's not present, I don't find the problem.

# Preparation

$ git --version
git version 2.20.1

$ cd /tmp/

$ git init main_repo
Initialized empty Git repository in /tmp/main_repo/.git/

$ git init repo_submod
Initialized empty Git repository in /tmp/repo_submod/.git/

$ cd repo_submod

$ echo Some text > file.txt

$ git add file.txt

$ git ci -m "First commit in subrepo"
[master (root-commit) ebc9325] First commit in subrepo
 1 file changed, 1 insertion(+)
 create mode 100644 file.txt

$ cd ../main_repo/

$ git submodule add /tmp/repo_submod submod
Cloning into '/tmp/main_repo/submod'...
done.

$ git ci -am "First commit, add submodule"
[master (root-commit) 695b3a1] First commit, add submodule
 2 files changed, 4 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 submod

# Problem 1 (can't run worktree add)

$ git worktree add ../wt -b new_branch
Preparing worktree (new branch 'new_branch')
fatal: exec '--super-prefix=submod/': cd to 'submod' failed: No such
file or directory
error: Submodule 'submod' could not be updated.
error: Submodule 'submod' cannot checkout new HEAD.
fatal: Could not reset index file to revision 'HEAD'.

The new directory (../wt) is created and removed (seen with strace).
The new branch is created and not removed.

# Problem 2 (submodule status seems not to detect some cases)

$ pwd
/tmp/main_repo

$ git submodule status
 ebc9325f7b19164c9bdfd05263481ded66d7bd7d submod (heads/master)

$ rm submod/file.txt submod/.git

$ git submodule status
 ebc9325f7b19164c9bdfd05263481ded66d7bd7d submod

So, I have a plain, empty directory where the submodule should be. Not
having any 'first char', I'd expect it to be checked out and up to
date. Is this expected?

Thanks a lot for the work!
