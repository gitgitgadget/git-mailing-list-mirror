Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0741F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfA2PU2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:20:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:45095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbfA2PU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:20:27 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLvGW-1gnPFn3vki-007n6y; Tue, 29
 Jan 2019 16:20:20 +0100
Date:   Tue, 29 Jan 2019 16:20:03 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
In-Reply-To: <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901291616370.41@tvgsbejvaqbjf.bet>
References: <pull.114.git.gitgitgadget@gmail.com> <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:P0NiCFSftICJT0/2Oi9lw/uqYVcuwmC+PgYGazNmazgJcKTFcgm
 DgY3TUzGC0EP+3qDfazNtm4pDXLP2AtYYV029HtMPeh7pd+VMarQ8e8qKW/0JjKd2TaFcDF
 BQVWu+VpH/RMbo1fh+7ip6sWgx61zvWSdUgWX6Egf01/9T3fwCdLAC9D65S7EVcrZnqA+mY
 mAaVNpXi7w3fr6ESbPOWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uVx3b4+MWwo=:YabjToZjDzFyZV0YfexgU4
 gtYK4fh9gRfo0w/cMeoxPTsbqDIamaAk3Uwrd6UmQdehtxRIAPDLWvpHFCGy7kZdWqDVgsWsH
 ITVbXCMNgzU9Hl13J0MnxdECQknV8HIVYY1NcMFnrKgGKhzHpbU2eF4b+iRFbxRMLL5LAzz47
 Vh9Q28uUuyrV7ZEkZlmL9qqbfMqzuAvL+flHecFRCtZyXZIYj6Vxzz6ZDjMWnKL7xTVzOdOrh
 y9QXiMMBJaZrvmxWzjImhJbam+Z0r5W8qtGFWqLfS05uc5UqTHg/hgZPN7zf9Z3OyM4bLFQae
 WvW5PFDs0JKs1cPTrLRGLACM7c9/CK0VcnZCh8QUN0QQyWZBVKrO6L70iBTjYdZorZPfRkpoa
 MuxfLs2BGcDdR46HIN3aCmJo94T/CuUsrzwXAOQ5SSgdYj6dpyp47fDohmVtuhomLr2rOCj8f
 qXnBu6JFDGrlj9vTonQ6setHbDGDAmAXITvOyVecm2+ni03GTZr9WGIGqg4QoVIo7eQ24sjk7
 RX1L8j2KcCHmXUnKm7NkQOnzNEAyIoLerwaZXkMmUdtW1bAytMDudo7Lp5T9DSlZ4AzFYRwI/
 XidB6nWUPrCAsIR7ypxCCt5TLk/TvwAbJE8punwJv1ug3fvnKfJw8df4oTxaHuWhJupcy2lm7
 +bjLOM0X3FcqUvo35jTjPwbpn0mVulffyOulQpeTsnEVnAv3z1++7T4g5OXGEkktvEgnqVjh4
 w7vl2Ocx3YAzaWSv4N6A5PCU5kSGc2OfWjk0DkbgQU5ZlsSE5ddPZkVFaojooeRNUx2WfLEc9
 hxbQJFBIF/a12t0uOpl5AEn5AduejZjVHR79ZRzIZt+tYi8TtyoMoiluDzOwEz1d39g7tVpFX
 q/JYQ6MIvGl9ljLX4BkJau0Pwyv+s/xIyIly0iRTCi9je2LkFhWmShP6/is3t0Q8EQrN5FX26
 zDVm7VnCINg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Tue, 29 Jan 2019, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When running the test suite for code coverage using
> 'make coverage-test', a single test failure stops the
> test suite from completing. This leads to significant
> undercounting of covered blocks.
> 
> Add two new targets to the Makefile:
> 
> * 'prove' runs the test suite using 'prove'.
> 
> * 'coverage-prove' compiles the source using the
>   coverage flags, then runs the test suite using
>   'prove'.
> 
> These targets are modeled after the 'test' and
> 'coverage-test' targets.

The rationale, and the diff (after reading what `test` and `coverage-test`
do), make a lot of sense to me.

Thanks,
Dscho

> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 1a44c811aa..ec886635ae 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2665,6 +2665,9 @@ export TEST_NO_MALLOC_CHECK
>  test: all
>  	$(MAKE) -C t/ all
>  
> +prove: all
> +	$(MAKE) -C t/ prove
> +
>  perf: all
>  	$(MAKE) -C t/perf/ all
>  
> @@ -3077,6 +3080,10 @@ coverage-test: coverage-clean-results coverage-compile
>  	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
>  		DEFAULT_TEST_TARGET=test -j1 test
>  
> +coverage-prove: coverage-clean-results coverage-compile
> +	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
> +		DEFAULT_TEST_TARGET=prove -j1 prove
> +
>  coverage-report:
>  	$(QUIET_GCOV)for dir in $(object_dirs); do \
>  		$(GCOV) $(GCOVFLAGS) --object-directory=$$dir $$dir*.c || exit; \
> -- 
> gitgitgadget
> 
