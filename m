Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240A31FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 12:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763300AbdDSM7Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 08:59:24 -0400
Received: from mout.web.de ([212.227.17.11]:63353 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763027AbdDSM7W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 08:59:22 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGABv-1cli7537oN-00FALx; Wed, 19
 Apr 2017 14:59:04 +0200
Subject: Re: [RFC PATCH] parse-options: disallow double-negations of options
 starting with no-
To:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <20170419090820.20279-1-jacob.e.keller@intel.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <68ed1250-534d-dc16-874e-ea14b592f8fd@web.de>
Date:   Wed, 19 Apr 2017 14:58:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <20170419090820.20279-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:by51112hgA7qNCesDsTh82ydN1b1H7zN2YFaytigVyCevqIn6pI
 x7XMb+B09dZCNQrCfIO7yQ19y2kout+PHVw0rcRQ5mi4atg/SEmGguE1WWGQ0OUxg00vfQ3
 xGq8HILgQxUzEs2o1wUskJ2Ty797CNUXEJIx53JMIV70/YeOOinnfxKSBV1h3dJ2iBjGkYe
 gsOj90xV9UbszuIgvBwVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o6uf6rYAQog=:o0VJl9bP47lMU9TuKB3AI7
 ZiZdmiAJ8Y5O/w74zRn+15QnLJo0iX2YgKtgg+7tUrCratg6d2oJl5lkyjRB96GHnhggvRlO9
 40Ez+Sh4j7Di55aCMpCU7JX8QvBOZpe4RPIapI8Mcdb+KIUJCECLrztyiUCJXdmLqSyA9gXEF
 Y88O8OVxazIu70KWt8qdr2Lnw1EcpZIioCY8R2zS2E8pIKKDZWjnqjLUvzBaSRg65Z1FiEhuX
 3HfjnA4WXkvVguDXcZeVzFOrdSXA+o0r/i/g8Gj0r/j7vYFsHxLQcD5Zfcj5TY0kB0IVtQMN9
 voABmoR9XAgd01ePb0T3zUb8czM34ElY3ts7ET9urLfZexbAdnWFnL9ms454zATHTSZpelvSA
 wMXNnkbqDVbhyUosL71dpOM3VppwIjcAuXyFi1j0c1v1TSC3IrzXrXdFUQwdQn2BXWvNXiXOx
 FiBvM6CjqPHCUFngGkQBXzNqoS8eXXk3BH7sD2gLnHs3QNPzfjTm2qu0zSwg8xnZQVnADkY29
 lcAWVNHtvMnZX9RZDs7cmN8YCgVUtyvfzvGTddBq7cVXcBJui77tc5FDa9e4N7Y7+js/Uyzt0
 Wzj/qsC4OVc2GE7jMQF7oaEqp9Xc7ydbMG+OiQnKeRwE3CQgI/le8OEFVVG+MfsXqJsK3wV21
 xManTAFxvK+w1VL46ecvgiMknAsdXxbE/xGPaYNNZJ7bqMCCaq1JaZB9bUY42jl/uGGv3Vjbg
 ZmSn6yAw2V6np/Lux7TouxeAESxu8Kay6ilPISzmRjHsLaJDTXGSNSTOXkkDFMXvmX+caeZ9n
 8QNVkfj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.04.2017 um 11:08 schrieb Jacob Keller:
> From: Jacob Keller <jacob.keller@gmail.com>
> 
> Many options can be negated by prefixing the option with "no-", for
> example "--3way" can be prefixed with "--no-3way" to disable it. Since
> 0f1930c58754 ("parse-options: allow positivation of options
> starting, with no-", 2012-02-25) we have also had support to negate
> options which start with "no-" by using the positive wording.
> 
> This leads to the confusing (and non-documented) case that you can still
> prefix options beginning with "no-" by a second "no-" to negate them.
> That is, we allow "no-no-hardlinks" to negate the "no-hardlinks" option.
> 
> This can be confusing to the user so lets just disallow the
> double-negative forms. If the long_name begins with "no-" then we simply
> don't allow the regular negation format, and only allow the option to be
> negated by the positive form.

Your patch is a modernized version of my old one, so I'm fine with it.

But I wonder how --no-no-x being treated the same as --x can be 
confusing.  https://en.wikipedia.org/wiki/Double_negative explains it, I 
think -- in some languages and dialects multiple negatives increase 
negativity instead of cancelling themselves out pairwise.  So users 
would expect to get no x with --no-x and even less of it with --no-no-x?

> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> I started going about implementing an OPT_NEGBOOL as suggested by Peff,
> but realized this might just be simpler, and we already support the
> positive format for the negation, so we don't lose expressiveness. We
> *might* want to tie this to an option flag instead so that it only kicks
> in if the option specifically requests it. Thoughts?

Do you mean that there should be a flag for allowing double negation? 
In which situation would it be useful?

Or do you mean that negation should be disabled by default and would 
have to be enabled explicitly, unlike the current situation where it is 
enabled by default and can be turned off with PARSE_OPT_NONEG?  That 
depends on how often we'd want to disable negation, I guess.  For 
boolean flags it probably makes sense to allow it by default.

>   parse-options.c          | 3 +++
>   t/t0040-parse-options.sh | 5 ++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/parse-options.c b/parse-options.c
> index a23a1e67f04f..8e024c569f52 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -299,6 +299,9 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
>   				}
>   				continue;
>   			}
> +			/* avoid double-negate on long_name */
> +			if (starts_with(long_name, "no-"))
> +				continue;
>   			flags |= OPT_UNSET;
>   			if (!skip_prefix(arg + 3, long_name, &rest)) {
>   				/* abbreviated and negated? */
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index 74d2cd76fe56..abccfa5f265f 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -88,7 +88,6 @@ test_expect_success 'OPT_BOOL() is idempotent #1' 'check boolean: 1 --yes --yes'
>   test_expect_success 'OPT_BOOL() is idempotent #2' 'check boolean: 1 -DB'
>   
>   test_expect_success 'OPT_BOOL() negation #1' 'check boolean: 0 -D --no-yes'
> -test_expect_success 'OPT_BOOL() negation #2' 'check boolean: 0 -D --no-no-doubt'
>   
>   test_expect_success 'OPT_BOOL() no negation #1' 'check_unknown_i18n --fear'
>   test_expect_success 'OPT_BOOL() no negation #2' 'check_unknown_i18n --no-no-fear'
> @@ -392,4 +391,8 @@ test_expect_success '--no-verbose resets multiple verbose to 0' '
>   	test-parse-options --expect="verbose: 0" -v -v -v --no-verbose
>   '
>   
> +test_expect_success 'double negation not accepted' '
> +	test_must_fail test-parse-options --expect="boolean: 0" --no-no-doubt
> +'
> +
>   test_done

Using check_unknown_i18n like in the test for --no-no-fear would be 
shorter and more consistent.

René
