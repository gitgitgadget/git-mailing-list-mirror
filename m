Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C4BC1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 20:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeI2DIE (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 23:08:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38761 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbeI2DIE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 23:08:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so5068392pfh.5
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/Avp2YNOnsM4hWIyIhgSjftNER8IzwLTIfTV+wcGQw4=;
        b=QZ4VqilTos5nqmL8WTlULhMDFDiYNIdR9gNv6XL0vXD6M4KDUrbQraE618Troe8jwI
         KHN5B6Dqy5jJh2nqIdDpYH13VkgksZEJOK3ueqkzFcl0bqbcXz3bFuqAVBaxTgjKJywQ
         gsbz8X4KQ7dJwrygYzL1q8M/Gy3FXbKVsaF2x256ls0pMziuw9QlWVr83L02JjI5xU6F
         /r4qQGn+PemHsfRTRl0D7zmpL6eENnyFwssczWX6iQ+31xnizprm23FBSSWF9/bXg08t
         rPI/PsvFZ/qxLf5tf3ub+QkMxwDmzFl1bPsSmJNpMRXkhR8QiWu9huRMMVLxqi53befZ
         hVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/Avp2YNOnsM4hWIyIhgSjftNER8IzwLTIfTV+wcGQw4=;
        b=iw2nT4nlIob7j1pCWyEpMA/4DeH3Zs2tvVZD3p1X5vF3j6VVGcDpQgINyNRqZTLNuS
         z6M9toyYA19pHNglarO09CQwTOanOk3qQ/u3ztWAyUOsGT15QA+1EnG1ao5eJJEJ5srS
         FQeiupkkbAKlFjEZaoLVosBRS+T2Qkx/Iqh/3FDBODhrm9SK98N2IaZE8tJwktSw0VEG
         NwqKQdq2D+54BQ+9tg3suURFcNzBheqp1b2KJxsMKT/GEpxSA1RiK38/Gv087j4/ZzkN
         ZW9PjkvzRcsB7n4UOKit8d0mttY87nv4lscF5reikZark05up7XypuvB8cSoMphQo5cT
         CjlA==
X-Gm-Message-State: ABuFfog1AOPzWtozJio8oJF8HUih/n2cYY6l/+rCnhQG/RKan+RIDuqD
        bbtoD0vUFoXbb1S1XyqJrO0=
X-Google-Smtp-Source: ACcGV60EDWcxHhCA3VZPg71gBu8LKwc0ZAOP7oHSv6D9IPNmixuhGFBlv93nrjBY528mfjv2xh7SWg==
X-Received: by 2002:a63:184a:: with SMTP id 10-v6mr251965pgy.81.1538167356205;
        Fri, 28 Sep 2018 13:42:36 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z11-v6sm493770pfd.99.2018.09.28.13.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 13:42:35 -0700 (PDT)
Date:   Fri, 28 Sep 2018 13:42:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-packagers@googlegroups.com, Git List <git@vger.kernel.org>
Subject: Re: Git for Windows for Unix?
Message-ID: <20180928204233.GA193055@aiede.svl.corp.google.com>
References: <87va6rhqup.fsf@evledraar.gmail.com>
 <20180927160523.GA112066@aiede.svl.corp.google.com>
 <87tvmaj4fq.fsf@evledraar.gmail.com>
 <20180927162623.GB112066@aiede.svl.corp.google.com>
 <87ftxtieeg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftxtieeg.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Thu, Sep 27 2018, Jonathan Nieder wrote:

>> That said, that seems to me like a lot of work to avoid adding some
>> patches to "next" that belong in "next" anyway.  I understand why the
>> Git for Windows maintainer does not always have time to upstream
>> promptly, which is why I suggest working with him to find a way to
>> help with that.
>>
>> If there's something I'm missing and Git is actually an uncooperative
>> upstream like the cases you've mentioned, then I'd be happy to learn
>> about that so we can fix it, too.
>
> That's one and valid way to look at it, convergence would be ideal.
>
> Another way to look at it, which is closer to what I was thinking about,
> is to just view GFW as some alternate universe "next" branch (which by
> my count is ~2-3k commits ahead of master[1]).

You could view it that way, but I don't.  Many Git for Windows patches
have never even visited the Git mailing list.

Thanks,
Jonathan
