Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED9BD20286
	for <e@80x24.org>; Sun, 10 Sep 2017 12:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbdIJM16 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 08:27:58 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:62751 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbdIJM15 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 08:27:57 -0400
Received: from UltraSam.fritz.box ([92.76.183.238]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0M0i6Q-1dbGJ90Gpq-00umwl; Sun, 10 Sep 2017 14:27:49 +0200
Subject: Re: Unexpected pass for t6120-describe.sh on cygwin
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <7c3db153-2a56-f27d-af71-e4b61f1252a1@ramsayjones.plus.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <947699e6-c206-7818-3780-c4367e0996f0@grubix.eu>
Date:   Sun, 10 Sep 2017 14:27:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <7c3db153-2a56-f27d-af71-e4b61f1252a1@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:28XMpWMKrxM1EuZZxFqZV10VKpKcodJI0AVTKTPEZ1L0f+qtIOK
 eIBVFTsDSRsWHbuYlZdSbStTeoSYegai39X5lg5Ek3Al7SVb9CUr4DwU6V0qBA8FInYDEC7
 2cYG+hICrZE3Yr0Vb7MBO4r1PuAGknTfBWOhg8V61wgl+eEA8zibwqGkx7DhNF5eVXuQM2G
 W35eFPBVj29csBJXOQtiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DC3tBjTIS3M=:O3gPvGSmSh2d52BTpmHq6f
 y8TqCLqn7sIpp+U/yjNme5plyS9hUyDHdlKwjcpA0Wm9v5whE3n0SUc/aH+kNSUuVF01O2d1M
 dN1PX2ukzm55fkB+QPtp8FWkNePIkEtxx4peEfrJmRqx6s35Vka23+YTY7K0it8w4xZdijs6N
 XZMcbiGv1z5l+8mLCvWh2faJhlwsg3EApNHIU/0ChdpGpqSJb/13RH/TkGG8SOVRd+OVZEyqe
 mh8juddwEeKryHmQT86IvU/OaQpK5CNRIEHu5K644ggdlGt5340YnIIPdgBg276conrZ056/e
 /AxEutLBk3n0+UKMDUq4VyS8kmytQeofTxsSkIEptPNABMC5xbRt0FuFZAKeK5olYfyn8hB+7
 oEMX+FVUnbSwhEFG3anp6UhcWfm+2wycQCUUdZNkkxxnXryB1Il5TYdHsXUAJOjfBT+eVYDkD
 7VvY1U0hnNjcjEjxvmm0GBFTd4byFhf8I6/3huFSfYHJGo9VaaxCwbeFeCA+7JRkI8QbT3+jG
 b2XRewOVQG/QGjIUbs04jHbLKVwdq8+26DxgCcoVaqjTDE28Cy9pmsQoKzjnwH4MVAjZlIzqO
 BokBOJ/Mugd/Z9mUng2TVp9bIhaQt+DFqnTZsJR3ozT+PK3z+4sSMR0JOxnSFTla8dzDcmX34
 CD7mTyEl77/Lg9mStkl9lG0CAVfGFznj02ZXS147RqPhnWyGSmsZKx30R/ZGMRIX+2LXD9mXO
 X6oGldjiAK1/tgyKohYwdXMui12jZ4Go7CP7nTFDSf6cot5CYtgWu40cSOQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones venit, vidit, dixit 09.09.2017 15:13:
> Hi Adam,
> 
> I ran the test-suite on the 'pu' branch last night (simply because
> that was what I had built at the time!), which resulted in a PASS,
> but t6120 was showing a 'TODO passed' for #52.
> 
> This is a test introduced by Michael's 'mg/name-rev-tests-with-short-stack'
> branch, which uses 'ulimit -s' to try and force a stack overflow.
> Unfortunately, 'ulimit -s' seems to have no effect on cygwin. I created
> a test program (see below) to eat up the stack and tried running it
> with various ulimit values (128, 12, 8), but it always seg-faulted
> at the same stack-frame. (after using approx 2MB stack space).
> 
> So, it looks like all ULIMIT_STACK_SIZE tests need to be disabled
> on cygwin. I also wonder about the ULIMIT_FILE_DESCRIPTORS tests,
> but haven't looked into it.
> 
> Given that 'ulimit' is a bash built-in, this may also be a problem
> on MinGW and Git-For-Windows, but I can't test on those platforms.
> 
> Unfortunately, I can't spend more time on git today, hence this
> heads up! ;-)

Thanks for the note. We have this in t/test-lib.sh:

run_with_limited_cmdline () {
        (ulimit -s 128 && "$@")
}

test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'

This apparantly expects "ulimit -s" to fail on platforms that don't
support it, so set the prereq accordingly. I moved the following to
t/test-lib.sh:

run_with_limited_stack () {
        (ulimit -s 128 && "$@")
}

test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'

Same things as above. Two things to note:
- Those requisites could be the same, also they are used in different ways.
- "ulimit -s" returning success without doing anything means that, all
along, we ran the existing tests when we didn't mean to (on Win), and
they succeeded for the wrong reason, which we did not notice.

So, I guess, short of testing the effect of "ulimit -s" with another
expensive test, it's best to simply set these prerequisites based on
"uname -s".


> ATB,
> Ramsay Jones
> 
> -- >8 --
> diff --git a/test.c b/test.c
> new file mode 100644
> index 0000000..bcbb805
> --- /dev/null
> +++ b/test.c
> @@ -0,0 +1,21 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <inttypes.h>
> +
> +void test(uint64_t count)
> +{
> +	int i, junk[1024];
> +
> +	for (i = 0; i < 1024; i++)
> +		junk[i] = count;
> +	i = junk[count % 1024];
> +	printf("%" PRIuMAX "\n", (uintmax_t)count);
> +	fflush(stdout);
> +	test(count + 1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	test(0);
> +	return 0;
> +}
> 

