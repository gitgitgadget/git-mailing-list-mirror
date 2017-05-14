Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01EFC201A4
	for <e@80x24.org>; Sun, 14 May 2017 22:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbdENW3C (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 18:29:02 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35793 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbdENW3B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 18:29:01 -0400
Received: by mail-wr0-f182.google.com with SMTP id z52so69781127wrc.2
        for <git@vger.kernel.org>; Sun, 14 May 2017 15:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:openpgp:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kTWDrMp2ofU3wihDoP1OsOypDX22aDyredZ7eglfh0Q=;
        b=jv5cwpQVr/bvsGoLiC1LeQFuJ3BMuiuQpBHKMUqb56ktWqsrafTWHlcqH+i4GF+tC5
         Ldi6+X8ZUkJrZl4GVBT/l1XiiNORhGU1eHn5ZF2j+AU7C34YFiDomzmnvMdaErkKMrJk
         JDVZs5AA+ex5XBWccRHT0yXVIdx4BeU5FXkbrh4bneJiboF4K7fl4HXS7HdovtzKHHeP
         DhCczyLPMF0UOYGoqKK0Hwiio3oP+XcwPEEJyIudqOZTXJCORxDY3Gp4h+/NWYgHCY1p
         8TugZNoOaPe57nOmoAkPHrJHZ4ZeyFwKlo460ntGSY/V0+1QuH3gad7DbYzgCJ+AWoBF
         sHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:openpgp:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=kTWDrMp2ofU3wihDoP1OsOypDX22aDyredZ7eglfh0Q=;
        b=hVzZ6nH4gfbOSG4+ZVeqXG5YyJsF66PmAOjqaeoLGO1sJLNyI3FHOydkF+oh4sJGgF
         2T4RyVjQdD6Z2fzeGA90OfG7qP1fHKYA5xfIqvDuMDbCMhEOmP822XtDpk4wGs722kHP
         Hu8Ka33rL+Za093mpzG5jfKhN/9YE99xmaYWfC+N8xavPrGamCiFlYNVLwfPRGq+hBCO
         PtV7c9qsJHWdWU/lDEcevWJzz5KoAsbi6Zx6mFP1iiK1VrCaJlAegYlpihxGZVn4Z12A
         qJ7ku7cNeoifU7dvAOswG45ualuD73qxbR1EpGPTSYJ4NAMPKAk2JciQZCKHWPKwFpKN
         1PAw==
X-Gm-Message-State: AODbwcC74EAapGwlg/hUpvbUaKjkvl/3OyiilC1J8SupJrc8OBfWbYMh
        qNchVq7rYMRk/m2O
X-Received: by 10.223.161.30 with SMTP id o30mr1853448wro.186.1494800939851;
        Sun, 14 May 2017 15:28:59 -0700 (PDT)
Received: from [192.168.6.46] (ppp-88-217-127-112.dynamic.mnet-online.de. [88.217.127.112])
        by smtp.gmail.com with ESMTPSA id w68sm12250718wrb.49.2017.05.14.15.28.58
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 May 2017 15:28:59 -0700 (PDT)
From:   Thomas Schweikle <tschweikle@gmail.com>
Subject: Cant clone/pull/fetch because of "Unable to create temporary file
 '$HOME/Dev/linux-stable/.git/objects/pack/tmp_pack_'
To:     git@vger.kernel.org
Openpgp: preference=signencrypt
Message-ID: <cf9ce8e9-a358-4fdf-aa7c-a8ab76b6429a@gmail.com>
Date:   Mon, 15 May 2017 00:28:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0a1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git clone
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
linux-stable
Cloning into 'linux-stable'...
remote: Counting objects: 5932092, done.
remote: Compressing objects: 100% (154131/154131), done.
fatal: Unable to create temporary file
'$HOME/Dev/linux-stable/.git/objects/pack/tmp_pack_XXXXXX': Permission
denied
fatal: index-pack failed

Since no file/directory created by git I cant tell why git isn't
able to create
"$HOME/Dev/linux-stable/.git/objects/pack/tmp_pack_XXXXXX".

If I try to create this file and directory I can create it:
$ mkdir -p $HOME/Dev/linux-stable/.git/objects/pack
$ touch $HOME/Dev/linux-stable/.git/objects/pack/tmp_pack_XXXXXX
$ ll $HOME/Dev/linux-stable/.git/objects/pack/tmp_pack_XXXXXX
-rw-rw-r-x+ 1 tps tps 0 May 15 00:18
/home/tps/Dev/linux-stable/.git/objects/pack/tmp_pack_XXXXXX
$

$ git --version
git version 2.11.0

-- 
Thomas
