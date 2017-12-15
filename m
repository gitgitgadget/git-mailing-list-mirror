Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9BC1F407
	for <e@80x24.org>; Fri, 15 Dec 2017 18:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755853AbdLOSY1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 13:24:27 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:44959 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbdLOSYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 13:24:09 -0500
Received: by mail-wm0-f54.google.com with SMTP id t8so19123253wmc.3
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 10:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=q55r9sHZWgX+KgUws820wOJ4mvu8LYA/G6viCBh9WkU=;
        b=kX9dz3QJOa/JOrav+Xx5STmKmkfYlBCOEYjdsKE/FMUpz8k/VW8wuA3LPAuuVjbsBg
         JcV1xYf33bOWbXsUy0cFd0OetWmvwJmr/0zkBDuWKzqj88C2kic1/T3XG8dR/t3zWmcu
         317O4CQ+64IiBAFthTveA5crGuUg2Rvv79JRsY1JdGM+YJ9P5DiHaShd6y4HE+2YqGjf
         bs+J5qWVeM1ZN7B0NasN+g0GZfT+gc/iiQlb9ZMmRjNxeJMQKBVpoKJNTNr7R2OGtGaQ
         4bRyB1LVN0uKfqnmIJmkDQ7kzGOyePK+GTElECqQCamECJoyJQ3POcBqL1CYGYltxzyb
         q/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q55r9sHZWgX+KgUws820wOJ4mvu8LYA/G6viCBh9WkU=;
        b=FsVavOFaGxCRX/JK8Ynxc3jch/rcylJek6rZ3Y1J7dyBckBYP1yhTyoyNoGeka09wW
         2H/qWZNGVFo+9AZcTrngBeqwMJZEdzCfiGbPMuPbbg5IdM6/+2/HXEtIe2DA2ZKdyOnG
         ngiwwHjpukmIlDNmEG2UFtrf2L75rCh6mkSVLpK0NijAQMXbtthCaH1N2+bdmMCUad0w
         Qe0NpFIl4hVglhPxKshWZ9g68MF+oQbk7nptyMS1TH/QipTfhj24NCc9KDl9PQFbwy1v
         VnSYj0kgBXblvuJsJLAF7s7fJtxQD2clBrtJdXyFgLX58+Q6SHPtOLepmmASplE5ZkFZ
         vYdg==
X-Gm-Message-State: AKGB3mIPvYipkgXnFeOmI7wAP7cgvsIOnVyZumziiU0yQi1J2WuBpPQH
        tNkCsIb67yHrWwrtOANGmyh4E7U1
X-Google-Smtp-Source: ACJfBouABS8MwXCWA+ccsEFO+t+QktjvihUnL55xdYBSW2S0Qa/yTC2mSt3GclBqzbZ/WS7yM3W8KQ==
X-Received: by 10.80.222.73 with SMTP id a9mr18772150edl.214.1513362247897;
        Fri, 15 Dec 2017 10:24:07 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id h56sm6063067eda.97.2017.12.15.10.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Dec 2017 10:24:07 -0800 (PST)
Subject: Re: Need help migrating workflow from svn to git.
To:     Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20171214130933.GA18542@raven.inka.de>
 <5eb3fe18-864d-0b04-223e-d9e5cbf2c81e@gmail.com>
 <20171215124739.GC18542@raven.inka.de>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <0c0867d8-73d7-3577-be26-2a9a7691d58b@gmail.com>
Date:   Fri, 15 Dec 2017 19:24:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171215124739.GC18542@raven.inka.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Josef,

Thank you for your patient answers. From what you said here and in 
that other reply[1], it looks like you know what you`re doing, you`re 
aware of circumstances, and you still prefer doing it that way.

So, here it goes... :)

On 15/12/2017 13:47, Josef Wolf wrote:
> 
> > I`m thinking of a workflow involving (scripted) creation of a 
> > temporary branch at fetched remote branch position, and using 
> > something like `git checkout --merge <temp_branch>` to merge your 
> > local modifications to latest changes fetched from remote (ending
> > up with conflicts inside working tree, if any),
> 
> But this would require local modifications to be committed?
 
Nope :) Here`s a script you can test to see if it works for you, 
simulating `svn update` (at least how I perceived it).

Feel free to adapt as you feel like it (I used local "master" branch 
and remote "origin/master", for example), or to speak up if any 
additional info is needed.

    git checkout -b temp &&               #1
    git fetch &&                          #2
    git branch -f master origin/master && #3
    git checkout -m master &&             #4
    git add -u &&                         #5
    git reset &&                          #6
    git branch -d temp                    #7

Explanation:
 1. Create temporary branch where we are, switching to it, so we can 
    update "master" without local modifications
 2. Fetch latest updates
 3. Update "master" to fetched "origin/master"
 4. Switch to updated "master", merging local modifications
 5. Mark any pending merge conflicts as resolved by staging them...
 6. ... and unstage them right away
 7. Delete temporary branch

Step (4) is what merges your local modifications with remote updates 
(leaving conflicts, if any), where steps (5) and (6) are not needed 
for a single run, but in case you don`t resolve conflicts before next 
cron job executes this script again, step (1) will now fail without 
them because of (still) unresolved merge conflicts.

So, as you seem to be pretty at ease with your flow, you might prefer 
leaving those two steps (5, 6) in.

This does seem ugly and hacky, but if it works for you, I don`t judge :) 
Please note that there might be better ways to accomplish this, I 
repeat, I`m not an expert, but hopefully this could do the job.

Also, if I missed something, I hope someone will correct me.

Regards, Buga

[1] https://public-inbox.org/git/20171215130645.GD18542@raven.inka.de/
