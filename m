Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33FF20248
	for <e@80x24.org>; Fri,  8 Mar 2019 15:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfCHPjI (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 10:39:08 -0500
Received: from mout.gmx.net ([212.227.15.18]:40191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfCHPjI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 10:39:08 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Likl3-1gWVfl1VwD-00cw0m; Fri, 08
 Mar 2019 16:39:00 +0100
Date:   Fri, 8 Mar 2019 16:38:44 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] line-log: suppress diff output with "-s"
In-Reply-To: <20190307194514.GA29260@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903081636350.41@tvgsbejvaqbjf.bet>
References: <20190307194514.GA29260@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xQ72EtDCyvvE663ORfGehQUquC/tny1Ik6z07hAJHJmFTn0bgoB
 KVigCeNFN3GCpSfm+OJXdrR5QpgDgm5qwjX8byVMS7aUAF1rKpc8e6XtQmRHLQ18MghCKko
 IWG5K6Xev0eBh8MajqXbdJKHPg1DkP4HJlr26q0OhLf5tbfeGeNCzbZbXK7X47UTdB25LTz
 gg184fMXyt6/xWfSxjTmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lf1vgisgh2I=:7+TYup7dHHscr+alS9N3kq
 9LWp9Kv4BsEsclZtp7dIl+nQFWded8ngLBefgTtkzpMoK8V/UhbUePS9qcxea46BkfynTce3P
 eRvYW1WFFIj0ijTjwc86gtfVQVGtiYeLpvvp4HljJw1vPp6Hq5pJ8587pKtZU4ydEoVM4KOIp
 QT4bH+nxtmKuo0IE7VKzAVDvlQdU4jyl29oLzaArJToJJKEGnaG/RrY8q028ovHcl5LhIlKn0
 xA2Gunh8uDWCCQpQMagrWcT9+zlPOmzsj5KrGtY62eyM9GkxHlGfZxMul72xTHTIfCyzsN4As
 PjeJ0YeRHtHOtDK8ic/+4brq1D4jE6C632r/2xYZnfC143ZqcAcE5EpwK0APKA8NAXCDyQ0jx
 8sxmx2gjFTaWskvLcYiqT2WvYuaxGDzNsZ5WGbBtW9MnrzJegx/h0QyJdd0qP1oqRAIiIi5CV
 ZkoCd3xwBI5DtlEn0SFnpCL5ddEb6tvl4q6CXRZd4pAmPx+kfEzw3cfnHPTqR3qxCs1LXis0I
 IhOqFIx4atlY97xGBTwsNuaS7hkbaEHF+TL0RCk0RKHJcTCW/v9yRG+u8Pe0TKb0VdyLslCi5
 cFFwmMBiR8lxlGVHDkFqa5e+mHRqL5+ZzDPlVNl/tvwyLIekfgPoFZBN6A2WhOxTivOck3uR6
 oGbuvmXbAZ9y9U8Uqcht3evP/puSdspJ+SmEhq2PO9NHws3I27k80hgU5O50eQc9Z9u5vR03y
 K86GEK5LNyPagYSuv3qSAp/dpJf3tnI4B8ygH5kYBq1LmKP1DjsOz71EDe6wtOhr28rcYXCyq
 fHl3quoJNIBZVLb6gC4XFKoUYTvMvmpgbQbI+axJnjRVVJP4anegNxo3W7Ri7sV/Tn7owpAkZ
 HUlTXE1GUFKCP+CJycO4DnhrXqByP4pcQ/AESDBUjWzq51jwQS+cehQOwhyIVdNghjFlFssG6
 GNEMNQ28F1g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 7 Mar 2019, Jeff King wrote:

> When "-L" is in use, we ignore any diff output format that the user
> provides to us, and just always print a patch (with extra context lines
> covering the whole area of interest). It's not entirely clear what we
> should do with all formats (e.g., should "--stat" show just the diffstat
> of the touched lines, or the stat for the whole file?).
> 
> But "-s" is pretty clear: the user probably wants to see just the
> commits that touched those lines, without any diff at all. Let's at
> least make that work.

Agree. The patch looks obviously good.

Thank you,
Dscho

> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is a repost from the thread at:
> 
>   https://public-inbox.org/git/CAEkQehdFu5zM4AY3ihN0pn1aCNEomY0WV07pryfAB45JN-tDDA@mail.gmail.com/
> 
>  line-log.c          | 6 ++++--
>  t/t4211-line-log.sh | 7 +++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/line-log.c b/line-log.c
> index 24e21731c4..59248e37cc 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -1103,10 +1103,12 @@ static int process_all_files(struct line_log_data **range_out,
>  
>  int line_log_print(struct rev_info *rev, struct commit *commit)
>  {
> -	struct line_log_data *range = lookup_line_range(rev, commit);
>  
>  	show_log(rev);
> -	dump_diff_hacky(rev, range);
> +	if (!(rev->diffopt.output_format & DIFF_FORMAT_NO_OUTPUT)) {
> +		struct line_log_data *range = lookup_line_range(rev, commit);
> +		dump_diff_hacky(rev, range);
> +	}
>  	return 1;
>  }
>  
> diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
> index bd5fe4d148..c9f2036f68 100755
> --- a/t/t4211-line-log.sh
> +++ b/t/t4211-line-log.sh
> @@ -115,4 +115,11 @@ test_expect_success 'range_set_union' '
>  	git log $(for x in $(test_seq 200); do echo -L $((2*x)),+1:c.c; done)
>  '
>  
> +test_expect_success '-s shows only line-log commits' '
> +	git log --format="commit %s" -L1,24:b.c >expect.raw &&
> +	grep ^commit expect.raw >expect &&
> +	git log --format="commit %s" -L1,24:b.c -s >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> -- 
> 2.21.0.787.g929e938557
> 
