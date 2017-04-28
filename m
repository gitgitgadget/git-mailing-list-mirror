Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B6A5207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 15:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424376AbdD1Ppf (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 11:45:35 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:38796 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424324AbdD1Ppd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 11:45:33 -0400
Received: by mail-it0-f52.google.com with SMTP id f187so43878021ite.1
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dKXC0XwGOeTIf4Amumg7HBDNOAcFAqYvzw6JUlh3o74=;
        b=pOPD31+byLUM7zbPsqH/eoOE6sQZdAvNTwNGSEKo3YFVNCBe9+W127YhV3pnZ15MG1
         jIyRxLdf9hrrgVqAujW27rDa1pKuV4KWAdgp/qaML4oMaUwrDBooBocSQwQPo2s8Y2sR
         tvwyiEcUnlabfnBGtyQMT5wNu0hatgmPBktgJSIrtX3nK0gQdwlzRtKgVfC/fp/1KhiM
         bf1uMn7qljWlrYqquFUGBoSfL1k5+hdiJ542/EDkfMDnFNSAu/aaNWtNPwe9Z4Bcg+qp
         VsuxGmNTCtCD58nHOTZJUH0HCQk9xKr+ijumIP6txQ/PjLtvVeJe9ccdOU0/NeafhJZG
         Rm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dKXC0XwGOeTIf4Amumg7HBDNOAcFAqYvzw6JUlh3o74=;
        b=N8Xg0kLq0MVLXC4E0zE+TlHFsS3GzpzZtjPiKc4ujsWUiQJ0BSaIMImYwETVQMFbnl
         fJpjxKRfC5i3ctAPzkrZRI6bU7SoxNxwVsnrYSYAVAP+fnwFzkLQYgsp3jOMtpsxG/Vj
         RNmDJuGGjj7mXKXKchwXOK11Jpvg3uRxbAquzqlnbu0tzZqlMXG3nmeuE+RTN7j1uts/
         vtUfspprVnxd0Zo7mwt25cxiDUlH6BhsphlyLOUSuLnK7CYtaSgVZh1iLCNjGdkx0Tbw
         GxaoxKPxoODlfabbm0n3ZSeiYld5PXBtcerHab7JTZXpsLzxgGC3QI2rYO+LCIC3GbT+
         RW+Q==
X-Gm-Message-State: AN3rC/4nnOmg9fz5xgpXUDE4vE7BTa15nkAlbRo8OxVFf/lMK7gxkTYn
        2yhEMHD6D+ZJ2MWieihxXqkKz6YmHFoJORU=
X-Received: by 10.36.43.130 with SMTP id h124mr30335ita.42.1493394332603; Fri,
 28 Apr 2017 08:45:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.158.5 with HTTP; Fri, 28 Apr 2017 08:45:31 -0700 (PDT)
In-Reply-To: <CAJRbB6w2BnXXzA46a-uzpx9u554GndEXxZtkLVTc5XOXMn3kkA@mail.gmail.com>
References: <CAJRbB6w2BnXXzA46a-uzpx9u554GndEXxZtkLVTc5XOXMn3kkA@mail.gmail.com>
From:   Chris Packham <judge.packham@gmail.com>
Date:   Sat, 29 Apr 2017 03:45:31 +1200
Message-ID: <CAFOYHZAsGp8Fw4euxsr=hRbTm5voBSRf_tJ9y3Sz25AE=VQ3hw@mail.gmail.com>
Subject: Re: git with ssh won't pull submodule
To:     Erik Haller <erik.haller@gmail.com>
Cc:     GIT <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Erik,

On Fri, Apr 28, 2017 at 11:25 AM, Erik Haller <erik.haller@gmail.com> wrote:
> Getting the following error for a submodule when using git/ssh:
>
> $ git clone --recursive ssh://incense:/home/erik/git/nacl.git
> Cloning into 'nacl'...
> remote: Counting objects: 32, done.
> remote: Compressing objects: 100% (25/25), done.
> remote: Total 32 (delta 5), reused 0 (delta 0)
> Receiving objects: 100% (32/32), 16.50 KiB | 0 bytes/s, done.
> Resolving deltas: 100% (5/5), done.
> Submodule 'vendor/golang.org/x/crypto'
> (file:///home/erik/git/github.com/golang/crypto.git) registered for
> path 'vendor/golang.org/x/crypto'

This is the problem. The .gitmodules entry in nacl.git uses an
absolute path (or URI in this case) for the submodule. Git does
exactly what it should and tries to clone it.

The solution to this is to use a relative path[1] in .gitmodules
(either edit it by hand or do git rm & git submodule add). Note that
by using a relative path it assumes that the parent and submodule
repositories are hosted in the same location (which may or may not be
true for your use-case).

--
[1] - see the 3rd paragraph for the add command in
https://git-scm.com/docs/git-submodule

> Cloning into '/home/erik/go/src/nacl/vendor/golang.org/x/crypto'...
> fatal: '/home/erik/git/github.com/golang/crypto.git' does not appear
> to be a git repository
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
> fatal: clone of 'file:///home/erik/git/github.com/golang/crypto.git'
> into submodule path
> '/home/erik/go/src/nacl/vendor/golang.org/x/crypto' failed
> Failed to clone 'vendor/golang.org/x/crypto'. Retry scheduled
> Cloning into '/home/erik/go/src/nacl/vendor/golang.org/x/crypto'...
> fatal: '/home/erik/git/github.com/golang/crypto.git' does not appear
> to be a git repository
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
> fatal: clone of 'file:///home/erik/git/github.com/golang/crypto.git'
> into submodule path
> '/home/erik/go/src/nacl/vendor/golang.org/x/crypto' failed
> Failed to clone 'vendor/golang.org/x/crypto' a second time, aborting
>
>
> The git clone --recursive file:///home/erik/git/nacl.git works fine
> and pulls the submodule "crypto.git". Any ideas?
>
> - The crypto.git is a valid repo.
> - I have the correct permissions.
> - The crypto.git repo is a git --mirror repo.
>
>
> git version: 2.11.0
> system: linux debian/testing
