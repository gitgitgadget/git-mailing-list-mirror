Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 046751F597
	for <e@80x24.org>; Tue, 17 Jul 2018 10:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbeGQLRD (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 07:17:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:38717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729749AbeGQLRD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 07:17:03 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LinyL-1gArL72dzx-00d1w6; Tue, 17
 Jul 2018 12:45:00 +0200
Date:   Tue, 17 Jul 2018 12:44:44 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 3/5] format-patch: extend --range-diff to accept
 revision range
In-Reply-To: <20180530080325.37520-4-sunshine@sunshineco.com>
Message-ID: <nycvar.QRO.7.76.6.1807171243410.71@tvgsbejvaqbjf.bet>
References: <20180530080325.37520-1-sunshine@sunshineco.com> <20180530080325.37520-4-sunshine@sunshineco.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:r/DknALIIzfwa5V3VAJn+mYksK/kpNzgvoVMKZZpvjJthIAFXLz
 fLwKWZPKYgJ9LHQCGTaVDdQQ52lU9M5bsW1H54kXKRcGio9f/UyTKM/exS2Cl5slZyvb5l5
 wQaLu+CjWhTVd5ogFEiBirpIJj7hWvij0V/fXodPnV0VfM5Uv9ASEpTx7gtMnjXa3JFPtb0
 2HYfH5cK/SxeIJIoILR2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:afJBMwFWIlU=:cKzRSKscBYyZ8T1m+AZmER
 Sj0/fg6BbtPiaPGUURlNjvJRsJv7IUUjJUrFhxWoILhvVV4fx7MFZhNsPkyDxkYQMB0wPwfrM
 a75HaCTL8lyQvPEVt1i0x+Ex8JuREFLcptZZ3k4qwDLHgoDIWffxtlnv+KjrvEpo2DQ1U7O8D
 EfbR4sdzSM1bTzzTX9kZH/uYviJCBDatjqd0UV6kQB8djf0FUholnYZzuIolbDxGiuLnrmzIg
 9ZzndKex9Yecz2iTmtx24ro3zjztM5/pD5PDWrg0Bn1euOmEgZBzdsP2qhT0GH6p8uBvhHoM0
 65WMeWCm35nh/F1T6fGt4G5C252R8i0rL0Yrlrgkm6j5BuZhoUtpkxCp74XNC1UqbQKnXNLXv
 Ceww8e5zN/SFODenpSvPeBmoIb1s0AZoX2/PsMrjFRguOWiHYl1bzyog6jWGd1hSAAniQFRMM
 lMo1MkqMQAfw6Uj943q6uJdXjftCzhZbTmge6v2Wn3AkZ0P6nzG3eHRuO382AZTS4SEEuosBH
 xWEym+xP5DlGmbM43XTK/2ZA2mil9kpw9xhaeT8OAu+8ZiEaUJjdNi/lcK3/5leT7rkHO5/fg
 kAqlD/kv0PoilftnqYhQD6eQQ3TduJkrDypNPz227rcVM5YEmFp7c6fJr1+vhHdUGqTyKfM8T
 ZQZMWelm0gMY0apFeZnqKarfd4awNXrFkYP8wc7rF/Qj022p5jXvJ1vQvbEnf/P01w9Z8bwf1
 lVZK3jaaHzaUGvKJlTYN1lrE9em08xrikNWsRhIDfjDcN89ZZ4T2yc8Oikh12jekG/I+8n80Q
 8It6kVj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 30 May 2018, Eric Sunshine wrote:

> diff --git a/builtin/log.c b/builtin/log.c
> index 460c31a293..e38cf06050 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -995,10 +995,20 @@ static char *find_branch_name(struct rev_info *rev)
>  
>  static void infer_diff_ranges(struct argv_array *args,
>  			      const char *prev,
> +			      struct commit *origin,
>  			      struct commit *head)
>  {
> -	argv_array_pushf(args, "%s...%s", prev,
> -			 oid_to_hex(&head->object.oid));
> +	if (strstr(prev, "..")) {
> +		if (!origin)
> +			die(_("failed to infer range-diff ranges"));
> +		argv_array_push(args, prev);
> +		argv_array_pushf(args, "%s..%s",
> +				 oid_to_hex(&origin->object.oid),
> +				 oid_to_hex(&head->object.oid));
> +	} else {
> +		argv_array_pushf(args, "%s...%s", prev,
> +				 oid_to_hex(&head->object.oid));
> +	}

This would be easier to read if the order was inverted:

	if (!strstr(...))
		...
	else if (!origin)
		die(...)
	else {
		...
	}

Otherwise, it makes sense to me.

Thanks,
Dscho

>  }
>  
>  static int get_range_diff(struct strbuf *sb,
> @@ -1059,7 +1069,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  	/* might die from bad user input so try before creating cover letter */
>  	if (range_diff) {
>  		struct argv_array ranges = ARGV_ARRAY_INIT;
> -		infer_diff_ranges(&ranges, range_diff, head);
> +		infer_diff_ranges(&ranges, range_diff, origin, head);
>  		if (get_range_diff(&diff, &ranges))
>  			die(_("failed to generate range-diff"));
>  		argv_array_clear(&ranges);
> diff --git a/t/t7910-branch-diff.sh b/t/t7910-branch-diff.sh
> index edbd69b6f8..c0e8668ed9 100755
> --- a/t/t7910-branch-diff.sh
> +++ b/t/t7910-branch-diff.sh
> @@ -155,5 +155,6 @@ format_patch () {
>  }
>  
>  format_patch 'B...C' topic
> +format_patch 'A..B A..C' master..topic
>  
>  test_done
> -- 
> 2.17.1.1235.ge295dfb56e
> 
> 
