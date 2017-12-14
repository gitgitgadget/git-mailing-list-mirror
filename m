Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89FF71F404
	for <e@80x24.org>; Thu, 14 Dec 2017 22:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbdLNW1Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 17:27:16 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:46348 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753595AbdLNW1P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 17:27:15 -0500
Received: by mail-wm0-f50.google.com with SMTP id r78so14216518wme.5
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 14:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5pEPjt8NHvO2eYDZtlSePqVy1f4/I61QsHSn/UB8EVk=;
        b=QFq+kZY1jBglxWcbH0xbenlvDPfuj/cU3hBKxt/WBWceR557pTBnk79PXTzCSZW0hd
         IT1AfWfb1ccsyG2KJrffddZ1wKikd7b8mzQJCjmyL8tAccBTtMzO+zZ0SCNzRI2iJISr
         xrMDJTvOIZUvZzCmwLA0lg/8xmrxuUwDYzYfsqTzst9vK/bgpt6H59ZwA/FaJFvOhcfF
         yEp47oq7FwPZgTlE03K1GQlm89JIN36mharr6uph1wAykUe0U+z9UBCloc2u7jYAEzNH
         z9u5jJO9Fbsl/u3u6yp7nK4Si4ftCSez9X8I5T03Xqb+mfp5DTVlw4mr5kMOeufAw9dN
         lsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5pEPjt8NHvO2eYDZtlSePqVy1f4/I61QsHSn/UB8EVk=;
        b=GlxWEShmrKtqsqsl5JwOvDwnPtJps4kh3phIEfOeYt/Ua6xs7LgMhTYMYgmbioPjSJ
         6hQDXaxwRtxAWMMIefqi6tohPlg5Fhv19dpFp0LclOed4GT9URqr8PxUx4dE0IyKHIyx
         33zf2LcGFwm27ZXJhBdp9dGoMW0Id9lAsXCW7S6xJ/2Az5wEr627Ryy5cG/Ox2GUYNQi
         rZTHkfth+AJdlhOdDsSC+LMzYtbUWRSu+ZNcUFpgqv7vPG2NhB3/nktmu6OgepBFevk4
         jTSlrapJN4F4MlgvzriCUcQCLLmDyYQBR5YsPHFHTbSfc/CtiDsNA/laJNCaHcE/TcWn
         m6kQ==
X-Gm-Message-State: AKGB3mI4jueK9bT23Chs3nEZ4opuCBUrNUDdh31BKObdWWHpADneWQAw
        0WXfDsEYpB0wLtVuWP8h1Em06nWY
X-Google-Smtp-Source: ACJfBotN+kC17tEkew41jbBlcSmTQ29BUlv7FhzX5H/S8wJ6+sxMekS0A5ehBE2rx9/I6Xu051zgOg==
X-Received: by 10.80.141.9 with SMTP id s9mr14594447eds.238.1513290433743;
        Thu, 14 Dec 2017 14:27:13 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id o42sm4708715edc.33.2017.12.14.14.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Dec 2017 14:27:12 -0800 (PST)
Subject: Re: Need help migrating workflow from svn to git.
To:     Josef Wolf <jw@raven.inka.de>
References: <20171214130933.GA18542@raven.inka.de>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <5eb3fe18-864d-0b04-223e-d9e5cbf2c81e@gmail.com>
Date:   Thu, 14 Dec 2017 23:27:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171214130933.GA18542@raven.inka.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Josef,

I`m not a Git expert, and I know less of Subversion, but following 
your explanation, I might try to help, at least until more 
experienced people join.

On 14/12/2017 14:09, Josef Wolf wrote:
> 
> Every machine has a working copy of the repository in a specific 
> directory. A cron job (running every 15 minutes) executes "svn
> update" and executes the scripts which are contained in this working
> copy.
> ...
> Sometimes, I need to fix a problem on some host or need to implement
> a new feature. For this, I go to the working copy of a host where the
> change needs to be done and start haking. With svn, I don't need to
> stop the cron job. "svn update" will happily merge any in-coming
> changes and leave alone the files which were not modified upstream.
> Conflicts with my local modifications which I am currently hacking on
> are extremely rare, because the scripts are pretty much independent.
> So I'm pretty much happy with this mode of operation.

Aside "update and merge" working copy while you`re hacking on it, 
what happens with "execute" part? It seems really strange that you 
don`t mind cron job running the same scripts which you are actively 
working on, thus being in an inconsistent state, if not broken, even.

> With git, by contrast, this won't work. Git will refuse to pull
> anything as long as there are ANY local modifications.

Not sure what`s happening at your end, but "ANY" part shouldn`t be 
true - you can have local modifications and still execute `git pull` 
successfully.

Only if you have local modifications in files that _also_ changed on 
the remote end, `git pull` aborts (fetch of the remote branch 
succeeds, actually, just merge with local branch is aborted).

Now, having in mind you said conflicts are extremely rare in your 
flow anyway, would this be enough for you? Of course, provided that 
issue you`re having with being unable to `git pull` with ANY local 
modifications, as you wrote, is resolved first.

> The cron job would need to
> 
>    git stash
>    git pull
>    git stash pop
> 
> But this will temporarily remove my local modifications. If I happen
> to do a test run at this time, the test run would NOT contain the
> local modifications which I was about to test. Even worse: if I
> happen to save one of the modified files while the modifications are
> in the stash, the "git stash pop" will definitely cause a conflict,
> although nothing really changed.

Is `git stash pop` causing conflicts your only concern here? How 
about a situation where you save one of the modified files _after_ 
`git stash pop` was successful, effectively discarding any updates 
introduced by `git pull` from remote end...?

As you basically have a flow where two users (you and cron job) can 
edit same files at the same time, desired outcome might be a bit 
ambiguous, especially when scheduled execution of those files is 
added to the mix.

> So, how would I get this workflow with git? Is it possible to emulate
> the behavior of "svn update"?
> 
> Any ideas?

I`m thinking of a workflow involving (scripted) creation of a 
temporary branch at fetched remote branch position, and using 
something like `git checkout --merge <temp_branch>` to merge your 
local modifications to latest changes fetched from remote (ending up 
with conflicts inside working tree, if any), which would seem to 
simulate `svn update` as desired (if I understand it correctly), but 
it might be good to address some of the concerns I raised above first.

Regards, Buga
