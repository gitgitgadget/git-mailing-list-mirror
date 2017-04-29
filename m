Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7391FC3E
	for <e@80x24.org>; Sat, 29 Apr 2017 22:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3000223AbdD2WXQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 18:23:16 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33871 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2998642AbdD2WXN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 18:23:13 -0400
Received: by mail-oi0-f49.google.com with SMTP id x184so59386725oia.1
        for <git@vger.kernel.org>; Sat, 29 Apr 2017 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FLTDwQE+LE9h0xgh9n3BRhnuKtFcUZeiwaz5qeBtjrg=;
        b=ZHrgUQwDj0z3xUldXe5hywKg0hxinRUdfD0izhUHXx5hXNZ/uMpXxVojNiyYA42d4f
         AnZI3TIsijvJhv9his0fbFRG3yJxvLY7+EGzt35PAlVzeR15XyjSzCzZYyN9GRpsblYD
         YDXj5jn/bg/Nzc/zTR/jsvFlrzalOL7dKKquWcgL1Hu11x/zsDbBAs0z1etY2BQEGMXq
         JZvjx1R7UFpvON4a6WucNDj/K3JZrgeFNxdcdhCmkkKF71qM5uqMBMG42WWsHgdZGaeK
         SeMWqo8OUjHTA7Krshpr0CrgvIOfzm85hEecrFTbtfhvXGjCLdG+13hyfadEw51oklQ1
         i/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FLTDwQE+LE9h0xgh9n3BRhnuKtFcUZeiwaz5qeBtjrg=;
        b=Qf6CtXZlnEGgcFSc7YejgN6n6pFON0FdRTgUjYGZWNE7nNtBh46Fo0Awg5CHFJF2q6
         8XlMRLF0DLHE3UYcYpQiA8VvQpsbiC73AdAwGa1VATBqMOPOpWUBTj2TOK4faZarkzO/
         beRZl0vKKXseDBFl3XBIzOyq2Agc1+xNSpJ6TyaAfE+MgBLwfbawuid1byPB+NFVizFK
         FlXHOP4vMML6WaQ4N6fihd1e51JI00mqWqS7ogfvLd54T2NA7Z7h4ZkjP6b7uJteGxVu
         OaNYjV6mNHzGZjLpiFBwaBPAiZFyL8xmRHL4WN6U4ua1epKxT81phET5KUDQ+WCOSnnE
         Wx/A==
X-Gm-Message-State: AN3rC/4pQ79AzZHP0NKXTT+DYQLyqC676AHxHnmDwENXvRFoeV1rHyAx
        WP/H22iv9fPawWMqXOun3E1fSvF/vQ==
X-Received: by 10.202.81.83 with SMTP id f80mr7630972oib.9.1493504593110; Sat,
 29 Apr 2017 15:23:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.11.27 with HTTP; Sat, 29 Apr 2017 15:23:12 -0700 (PDT)
In-Reply-To: <CAFOYHZAsGp8Fw4euxsr=hRbTm5voBSRf_tJ9y3Sz25AE=VQ3hw@mail.gmail.com>
References: <CAJRbB6w2BnXXzA46a-uzpx9u554GndEXxZtkLVTc5XOXMn3kkA@mail.gmail.com>
 <CAFOYHZAsGp8Fw4euxsr=hRbTm5voBSRf_tJ9y3Sz25AE=VQ3hw@mail.gmail.com>
From:   Erik Haller <erik.haller@gmail.com>
Date:   Sat, 29 Apr 2017 15:23:12 -0700
Message-ID: <CAJRbB6wz5y=GJLq1gWnmWC7CbPJdqjUn97dAW9SaftnSWVaaag@mail.gmail.com>
Subject: Re: git with ssh won't pull submodule
To:     Chris Packham <judge.packham@gmail.com>
Cc:     GIT <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah. I was able to get it to work with the ssh protocol and a relative
path. Thank you for your help.

On Fri, Apr 28, 2017 at 8:45 AM, Chris Packham <judge.packham@gmail.com> wrote:
> Hi Erik,
>
> On Fri, Apr 28, 2017 at 11:25 AM, Erik Haller <erik.haller@gmail.com> wrote:
>> Getting the following error for a submodule when using git/ssh:
>>
>> $ git clone --recursive ssh://incense:/home/erik/git/nacl.git
>> Cloning into 'nacl'...
>> remote: Counting objects: 32, done.
>> remote: Compressing objects: 100% (25/25), done.
>> remote: Total 32 (delta 5), reused 0 (delta 0)
>> Receiving objects: 100% (32/32), 16.50 KiB | 0 bytes/s, done.
>> Resolving deltas: 100% (5/5), done.
>> Submodule 'vendor/golang.org/x/crypto'
>> (file:///home/erik/git/github.com/golang/crypto.git) registered for
>> path 'vendor/golang.org/x/crypto'
>
> This is the problem. The .gitmodules entry in nacl.git uses an
> absolute path (or URI in this case) for the submodule. Git does
> exactly what it should and tries to clone it.
>
> The solution to this is to use a relative path[1] in .gitmodules
> (either edit it by hand or do git rm & git submodule add). Note that
> by using a relative path it assumes that the parent and submodule
> repositories are hosted in the same location (which may or may not be
> true for your use-case).
>
> --
> [1] - see the 3rd paragraph for the add command in
> https://git-scm.com/docs/git-submodule
>
>> Cloning into '/home/erik/go/src/nacl/vendor/golang.org/x/crypto'...
>> fatal: '/home/erik/git/github.com/golang/crypto.git' does not appear
>> to be a git repository
>> fatal: Could not read from remote repository.
>>
>> Please make sure you have the correct access rights
>> and the repository exists.
>> fatal: clone of 'file:///home/erik/git/github.com/golang/crypto.git'
>> into submodule path
>> '/home/erik/go/src/nacl/vendor/golang.org/x/crypto' failed
>> Failed to clone 'vendor/golang.org/x/crypto'. Retry scheduled
>> Cloning into '/home/erik/go/src/nacl/vendor/golang.org/x/crypto'...
>> fatal: '/home/erik/git/github.com/golang/crypto.git' does not appear
>> to be a git repository
>> fatal: Could not read from remote repository.
>>
>> Please make sure you have the correct access rights
>> and the repository exists.
>> fatal: clone of 'file:///home/erik/git/github.com/golang/crypto.git'
>> into submodule path
>> '/home/erik/go/src/nacl/vendor/golang.org/x/crypto' failed
>> Failed to clone 'vendor/golang.org/x/crypto' a second time, aborting
>>
>>
>> The git clone --recursive file:///home/erik/git/nacl.git works fine
>> and pulls the submodule "crypto.git". Any ideas?
>>
>> - The crypto.git is a valid repo.
>> - I have the correct permissions.
>> - The crypto.git repo is a git --mirror repo.
>>
>>
>> git version: 2.11.0
>> system: linux debian/testing
