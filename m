Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8111F463
	for <e@80x24.org>; Thu, 19 Sep 2019 23:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405333AbfISXSm (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 19:18:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38054 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405316AbfISXSm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 19:18:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so248862wmi.3
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 16:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ycVv5q8iZcb/5VRxI8qsresLsx/U0c2nE/6JFhNepxk=;
        b=Z085cGQ09Ipo8Bo0BAngMMZyu0ZLNGXQTQORjaYBjls9y0sswYKrrbDIrjnF7Pk+9h
         3bIGbwsJnvH4F5Wp67h4nGCRXQmNM4bUW3gxWm9X1fzriRAwWeaVTP/iLjCMDSwYtmMQ
         MZrdpgAHA05G6WidHIg+NeDc72sudY75FCjqLOb5qb+TmH5CcfStCZlupuqKbryu9ttF
         UVVnZnuqGoKI8kWKS830XiAtoxFKZjHwHtgFGrSGZxEuigE1BIEwyY2WdOdBt4M8kibg
         zeEI11+oVSdENzxMbqKiuQ48SG1CtjDbYCahtoC0hMzu6E3pFF6yGIO9YYSixKAS/Tki
         V4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ycVv5q8iZcb/5VRxI8qsresLsx/U0c2nE/6JFhNepxk=;
        b=gEqFzBPZqknZz7sNJAmEBKAlHLxG36QVbIBZYymcWR5Aw/jYfNpDWNLekcR5SjkDfx
         NNTGRRRxeRRAUIotuIXUR0k5A5lFuuUu2ChPjjZVuLgMZkaMEreVVEm5VRo5YN4i8MkJ
         4Pv+QyBcIkCxeGP9Gub8dhLWAvX6eIKHuuizppnUxbhvxDCyfS2LNSt3lnSMqh/wMb11
         tqd26h7GJkGNm9B35bV5cSW277DZQe/7MlJdyKL7IUBqACKX8w2/p4kfdYJCNV/+iWsb
         S3E/zF8dC3o1XTlWgOc5b1iuve3aLnth6aJFAARzrz7D55fa8+bIYt3GOJJ/EvWxL3fQ
         49VA==
X-Gm-Message-State: APjAAAXnxx8QJ70Z16kKONlLnCoJRI43wOscKv2oK2FyWiKwAihXBKaq
        yfwh7Dluk5g6ktvAWmAFn+Vczjyd
X-Google-Smtp-Source: APXvYqz5OBg3QsGBZMQW5kfy7t2r2OnLt4gRtoczOmT8QkY9zfHhpeZOkuBWii7KkqxxmBlgXq7DLw==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr241017wmb.93.1568935120417;
        Thu, 19 Sep 2019 16:18:40 -0700 (PDT)
Received: from szeder.dev (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id v2sm82816wmf.18.2019.09.19.16.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 16:18:39 -0700 (PDT)
Date:   Fri, 20 Sep 2019 01:18:33 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Joseph Mingrone <jrm@ftfl.ca>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: git-svn authors file in repo (Author: xxx not defined in
 .gitauthors file)
Message-ID: <20190919231833.GA9363@szeder.dev>
References: <86o8zgfj82.fsf@phe.ftfl.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86o8zgfj82.fsf@phe.ftfl.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 11:34:21AM -0300, Joseph Mingrone wrote:
> Hello,
> 
> We maintain a .gitauthors file for git-svn.  When a new committer is
> added to our project, a new entry is added to the .gitauthors file,
> but we sometimes see errors like this:
> 
> % git -C /usr/ports svn rebase
>         M       .gitauthors
> r512146 = 0c1f924ca984d53333beabb909ea53afb856c44b (refs/remotes/origin/trunk)
>         M       math/py-pystan/Makefile
> r512147 = acc387d4c8f3ebf904010bccc5679be06b184a9d (refs/remotes/origin/trunk)
>         M       deskutils/gworkspace-gwmetadata/Makefile
> ...
> ...
> ...
> r512184 = 442bd1025776d5e3171be8e497ef2056dc47ff06 (refs/remotes/origin/trunk)
>         M       www/rubygem-passenger/Makefile
>         M       www/rubygem-passenger/distinfo
>         D       www/rubygem-passenger/files/patch-asio-libc++7
> W: -empty_dir: head/www/rubygem-passenger/files/patch-asio-libc++7
> r512185 = f1a1b447811ae84011288678136e185c83180b8e (refs/remotes/origin/trunk)
>         M       astro/xearth/files/freebsd.committers.markers
> Author: dmgk not defined in .gitauthors file
> 
> The new committer, dmgk, was added to .gitauthors in svn commit r512146,
> then later he committed to the repository for the first time in r512185.
> It seems that if these two commits are included in the same `git svn
> rebase`, the error above will occur.
> 
> Is there a solution or workaround for this aside from each committer
> having an updated .gitauthors before doing `git svn rebase`.  It's seems
> to be a chicken/egg issue; they first need the updated .gitauthors file,
> but the way to get the updated .gitauthors files is to do `git svn
> rebase`.

I have no idea how 'git svn' works and what this '.gitauthors' file
is, so no workarounds from me...  But this seems to be similar to the
issue with '.gitattributes' in core Git that was fixed recently:

  https://public-inbox.org/git/20190902223944.897504-3-sandals@crustytoothpaste.net/

Perhaps 'git svn rebase' should do the same, i.e. look out for commits
changing this '.gitauthors' file and re-read the file each time it is
changed.

Cc-ing Eric for git-svn know-how.

