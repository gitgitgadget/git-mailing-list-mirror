Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840F6207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 22:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031680AbdDZWcO (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 18:32:14 -0400
Received: from mout.web.de ([212.227.17.12]:55159 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031615AbdDZWcM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 18:32:12 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MI5ze-1d7LEP1Er8-003tez; Thu, 27
 Apr 2017 00:32:07 +0200
Subject: Re: [PATCH v5 6/8] Introduce a new data type for timestamps
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <cover.1492771484.git.johannes.schindelin@gmx.de>
 <cover.1493042239.git.johannes.schindelin@gmx.de>
 <fea2df0e1ff5869572cf756d75fd3468d184457f.1493042239.git.johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <615c74de-0a9d-b5ff-f7f2-68feca5d1985@web.de>
Date:   Thu, 27 Apr 2017 00:32:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <fea2df0e1ff5869572cf756d75fd3468d184457f.1493042239.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:NqPCr79E2GL5gQssZRCPPiokV/VXHFqlVHdnpGcip6saRGO3PlZ
 UDpQKKR+EliqDWCEAmknk+FR2oBGr80v8J59m1IUmy9koJ8Hk2MuESjPR0MnCD88zi8c4q9
 Yk5Czjpfizyb6xIDUyidHHqoAwBnPqeSZIo63IxOH8EZ9/kbOAUYd3Ctg9hh/oWNBzS7eFu
 CcXMPKO8xKSXQQWRXLIMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RJSOJvh4YY0=:gQ/7AZh80cu+u+v04eE9EO
 VDGUsWWn89SJ/doX4wHYEEnL1Pzp/TpCskFwL6bmHEzOCwTt7MJsJp3YOfufpQeuRUQnNPK4L
 nDlaGtBuYLvuNY6pj1+xzz0IDXCZETT+DBGOjMEEYJNEQU8LrRE3pZhOZPHOMvcvIi712I2XO
 DfRBanZ64FBov0yHy6JESPxtQuP3AzSGoLSM6MvJgxdbj++dx92Xq/W8Iaucjp2BmHHq4o45U
 HrP0lNkIghIhYHNqgd2Rrx9g901EEAtEpni6h2UVfJEaKlP+oUMZ8HSnF0k/DDUMG1m1WKuCW
 okp71rQW0BlryPVPol1lu/LFagc5JHgueM+r2ZLuqbZeoCQsojPYbPRtGtVBQEJSR0mSqXyg9
 Ku7MEItRLkClsh1FIZkpXOFhA8KMISZyso6q/8G2yfgoF/B06eeFjNvxcoXqKtpf4HArFUgNi
 NQpHbdfUGSnVKxr/iMQoez4cItFWMy7hLr11J7PuQ+0rPcMConTfIEtlk/A3YVdZOLSnuQVIP
 p36QHLaX8Klmm9XObIO9gwJ34Q1wkM1I/G4LLXLs61mjJIhXBadK7RyEtOPxziJnVnFaGyWhs
 ydbrO3ZyKrXzG5phL4mjkwR3mtWhePfpJOAabvXeJw3z1pPHY6qgom8F9arAAUh1t+EFbGVu9
 Ro/yy1vtMuW6zhh54GEmbf7C4GMDwmaWHuN+/sZQuhWTfqKMVLwe+IE9v8buMVnoi7zg0tu1j
 I3eG2yMhhXNIqBySIi5g3Tjov1lY+xFGMViPQgaT28RfgT1WJZrVqFz8ufL4My6D1hs/Moz04
 EfskCix
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.04.2017 um 15:58 schrieb Johannes Schindelin:
> diff --git a/archive-tar.c b/archive-tar.c
> index 380e3aedd23..695339a2369 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -27,9 +27,12 @@ static int write_tar_filter_archive(const struct archiver *ar,
>    */
>   #if ULONG_MAX == 0xFFFFFFFF
>   #define USTAR_MAX_SIZE ULONG_MAX
> -#define USTAR_MAX_MTIME ULONG_MAX
>   #else
>   #define USTAR_MAX_SIZE 077777777777UL
> +#endif
> +#if TIME_MAX == 0xFFFFFFFF
> +#define USTAR_MAX_MTIME TIME_MAX
> +#else
>   #define USTAR_MAX_MTIME 077777777777UL
>   #endif
>   
> diff --git a/archive-zip.c b/archive-zip.c
> index b429a8d974a..68df3d64402 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -545,9 +545,17 @@ static void write_zip_trailer(const unsigned char *sha1)
>   		write_or_die(1, sha1_to_hex(sha1), GIT_SHA1_HEXSZ);
>   }
>   
> -static void dos_time(time_t *time, int *dos_date, int *dos_time)
> +static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
>   {
> -	struct tm *t = localtime(time);
> +	time_t time;
> +	struct tm *t;
> +
> +	if (date_overflows(*timestamp))
> +		die("timestamp too large for this system: %"PRItime,
> +		    *timestamp);
> +	time = (time_t)*timestamp;
> +	t = localtime(&time);
> +	*timestamp = time;
>   
>   	*dos_date = t->tm_mday + (t->tm_mon + 1) * 32 +
>   	            (t->tm_year + 1900 - 1980) * 512;
> diff --git a/archive.h b/archive.h
> index 415e0152e2c..62d1d82c1af 100644
> --- a/archive.h
> +++ b/archive.h
> @@ -9,7 +9,7 @@ struct archiver_args {
>   	struct tree *tree;
>   	const unsigned char *commit_sha1;
>   	const struct commit *commit;
> -	time_t time;
> +	timestamp_t time;
>   	struct pathspec pathspec;
>   	unsigned int verbose : 1;
>   	unsigned int worktree_attributes : 1;

time_t is converted to timestamp_t here.  Hmm.

Truncation can already occur in archive.c::parse_treeish_arg() when
assigning commit->date (of type timestamp_t) to archive_time (of type
time_t).  The overflow check should either be moved there or the type of
the latter variable should be changed, right?

Compilation and tests are still successful on Debian x86 and MinGW64
even after removing the changes above.  On the former the test "generate
tar with future mtime" in t5000 writes Epoch time stamps in both cases
(and doesn't notice because tar is unable to handle times after 2038, so
that check is skipped), on the latter it emits the correct future dates.

So what are the benefits of these changes?

Unless I'm missing something (very possible at this time of day) I'd say
drop these hunks and let me handle the fallout of the series in archive.
I was planning on improving its date handling code anyway (eventually)..

René
