Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078AC1F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 10:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfAQKSi (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 05:18:38 -0500
Received: from mout.gmx.net ([212.227.15.15]:40425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfAQKSh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 05:18:37 -0500
Received: from [10.49.97.215] ([95.208.59.108]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4002-1h2I7x3RII-00rcSW; Thu, 17
 Jan 2019 11:18:31 +0100
Date:   Thu, 17 Jan 2019 11:18:15 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 15/21] tests: include detailed trace logs with
 --write-junit-xml upon failure
In-Reply-To: <f678b105f81ec60f64c0f19e3cc7a8ef151ed52e.1547645770.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901171112000.41@tvgsbejvaqbjf.bet>
References: <pull.31.v2.git.gitgitgadget@gmail.com>        <pull.31.v3.git.gitgitgadget@gmail.com> <f678b105f81ec60f64c0f19e3cc7a8ef151ed52e.1547645770.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tnIZo/xEPUHED2kE1Tc4j1vQ+wZFb3uPsBIol8oRmmq0JwTRHVD
 g4KFuBwBNpoYnKUTiFA8U6JrPXPcNWPZqAJbrw5TwstNQe1roOG73RsT1v2Zkq0H1G3w0VG
 VtRPFZOr4nbyfCYkNi1YSYii5ChlSMS35Suk0PntXJrTmkfdBpjyP7Ljap0HcCmVOjdc1Ih
 O6eqvn5rArm/KryfJEoQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c7rg/sBGcjU=:HVMq2e/4nU6EQT+R+gGLr+
 1l0SG5v19l7A96pbG1q4wCMYZJLNJpSXiCVHW9tkm4eRNDT5r52Zq4KO5iwZBG9vvgN6R2stO
 phs6psA1vTKekn7hJczRQXf2aWJ0mXgvOklE4jIFK4KIlq6gYGi5Y8f3BfwVrGwvgdo6GueBj
 vKnrF0tyvfnkoofSiGQ/mgmnTBHJgkNel9kgRFGADV0nnZh03f67FN5DsS00Gx8mgfoYfYTwa
 vUsmHnAX2l+wVZWT/QHAkTCHBU7e9e6qDlQ+vsMb6jlwQH0eZ6BicIxXUIdrKQRka6/8Ho/dF
 jQ4PIBEXOjfzM14nPUlAh7j2R15TapYORXtrsCPiN/1jKrzlVkHHW9I2VBl0PAmUBnsOEyLnE
 4imTmdHc9yGv9NCLHMn4qmKq+K7f0wV5idj8g2HAbRoQQ+snLd8Xa9rUoXWTYDFNJqgnVH0wr
 Exbhim8orBvJi4ES8U2MLM5zdg4qVZ4XiAMUYyJ9jFoFplPNT6nwEkCiWQRkOTw7a/LUq7ba7
 cR9qhB/psFDOqQ5PWDxwXSelT88zE/YtM/xi3vvuFfbDrCLmzL3WHbk6/8hTHEajsL2wdabWY
 ZX5UALo1/xpDzZLQL/cMyJTw6Hawy39tKoRxLw7W7eMwdewSugxfHZGyaQfon/DEbLthisVMJ
 CU3GPdd1H74iQwWcn/sXKBraBSuQHiFsiHmcpOKrX9WiEtCmqwkKdXp8B/dYds/Smq6CUG4bW
 DGwG8sC33Yry/pW1bBK2tdXox+ngi4DagzU+InRI+tjqDaymKbFrm8KEdzi7CfgPzMWChdJjZ
 fVKGIgWjKkjvej5eL1UX4IYntth5TCeGoCL9tnRB+X+qJx15B54qQe0sNCGo4jpqC8hLth9Hv
 FqUit1vCw32Hwis5NDRGwFjXey1jekotOISsgx6HN7aHkXb0P/5gZQrPLTJu6H2FZsFGfjYj2
 zWzKwVwHikA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 16 Jan 2019, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index e9782b6b32..f5371f505a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -503,8 +503,18 @@ test_failure_ () {
>  		junit_insert="<failure message=\"not ok $test_count -"
>  		junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
>  		junit_insert="$junit_insert $(xml_attr_encode \
> -			"$(printf '%s\n' "$@" | sed 1d)")"
> +			"$(if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
> +			   then
> +				cut -c "$GIT_TEST_TEE_OFFSET-" <"$GIT_TEST_TEE_OUTPUT_FILE"

Ooops. This does not work.

The intention of this patch was to remember the file size of the tee
output file at the point when the previous test case was done, and skip
that part (so that the first thing the user sees is the detailed trace of
*just* the failed test case, with the complete trace being attached as
`Standard_Error_Output.log`).

However, I totally misunderstood that `cut` is *always* line based. So
this `cut -c` (which should have been a `cut -b` to begin with) is just
plain wrong.

And since there is no easy Unix shell tool to just skip a bunch of bytes
(`dd` comes close, but you have to abuse the buffer size to specify the
number of bytes, or use buffer size 1, neither of which I like), I will
just add a dozen lines to the `test-path-utils.c` to get problem fixed.

> +			   else
> +				printf '%s\n' "$@" | sed 1d
> +			   fi)")"
>  		junit_insert="$junit_insert</failure>"
> +		if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
> +		then
> +			junit_insert="$junit_insert<system-err>$(xml_attr_encode \
> +				"$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")</system-err>"
> +		fi
>  		write_junit_xml_testcase "$1" "      $junit_insert"
>  	fi
>  	test_failure=$(($test_failure + 1))
> @@ -872,6 +882,11 @@ write_junit_xml_testcase () {
>  	write_junit_xml "$(printf '%s\n' \
>  		"    <testcase $junit_attrs>" "$@" "    </testcase>")"
>  	junit_have_testcase=t
> +	if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
> +	then
> +		GIT_TEST_TEE_OFFSET=$(test-tool path-utils file-size \
> +			"$GIT_TEST_TEE_OUTPUT_FILE")
> +	fi
>  }
>  
>  test_done () {
> @@ -1153,6 +1168,11 @@ then
>  		date +%Y-%m-%dT%H:%M:%S)\""
>  	write_junit_xml --truncate "<testsuites>" "  <testsuite $junit_attrs>"
>  	junit_suite_start=$(test-tool date getnanos)
> +	if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
> +	then
> +		GIT_TEST_TEE_OFFSET=0
> +		GIT_TEST_TEE_ERR_OFFSET=0

Also, in case anybody wonders, this `GIT_TEST_TEE_ERR_OFFSET` variable is
no longer used, and I should have removed it.

Oh well, I will just queue up the fixes in preparation for v4.

Ciao,
Dscho

> +	fi
>  fi
>  
>  # Provide an implementation of the 'yes' utility
> -- 
> gitgitgadget
> 
> 
