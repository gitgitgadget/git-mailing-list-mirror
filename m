Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B0562047F
	for <e@80x24.org>; Sun, 17 Sep 2017 13:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbdIQNYx (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 09:24:53 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:37595 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdIQNYw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 09:24:52 -0400
Received: from [192.168.2.240] ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id tZZ3dGaq4pb8rtZZ3dGq64; Sun, 17 Sep 2017 14:24:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1505654690; bh=PBXzXujCFMae0LRNoJY9PUILCmAqcswpHotW+L9ph3Q=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=PTc0//1N1FmX5OyW6Zj6ZP1nOmwN18QbXAxw0vyv/X0P2+Na9++p9g9l2Jiy4tIwj
         yRXKK1iSxIDszPscHx+S8j/yA1adp/fCCnObZ1a1Sf70iujmH9dd/ESyH5PQoy/3jc
         gUZMXAFsaTKw64lqime5M8Z/sWvgfMB26Vf6yDFE=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8
 a=pGLkceISAAAA:8 a=extA4yZ_AAAA:8 a=eA_Qv9OQm11-r3pDZSoA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=hVSmkA6k2N-FF26V3nNA:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] doc: update information about windows build
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
References: <0102015e8e4f7e75-dfec22a3-bb1a-4208-a069-450275d52b6d-000000@eu-west-1.amazonses.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <80afe093-aceb-9478-f0d2-d69f7f75eaab@talktalk.net>
Date:   Sun, 17 Sep 2017 14:24:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0102015e8e4f7e75-dfec22a3-bb1a-4208-a069-450275d52b6d-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfATFBpxk14WNQyyQqNHogssZs0VvaUDHDgPUYOmHWam4zdpd1CvcVXDu0t7FrVy6HnVovNK0KTg9i5nUQuTxRDZ9XBRuZEIgVi0ayUPJ+ll//rRHMSwx
 uAEFKT0BuffwNVsSd95W0DRfvr5Pt1dIPZKJtK5a0odchUpnIj6xNtjQMMADvW61WsGzIilcdn7iLxJn1ApJzLZCC2LDy7+jBYHq5GuStJQUdPut0LTqlUuJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/09/17 06:28, Kaartic Sivaraam wrote:
> 
> 029aeeed5 (travis-ci: build and test Git on Windows, 2017-03-24) added
> support for testing the git build for Windows.
> 
> So, update the documentation and the example used in it.

 From that commit:
diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
new file mode 100755
index 000000000..4e3a50b60
--- /dev/null
+++ b/ci/run-windows-build.sh
@@ -0,0 +1,74 @@
+#!/usr/bin/env bash
+#
+# Script to trigger the a Git for Windows build and test run.
+# Set the $GFW_CI_TOKEN as environment variable.
+# Pass the branch (only branches on https://github.com/git/git are
+# supported) and a commit hash.
+#

so only git/git from github gets built on windows, not other peoples 
trees. One cannot use travis to test ones changes on windows before 
submitting them

Best wishes

Phillip
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>   Documentation/SubmittingPatches | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 558d465b656a0..43c9b9ae49298 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -395,8 +395,9 @@ GitHub-Travis CI hints
>   
>   With an account at GitHub (you can get one for free to work on open
>   source projects), you can use Travis CI to test your changes on Linux,
> -Mac (and hopefully soon Windows).  You can find a successful example
> -test build here: https://travis-ci.org/git/git/builds/120473209
> +Mac.  Though Travis CI doesn't support Windows we have worked around
> +that temporarily!  You can find a successful example test build
> +here: https://travis-ci.org/git/git/builds/264560175
>   
>   Follow these steps for the initial setup:
>   
> 
> --
> https://github.com/git/git/pull/402
> 

