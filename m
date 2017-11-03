Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB7C20450
	for <e@80x24.org>; Fri,  3 Nov 2017 16:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754477AbdKCQw3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 12:52:29 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:46272 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752426AbdKCQw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 12:52:28 -0400
Received: by mail-wm0-f49.google.com with SMTP id r68so2776595wmr.1
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v8sHNMBjRaXUE/h2KFO6LF47C7/pFoW4gFXz5wy/80c=;
        b=dvJ6aXDNylKU1nXkO883JZytosY7QaE3HrkzUnjLQT78xseINTiKQzwQSpvxwezbbE
         KoV8Pz54WTKmmpQBq1J6SBmZCHEC/eU3FzYOWys1b9e34QVLd+NVLibdLyoTtN0P5S0T
         BRRXPGbUHzijNH01OyANzyDZwVwnxjqeyncE/gu1Q4AODSGi14sceSmTsLDwyjmtwHVv
         cXcWaE4+mE+5uNDk+slM9Vael2K+UW7dkzxHBy1Bd5mQEWWUdMuQ90mYljOTgSNbtSe3
         GlXu2adiTRi9rACEpccY6YeccICicHxrIm87c58wQ5xvbkbrqWx10l30rwQsv8AUyCwo
         tQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v8sHNMBjRaXUE/h2KFO6LF47C7/pFoW4gFXz5wy/80c=;
        b=c84P0Jd4LrgIUueQO3J5xWOorsLfxn7SyGRkOBP5+YlQ5qFRSAXCGQymMxnIvyG0eS
         udFf/Rfsp8TU77HyUn7WLuYhOl3lZABU8tEBt9JBF0GJWC2CLdnaYThTcK7LVwwFNa+Z
         MNPds7r0yPTNPv2qBYkdXHU7sp78TVRQsY8GVcKuuoU7O/S/49vxOyis8lsUEfY9xs3E
         Ryo6P1VsrNpYt1llXBveh7zp9ZuHyRfnz/MqS9+exMSPwosFYeOaXB4iDfMxmGhIkxN7
         poC/FeyP9lKVHTs0eGEy4fw+TPV0n9Hjy0dTlBQufGAT4V9ZP1eb8yrrz0asVCp5h49x
         DqCg==
X-Gm-Message-State: AMCzsaWDo40QsuyOYaVeSJO660mqlKj0botSLQA8Ls5bhzdO422kLK3j
        kChOyNZ+KbfNMSBDcoE5Mi1rVrfLzQ==
X-Google-Smtp-Source: ABhQp+SZqnJO8GB8wbPRpISQcSGEqht97sXCo+IOUF73fPbHrclg5xAOYY0Cio8uWVc1gXMkEp1LhQ==
X-Received: by 10.80.242.154 with SMTP id f26mr10061512edm.6.1509727947510;
        Fri, 03 Nov 2017 09:52:27 -0700 (PDT)
Received: from starfire ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id w10sm5648346edj.11.2017.11.03.09.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Nov 2017 09:52:26 -0700 (PDT)
Message-ID: <1509727946.1734.2.camel@kaarsemaker.net>
Subject: Re: git, isolation
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     =?ISO-8859-1?Q?P=E9ter?= <e2qb2a44f@prolan-power.hu>,
        git@vger.kernel.org
Date:   Fri, 03 Nov 2017 17:52:26 +0100
In-Reply-To: <9f514a9b-858c-9f3a-e2d4-a45987a19b9a@prolan-power.hu>
References: <9f514a9b-858c-9f3a-e2d4-a45987a19b9a@prolan-power.hu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-11-03 at 17:33 +0100, Péter wrote:
> Hi,
> 
> If I do a "git commit", issue git operations, and at the end, issue a "rm <the_git_dir>", is there any guarantee that my 
> filesystem will be "clean", 

No.

> i.e. not polluted or otherwise modified by some git command? Are the git operations 
> restricted to the repo-directory (and possibly remote places, over network)? 

No.

> Do the git-directory behaves as it were 
> chroot-ed or be a sandbox? (Yet another words: is the git-directory isolated from the rest of the local filesystem (and 
> packaging system)?)

And no :)

Most git commands will not touch anything outside the main worktree and
the .git directory in there, but commands like 'git worktree' can be
used to create worktrees anywhere in the filesystem, and when you play
tricks with the GIT_WORK_TREE environment variable, you can do other
nasty things.

D.
