Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E121F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 14:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767161AbcHRO3D (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 10:29:03 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34291 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1950266AbcHRO3A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 10:29:00 -0400
Received: by mail-pa0-f45.google.com with SMTP id fi15so6730550pac.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 07:29:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tobiah-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=96xeHQc4hh+L09TY+Md8+haqX/gjCBU5yQ/fAeWfVnc=;
        b=DJtrBom5NMM5VA5tcdUWBtqmCgBspvAgiJGLxVnqTj2Jvs1ynnZ8IlLdXmQVjN7YV4
         EvmPKqamS5ymDUNae3MoxqDl57sGs6TeIu8oZkMUHHVlG3GHT45a8QfkEDNAbaj75Edq
         Ap5e6r8Q3b5tJnqDdcixtxvHXrAzkI8Fvk1QCCE9Id3kjPsU7KL0uYS9FyhJ6awJu9vN
         g3Q8yAydDaW8SF1hm4QS4FR+DJtxonyx1cN5HDHf4v+3yquNudGWno5XnPgOiwFkwjWB
         eLtzo7RlDpiXPT/ivne8bbI7RGieqUhufBjvepMxE3rEbe03S/WuB0bT4ko/to2dsySy
         k0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=96xeHQc4hh+L09TY+Md8+haqX/gjCBU5yQ/fAeWfVnc=;
        b=LUmxSQ66sVo7pRxhapOppQSOqagkXLSWQCTn3Npmcsp8Hh9UUWx7RFi8ObMBp7d3WP
         RqoVH8P/nus7UX7ItwWPOK3x3AV4AVcOTeW4r9cW7skqrjTa0nhsCAPBzLDfz0y5gkZ8
         310+TBZFwWLkcNlrqM22EgWGVJ9jcwXOP6XwMKnY5UJzcixVPFYVl5vN4N0/GZnJxbUP
         p0qeN01NML/fMap0GDr+iIzuyu4CpjSOTiAyzTBvXqH8S5/p1yAtSSTbQdxaWbBPd/EK
         PUtB5y3oV1lwIfZZFWkOpP138RcsWB9lY82DJpVk+p1GViDFIoVRyHhH9jizlcrV0dG+
         afGw==
X-Gm-Message-State: AEkooust5JBJ5r4oa30UxxD3UYv+DV82rtUBIyavfisBhUk5h0eAbkgM6b+VcSAx6MJLrQ==
X-Received: by 10.66.137.107 with SMTP id qh11mr4558194pab.49.1471530539942;
        Thu, 18 Aug 2016 07:28:59 -0700 (PDT)
Received: from [10.10.10.25] (72-165-89-133.dia.static.qwest.net. [72.165.89.133])
        by smtp.googlemail.com with ESMTPSA id p64sm4397629pfd.11.2016.08.18.07.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2016 07:28:59 -0700 (PDT)
Subject: Re: Working from different machines.
To:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
References: <71d05705-792f-8bb9-026b-5b9251b104b9@tobiah.org>
 <xmqq4m6j81ci.fsf@gitster.mtv.corp.google.com>
 <60d5e760-dbc9-121e-f003-a6971534cdcb@gmail.com>
From:	Tobiah <toby@tobiah.org>
Cc:	git@vger.kernel.org
Message-ID: <4a154cc2-c3e2-65b7-4bdd-d7c41d700491@tobiah.org>
Date:	Thu, 18 Aug 2016 07:28:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <60d5e760-dbc9-121e-f003-a6971534cdcb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


>
> * First, `--mirror` might be what the relation between 'desktop'
>   and 'home' repositories should be.
>


Here's what I'm trying, am I in the right ballpark?

desk> git branch
* master
desk> git checkout -b banana
Switched to a new branch 'banana'
desk> echo 'message' > oracle
desk> git add oracle
desk> git commit -a -moracle
[banana 66e7823] oracle
  1 file changed, 1 insertion(+)
  create mode 100644 oracle
desk> git push --mirror
Counting objects: 3, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 260 bytes | 0 bytes/s, done.
Total 3 (delta 1), reused 0 (delta 0)
To toby@shells.rcsreg.com:/home/git/toby/exposmart
  * [new branch]      banana -> banana

# Then on another machine:

home> git branch
* master
## Forgot to 'pull' here, but it never shows new branches anyway
## I have to get them by name.  Can I automate that?

home> git checkout banana
Branch banana set up to track remote branch banana from origin.
Switched to a new branch 'banana'
home> cat oracle
message
home> echo 'other message' >> oracle
home> git commit -a -moracle2
[banana 78e6c45] oracle2
  1 file changed, 1 insertion(+)
home> git push --mirror
Counting objects: 36, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (22/22), done.
Writing objects: 100% (36/36), 2.90 KiB | 0 bytes/s, done.
Total 36 (delta 13), reused 14 (delta 4)
To shells.rcsreg.com:/home/git/toby/exposmart
    66e7823..78e6c45  banana -> banana
    7e01bf8..c65ed75  origin/HEAD -> origin/HEAD
  * [new branch]      origin/auto -> origin/auto
  * [new branch]      origin/banana -> origin/banana
  * [new branch]      origin/develop -> origin/develop
  * [new branch]      origin/flipper -> origin/flipper
  * [new branch]      origin/tart -> origin/tart
home> vi
home> git push --mirror
Total 0 (delta 0), reused 0 (delta 0)
To shells.rcsreg.com:/home/git/toby/exposmart
    66e7823..78e6c45  origin/banana -> origin/banana
home> git push --mirror
Everything up-to-date
home>

## Why do I have to push three times to get the 'Everyting up-to-date'
## message?  Why does it still mention 'flipper' and 'tart' and all
## other branches I've played with.  When I delte them locally, I want
## them to be deleted everywhere.  They just keep accumulating.
##
## Now back a the other machine


desk> git pull
remote: Counting objects: 5, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
 From shells.rcsreg.com:/home/git/toby/exposmart
    66e7823..78e6c45  banana     -> origin/banana
There is no tracking information for the current branch.
Please specify which branch you want to merge with.
See git-pull(1) for details.

     git pull <remote> <branch>

If you wish to set tracking information for this branch you can do so with:

     git branch --set-upstream-to=origin/<branch> banana

desk> git branch
* banana
   master
desk> git pull origin banana
 From shells.rcsreg.com:/home/git/toby/exposmart
  * branch            banana     -> FETCH_HEAD
Updating 66e7823..78e6c45
Fast-forward
  oracle | 1 +
  1 file changed, 1 insertion(+)
desk> cat oracle
message
other message


## So it seems to have worked, but the more I go back and forth
## The more I seem to have eventual problems getting branches
## and changes.  Am I doing it right?


Thanks



