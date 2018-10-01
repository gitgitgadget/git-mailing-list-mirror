Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39421F453
	for <e@80x24.org>; Mon,  1 Oct 2018 08:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbeJAPcN (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 11:32:13 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:47000 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbeJAPcN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 11:32:13 -0400
Received: by mail-ed1-f45.google.com with SMTP id g32-v6so3029801edg.13
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=e+fkagyYJHcz13Yay412kDEOrU7ig1VBTKp+pCzUdFk=;
        b=cT7CdxtSUxjRtrkjCNM5yJM//ymDaQoXXTKxysHAerg5lqRxA8P8tafdcbPOQ1qwfB
         lPa7E0Zn2arN0grXvpawrLAQxEFXcNYg1owUQ89XgAJeYSnJta2NCOImDC9MKUMRsE/m
         i2i8bqPU8fX0T/YKsKbjVDFVFD6G5U6/PmaFKqjJRrVdKatnlFPeLSIHDFIdATWe57hs
         jp7cfYr5zWrtzLl/wiIQiE5ER+DN89gM2ze+01KcxIXtMtnFMFoJRUGTYneeoiJ6K14n
         IVBF7gb/I1+mYipWZc4Merx9UANJLL6EqVYh35qSj6A4OXNZ9n68ObK9WutJLstF22Ok
         pBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=e+fkagyYJHcz13Yay412kDEOrU7ig1VBTKp+pCzUdFk=;
        b=plzH/o/BMS6QMnyrfkIgJUUbRcvfB/f39KxaLX80RCu0Lm9C+xDBZ+EwkKtAqYEc0g
         4Hcv6i9Nr90i3F+L+SK5lXFpi7GTKx6+ZzMdjhOLg7B5U6PMbU9nieIAGsppqPMc/Dfw
         zbKxdFl9yUI4ca+Esx6bhf6neqqOhfwfpuTkF0K6yLVcvOznKASSajkI61rzswY/T2fs
         Dqc0Of+ySsFvC+9tI3ylczUd+ty1JgqSPvwO3lYYBavUwPCJz930b+SAGZn+5aSutPP6
         7ZLo2EJ08VR+YyMom7x6Br57XFKNl1Dv7OFXf6swUlsH79AakXZasWw51SeVA7KlShsc
         csWg==
X-Gm-Message-State: ABuFfogCe0WioL4UibHynhLBKSvJMY9qQclHsmYFMnLefSGC6qHQo3Gs
        BAW3QK2vtNX01tUAItAh+/o=
X-Google-Smtp-Source: ACcGV63QyIjf+vGuxaUhp7t5ipM78x0pUfnNoCFAdaZSGOiWcQvIqqiKUoVRCL4Nuuew97YHEa1eTw==
X-Received: by 2002:a50:f397:: with SMTP id g23-v6mr6245167edm.110.1538384130656;
        Mon, 01 Oct 2018 01:55:30 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id o29-v6sm289196edc.95.2018.10.01.01.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 01:55:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jose Gisbert <jose.gisbert@live.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Using git svn rebase at quarantine environment or a feasible alternative to synchronize git and svn repositories
References: <VI1PR0902MB2223EA3FC0ACE7E9AFB7A6ACE2EF0@VI1PR0902MB2223.eurprd09.prod.outlook.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <VI1PR0902MB2223EA3FC0ACE7E9AFB7A6ACE2EF0@VI1PR0902MB2223.eurprd09.prod.outlook.com>
Date:   Mon, 01 Oct 2018 10:55:28 +0200
Message-ID: <87a7nyhwqn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 01 2018, Jose Gisbert wrote:

> Dear members of the Git community,
>
> The enterprise I work for is planning to switch from svn to git.
>
> Before the complete switch to git we have decided to implement a scenario
> where the two SCMs live together, being the svn repository the reference. We
> also want this scenario to be transparent for both SCM users.
>
> I read the articles referenced at the end of the email and I come to the
> following solution.
>
> My proposal consists to import the svn repository to git using git svn and set
> receive.denyCurrentBranch to updateInstead. Then install pre-receive and
> post-receive hooks and set that repository as the central repository for git
> users.
>
> The pre-receive hook does git svn rebase and, if there is an update at the svn
> repository, rejects the push and instructs the user to do git pull. The
> post-receive hook does git svn dcommit to update the state of the svn
> repository, then instructs the user to do git pull too.
>
> Both scripts check the changes pushed are made at master before doing anything
> and exit after performing these tasks. branches.master.rebase is set to merges
> at the user repository to avoid the histories of the central and the user
> repositories diverge after doing git svn dcommit.
>
> However I'm stuck at this point because the pre-receive hook it's not allowed
> to do git svn rebase because update refs are not allowed at the quarantine
> environment. I was sure that I tried this solution with a past version of git
> and it worked, but now I doubt this because the restriction to update refs at
> quarantine environment was delivered at version 2.13, that dates from April
> 2017, if I'm not wrong.
>
> I don't know if this solution could be implemented or is there a better way to
> accomplish this kind of synchronization (I tried Tmate SubGit, but it didn't
> work for me and I don't know if we will be willing to purchase a license).
> Could you help me with this question?
>
> I come here asking for help because I think this is the appropriate place to
> do so. I apologise if this is not the case. Any help is welcome. If anything
> needs to be clarified, please, ask me to do so. I can share with you the
> source code of the hook scripts, if necessary.

A very long time ago I had a similar setup where some clients were using
git-svn. This was for the first attempt to migrate the Wikimedia
repositories away from SVN.

There I had a setup where users could fetch my git-svn clone, which was
hosted on github, and through some magic (I forgot the details) "catch
up" with their local client. I.e. there was some mapping data that
wasn't sent over.

But users would always push to svn, not git. I think if you can live
with that you'd have a much easier time, having this setup where you
push to git and you then have to carry that push forward to svn is a lot
more complex than just having the clients do that.

GitHub also has a SVN gateway, that has no open source equivalent that I
know of:
https://help.github.com/articles/support-for-subversion-clients/

Maybe that's something you'd like to consider, i.e. fully migrate to git
sooner than later, and for any leftover SVN clients have them push to a
private repo on GitHub. Even if you only keep that GitHub repo as a
bride during the migration and host Git in-house it'll be a lot easier
with git as a DVCS to continually merge in those changes than pulling
the same trick with a centralized system like SVN.
