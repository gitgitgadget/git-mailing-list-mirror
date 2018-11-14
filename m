Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2AA1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 13:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeKNX5B (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 18:57:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:58753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbeKNX5B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 18:57:01 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaIw0-1g3BnX1NWq-00Jqb9; Wed, 14
 Nov 2018 14:53:31 +0100
Date:   Wed, 14 Nov 2018 14:53:29 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        gitgitgadget@gmail.com, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] tests: add a special setup where rebase.useBuiltin
 is off
In-Reply-To: <20181114091506.1452-3-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811141452520.39@tvgsbejvaqbjf.bet>
References: <0181114090144.31412-1-avarab@gmail.com> <20181114091506.1452-3-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-526498415-1542203611=:39"
X-Provags-ID: V03:K1:adTwtTm2asoCePBYfLRoM0013x6TDPwWBQqdG2pmsCIlTa5ZK80
 zOudCQT0M6LoiNmdgT+oACguxZcMZ1yaOY+oDLzKoO0szpynb6yhyBrXxH2bHuF8xsyCsji
 0GRRlxDIgihuNDT4v0oijjhaU3PEt7JgszkQd2ozfeCnLs7/c7MweO2O0asXybvR0E5NG0v
 4esvM5O/9FzolrVUU2O7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OGMvQEzeWis=:2gTVGwwabvHzfrJFyV768V
 aoq4YfyB/fBxOgMaJEdwam0eka6G+1PbjA5w3AfTXA3CPdFdH4zV3GKGsu2PYjDFJ/TVzKtkX
 JzPEXnEXoOmmlWznssDdtLhHpcRoNjSa3pbftyBtnOvj+WHL69obZKhEI8KBr8pP0SOioo/q4
 +cNnojJb2bq4O6Fzcoc7BT6409uar4mCCGNbjzhom1+UpfupdmW+dxaCaTzLduH+lOnaNqQsx
 MXr/U1S+3zpeXFGnenFoVgeHlUtDAjWXxxP5rK9xTnpcpF9OpYTqTbS5QmxNjru1S35bO7WF/
 DeNp+YPK2wjg0AtCol/KdhuUi9p+aucJFagMuTYlN1GFy7KUqVm8CtWj1qHUIBN96Nk8/1Egc
 eriDzfCFJBXa+giOJTZnVg9z5hEtPzjTqKzcdM51+7XbzQzfjOxCt2W01q0dK5TrlPrLg5zbk
 5EZTA4wzbJP4cMyPU3gBqI0rxOEDiYZlJ6pIw5p7aksvCRWIQEaxtp5fmzEVqjBL3LZH0Dn6y
 OwZgA5qohQzS79PkNOTymWF8z9SW06F0SudQqgdwuHbgl4i0ZpIev9Oy1yi0J3dPDGnW2Idge
 wdGhilCSn9Ir9TcMxiQLz1Y/aBrZRnFVI9xevoRoSGS5MbLupGwwdCLo490Ti2ES4Sdq0WfW6
 zQyDFgRiGJVU39s+wL9fKjVGcUAijYMW2jRns9zDKEgY6ZO7pXyxyfGRhb5VQ1VbPOK3N1+mQ
 v02+XIptI1hZSh+mCSRJr4jxvGGYTNZYFpTjG5pSn8RHnEMJx5f8+XMlob8UYuHpcg8TQH4hb
 87btCBFT6TQm7RMGscHHzMkdu/IEnn8XHScjZu78YHwvqicdFelshYSYDEdHL9zhfb7hm0jEo
 yv17APaZM8WEjbctJTg8lD6pdGuEXLvM3DQRsmQjJFia/3vKW3lSzj5OtDj0n6kauz+K61Alf
 avWLgQQn6Ow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-526498415-1542203611=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Wed, 14 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> Add a GIT_TEST_REBASE_USE_BUILTIN=false test mode which is equivalent
> to running with rebase.useBuiltin=false. This is needed to spot that
> we're not introducing any regressions in the legacy rebase version
> while we're carrying both it and the new builtin version.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/rebase.c | 5 ++++-
>  t/README         | 4 ++++
>  2 files changed, 8 insertions(+), 1 deletion(-)

I am slightly surprised not to see any ci/ change in this diffstat. Did
you mean to add a test axis for Travis, or not?

Ciao,
Dscho

> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 0ee06aa363..68ad8c1149 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -48,7 +48,10 @@ static int use_builtin_rebase(void)
>  {
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	struct strbuf out = STRBUF_INIT;
> -	int ret;
> +	int ret, env = git_env_bool("GIT_TEST_REBASE_USE_BUILTIN", -1);
> +
> +	if (env != -1)
> +		return env;
>  
>  	argv_array_pushl(&cp.args,
>  			 "config", "--bool", "rebase.usebuiltin", NULL);
> diff --git a/t/README b/t/README
> index 242497455f..3df5d12e46 100644
> --- a/t/README
> +++ b/t/README
> @@ -339,6 +339,10 @@ for the index version specified.  Can be set to any valid version
>  GIT_TEST_PRELOAD_INDEX=<boolean> exercises the preload-index code path
>  by overriding the minimum number of cache entries required per thread.
>  
> +GIT_TEST_REBASE_USE_BUILTIN=<boolean>, when false, disables the
> +builtin version of git-rebase. See 'rebase.useBuiltin' in
> +git-config(1).
> +
>  GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
>  of the index for the whole test suite by bypassing the default number of
>  cache entries and thread minimums. Setting this to 1 will make the
> -- 
> 2.19.1.1182.g4ecb1133ce
> 
> 
--8323328-526498415-1542203611=:39--
