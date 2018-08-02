Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE883208E9
	for <e@80x24.org>; Thu,  2 Aug 2018 13:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbeHBPPw (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 11:15:52 -0400
Received: from mout.web.de ([212.227.15.14]:34223 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387516AbeHBPPw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 11:15:52 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MN47k-1frqMX3pMG-006e1r; Thu, 02
 Aug 2018 15:24:37 +0200
Subject: Re: [PoC] coccinelle: make Coccinelle-related make targets more
 fine-grained
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
 <20180802115522.16107-1-szeder.dev@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <edd896c5-9d73-7771-984e-f7443b74d01f@web.de>
Date:   Thu, 2 Aug 2018 15:24:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802115522.16107-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4o1AWzcRviLy0UMAKFnDLanNxnQDGiBx3zxdguALthlE6dqVgz1
 gI0D/Kl8GzxFs2vf/IFXj9tgdWaTakXDHAExV/oJo2fVKW7xRAUDY+D9vAePBN+ENlx7FMu
 7Hb4CQQMC20Mp6aXyiGWhtKPWtSO5Xt41gG6MzVuC6WrAIPa1+cjZ9d0t9fP85gENzuhBDO
 zqCjyFJ2aJrLb6VdVvDUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DvR5mK2lEmI=:1Lk1KmqAWua6COTdxL9b0o
 HPkl0p7izmXYDiqxxaMrKPSRPrTp4yOB7bnFXy8+e2NlWc1h0IGtRY0yfSEA6wunWrkOJFaEL
 pHUNihVAB11PVkG02s8rk4uuQMNpZQIABoEoliSOssFS6h8CjHjGz8gCoESs4v+7+SmsJVqER
 aw6AxwDOUsdoNnlgrMutpPDfDIpU1ooJBGks+F3YeKDUWWVcQkQwp1ySTas5WMfw9UgP9F17M
 KxzbaaZ1+7nxW9TmzIjTE09XgBDgrDT8YJJ4JSHcGlEpFBUVjx5ugl153YFbevODEjPKuJUYM
 /KVtWXXUxNgwCPzdHUoVeGfr7NP0MEhw0mFLlxnLckDlXKk22aBemEUQcQjsm2ksHlJGu/u9K
 oxJ3xseO/4z1GmPdGPK58FjUnRvtEWvdgZ55i4EHw2DlB8730fbCrU0l/xZJJ55ys7g7HTb0q
 QF78UAUvmcrdbBsqvPSVhMtDYdWz80e4ujBP7Di+8tSI6IojHjxVUeihXkbtZiSp+CL2tGBnH
 dpBZRuu1r14fZRDcKIluCum8Y+42Z7LebZs6DAK2iku8rT4selWKXkooOmWlkYBn9hin0zm9i
 eEryvHYlW6+6MKrVMuS2wylPMcCikaNrxXFbjL41fPTVwbcmlwa54uCfn9NS8PqG5C+B6Kviw
 OghnRdYbGb2/gptcnLJOmm0oiektzNORksbZv6uAIU01KPcKYXkvC1cuUQo/SrTVM8Qs07NQf
 mMkgvOKO8pTlYJYVztcIjeB6sylxVQsZncO4xjU78Sl+UxjeDVR1t+LgvsNhV42FG8XFP4ofi
 MM2lK4G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.2018 um 13:55 schrieb SZEDER Gábor:
> Let's add a bit of Makefile metaprogramming to generate finer-grained
> make targets applying one semantic patch to only a single source file,
> and specify these as dependencies of the targets applying one semantic
> patch to all source files.  This way that shell loop can be avoided,
> semantic patches will only be applied to changed source files, and the
> same semantic patch can be applied in parallel to multiple source
> files.  The only remaining sequential part is aggregating the
> suggested transformations from the individual targets into a single
> patch file, which is comparatively cheap (especially since ideally
> there aren't any suggestions).
> 
> This change brings spectacular speedup in the scenario described in
> point (1) above.  When the results of a previous 'make coccicheck' are
> there, the time needed to run
> 
>    touch apply.c ; time make -j4 coccicheck
> 
> went from 3m42s to 1.848s, which is just over 99% speedup, yay!, and
> 'apply.c' is the second longest source file in our codebase.  In the
> scenario in point (2), running
> 
>    touch contrib/coccinelle/array.cocci ; time make -j4 coccicheck
> 
> went from 56.364s to 35.883s, which is ~36% speedup.

Awesome!

> Unfortunately, this new approach has some disadvantages compared to
> the current situation:
> 
>    - [RFC]
>      With this patch 'make coccicheck's output will look like this
>      ('make' apparently doesn't iterate over semantic patches in
>      lexicographical order):
> 
>        SPATCH commit.cocci              abspath.c
>        SPATCH commit.cocci              advice.c
>        <... lots of lines ...>
>        SPATCH array.cocci               http-walker.c
>        SPATCH array.cocci               remote-curl.c
> 
>      which means that the number of lines in the output grows from
>      "Nr-of-semantic-patches" to "Nr-of-semantic-patches *
>      Nr-of-source-files".

The output is mostly interesting to see if something is happening, to
see if some semantic patch generated a non-empty diff and to get
error details.  We have ca. 400 .c files and 8 .cocci files -- that
means the lines would fill up my scroll-back buffer.  Hmm.

Would it be possible to have a phony target (or directory) per source
file that just prints a line and depends on the individual file+cocci
targets?  (I don't know much make, you probably thought about it
already.)

Or to select one random .cocci file (let's say the first one) and
only print SPATCH lines for this one (without mentioning its name)?
(A dirty hack..)

> ---
>   Makefile                      | 52 ++++++++++++++++++++++++-----------
>   contrib/coccinelle/.gitignore |  3 +-
>   2 files changed, 38 insertions(+), 17 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index d616c04125..f516dd93d1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2674,25 +2674,44 @@ COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
>   else
>   COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
>   endif
> +COCCI_SEM_PATCHES = $(wildcard contrib/coccinelle/*.cocci)
>   
> -%.cocci.patch: %.cocci $(COCCI_SOURCES)
> -	@echo '    ' SPATCH $<; \
> -	ret=0; \
> -	for f in $(COCCI_SOURCES); do \
> -		$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
> -			{ ret=$$?; break; }; \
> -	done >$@+ 2>$@.log; \
> -	if test $$ret != 0; \
> +define cocci_template
> +$(cocci_sem_patch)_dirs := $$(addprefix $(cocci_sem_patch).patches/,$$(sort $$(dir $$(COCCI_SOURCES))))
> +
> +$$($(cocci_sem_patch)_dirs):
> +	@mkdir -p $$@
> +
> +# e.g. 'contrib/coccinelle/strbuf.cocci.patches/builtin/commit.c.patch'
> +# Applies one semantic patch to _one_ source file.
> +$(cocci_sem_patch).patches/%.patch: % $(cocci_sem_patch)
> +	@printf '     SPATCH %-25s %s\n' $$(notdir $(cocci_sem_patch)) $$<; \
> +	if ! $$(SPATCH) --sp-file $(cocci_sem_patch) $$< $$(SPATCH_FLAGS) >$$@ 2>$$@.log; \
>   	then \
> -		cat $@.log; \
> +		rm -f $$@; \
> +		cat $$@.log; \
>   		exit 1; \
> -	fi; \
> -	mv $@+ $@; \
> -	if test -s $@; \
> -	then \
> -		echo '    ' SPATCH result: $@; \
>   	fi
> -coccicheck: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.cocci))
> +
> +# e.g. 'contrib/coccinelle/strbuf.cocci.patch'
> +# Applies one semantic patch to _all_ source files.
> +$(cocci_sem_patch).patch: $(cocci_sem_patch) $$($(cocci_sem_patch)_dirs) $$(patsubst %,$(cocci_sem_patch).patches/%.patch,$(COCCI_SOURCES))

Are the dependencies correct (before and after the patch)?  E.g. are all
semantic patches reapplied after cache.h was changed?  I think we ignore
header files currently, and that becomes more of a problem if the check
becomes more fine-grained.

René
