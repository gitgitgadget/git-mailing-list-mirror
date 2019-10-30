Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 011991F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 18:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfJ3Sjy (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 14:39:54 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:34799 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfJ3Sjx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 14:39:53 -0400
Received: by mail-pf1-f178.google.com with SMTP id b128so2197059pfa.1
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 11:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=uMPesqxMJqbV+iKg1rVGQisqKO4gqbrKD+Nw4IAF9Uw=;
        b=DH8x4idDiVKl1H78XBiM1lWlpPHK4o04Dd1QA8s6w7KjqA1JH7U9RrLqDRVaIMDMUn
         Pb9yZtocSakeNfGA/WBBVUeNEab6XPEWN8Yl00QPrNT2nngWEMsH6CvxBPbfu5z+2zdr
         OPMNaGhlavOY7cOlpbQT9oZakqz7gqazlIFsZN1BSlNT2rMlglUcY0dMdhz+viRTp7BZ
         rUaEbTlB5NOeY+IFgQ/zX/e5BdsKR1fCEL9tXgTp8Vho7UzHUNCxGfWPxTam9YsaTQn2
         2a2iOjOvak61go4VkBhFiKdUt5gVnOifpbYf/IHcxeqZ4p06Oiw5QkfbpilnBAWOMpmJ
         3xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uMPesqxMJqbV+iKg1rVGQisqKO4gqbrKD+Nw4IAF9Uw=;
        b=KZ0bDZDiY/VXco6mcZX39WXoNM8ImfZqRBLc/EXo+B+FgdvjbiXkb42BsaCazssA04
         Au69eJMEnox/vbjkHerj1oGPSKL0LsaOsqWhjlhZiSzwIJ0W7QWqzc4nApqqICCKt7+B
         hmGz7MbuWohM2jYelOr8SgFGFZIDoiR8A65h8FpbsqHusYsqB6cXEm3prKrcXXWFG/MT
         Wfir2CvnqCc+5/j4zBmKp6NwkOxVSxkC+cNQK5Gft6i79B3052ukvWOkuWIy3LCdv2AF
         Pxe/8xOOcSFTXOYRywSCRY9WeIB79T7eAH7ctsSoq9tRJdkui0IkIuvxeB7AIEKWxrcw
         SkjA==
X-Gm-Message-State: APjAAAXQwpwdw5uHxHtSkR0evy51Tpw9UZc66WLwbaF8+YW9zxrq1SUk
        KcOjgtKKh+apJPp4ZGCNgCEgka6A
X-Google-Smtp-Source: APXvYqxQwLfKrWJz620k8FvpXmi+lNS/OMxIDLAdcEkMlgyATwvQhlz8/MkxYfXiVYS3eXsYkegitg==
X-Received: by 2002:a17:90a:d588:: with SMTP id v8mr826224pju.51.1572460792680;
        Wed, 30 Oct 2019 11:39:52 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id 39sm4072689pjo.7.2019.10.30.11.39.51
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:39:51 -0700 (PDT)
Date:   Wed, 30 Oct 2019 11:39:50 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: git branch --edit-description a custom file
Message-ID: <20191030183950.GA21277@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

It seems like everyone working on git.git has their own patch management
system. Currently, I keep all of my branch-specific configurations
(including CC lists) and patches in a worktree within the repo so that I
can keep my configs synced around on different computers.

One thing that's missing about this setup is that I would like to
version my branch descriptions as well since I use those to generate
cover letters. Unfortunately, `git branch --edit-description` only
operates on .git/config.

As a workaround, I rewrote `git branch --edit-description` as a
shell-script that can operate on any config file but I feel like a more
general solution should be warranted.

Would changing the option to `git branch --edit-description[=<config>]`
make sense, where the `<config>` is optional but if it's specified,
it'll operate on that file instead of the .git/config.

Alternately, would it make sense to support a $GIT_CONFIG environment
variable globally? That is, when $GIT_CONFIG is specified, git will
read/write from $GIT_CONFIG instead of .git/config? It'd be a little
heavy-handed for me to make the change just for this one use-case but
perhaps people may find other uses for it?

Thoughts?

-Denton
