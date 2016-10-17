Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A971F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 20:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758039AbcJQUFO (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 16:05:14 -0400
Received: from mout.web.de ([212.227.17.11]:56058 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756739AbcJQUFL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 16:05:11 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lw0ht-1d1DyV1MuT-017lJL; Mon, 17 Oct 2016 22:04:46
 +0200
Subject: Re: [PATCH] cocci: avoid self-references in object_id transformations
To:     Junio C Hamano <gitster@pobox.com>
References: <a5ed26c0-7fea-259c-74c1-0cd870a35290@web.de>
 <20161015134503.u3aznujploqee2le@vauxhall.crustytoothpaste.net>
 <xmqqlgxmvof2.fsf@gitster.mtv.corp.google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <014ef44e-9dd8-40b3-a3ec-b483f938ee02@web.de>
Date:   Mon, 17 Oct 2016 22:04:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqlgxmvof2.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:+5BQ6vFQWMpjmig0w6+F72Ua7NEa4HNoIjpRYRZhc3ops4+JByf
 +R3vjogMzuI7L1B+tpeo7I1fa81GcnPyNRqa/LL/7nnE7t0e4ctii/bcJ459YtkiqkTesrR
 2WOc5OYp8tTBBgvlfODdxrfwlorwtjvGqE1iASl6wCldr72bMVwoqC+yhVfrDp7p0KUPpEY
 45xWnuYaX7vi6wtMY6swA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ovBy6oXJY9A=:uVWK7wzag22Fis9TrTLPkm
 rTMLqTe1p9lfjiCQGhtHs/G66IiFa/oH26hIbFT/cX8xzaN4StEinSJ0Bm29drdCjGJWiI1Uq
 Md46OIhCj9nCBZkIH4YVhKhaXdO3bT7zTjDWQWpkq0fsRsaVUUstBRC8W7ws2f+9dm9EcGEDs
 8vMsNM9VdD1jCdd0lN9R31NBp1pl77mBRFWHzG6MaK+DGlmGCQyof8g6imIturPLxwAZSw/8Q
 r0eqL00gQlZ517Y2bwvgyHAgX1kHvC5SZey7AKlReCNeQLm6HznNkCB05nL/Ew2u37Kk40hB/
 pdU3SnSL1Bn1dGUgG07Ms/Hd+nB8uMB0YrKXcLs4Ux2dlBUe6Q3ONQw5CNQdU/ugOoJiUIv7D
 otKjcahd8JZYF03DlNyCu8WqqSqASoPbsfkcXaR+5Rd6hdB4x4nplsSbQB7cfsj5QrOVH5EIO
 BsQgaFqJBDzBHPma7C0j1YHN55DdbKCzpcNW6im3tpfFUEfdd8W80YEEt2sVtVwDJPkbwjgGI
 /rgvpTp81c6G6vMepEZGxK1YGsSzyPIkDRt1dWKa5Obee+sjE7HfVrU7nBQQGlVXvyyvs4RjK
 bgOSidCtG5xZvETCa4TgvipRHgllBYjZtqq3wenqYxtzbrRi2OoeF1J2iw+WtBathYFufGwtZ
 5vEPdi0DdjSDLgdisi1HsMp0I5SQ8euFs2YSQH1xbnvCt/C9EOPyovlXUZBEhvXUNyME+XnAH
 q2ugcHZfa/cdPrW0uzANL4rgZcUHMjU3nOZ9MwgzkKFdwMTFe+WglxBtuNG5xZ2i9MDrB1yBW
 vn75oZE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.10.2016 um 20:08 schrieb Junio C Hamano:
> ... oops.  Totally unrelated to this patch, but I see these in
> strbuf.cocci.patch (this is at the tip of 'pu'), which are total
> nonsense.  Perhaps I am running a way-stale spatch?  It claims to be
> "spatch version 1.0.0-rc19 with Python support and with PCRE support"
> 
> --- date.c
> +++ /tmp/cocci-output-21568-bd3448-date.c
> @@ -179,7 +179,7 @@ const char *show_date(unsigned long time
>  
>  	if (mode->type == DATE_UNIX) {
>  		strbuf_reset(&timebuf);
> -		strbuf_addf(&timebuf, "%lu", time);
> +		strbuf_addstr(&timebuf, time);
>  		return timebuf.buf;
>  	}
>  
> --- log-tree.c
> +++ /tmp/cocci-output-21608-b02087-log-tree.c
> @@ -400,7 +400,7 @@ void log_write_email_headers(struct rev_
>  		extra_headers = subject_buffer;
>  
>  		if (opt->numbered_files)
> -			strbuf_addf(&filename, "%d", opt->nr);
> +			strbuf_addstr(&filename, opt->nr);
>  		else
>  			fmt_output_commit(&filename, commit, opt);
>  		snprintf(buffer, sizeof(buffer) - 1,

I get these instead with 6513eabcbcbcfa684d4bb2d57f61c662b870b5ca on
Debian testing with its "spatch version 1.0.4 with Python support and
with PCRE support", which look legit:

--- sequencer.c
+++ /tmp/cocci-output-40365-db7a71-sequencer.c
@@ -159,7 +159,7 @@ int sequencer_remove_state(struct replay
 		free(opts->xopts[i]);
 	free(opts->xopts);
 
-	strbuf_addf(&dir, "%s", get_dir(opts));
+	strbuf_addstr(&dir, get_dir(opts));
 	remove_dir_recursively(&dir, 0);
 	strbuf_release(&dir);
 
--- builtin/branch.c
+++ /tmp/cocci-output-40858-a86d1a-branch.c
@@ -316,7 +316,7 @@ static char *build_format(struct ref_fil
 
 	if (filter->verbose) {
 		strbuf_addf(&local, "%%(align:%d,left)%%(refname:strip=2)%%(end)", maxwidth);
-		strbuf_addf(&local, "%s", branch_get_color(BRANCH_COLOR_RESET));
+		strbuf_addstr(&local, branch_get_color(BRANCH_COLOR_RESET));
 		strbuf_addf(&local, " %%(objectname:short=7) ");
 
 		if (filter->verbose > 1)
