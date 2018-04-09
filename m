Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 057061F404
	for <e@80x24.org>; Mon,  9 Apr 2018 13:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeDINwG (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 09:52:06 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36906 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeDINwF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 09:52:05 -0400
Received: by mail-oi0-f45.google.com with SMTP id f63-v6so7649236oic.4
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WHdTW7VbEtRH6rZjH16HJbgm/ZHJqY9rSVUivllUBZE=;
        b=hkx4ytl0WMbVKY3gYtUWq4Tx2B403ItS5Flp0Exu99xGJ9qOr+t92TSnjCX18lciHD
         YtQEJC1nDwF9fLGpAn6Awm/pQE73u3a9Eb6UMH6LUmLHVLIotwIEp478AvHeybN5VwwM
         OlBiWjnDVVvbfTdBnUfocltHcWpCQ+qhAQ8jXaMTpRb7XBP4pAsAG21DWhvm0iOuFOrt
         LDhosx+QejY38P1ebu6kgxwoDRU9g52PS3IDWRfvkk9RdIiCvTXOLSH/75DA2iz/bNwY
         DmQd8K9QQk6sNCBLW3NIMmgyO4aN23jIxMWLTa+wE4jI9lHQqLAGyUeelDp70aN2Sy1x
         2NCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WHdTW7VbEtRH6rZjH16HJbgm/ZHJqY9rSVUivllUBZE=;
        b=B/AcoCGKA9VeHUnGG88DaenTFGR2qqkTY4zjOIIq4MtYtSLfgkDhPhP4iYOcfUPNXW
         n7sXeTjYI6cOkg6OrOq3x60bOJO8e1k5IX4KYylS/HGNl6Q32LlFkgQZ8bliiqi5aYdm
         9d8oyRqD3mNXZhTZQFsDIyX2OqctZGstypbau1VGE40i6w+hIb3hatUiaXpk0+tBCkIm
         HnhnY2YHzlxMn/GalmqHuoCi/hV1Yi9JHVbP0nO2d2rwiiQDspAAY4tCKh/LzjZuxYJ9
         RsIPbvkLxuXvlV/e+D47xSVnHinwofJV/xkHDZaSdP8QBR7oFkrz89fKFCc9DGzekufm
         RXEQ==
X-Gm-Message-State: AElRT7E9UzgESBRuhq91VfwTKvtzlVC8p2vSbojl7u8IL1XqVjdmI2qV
        zDTqw0G6MEJxQxfJ6umYsJdbJ6MxCNjgt93iL3xHPOX+
X-Google-Smtp-Source: AIpwx49MRLnLFfFmlhf2AdL9iKqfFczN8yixhlZHXDA0rM7pZ29qKddB1zmar1F9DGnfGOUWgdjuXBmOsR0SY/gX52Q=
X-Received: by 2002:aca:b5d4:: with SMTP id e203-v6mr22781874oif.163.1523281924860;
 Mon, 09 Apr 2018 06:52:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.160.222 with HTTP; Mon, 9 Apr 2018 06:51:44 -0700 (PDT)
From:   vaibhav kurhe <vaibhav.kurhe@gmail.com>
Date:   Mon, 9 Apr 2018 19:21:44 +0530
Message-ID: <CAHKv1qs-cnmcd2pR9iv=Xx1aKnb=SEsCQ7OAjy-4yHhCE_e_dw@mail.gmail.com>
Subject: Want to start contributing to git through this task: "Use
 dir-iterator to avoid explicit recursiv
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,
I am a Git user since last 2 years and now I want to contribute
towards its development.
Yesterday, I had a discussion with Kevin on the IRC channel
#git-devel, where I got this link:-
https://git.github.io/SoC-2018-Microprojects/.
Out of the tasks listed down in above URL, I found this one interesting:-
"Use dir-iterator to avoid explicit recursive directory traversal"
==>
Some places in git use raw API opendir/readdir/closedir to traverse a
directory recursively, which usually involves function recursion. Now
that we have struct dir_iterator (see dir-iterator.h), convert these
to use the dir-iterator to simplify the code. Do only one conversion
per microproject.

I cloned the git repo and browsed through it. I found that in git
clone (buildtin/clone.c), raw directory API readdir() is used
recursively.
So there is a place to change it to use the already available
"dir_iterator" structure.

I just want to know, if anybody is working on this task already.
If not, then I can proceed to work.

Thank you and Regards,
Vaibhav
