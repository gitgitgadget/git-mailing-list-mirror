Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 076E91FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 20:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755552AbdDFUVF (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 16:21:05 -0400
Received: from mout.web.de ([212.227.17.12]:58632 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754719AbdDFUVE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 16:21:04 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lcxxc-1cE3RT1FMO-00i8Ok; Thu, 06
 Apr 2017 22:20:51 +0200
Subject: Re: [PATCH v5 1/4] p0004-read-tree: perf test to time read-tree
To:     git@jeffhostetler.com, git@vger.kernel.org
References: <20170405173809.3098-1-git@jeffhostetler.com>
 <20170405173809.3098-2-git@jeffhostetler.com>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6937b76e-9bbf-7ce5-8605-e09f556f8a26@web.de>
Date:   Thu, 6 Apr 2017 22:20:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170405173809.3098-2-git@jeffhostetler.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:re1gnWyYXUEfRnYuZB6mxIW0fP5refM2QJs0W/3o6O02QbjIebX
 QAhej0RBpVB3k9RjwJaFGqyXt6pQO9Iyc6bpp5IIWFfml6nbJgShf1rFLZYHpTTRzdjCqsj
 XRlnU5uEJA0OdPg5m7z6m1GozLCQwPCxoV32Mabj8is2pHWTqEIEA/tN+kN2Xa6vQLYQcgb
 iwZ9Z8VDQUk0tPdckN0ZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R/anHFHYjVE=:MaIct/aFSeJT4H25McJO5x
 4gi5AIKOu8bicd0YqF+KYC8PwurjBoSOBSIIUqFm2G6LK5cCrsbkRXF2W8a247lePRCD0BpbG
 oG8G9UoS2sHufv0kOoBLoFdYd6ArO40zVDA0TpaxsUG6DCNS8m/Cx72r06hhq5cwCAh5Cnn8C
 gX2wsTyRUATYC9CRzt2lTiUukpSCL9PcHnymVIY8Bg6+Dbma5Ln4zqM13T4R7js1YMEmMU3WF
 N3SpwzC8a5kVoN+2zVCLPenwT51CKwIfyd3k7hxFSXI00ZP0xNw/QByTTldai2+PpedZziQrp
 H34wFYXjwSp2iY+QqSFvc1J1rLyc26al+i3AgOkk3LEo8sgfmniwbaARiUe1jNYCwzTTlFph5
 gpXcOVXGjjyUVSh9C9sjAg8szg9SkufgOJMB1gZmYF9eMOHyR8vL9kP6xxqzRB1HPwk99NWMy
 iTwEHezwrzrHr8qjfYR+jRsWIkIngCVuqgN5xghMAvqApWjatJF5FkHbYZ6zz2iP3vxgrKwhb
 Gk8Au1pfsccLWTYUsTUltZulA9RBxcJi3kQIJV5IqSgEewgRnaWAWyxXZb2i/+O2nyXBPQy1G
 ZhhnZnHkQjKwIvF1wLXTuRX4mhzAo4UUABu9awZx3sNw91a81ta64OFfXxtF2mBiXBBRuYXxX
 /1kVsPncQvQrnleBxSAJKyCVRPGI3ITtCLI6VW5XZHRpcPk/tW1AuyFmF6zIxMq1dWqPY+0nA
 QSuFZcjEqhqGYaZKDJ6zzpctgR9KfxLhSN0eyMiK3YO098xNequkiqKJGp4ZFCZPHtonLXIEQ
 hsGnd7l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.04.2017 um 19:38 schrieb git@jeffhostetler.com:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  t/perf/p0004-read-tree.sh | 116 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100755 t/perf/p0004-read-tree.sh
> 
> diff --git a/t/perf/p0004-read-tree.sh b/t/perf/p0004-read-tree.sh
> new file mode 100755
> index 0000000..5d8bbf5
> --- /dev/null
> +++ b/t/perf/p0004-read-tree.sh
> @@ -0,0 +1,116 @@
> +#!/bin/sh
> +
> +test_description="Tests performance of read-tree"
> +
> +. ./perf-lib.sh
> +
> +test_perf_default_repo
> +test_checkout_worktree
> +
> +## usage: dir depth width files
> +make_paths () {
> +	for f in $(seq $4)
> +	do
> +		echo $1/file$f
> +	done;
> +	if test $2 -gt 0;
> +	then
> +		for w in $(seq $3)
> +		do
> +			make_paths $1/dir$w $(($2 - 1)) $3 $4
> +		done
> +	fi
> +	return 0
> +}

"make_paths xxx_dir_xxx 5 10 9" takes more than a minute for me.
Providing its results as a file would be quicker but less flexible.
The following command prints the same result in less than a second.

	awk -v dir=xxx_dir_xxx -v depth=5 -v width=10 -v files=9 '
        	function make_paths(dir, depth, width, files,  i)
	        {
        	        for (i = 1; i <= files; i++) {
	                        print dir "/file" i
        	        }
	                if (depth > 0) {
        	                for (i = 1; i <= width; i++) {
	                                make_paths(dir "/dir" i, depth - 1, width, files)
        	                }
                	}
	        }
	        END {make_paths(dir, depth, width, files)}
	' </dev/null

It's faster because it avoids calling seq thousands of times.

> +
> +fill_index () {
> +	make_paths $1 $2 $3 $4 |
> +	sed "s/^/100644 $EMPTY_BLOB	/" |

You could add the prefix to the script above and avoid this sed call
as well.

René
