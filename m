Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF891F453
	for <e@80x24.org>; Fri, 19 Oct 2018 12:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJSUw2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 16:52:28 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:34734 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeJSUw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 16:52:28 -0400
Received: by mail-ed1-f49.google.com with SMTP id w19-v6so31328689eds.1
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 05:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VmXV148T5CXUuZDdhbSs4NqBQ8MOrUZ1qUNnTUYmMWs=;
        b=IG9G25rcesbBPEFxo5sLX//kb2TapgnY4Q6yOd/xP/0YTT8mXLJAYTpCwo9pYbC6qm
         y6BB4sFIbBSQmycK/OUgQ3L9pvxay6HTSBFf42AQFZuq2f5Z0B7kyXX/5zU4GwhYAhmz
         AjJ4VaFiqJE4KCeroBgY2YF5z2Al84QD4Wx4bHRN5gPIjrEiakAhXssz0gruUMBV00gP
         vLXh2DRwD3BZjUeP+MBbiXwXwk0RkLFDElt9r3r/zqEAMMqcSPqW3XRQf+iOcpVg4gDX
         w+w53UEoc2rFFIkM0/V6Qj+v5zmYTNN16zfQupSxg2xKhnoUWTdLBmr/pbVuqrkSstyn
         KFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VmXV148T5CXUuZDdhbSs4NqBQ8MOrUZ1qUNnTUYmMWs=;
        b=Ef+jmjR1s2QdhLCTsrC5f8rkg6TPsqoZT0/PWWV42tcwqLqNu3diPl+uA1AwhPo0Hq
         ydu5tQ/RfVPNepaw+B8j9zoeC0WmHaTx7ZLIS4rvm5mcs4xla2Rny18cS8xIL/5LixtZ
         z2DbkF4cQRTXDsxoFCruhYQUf94NIUhei3YCK67nWFO2qOHc4yWLgvnmOPedxYyzkfZ4
         n+xRy6hohistV0R69U2ScXXFXP76Fu83pHML0c5WHnoOFTWfDxMRUnW5xrLk41252uF/
         zqAbHhGkgiEHxkmM1GBrGZBAiDHHLCP3+/ikStKPvLiGd9s6LmR1nyAVMrOwpGPIW7ux
         RU3A==
X-Gm-Message-State: ABuFfoi6GWiueXXXLizrB9DXOsOYCTKCldkXv8nOMQABX3kCisqGG/zI
        ThpDLosFOm0L8UcCeWuL0Qg=
X-Google-Smtp-Source: ACcGV618oRD0vw2+qpRxyTiV6+8DwA52cQiV0LVSAaDdg4N3YEvSUBlvB5dUiVTf/sbafdXzB7gp8Q==
X-Received: by 2002:a17:906:b857:: with SMTP id ga23-v6mr31456409ejb.222.1539953188385;
        Fri, 19 Oct 2018 05:46:28 -0700 (PDT)
Received: from szeder.dev (x4db1e3c6.dyn.telefonica.de. [77.177.227.198])
        by smtp.gmail.com with ESMTPSA id 9-v6sm4859686ejw.46.2018.10.19.05.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 05:46:27 -0700 (PDT)
Date:   Fri, 19 Oct 2018 14:46:25 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pratik Karki <predatoramigo@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2018, #04; Fri, 19)
Message-ID: <20181019124625.GB30222@szeder.dev>
References: <xmqq8t2u1nkh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8t2u1nkh.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 03:02:22PM +0900, Junio C Hamano wrote:
> Two large set of topics on "rebase in C" and "rebase -i in C" are
> now in 'next'.

I see occasional failures in 't5520-pull.sh':

expecting success: 
	test_config rebase.autostash true &&
	test_pull_autostash --rebase

+ test_config rebase.autostash true
+ config_dir=
+ test rebase.autostash = -C
+ test_when_finished test_unconfig  'rebase.autostash'
+ test 0 = 0
+ test_cleanup={ test_unconfig  'rebase.autostash'
		} && (exit "$eval_ret"); eval_ret=$?; :
+ git config rebase.autostash true
+ test_pull_autostash --rebase
+ git reset --hard before-rebase
HEAD is now at 12212b3 new file
+ echo dirty
+ git add new_file
+ git pull --rebase . copy
From .
 * branch            copy       -> FETCH_HEAD
Created autostash: 5417697
HEAD is now at 12212b3 new file
First, rewinding head to replay your work on top of it...
Applying: new file
Applying autostash resulted in conflicts.
Your changes are safe in the stash.
You can run "git stash pop" or "git stash drop" at any time.
+ test_cmp_rev HEAD^ copy
+ git rev-parse --verify HEAD^
+ git rev-parse --verify copy
+ test_cmp expect.rev actual.rev
+ diff -u expect.rev actual.rev
+ cat new_file
cat: new_file: No such file or directory
+ test  = dirty
error: last command exited with $?=1
not ok 25 - pull --rebase succeeds with dirty working directory and rebase.autostash set

When running t5520 in a loop, it tends to fail between 10-40
iterations, even when the machine is not under heavy load.

It appears that these failures started with commit 5541bd5b8f (rebase:
default to using the builtin rebase, 2018-08-08), i.e. tip of
'pk/rebase-in-c-6-final', but it's a "flip the big switch" commit, so
not very useful...

