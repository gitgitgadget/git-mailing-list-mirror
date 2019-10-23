Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC69A1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 10:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403847AbfJWKEz (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 06:04:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53300 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390973AbfJWKEz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 06:04:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id i13so5253177wmd.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 03:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=31fB6m8R7OM53zUiPp6PCJ0rhzx64qkVhdZ3JnekEvU=;
        b=AudsYywyetLdUC/xGmQ1egASQ2UOtvai/wsLTPeIziDzFBf3H6HFIjPUucRm5UIPMY
         onwx/FhtnaIgNZfPd0+Gmagj3huv2DLJUjHktUVVQPL0qWvhXug9PurNbc51F7V9aqxZ
         9aBrnOLhcq8gBpbQxYH+klpauEuT8yTPDLkKpjcX/o9W2yqk8CDKv4vLF7zmiHBHd7fI
         4Kj58H+xFzbfna41qieIk6YO8D7FBUdm75jrsLYkZslU6QpNaEC0/m5Adhay1CdzEnGU
         Un7MjUoSgZapdryT5vU+KPS6U41NmxVbiEjeyMHAcvQW6WYSFu35yNDHaVYwJjip9m2/
         REvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=31fB6m8R7OM53zUiPp6PCJ0rhzx64qkVhdZ3JnekEvU=;
        b=VauuIKHWeWGQWyBm6rGb3o7mjMbU2C/iholNkbTCuupRBLyx/e2pE/61WvwzgA06vG
         Vdu1RTYKsrvvavHPyvn7mOwex66n3iNUw5SkQw760gHsWlcFsJapCzVb1Sqykfa7ifwe
         u9CTbJFXOp1YffjxvDuBgROswDqbfdxnbIm9EcHxVOfcwL6VP1wgArwv/uxUWHbsTnYL
         UylD9PxZnyFsyXIhchGKZ16kK6CBsKLhHUDEwYhLo0M4m+9X0+xV81nGuIYN2so9qOt2
         NE/p+JJQfMERgKXfQpNwYB8rsJqcjSGL8NZLfpRM8QCkl4piM1Q/ma+aTb0ZliAlPwZp
         ZIaQ==
X-Gm-Message-State: APjAAAUWWv3ZEFcTnke5UGpJVOYDSyGE+gI3ec1fgHNXlHitmdLUDAAh
        QOqaUNiy2pilFxMtgr57SZhO01gv
X-Google-Smtp-Source: APXvYqzgvNc2dRbsSNXPGMzslAm8OOiBzY7pbS2EZ7LZpZ/4Lo0+Uac3oSY5PptsOidpcIcBiJ+xhA==
X-Received: by 2002:a1c:1f4b:: with SMTP id f72mr6594306wmf.22.1571825093114;
        Wed, 23 Oct 2019 03:04:53 -0700 (PDT)
Received: from szeder.dev (x4db97b71.dyn.telefonica.de. [77.185.123.113])
        by smtp.gmail.com with ESMTPSA id l5sm3654178wmj.44.2019.10.23.03.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 03:04:52 -0700 (PDT)
Date:   Wed, 23 Oct 2019 12:04:49 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Aleksey Mikhaylov <almikhailov@plesk.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Issue: "Could not access submodule" error when pulling
 recursively with Git 2.22.0
Message-ID: <20191023100449.GH4348@szeder.dev>
References: <AM5PR0902MB1953988602B657C3D0BB9B17A36B0@AM5PR0902MB1953.eurprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM5PR0902MB1953988602B657C3D0BB9B17A36B0@AM5PR0902MB1953.eurprd09.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 07:22:12AM +0000, Aleksey Mikhaylov wrote:
> "Could not access submodule" error when pulling recursively with Git 2.22.0.
> This issue causes if there is submodule in submodule.

> Please use my simple test repository to reproduce the problem:
> https://github.com/agmikhailov/example2361.git
> 
> It is just an empty repository with one submodule (https://github.com/agmikhailov/example2361M1.git) 
> and one submodule of submodule (https://github.com/agmikhailov/example2361M2.git):
> 
> git clone https://github.com/agmikhailov/example2361.git
> cd example2361/
> git submodule init

According to the docs of 'git submodule init', it "initializes the
submodules recorded in the index".  Therefore, it can only initialize
the submodule in 'example2361M1', because at this point we have no
idea that there is a nested submodule in there.

  $ git submodule init
  Submodule 'example2361M1' (https://github.com/agmikhailov/example2361M1.git) registered for path 'example2361M1'

> git submodule update

This command clones 'example2361M1':

  $ git submodule update --recursive
  Cloning into '/tmp/example2361/example2361M1'...
  Submodule path 'example2361M1': checked out '6a9be24a1c0ebd44d91ae4dcf1fd62580b936540'

Only at this point can we finally see that there is a nested
submodule, and can initialize and clone it with:

  $ cd example2361M1
  $ git submodule init
  Submodule 'example2361M2' (https://github.com/agmikhailov/example2361M2.git) registered for path 'example2361M2'
  $ git submodule update
  Cloning into '/tmp/example2361/example2361M1/example2361M2'...
  Submodule path 'example2361M2': checked out '9ed39cf1fe0a8cf34e72d2e7ebff1ea9d4a63ac1'

> git pull --recurse-submodules=true

And after that:

  $ cd ../..
  $ git pull --recurse-submodules=true
  Fetching submodule example2361M1
  Fetching submodule example2361M1/example2361M2
  Already up to date.


> ACTUAL RESULT
> 
> "git --recurse-submodules=true" command fails with message "Could not access submodule":
> 
> $ git --recurse-submodules=true
> Fetching submodule example2361M1
> Could not access submodule 'example2361M2'
> 
> EXPECTED RESULT
> 
> All submodules are successfully updated by "git --recurse-submodules=true" command.
> 
> ADDITIONAL INFORMATION
> 
> Git version 2.20.1 does not have this problem. 
> So we had to downgrade Git to work with submodules.

The behavior was indeed different with v2.20.1, but that version
didn't show the behavior you expected.  When running your commands
with v2.20.1 I get:

  $ ~/src/git/bin-wrappers/git pull --recurse-submodules=true
  Fetching submodule example2361M1
  Already up to date.
  $ find example2361M1/example2361M2/
  example2361M1/example2361M2/

So while that 'git pull' didn't error out, it didn't even look at the
nested submodule, which is still uninitialized and empty.

FWIW, bisecting shows that the behavior changed with commit
a62387b3fc, but, unfortunately, the commit message doesn't seem to be
very helpful to me, but perhaps others with more experience with
submodules can make something out of it.

commit a62387b3fc9f5aeeb04a2db278121d33a9caafa7
Author: Stefan Beller <sbeller@google.com>
Date:   Wed Nov 28 16:27:55 2018 -0800

    submodule.c: fetch in submodules git directory instead of in worktree
    
    Keep the properties introduced in 10f5c52656 (submodule: avoid
    auto-discovery in prepare_submodule_repo_env(), 2016-09-01), by fixating
    the git directory of the submodule.
    
    Signed-off-by: Stefan Beller <sbeller@google.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

 submodule.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)


