Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D55E208DB
	for <e@80x24.org>; Wed, 23 Aug 2017 01:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752822AbdHWBBA (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 21:01:00 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34280 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752794AbdHWBA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 21:00:59 -0400
Received: by mail-pg0-f54.google.com with SMTP id s14so1387978pgs.1
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 18:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UnqtCptxO0QMYvJlkgcZeHr+mTnJ50sMIwmrIvcdDM8=;
        b=XWGhEcPXxcCsvBOwe2q+tA2f4gsASGe5VQOgmFBKTfpyMG+/jGYsB1oUUbns3YkSmD
         ELmaArYCBtY1ObpIR7TQ+NgP40ZuI6jY0/F6Q6velehoNfC6/t9sh8A94/g+6j2fScsk
         Veejk2uSJ0uPiPjhbKB6+ahsEv0EtYLCQQpNNQcHWJbTed5i94UZpJ+YJJtko1CWhDyl
         NipbPDpksdIgBhYTD0NDErWfcKwLl2mrK4xjrRsjajJAYa6VfL/nuYXMQOmAj8b8dxqm
         l6H12PRLGv4Z431geAMGTVZp1E7TRT5kbJ4FxEGnV1ViThn9Wd9U4loOis9sgSMlowzZ
         rs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UnqtCptxO0QMYvJlkgcZeHr+mTnJ50sMIwmrIvcdDM8=;
        b=JyDasneeikdIsPStIS9N0BUxD1StvkyOe4IyrSXO9ue0Slyec8bDHyuJIsZbanRF1R
         tTKKhFn+L9BYK8216m/MFaLyO/WbQtTxlnfSoTtp4dq4F8s8LwUoKgyyYJy6gJ+r/Eei
         GYpfTmzfGOte3IUygz2LmemC8c4C3D9CDu9n0BjbXFw2sf52KfnQUEWg7neQhH1c16fL
         HohyLiE6AXYhJRecY03dGbUvhngbB/qTX4Fn3NIgyWo6WU6ppJNnfvlREcJK2/DJj4pu
         C3dKey3/TgBQwsOnH1hliJjIBEZzyvomqa+8IufRmD4QtuemBQqrrfx+KkeIuuADHtqo
         ezlA==
X-Gm-Message-State: AHYfb5j2O0ZZJ8NGe1EYKBo3fT0mwZEdhGWufpSZkAKCjtT/Xp5wn+JL
        pHptrQ/lFiCr6BdvpUX6ig==
X-Received: by 10.84.218.136 with SMTP id r8mr1107925pli.462.1503450058358;
        Tue, 22 Aug 2017 18:00:58 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:e139:89dc:931e:ea9e])
        by smtp.gmail.com with ESMTPSA id y23sm251324pge.65.2017.08.22.18.00.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 18:00:57 -0700 (PDT)
Date:   Tue, 22 Aug 2017 18:00:56 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #05; Tue, 22)
Message-ID: <20170823010056.GB114773@google.com>
References: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/22, Junio C Hamano wrote:
> 
> * bw/submodule-config-cleanup (2017-08-03) 17 commits
>  - submodule: remove gitmodules_config
>  - unpack-trees: improve loading of .gitmodules
>  - submodule-config: lazy-load a repository's .gitmodules file
>  - submodule-config: move submodule-config functions to submodule-config.c
>  - submodule-config: remove support for overlaying repository config
>  - diff: stop allowing diff to have submodules configured in .git/config
>  - submodule: remove submodule_config callback routine
>  - unpack-trees: don't respect submodule.update
>  - submodule: don't rely on overlayed config when setting diffopts
>  - fetch: don't overlay config with submodule-config
>  - submodule--helper: don't overlay config in update-clone
>  - submodule--helper: don't overlay config in remote_submodule_branch
>  - add, reset: ensure submodules can be added or reset
>  - submodule: don't use submodule_from_name
>  - t7411: check configuration parsing errors
>  - Merge branch 'bc/object-id' into bw/submodule-config-cleanup
>  - Merge branch 'bw/grep-recurse-submodules' into bw/submodule-config-cleanup
> 
>  Code clean-up to avoid mixing values read from the .gitmodules file
>  and values read from the .git/config file.
> 
>  So, after the recent discussion around submodule.<name>.update (and
>  its resolution "use submodule.<name>.active; "reset --hard" must
>  ignore the .update thing"), this is now good to go, I presume?
>  Please yell at me that I am clueless if that is not the case ;-)

Yep I came to the same conclusion that you did so this should be good to
go!

-- 
Brandon Williams
