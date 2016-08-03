Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B78231F858
	for <e@80x24.org>; Wed,  3 Aug 2016 12:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757566AbcHCMjY (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 08:39:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34988 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbcHCMjX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 08:39:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so36147703wmg.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 05:39:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0tI2z7hNswsGf7jG1NX3KRMWKj8YVA+8PaFFEnMDuWk=;
        b=POX4vvA5IqzbORLZLzFdN4SG4uUXac/hcOJqKoQ4YHO/4THBVipzmvi59j9hF0A+Fw
         m48FKGN0XRtWqOXgVXm5x4RwedGu87F0qH2a9TcVFLd4FfGYAXFGdFoxP97pcKE4+Xt2
         9cm1i/5mT5oKdnVDRADgr48cP71bx8rKhkKTDoR+K+de8tlLy7tQDbQLVX22nGPr+pwE
         w3UvCUHkRvAppZtiiCMU5OZkjo+MuLBMKUjcA7RinIUa0EYPiPe9iI+y2n81rD4gjTFP
         qKWbf2BmWtfz5D4HSu1cDIP4/bmuXRyKpr7oReF8f6XJRUYB1rDewCP5ppKodPpj4hur
         C5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0tI2z7hNswsGf7jG1NX3KRMWKj8YVA+8PaFFEnMDuWk=;
        b=FDWk7oxEuem1sE1mMf0MpQx0UMUBUzeVwL5uKPeueL1p5945QI7Citjvx99UXqBLOm
         Qab/7ZuH45KYokfD8GdDjNAcDISyXlqTTvi80BDwKuo8Xa3lnMJXREdXl5cq/q44N7eM
         +iNl/oXG+nq5Y0SlTPTKXMAmW0byiyIwzuor6/kUhykSdxUgFMM4QkOv86R0Qif6Qqjs
         KTvgZfyS6tMhqxxliJ/Jcp574DexRxM7mPjA/Gq1gc0EF2A+iY+dqiCKQc6LF49PJE9M
         p7XNeUaaBhBpUfZaEOvtqJlsgvx8JUoiKKvtURUV5WqNSMck750BU9h3MJ2MeBTYMYcw
         c6wg==
X-Gm-Message-State: AEkoouuBnnM2ISo4utAKZQYdCTvYI7dOrwBf7uHYnhnS/WpZEFFHelwGmhueL5w3r9aeow==
X-Received: by 10.194.144.161 with SMTP id sn1mr69103429wjb.29.1470227119982;
        Wed, 03 Aug 2016 05:25:19 -0700 (PDT)
Received: from [192.168.1.26] (daq191.neoplus.adsl.tpnet.pl. [83.23.16.191])
        by smtp.googlemail.com with ESMTPSA id i7sm7499581wjg.42.2016.08.03.05.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2016 05:25:18 -0700 (PDT)
Subject: Re: What's cooking in git.git (Aug 2016, #01; Tue, 2)
To:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqlh0ebyhn.fsf@gitster.mtv.corp.google.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <d3fccd33-1aa2-7e91-9389-df6507861522@gmail.com>
Date:	Wed, 3 Aug 2016 14:24:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqlh0ebyhn.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 03.08.2016 o 00:24, Junio C Hamano pisze:

> --------------------------------------------------
> [Stalled]
> 
> * jh/clean-smudge-annex (2016-08-01) 9 commits
>  - use smudgeToFile filter in recursive merge
>  - use smudgeToFile filter in git am
>  - better recovery from failure of smudgeToFile filter
>  - warn on unusable smudgeToFile/cleanFromFile config
>  - use smudgeToFile in git checkout etc
>  - use cleanFromFile in git add
>  - add smudgeToFile and cleanFromFile filter configs
>  - clarify %f documentation
>  - Merge branch 'cc/apply-am' into HEAD
>  (this branch uses cc/apply-am.)
> 
>  The interface to "clean/smudge" filters require Git to feed the
>  whole contents via pipe, which is suboptimal for some applications.
>  "cleanFromFile/smudgeToFile" commands are the moral equilvalents
>  for these filters but they interact with the files on the
>  filesystem directly.
> 
>  This is starting to bit-rot, as the topic it is built upon keeps
>  getting rerolled.  I _think_ I rebased it correctly, but I would
>  not be surprised if I made a mistake.
> 
>  Will discard if/when I have to do another rebase, preferring to
>  have a fresh reroll directly from the author.

Could you apply the first part (the first patch) of the series,
namely:

   - clarify %f documentation

> * da/subtree-2.9-regression (2016-07-26) 2 commits
>   (merged to 'next' on 2016-07-26 at 9d71562)
>  + subtree: fix "git subtree split --rejoin"
>  + t7900-subtree.sh: fix quoting and broken && chains
>  (this branch is used by da/subtree-modernize.)
> 
>  "git merge" in Git v2.9 was taught to forbid merging an unrelated
>  lines of history by default, but that is exactly the kind of thing
>  the "--rejoin" mode of "git subtree" (in contrib/) wants to do.
>  "git subtree" has been taught to use the "--allow-unrelated-histories"
>  option to override the default.
> 
>  Will merge to 'master'.

Good. At least one Git user was bitten by this bug, see
<1BED74C8-2E4C-4CA7-B785-F0666B69C1A7@gmail.com>


P.S. I guess that filter.<driver>.process series is considered
     pre-cooking?

-- 
Jakub Narębski
