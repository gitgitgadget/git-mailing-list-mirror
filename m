Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E59A81F770
	for <e@80x24.org>; Wed,  2 Jan 2019 15:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfABPrU (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 10:47:20 -0500
Received: from mout.gmx.net ([212.227.15.18]:46411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbfABPrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 10:47:19 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LlDb4-1hDEH52dWw-00b4AU; Wed, 02
 Jan 2019 16:47:17 +0100
Date:   Wed, 2 Jan 2019 16:47:16 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Orgad Shaneh <orgads@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] Rebase: Run post-checkout hook on checkout
In-Reply-To: <20181229213759.12878-2-orgads@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901021646060.45@tvgsbejvaqbjf.bet>
References: <20181229213759.12878-1-orgads@gmail.com> <20181229213759.12878-2-orgads@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tdU9UsxuGWhYJzOaYxuptWe0qN1Fw3VQaCSynYCuhRbCn7WLtp7
 wQSb1XVII+NQWO9DYiq5iIugVCAO9gtBvvKJZ7nFVaLZ92UW4b1ntoy/R1+WWqLOCKfmvg/
 IkAyJ9w0XYba9G42rCUqPCg+lzy/b0WGBtbJeQecMZetJHde+f3f3NGq/Cw8b4djbK+OvKW
 AfYgNI39a/OrxkouUAg4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QWPwOhvV8Lw=:axCilXKdlkmT/XWN6S0xLZ
 OyN+nykVsWL8qHoWhZKBy20zdUiaO1jWH/RG/piDyrkmcARKSa1ZHn7ZG4sgM6W6N7bEJJMgX
 vOWAw/a2D4SuGtVCfkPMByOkYmzcIVFCCfikc02im+uvdZxmiS+S31EgFd55mnAIqT1WVh/HR
 HMYQrF2hOLj1sjYEk8Rx9I0KVZJ7w2zPeldo/pQNEmcjACY4dkiKObE74uUPpMqoVS+BUd9PQ
 AR/eMizlsdHbRWofieOvuN6paI5E5SYOkX+xCLDkE8CDpD6SNj3hhdGDVWtoyuDHmis102Q0S
 3tKznWkbSz2TDq9hQXi/P3c29G3f/3Bc+yS3esJocLOJr+7jkKTA0Z32NMK3KNvVDlz1bssC8
 r1oVrd3K8ElAvxLzCrKGZjFAnX/LAXjwBNcver0Sq4qOUnNkiZCnNOUVVLMJoHzV82s/SEQt7
 1KfwPbJ9D9SPfaYR3F8K3JNHTs2FvEyDXLYcLjDWwP1QMB4X44/97u0qT3noglZ/KTpguhHIW
 jWrI2LFp406GUfqVbXuA7KOTwmmUKCXsXUcXvsGk28beFETqWRkoH6hHX86IijuRJ1w9acBaL
 gFfQeXrjhoYYlth9S12Tra88X/hvlNAy4wnAc4D4g3LvqFTE5L8O1hWpcwnF7WK/jMNXVjbK2
 KqfkHOKn2RmGaMpYsVtXEEFPuYCvvWtXLiV0m4dfByRRiTTSqosL+btNnNoKScVW+diBeVKrN
 96u6mT/Z3wW6GIWkJQZF4W+MmeKk5pgCPLkHPSRCJJeMYTBA+FW51z+B6PGj2iSkaJYmgUgfz
 CoypzHzwG/XX32/DpwWTTWBV6B4lcV59/iHcNpWrE8obQvmhrc9dZYwCHB/d3Yvg+GqRdYG12
 jBhFyBu29B2H0OjzayJwwkCpkW6SUCsUKMnOq/GsLImFOSp6kZiNB/SnpVLEh17d3T2Fn24c3
 /a9XcnmzZxQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Orgad,

On Sat, 29 Dec 2018, orgads@gmail.com wrote:

> From: Orgad Shaneh <orgads@gmail.com>
> 
> The scripted version of rebase used to run this hook on the initial
> checkout. The transition to built-in introduced a regression.
> 
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>

ACK!

For lurkers: there was a "pre-review" at
https://github.com/git-for-windows/git/pull/1992

Ciao,
Dscho

> ---
>  builtin/rebase.c              | 12 ++++++++++--
>  t/t5403-post-checkout-hook.sh | 20 ++++++++++++++++++++
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index b5c99ec10c..8402765a79 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -530,6 +530,7 @@ static int run_specific_rebase(struct rebase_options *opts)
>  
>  #define RESET_HEAD_DETACH (1<<0)
>  #define RESET_HEAD_HARD (1<<1)
> +#define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
>  
>  static int reset_head(struct object_id *oid, const char *action,
>  		      const char *switch_to_branch, unsigned flags,
> @@ -537,6 +538,7 @@ static int reset_head(struct object_id *oid, const char *action,
>  {
>  	unsigned detach_head = flags & RESET_HEAD_DETACH;
>  	unsigned reset_hard = flags & RESET_HEAD_HARD;
> +	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
>  	struct object_id head_oid;
>  	struct tree_desc desc[2] = { { NULL }, { NULL } };
>  	struct lock_file lock = LOCK_INIT;
> @@ -636,6 +638,10 @@ static int reset_head(struct object_id *oid, const char *action,
>  			ret = update_ref(reflog_head, "HEAD", oid, NULL, 0,
>  					 UPDATE_REFS_MSG_ON_ERR);
>  	}
> +	if (run_hook)
> +		run_hook_le(NULL, "post-checkout",
> +			    oid_to_hex(orig ? orig : &null_oid),
> +			    oid_to_hex(oid), "1", NULL);
>  
>  leave_reset_head:
>  	strbuf_release(&msg);
> @@ -1465,7 +1471,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  					    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
>  					    options.switch_to);
>  				if (reset_head(&oid, "checkout",
> -					       options.head_name, 0,
> +					       options.head_name,
> +					       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
>  					       NULL, buf.buf) < 0) {
>  					ret = !!error(_("could not switch to "
>  							"%s"),
> @@ -1539,7 +1546,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	strbuf_addf(&msg, "%s: checkout %s",
>  		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
>  	if (reset_head(&options.onto->object.oid, "checkout", NULL,
> -		       RESET_HEAD_DETACH, NULL, msg.buf))
> +		       RESET_HEAD_DETACH | RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
> +		       NULL, msg.buf))
>  		die(_("Could not detach HEAD"));
>  	strbuf_release(&msg);
>  
> diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
> index 1d15a1031f..a539ffc080 100755
> --- a/t/t5403-post-checkout-hook.sh
> +++ b/t/t5403-post-checkout-hook.sh
> @@ -13,6 +13,8 @@ test_expect_success setup '
>  	EOF
>  	test_commit one &&
>  	test_commit two &&
> +	test_commit rebase-on-me &&
> +	git reset --hard HEAD^ &&
>  	test_commit three
>  '
>  
> @@ -44,6 +46,24 @@ test_expect_success 'post-checkout receives the right args when not switching br
>  	test $old = $new && test $flag = 0
>  '
>  
> +test_expect_success 'post-checkout is triggered on rebase' '
> +	test_when_finished "rm -f .git/post-checkout.args" &&
> +	git checkout -b rebase-test master &&
> +	rm -f .git/post-checkout.args &&
> +	git rebase rebase-on-me &&
> +	read old new flag <.git/post-checkout.args &&
> +	test $old != $new && test $flag = 1
> +'
> +
> +test_expect_success 'post-checkout is triggered on rebase with fast-forward' '
> +	test_when_finished "rm -f .git/post-checkout.args" &&
> +	git checkout -b ff-rebase-test rebase-on-me^ &&
> +	rm -f .git/post-checkout.args &&
> +	git rebase rebase-on-me &&
> +	read old new flag <.git/post-checkout.args &&
> +	test $old != $new && test $flag = 1
> +'
> +
>  test_expect_success 'post-checkout hook is triggered by clone' '
>  	mkdir -p templates/hooks &&
>  	write_script templates/hooks/post-checkout <<-\EOF &&
> -- 
> 2.20.1
> 
> 
