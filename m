Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE601F406
	for <e@80x24.org>; Sat,  9 Dec 2017 14:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbdLIOqV (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 09:46:21 -0500
Received: from mout.web.de ([212.227.17.11]:61711 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751289AbdLIOqU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 09:46:20 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEEa4-1eH2Xg1Sv2-00FWPb; Sat, 09
 Dec 2017 15:46:08 +0100
Date:   Sat, 9 Dec 2017 15:46:07 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
Message-ID: <20171209144607.GA6443@tor.lan>
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
 <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com>
 <alpine.DEB.2.21.1.1712071643410.4318@virtualbox>
 <175f87bc-0270-fb18-fc14-24e8f59321d6@jeffhostetler.com>
 <20171207213312.GB3693@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207213312.GB3693@zaya.teonanacatl.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:3c5A151kXREM18iXlPqR6TycVmzXSWwas3HlMx1tN6NJKk+Yrp+
 jet5AsCNP9Smyam9aQFta87PcMRw5ghhNZxU9zFW8y32OOR1yNt+2BqyK9Nvrna/Dc9+2X5
 CEvlaKI3z89sQiCWq8nVjciJJL3WWscst/Ytv4zjVaPU/tWT19j/TeM6QT1wszxImN76bTv
 7Fecf/5vfmJ3MXNqmIKqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KZx3uuADjbo=:PFK9dx6/eTd64plg9hLKai
 tRbCt6ncEWd4vMBFcFRTlyq8NtvlacoI+7+qrMjPFVmGJPnLteQNxwIbmkh32w7ctls6xQMVC
 kJFqe3xznilTWSZDQyaLq96+e0O5PHn8WskdQxgGKNJof50H5VwAXxR4PPf5y5H12t0TDznU5
 FvOQcand+/7L7UytLLRPrfkv+SlQQFaC6LcZ4+xSoGdnhXI+sQauFeEY7xVDUlLws5lcPEdU5
 JnUquGs2fdk+cbr4I6AocR9yEl5mBU/aPWqud43fytUx9s8YXIa9fwqpSZRlT4qbsLj6xYRLX
 4ylHn8LlD3Juu5SvIDhwXnDShmA4RioTfgO+Qzz6q22xSNhGhjN4Rb0Xiu99ugLm87RPsD+Vi
 nzs12O0jkEnkZHzVJ+4wjKX5QjdjTPq3zGchturEh09k7jA2Mg7030VtLoyavLU0SWsmZuoi/
 QY14bYtavTTCbNbtGTT7PcYdFxNkX1RP2MskGESq1QcpcboR+mwugMFYTsUGsb+ncEIyLSn29
 KiZh8lbEcp4bKS4bNcddAgiMkNCrjo8ZgKPcToJ4iRxxklTATVLEfHURXb/BMIgOuJo5iWWCW
 6SOmqTpyVLDARhDU8q/b7yxE6lpqkvHIW60jQHb579j1cTWhwSDhAj92/NGOtmYFTr6m7RGMQ
 PoMplbAksZMruBNaSqzITulfcDl+loZka2DIDqKj6ZRR5NmfIjY3O7Td5049ck6Fpsl+nn+D1
 fGClp5V9cqrmSwrb4vInZS/Wc0BqCYGO/WN6TkYpnrB+zT6VMkrZBWi8EW80B9FsogLOSMrT/
 LytfOiEU+3pDDEIjJS5gWV8ldodpA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 07, 2017 at 04:33:12PM -0500, Todd Zullinger wrote:
> Jeff Hostetler wrote:
> >I'm looking at t5616 now on my mac.
> >Looks like the MAC doesn't like my line counting in the tests.
> >I'll fix in my next version.
> 
[]
> 		| sort >expect_2.oids &&
> -	test "$(wc -l <expect_2.oids)" = "8" &&
> +	test_line_count = 8 expect_2.oids &&
> 	git -C src blame master -- file.1.txt >expect.blame
> '


The problem seems to be the '"' around wc, this would work:
test $(wc -l <expect_2.oids) = "8" &&


What do you guys think a about a lint test like this:

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 03dc9d2852..9ebf65c26f 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -21,6 +21,7 @@ while (<>) {
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)';
 	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (please use =)';
+	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable, please use `$(wc -l)`';
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (please use FOO=bar && expo






