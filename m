Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F9D4207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954983AbdDYVy4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:54:56 -0400
Received: from mout.web.de ([212.227.17.11]:62480 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1954980AbdDYVyz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:54:55 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MX0UC-1cXDQb0gBY-00W0oO; Tue, 25
 Apr 2017 23:54:49 +0200
Subject: Re: [PATCH v5 0/8] Introduce timestamp_t for timestamps
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <cover.1492771484.git.johannes.schindelin@gmx.de>
 <cover.1493042239.git.johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7a2271ff-1386-18a6-5f6d-7eb13dc92509@web.de>
Date:   Tue, 25 Apr 2017 23:54:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <cover.1493042239.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:VvXEtI3qwQqq3X/9tgX07PMLYXrIEVjRKpdHcnB7wtLvNplfZkN
 LKpCO3fHIGPXsvXUXl2dC5f2aQkjBWJHXssC7CAmaltZWJQhTx7shkHXjCeLBNMbHWDN2d3
 XiCPiOi6ayFUEFPC5uzPM92gPHp4ulo1zTBveqdSrcIbi3lc0D0gM0wg/Dx96gVGMA0bMvE
 LVLN4YDK2X/9ZK/aSvBUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QTmqtI0Lj0M=:oLN/okR3NsTEdr2M5yZmC1
 Sj6u6mKMJ1cHmfNEIcnYCN0pwzPXcabbhLculU9rEjcY2Zo6ZXIX2304Ky9NO6buBO2Q7t4ja
 Z2LPMSJT+eU5iWhZs8dK1EDFTCh4SspQi+kGUG1kUhv2okZf+cRvu/bjSYHYhP+ejHOs949U1
 O7/2szyBjJFinDP9uo1u9R7apBvpw2jAz6lwwuNaYTqhGPk1rD1NgTKGeOk56qML9mhj7SIjh
 O7GA3heUbCvPuO56VO2K6JANqsU+JTRKkvz0AOsUjXcNnd1C73DnarFhl+AYzNLxtByBN/6fu
 tlglCG+BKnUMwb/rYDQdyMiO0C4S9Lpz1ugdR45Z13QdEXTwPCBVE0NrRDZBzJ22v5PN/O7nK
 rZGEGlbeOqkgNENTfc0oPqImY2SzE207cBZobRVi2hjrh9bzFT5WlxJfzaBj4Gpm4U5bjahmD
 3oU5P2cXLQ2kpDxnycvxAexJ5AgQRi/oXomCeGDCJdD6N1LjYlQcQjQlTecWqFO17AAHxEKDW
 i8/AOe/B8OVhHrecKVi2emZTgx7l3fvhXJF1jCppAuu7TK4iEy8pIB5XCsNNyYJ4Z2/KlUb9e
 9w1dQ+iEI5QMWkoJolnk+ztyV6azyjQRVCCW41Smu/0wnBkjnZuCbt8+FWr2km3CjHRpVo0he
 AMmE2rh+nUjYSYVOrAsX08nqA+11o7TSsB/F3m9KH/IXYP6mbR1mtHiOr7YCODyBok7YKEY4P
 XrEBdbQ8o594c8x2e3IrhGpWPELC50QtrAzR4LQh562p8znjCztLkW3GEFTm6dPRdbCM2aI0t
 kbl1CSO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.04.2017 um 15:57 schrieb Johannes Schindelin:
> Git v2.9.2 was released in a hurry to accomodate for platforms like
> Windows, where the `unsigned long` data type is 32-bit even for 64-bit
> setups.
> 
> The quick fix was to simply disable all the testing with "absurd" future
> dates.
> 
> However, we can do much better than that, as we already make use of
> 64-bit data types internally. There is no good reason why we should not
> use the same for timestamps. Hence, let's use uintmax_t for timestamps.
> 
> Note: while the `time_t` data type exists and is meant to be used for
> timestamps, on 32-bit Linux it is *still* 32-bit. An earlier iteration
> used `time_t` for that reason, but it came with a few serious downsides:
> as `time_t` can be signed (and indeed, on Windows it is an int64_t),
> Git's expectation that 0 is the minimal value does no longer hold true,
> introducing its own set of interesting challenges. Besides, if we *can*
> handle far in the future timestamps (except for formatting them using
> the system libraries), it is more consistent to do so.

time_t is signed on Linux and BSDs as well.

Using an unsigned type gives us the ability to represent times beyond
the 292 billion years in the future that int64_t would give us, but
prevents recording events that occurred before the Epoch.  That doesn't
sound like a good deal to me -- storing historical works (e.g. law
texts) with real time stamps is probably more interesting than fixing
the year 292277026596 problem within this decade.

> The upside of using `uintmax_t` for timestamps is that we do a much
> better job to support far in the future timestamps across all platforms,
> including 32-bit ones. The downside is that those platforms that use a
> 32-bit `time_t` will barf when parsing or formatting those timestamps.

IIUC this series has two aims: solving the year 2038 problem on 32-bit
Linux by replacing time_t (int32_t), and solving the year 2106 problem
on Windows by replacing unsigned long (uint32_t), right?  The latter one
sounds more interesting, because 32-bit platforms would still be unable
to fully use bigger time values as you wrote above.

Can we leave time_t alone and just do the part where you replace
unsigned long with timestamp_t defined as uint64_t?  That should already
help on Windows, correct?  When/if timestamp_t is later changed to a
signed type then we could easily convert the time_t cases to timestamp_t
as well, or the other way around.

> This iteration makes the date_overflows() check more stringent again.
> 
> It is arguably a bug to paper over too-large author/committer dates and
> to replace them with Jan 1 1970 without even telling the user that we do
> that, but this is the behavior that t4212 verifies, so I reinstated that
> behavior. The change in behavior was missed because of the missing
> unsigned_add_overflows() test.

I can't think of many ways to get future time stamps (broken clock,
broken CMOS battery, bit rot, time travel), so I wouldn't expect a
change towards better error reporting to affect a lot of users.  (Not
necessarily as part of this series, of course.)

> Changes since v4:
> 
> - in gm_time_t(), we now test specifically that the timezone adjustment
>    neither underflows nor overflows.
> 
> - the patch introduced in v4 that tried to defer the date_overflows()
>    check to gm_time_t() rather than replacing the ident timestamp by a 0
>    without any warning was dropped again: it broke t4212.
> 
> 
> Johannes Schindelin (8):
>    ref-filter: avoid using `unsigned long` for catch-all data type
>    t0006 & t5000: prepare for 64-bit timestamps
>    t0006 & t5000: skip "far in the future" test when time_t is too
>      limited
>    Specify explicitly where we parse timestamps
>    Introduce a new "printf format" for timestamps
>    Introduce a new data type for timestamps
>    Abort if the system time cannot handle one of our timestamps
>    Use uintmax_t for timestamps
> 
>   Documentation/technical/api-parse-options.txt |   8 +-
>   archive-tar.c                                 |   5 +-
>   archive-zip.c                                 |  12 ++-
>   archive.h                                     |   2 +-
>   builtin/am.c                                  |   4 +-
>   builtin/blame.c                               |  14 ++--
>   builtin/fsck.c                                |   6 +-
>   builtin/gc.c                                  |   2 +-
>   builtin/log.c                                 |   4 +-
>   builtin/merge-base.c                          |   2 +-
>   builtin/name-rev.c                            |   6 +-
>   builtin/pack-objects.c                        |   4 +-
>   builtin/prune.c                               |   4 +-
>   builtin/receive-pack.c                        |  14 ++--
>   builtin/reflog.c                              |  24 +++---
>   builtin/rev-list.c                            |   2 +-
>   builtin/rev-parse.c                           |   2 +-
>   builtin/show-branch.c                         |   4 +-
>   builtin/worktree.c                            |   4 +-
>   bundle.c                                      |   4 +-
>   cache.h                                       |  14 ++--
>   commit.c                                      |  18 ++--
>   commit.h                                      |   2 +-
>   config.c                                      |   2 +-
>   credential-cache--daemon.c                    |  12 +--
>   date.c                                        | 113 ++++++++++++++------------
>   fetch-pack.c                                  |   8 +-
>   fsck.c                                        |   2 +-
>   git-compat-util.h                             |   9 ++
>   http-backend.c                                |   4 +-
>   parse-options-cb.c                            |   4 +-
>   pretty.c                                      |   4 +-
>   reachable.c                                   |   9 +-
>   reachable.h                                   |   4 +-
>   ref-filter.c                                  |  22 ++---
>   reflog-walk.c                                 |   8 +-
>   refs.c                                        |  14 ++--
>   refs.h                                        |   8 +-
>   refs/files-backend.c                          |   8 +-
>   revision.c                                    |   6 +-
>   revision.h                                    |   4 +-
>   sha1_name.c                                   |   6 +-
>   t/helper/test-date.c                          |  18 ++--
>   t/helper/test-parse-options.c                 |   4 +-
>   t/helper/test-ref-store.c                     |   4 +-
>   t/t0006-date.sh                               |   4 +-
>   t/t5000-tar-tree.sh                           |   6 +-
>   t/test-lib.sh                                 |   3 +
>   tag.c                                         |   6 +-
>   tag.h                                         |   2 +-
>   upload-pack.c                                 |   8 +-
>   vcs-svn/fast_export.c                         |   8 +-
>   vcs-svn/fast_export.h                         |   4 +-
>   vcs-svn/svndump.c                             |   2 +-
>   wt-status.c                                   |   2 +-
>   55 files changed, 260 insertions(+), 219 deletions(-)

How did you find all the pieces of code that need to be touched?  Is
there a regex or something that can be used to spot new such places
that sneak in, e.g. through in-flight merges?

> base-commit: e2cb6ab84c94f147f1259260961513b40c36108a
> Published-As: https://github.com/dscho/git/releases/tag/time_t-may-be-int64-v5
> Fetch-It-Via: git fetch https://github.com/dscho/git time_t-may-be-int64-v5
> 
> Interdiff vs v4:
> 
>   diff --git a/date.c b/date.c
>   index 75f6335cd09..63fa99685e2 100644
>   --- a/date.c
>   +++ b/date.c
>   @@ -47,9 +47,16 @@ static time_t gm_time_t(timestamp_t time, int tz)
>    	minutes = (minutes / 100)*60 + (minutes % 100);
>    	minutes = tz < 0 ? -minutes : minutes;
>    
>   -	if (date_overflows(time + minutes * 60))
>   +	if (minutes > 0) {
>   +		if (unsigned_add_overflows(time, minutes * 60))
>   +			die("Timestamp+tz too large: %"PRItime" +%04d",
>   +			    time, tz);
>   +	} else if (time < -minutes * 60)
>   +		die("Timestamp before Unix epoch: %"PRItime" %04d", time, tz);
>   +	time += minutes * 60;
>   +	if (date_overflows(time))
>    		die("Timestamp too large for this system: %"PRItime, time);
>   -	return (time_t)time + minutes * 60;
>   +	return (time_t)time;
>    }
>    
>    /*
>   diff --git a/pretty.c b/pretty.c
>   index 35fd290096a..587d48371b0 100644
>   --- a/pretty.c
>   +++ b/pretty.c
>   @@ -410,10 +410,14 @@ const char *show_ident_date(const struct ident_split *ident,
>    
>    	if (ident->date_begin && ident->date_end)
>    		date = parse_timestamp(ident->date_begin, NULL, 10);
>   -	if (ident->tz_begin && ident->tz_end)
>   -		tz = strtol(ident->tz_begin, NULL, 10);
>   -	if (tz >= INT_MAX || tz <= INT_MIN)
>   -		tz = 0;
>   +	if (date_overflows(date))
>   +		date = 0;
>   +	else {
>   +		if (ident->tz_begin && ident->tz_end)
>   +			tz = strtol(ident->tz_begin, NULL, 10);
>   +		if (tz >= INT_MAX || tz <= INT_MIN)
>   +			tz = 0;
>   +	}
>    	return show_date(date, tz, mode);
>    }
>    
> 
