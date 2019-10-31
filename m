Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1E391F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 10:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfJaKPp (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 06:15:45 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:36098 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfJaKPp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 06:15:45 -0400
Received: by mail-wm1-f54.google.com with SMTP id c22so5264820wmd.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 03:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/u/6tnD428lNiqxaCFT6NwFpC2gXjEla2x0KsKWvfxg=;
        b=HBKd+PbrM17wb9hu4Fvj1IUV4fN4Tdrj8DU6dYmY+fLmsgY+Vw4ICwPlSrDx9LQicH
         FADbIIy6sS/sDFjhe4aqCrClTPn84+zPhh/c+fFE1TctEXxTcC12tK9Z+lUk5TtaFEB5
         j2EQd0Z7wSj6zTEW4hKC6szTbLiCERW31tpuqPCeUHv+RO4Ye6qVTyjeehZGLxV4CAAS
         Xk96sbZ8RyyCG/UDOCWs29niTPaoC9Ni5/1mEUezOe+csqop0Ar27vu14qnwTS8QVr6R
         HZtJCONpF/gnEIJ720AqCOSymSyQCOH7W9Q3+Gfwv5SblPksnQVGcntXntTR/jnPWqJX
         cysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/u/6tnD428lNiqxaCFT6NwFpC2gXjEla2x0KsKWvfxg=;
        b=aM9jYSzZ/rsR37UtPC7e9mBbGwTGgmdZuexMqAVWcG/ko+DzgkGJgXTS1ed7mHu/WH
         kHPf/69vCjVWIrYesqgseEa89l2TuQevLZ0KpnUyHpj7apGzQb88rvENkV5oaNs25yW9
         3Ql7aaJ8MB87VZciRIdiykr/RZNS383J04MoeZ3Nu/2c8bouYvavOu5IEACR44KFPOoX
         q1d8FmjH1umslnL01h1PTmprhYUeQ7fq3fdetkIrAG/20WNGpnkvJs3tv1KjaTvTAvig
         GT0c6P8nQwFmN7jq/GgsWkvR2ullKr/8HyI54Z4bkPrHzk2W2oOem+n0WIsXTq+LUL2n
         cXew==
X-Gm-Message-State: APjAAAW9m8b9TUC6OTs/Dd5Pm3+NU5RVnWife9m01bixwREjoUoyu7YS
        P5Mk1l8OmdK7KAAimUj+GDSIuI2b
X-Google-Smtp-Source: APXvYqxqfaWCU4Jge0x3cv/vVDew1a/oWI9sBssPVHSJ29i6oD3llr1xxBXIOf1gNbbws+ROx855ig==
X-Received: by 2002:a1c:60d7:: with SMTP id u206mr4512304wmb.101.1572516943444;
        Thu, 31 Oct 2019 03:15:43 -0700 (PDT)
Received: from szeder.dev (x4dbe1c44.dyn.telefonica.de. [77.190.28.68])
        by smtp.gmail.com with ESMTPSA id o1sm2529711wmc.38.2019.10.31.03.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 03:15:42 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:15:39 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     git@vger.kernel.org
Subject: Re: git fsck, badDate: invalid author/committer line - bad date
Message-ID: <20191031101539.GY4348@szeder.dev>
References: <20191031092749.074ed112.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191031092749.074ed112.olaf@aepfle.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 31, 2019 at 09:27:49AM +0100, Olaf Hering wrote:
> While preparing changes for git://git.annexia.org/virt-top.git, git push to github complains:
> 
> remote: error: object c609265ccce27a902b850f5d62e6628710ee2928: badDate: invalid author/committer line - bad date
> 
> Also 'git fsck' is unhappy about a number of commits.
> 
> What is wrong with these commits, and how can the maintainer of virt-top.git repository fix his repo?
> 
> $  git  --no-pager  log -p -M --stat --pretty=fuller c609265ccce27a902b850f5d62e6628710ee2928^! | head
> commit c609265ccce27a902b850f5d62e6628710ee2928
> Author:     Richard W.M. Jones <rjones@redhat.com>
> AuthorDate: Mon Oct 5 11:39:28 2009 +0100
> Commit:     Richard W.M. Jones <rjones@redhat.com>
> CommitDate: Mon Oct 5 11:39:28 2009 +0100

'git log' doesn't show the commit object's headers as-is, but 'git
cat-file' does:

  $ git cat-file -p c609265ccce27a902b850f5d62e6628710ee2928
  tree ea8e3bd64e67d159e706b8feccfc169f6ac0829d
  parent db4e80ee11a4e212a97efc1761ed237c7da72cb1
  author Richard W.M. Jones <rjones@redhat.com> <"Richard W.M. Jones <rjones@redhat.com>"> 1254739168 +0100
  committer Richard W.M. Jones <rjones@redhat.com> <"Richard W.M. Jones <rjones@redhat.com>"> 1254739168 +0100
  
  New translations.

And now you don't need me to tell you what triggers those errors.

You can tell 'git fsck' to ignore those badly formatted commits
locally using the 'fsck'skipList' configuration variable:

  $ echo "# Commits with bogus author/committer lines" >.git-fsck-skiplist
  $ git fsck 2>&1 |cut -d' ' -f4 |sed -e 's/://' >>.git-fsck-skiplist
  $ git config fsck.skipList .git-fsck-skiplist
  $ git fsck
  Checking object directories: 100% (256/256), done.
  Checking objects: 100% (1803/1803), done.
  $ echo $?
  0

It might be worth to commit this file, so other devs can easily start
using it as well, and don't have to maintain such a list themselves.
(Note, however, that if this file is committed and the config variable
is set, then attempting to run 'git fsck' while an older revision is
checked out will result in a 'fatal: could not open object name list:
.git-fsck-skiplist' error; I think that's an acceptable trade-off.)

However, I don't know how to tell about the skiplist file to GitHub,
or any other Git hosting service for that matter.

