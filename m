Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2426AC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039B920757
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388707AbgDBNku (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:40:50 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:58283 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388520AbgDBNku (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:40:50 -0400
Received: from [192.168.100.176] ([80.150.130.51]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MVeDs-1jjCRs1A9M-00RdN5; Thu, 02 Apr 2020 15:40:44 +0200
Subject: Re: [REGRESSION] gitk can't be run from non-worktree folders
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de>
 <20200123163151.GC6837@szeder.dev>
 <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
From:   ch <cr@onlinehome.de>
Message-ID: <3c1a3e23-cf52-48cc-e9b6-f80642ca67ac@onlinehome.de>
Date:   Thu, 2 Apr 2020 15:40:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:O2BMU9XGtW0zAu1Qac7bKaPti0AXQZWGAk30OCIVTMeBP3XlMx/
 uoPuhb6WkebLR6Da7L9mRi56BrY6buxLvgPM+KGEfZhQMd1R0k8kT4t2B2BbCvzsU/ANGN1
 3qoXrWFLweT7DyjthbvbDY7wVvwHjYbjN8r0k98m8KHTkK98Uvj7jWw3nIZoSOJN4To15mq
 SOY/Soxhxb3dTDLwTWjNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WwcKQvOPjxg=:fPAH8v5GHeAJeE8a21gqpv
 y1kTJ8hHw7LbSUSRNkJUvCluvLRngD/M4JQ1q8h8gIBeGaXSubIb23zrgmLLkd8Ny9U0kUJom
 2g1RHMp/oUvLhdv9ZQGBz4sxkZRuPWK3xPT1JdoS/nDobHs80BESO/XUFIvCim8ikZhvAixuO
 8lPF6YLxcnvzjbBewf91cosxFEEEK5/5aFpPDQwL3v4I1KknifSBEBNgTlGaZvZE0UUYubD6q
 +FONAIWgQYDPFUSQ2M3KO7TZcnyq2kdohWnP9tSzq52+vcI92SRv+ca3mbPAN49XpBlpWr3Mo
 piLSxogmy91d6z20v2mB885/cCrBUgWNNrlMhX9kCTl0Yi0Y32COzlXZlOXVYL3tyY0lCmUTs
 +HBTm2Bc0UVIRm1A6i63lkgqkrLAGcx6WVd2Xt4xYlUMPseZEUz/DZ8hn7Kq4zAQskJPujonw
 Uyg6DRBlzEnKHObYASoX/8ucc4ujfj9KDOdc4K29ls7bwAS94P4P7RfxpG+9NsZGWAakFCZVb
 h1XwpTbZbG2kooPqTwm9S8tUApkHOe6FhULUod84xVpK24jz+eQ3+lRNPCJadHcd0iLfbrS2b
 R1iN7o2dAUTkFj2bIZ+C5XzuQ41sYHPZ5lMLSIQBuH7pJ2Kt523BxBOzzECr9BV5jWwn5O0x4
 81+cZU3AGYxNFcGhZHIqAB8wDDilpOiU4lH93mYI+KALx48vs5v0NRUuy3hwSI+hj6wmakGeG
 N0crIqmx75G/j6DiMLlrB2QecjqEOszZ1gzjQB4j6yDMDw5reDTiiCqd03+fPArD0jRXcCHez
 AaXXSZMzZn93yzNIfIaHWb6/bq/aGDnb9jZVuEHki440xlvYgGQBbliJs2w8P01iU58TgH1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I haven't actually bisected it but the change possibly also broke
git-gui-browser on bare repositories.

The follow patch seems to fix the issue. As I stated in my original bug report
I'm using Git for Windows so maybe it does not apply cleanly on upstream Git.

-- >8 --

--- git-gui.tcl	2020-03-23 12:22:36.000000000 +0100
+++ git-gui-fixed.tcl	2020-04-01 17:35:26.092223600 +0200
@@ -1286,7 +1286,7 @@
  	if { [is_Cygwin] } {
  		catch {set _gitworktree [exec cygpath --windows [git rev-parse --show-toplevel]]}
  	} else {
-		set _gitworktree [git rev-parse --show-toplevel]
+		catch {set _gitworktree [git rev-parse --show-toplevel]}
  	}
  } else {
  	# try to set work tree from environment, core.worktree or use

-- >8 --

On 23.01.2020 17:36, Eric Sunshine wrote:

> It's a new regression introduced by 2d92ab32fd (rev-parse: make
> --show-toplevel without a worktree an error, 2019-11-19), as far as I
> can tell. I have many times used gitk on bare repositories as an
> interactive replacement for git-log, so this is a unfortunate bit of
> fallout from that change. That's not to say that 2d92ab32fd should be
> reverted, though... perhaps gitk itself needs a bit of a fix.
> 
