Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FB5320196
	for <e@80x24.org>; Thu, 14 Jul 2016 15:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbcGNPVr (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 11:21:47 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33967 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbcGNPVp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2016 11:21:45 -0400
Received: by mail-io0-f176.google.com with SMTP id q83so78792363iod.1
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 08:21:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mdz0j/sEQm8a0DuMz6asoPRvGQ6LnPF4tyuRMuGMFQU=;
        b=iiiRGhyStZo6lHRPa26WGMgHUd4tu8S1RXHfeDgxSpvbzdktfZOHPowWfzOyb1ts0U
         MNg8juHfOHKPiNer3Aay1s7sP6TlGb6xQtFC4JdN5xSKw3Q2qHXiyGsAZpV0GXpOlTTy
         AjDmtSlkD4ttjAutv+AmP7aGfvt2ZOWQKSHe/ZjHhRBcLxs/+RdrrYRr3yEPuNcgJK3m
         McH2lZLTAAkCpQTW/DiDyCYNpDTl91TRPuFrMIbXJuksDz4pcmVg8jw0mvyfe05GO8LY
         GyKgRftDb31hTPybdf+yjCgA+kLVh4G7rujixI4NiPWUuAodPRCpUcIH1Ztt1WdVO96p
         PPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mdz0j/sEQm8a0DuMz6asoPRvGQ6LnPF4tyuRMuGMFQU=;
        b=FrHaT7VQhbU4y431tC9tVvY9I1uINDFAA9UtBlZ15bguZrDOkz41MCwf6wap6dihim
         2ukcjzewnbe+YRtzi32t3D/wEQmIJAIOseHgXlvdXDG/DrpmTSYyubDOdh6H7CrUwLQ9
         ckFAU95sFRSDqEemE8w6U/9KAZDN7M2n1XF9cn0+AUULW/z9NHZYNp3GeWM1dr7T4WE4
         sjGj30Nb7bY1DvhL5w5y373XVLFQLln3EV///nZH3zqlxEkLQqEjdj2QYzcl/+zK+HKz
         1qqnVwQJTh7u7kqRvF2OJc/BW7GS1jEXfwarkY282n4V0+3knE1kVSv4MoPS3YOLX9d3
         xQAA==
X-Gm-Message-State: ALyK8tIfIXDr6/u0QndDjJ7yOddzGqHiQ60kVJdj6C5Cl4uFYiQm7yPxBNFaejSb9kGJc15Aw1PzMi1wnK1qiw==
X-Received: by 10.107.22.6 with SMTP id 6mr15125002iow.128.1468509704609; Thu,
 14 Jul 2016 08:21:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Thu, 14 Jul 2016 08:21:15 -0700 (PDT)
In-Reply-To: <CACsJy8D9b1U9kP4FfBerWh-q_3fEO5a3aHzSJm9V+2mW5w6YGQ@mail.gmail.com>
References: <009701d1dd53$72777330$57665990$@gmail.com> <CACsJy8D9b1U9kP4FfBerWh-q_3fEO5a3aHzSJm9V+2mW5w6YGQ@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 14 Jul 2016 17:21:15 +0200
Message-ID: <CACsJy8AiER_=5aJ65r+GPCE_nXbrPTAMKJi=FuJgT8zzV2-NFw@mail.gmail.com>
Subject: Re: Bug in index-helper/watchman?
To:	Ben Peart <peartben@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Cc:	David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

...and somehow I forgot to CC git@vger, grrrr....

On Thu, Jul 14, 2016 at 5:14 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> Bug reports should always be in public (so people are aware of it)
> unless it's security exploit of course.
>
> I have not read this mail yet, but I will in a couple of hours, hopefully.
>
> On Thu, Jul 14, 2016 at 12:11 AM, Ben Peart <peartben@gmail.com> wrote:
>> I’ve been chasing down an issue where it looks like the untracked cache
>> logic doesn’t work correctly in the index-helper/watchman patch series.
>> It’s also entirely possible that I’m just missing something so feel free to
>> correct my misconceptions.
>>
>>
>>
>> Ultimately, it appears that none of the untracked cache directories are
>> getting flagged as invalid from the data in the watchman extension.  I
>> believe this is happening because untracked->root doesn’t get initialized
>> until validate_untracked_cache is called from read_directory.  This causes
>> all calls to lookup_untracked to return NULL so the dir->valid flag is never
>> set to zero in mark_untracked_invalid.  See the call stacks and sequence
>> below for details:
>>
>>
>>
>>
>>
>> cmd_status at builtin/commit.c:1362
>>
>>               status_init_config (s=0x6667a0 <s>, fn=0x432790
>> <git_status_config>) at builtin/commit.c:187
>>
>>                              gitmodules_config () at submodule.c:196
>>
>>                                            read_index (istate=0x693860
>> <the_index>) at read-cache.c:1442
>>
>>                                                           read_index_from
>> (istate=0x693860 <the_index>, path=0x2ea3c58 ".git/index") at
>> read-cache.c:1849
>>
>>
>> do_read_index
>>
>>
>> read_index_extension
>>
>>
>> read_watchman_ext
>>
>>
>> mark_untracked_invalid
>>
>>
>> find_untracked_cache_dir
>>
>>
>> lookup_untracked
>>
>>
>> if (!dir)
>>
>>
>> return NULL;
>>
>>
>>
>>               wt_status_collect (s=0x6667a0 <s>) at wt-status.c:627
>>
>>                              wt_status_collect_untracked (s=0x6667a0 <s>) at
>> wt-status.c:593
>>
>>                                            fill_directory (dir=0xbafab0,
>> pathspec=0x6667b8 <s+24>) at dir.c:191
>>
>>                                                           read_directory
>> (dir=0xbafab0, path=0x61cac3 <atat+155> "", len=0, pathspec=0x6667b8 <s+24>)
>> at dir.c:2009
>>
>>
>> validate_untracked_cache at dir.c:1903
>>
>>
>> if (!dir->untracked->root)
>>
>>
>> read_directory_recursive
>>
>>
>> open_cached_dir
>>
>>
>> valid_cached_dir
>>
>>
>> read_directory_recursive
>>
>>
>> open_cached_dir
>>
>>
>> valid_cached_dir
>>
>>
>> if (dir->untracked->use_watchman)
>>
>>
>>
>>
>>
>> If I’m reading this correctly, one potential fix is to move the logic that
>> loops through the directories calling mark_untracked_invalid to between the
>> call to validate_untracked_cache and the call to read_directory_recursive.
>> I wonder if there is another simpler/better fix.
>>
>>
>>
>> Thoughts?
>>
>>
>>
>> Ben
>
>
>
> --
> Duy



-- 
Duy
