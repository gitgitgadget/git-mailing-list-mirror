Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396881F859
	for <e@80x24.org>; Sat, 27 Aug 2016 07:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbcH0HzR (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 03:55:17 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35041 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbcH0HzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 03:55:16 -0400
Received: by mail-wm0-f46.google.com with SMTP id f65so18240611wmi.0
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 00:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=CrU7nPANFmqiv8qk9epUujQhV6tmhS77Gilm9fake6o=;
        b=ns1CYdzE5tlL2hao5ajfofliIdgvW8foPe+ahtLuHOccZqUxHSQJrpqH+2NKq4IYoP
         0pVkV3ggXr5Eva1ZerdVW5kQ9pfybll7f8BpTOlSoZAqRty1tA+v47Rl5zZMmjM8hv1s
         zbgob7UenFBe6vncIiSVvlchGVwUh7Vwm33K6qhLPAM5yg9HVODusgLrFJE2jBRsH9c5
         Q7EFtD5A8It9UP9XNR8dgPRg3TeOerDwo45Pmu/sMAsm1R37q1Cx9x/HgFUk07tTriRO
         yoAcApzbLnV4WIZwj8ff4AdwmHlQndTMPAXFZZ4A7f0JGqGwMpIwt5YA4sUeF0DSCq1/
         NHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=CrU7nPANFmqiv8qk9epUujQhV6tmhS77Gilm9fake6o=;
        b=cKO7JrYj6hWuBDxdL7PuJ2g0H8yeGcytnx9U6mTbuKqwt/FhnvXYwGfU/11sNj1nMp
         BDFMtNy9LQ0kxRVVF/csxqvC5X/Am6NHWr7LPo+4m8+RExO0s2Q/7AWPzRWuKYiDXQ6+
         UOeC8KnZuS3uSgfT2sbZ+t8XUhv25wTsseYW0CZFpjO5yUwL6gwUypVvWxp5Qf1bz20l
         zGq7cvrZVmWZJvLlDyPakM/aFZ5KL6HfbOPha5TBQXTEuWF19z20hx7MorCevtwvvdKp
         /tkMEL4IGonEFebsyePsOi4u1m8/OsbTTYj7ELHI98OUx5w+QM8BHAc9lmKpSZy0b27w
         Pp4Q==
X-Gm-Message-State: AE9vXwOEXQ/ljaVPkGvhnStrWrQGUFPSa1bkfgo4gOz/zzsPWvabU8R3lrnNwtJGvt/97w==
X-Received: by 10.28.197.129 with SMTP id v123mr2150371wmf.70.1472284514585;
        Sat, 27 Aug 2016 00:55:14 -0700 (PDT)
Received: from [192.168.1.26] (dav122.neoplus.adsl.tpnet.pl. [83.23.21.122])
        by smtp.googlemail.com with ESMTPSA id pm1sm23448744wjb.40.2016.08.27.00.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Aug 2016 00:55:13 -0700 (PDT)
Subject: Re: stable as subset of develop
To:     Brett Porter <porter@devrts.com>, git@vger.kernel.org
References: <57C0FB1D.9070206@devrts.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <1b3990a1-f9a0-f48e-239f-095b17108d0a@gmail.com>
Date:   Sat, 27 Aug 2016 09:55:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <57C0FB1D.9070206@devrts.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 27.08.2016 o 04:29, Brett Porter pisze:
> 
> In a small group, develop is the branch where all fixes/additions/... from topic
> branches are merged rather dynamically. Thorough testing of commits
> may lag behind, but when we think one is a pretty good commit we want
> to identify it as (at least relatively) the latest stable. We could
> tag it, but we would like these stable commits to be a branch in the
> sense that each commit points back to a previous commit.
> 
> Merging from a development branch commit to stable isn't quite what
> we want. It seems more like:
> 
>   checkout the new good development commit
>   change HEAD to the head of the stable branch
>   git add --all
>   git commit
>   (maybe tag the new commit with the hash of the chosen development commit)

If you are really using topic branches, a better workflow would be
to make use of them.  That is, do the development of new features
on topic branches, test them in relative isolation, and when deemed
ready merge them into development branch, for more testing (including
integration testing).

Then, those topic branches that are considered stable are merged
into stable branch ("trunk").  You can think of it as picking
features to have in stable.

Take a look at Junio's blog posts about this topic.

> Will that work (one thing beyond my current understanding is if there
> are index complications)? Other ideas?

That looks a bit like reimplementation of cherry-picking.

Also, I think you would loose the ability to run git-bisect to find
bad commits.
 
> This could help with applying successively more intense testing over
> time and chase down where problems arose.

Reiterationg: if you are using topic branches, use topic-branch workflow.

-- 
Jakub Narębski

author of "Mastering Git"
https://www.packtpub.com/application-development/mastering-git
