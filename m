Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393AB1F405
	for <e@80x24.org>; Fri, 21 Dec 2018 16:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbeLUQM0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 11:12:26 -0500
Received: from mout.gmx.net ([212.227.17.21]:53207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbeLUQMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 11:12:25 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgYGJ-1gmoGN0QGF-00NyFY; Fri, 21
 Dec 2018 17:12:24 +0100
Date:   Fri, 21 Dec 2018 17:12:08 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Orgad Shaneh <orgads@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] Rebase: Run post-checkout hook on checkout
In-Reply-To: <20181220214823.21378-2-orgads@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812211708010.41@tvgsbejvaqbjf.bet>
References: <20181220214823.21378-1-orgads@gmail.com> <20181220214823.21378-2-orgads@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gZgi4mKkUA/8CL0V8OBGOydAy7j4ADku8z6kK973EQj8OobtqZ7
 RAeShWKiDGBz8t/bgUDVt7kDGzg32KhJLBFxXLl9Fmy6dKeYTxYwIndZdhyFSg+rDDJhQJM
 PKmO4+hn8eBkG2+oAxzrBxfV7c7ia2UEhUjIEPA7Zf11W5VUpazyHqa3ZWdLO5LPggPAfSv
 tsxzIgyplKaIxGPOnw1Cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PghiHbriOis=:QOez4ZONKSWokob3aBpxnx
 U+N7boCGZ4V1oREgvmdNAXWXI6idQ0o2d8Pj1a5HP+u9UfbynOoMxYyIxDtyGQzZH18ZOZjwu
 mhWZjEmlIZfJ0AUwVo/GFBAbHEzG07Oo9piV+Dy4ayr0lH8m8sVW0E1FSxrbnHzkzlgl3QBYa
 M+yKZ4Xvudx9bhOZfKeH64AA2umLcda4s/8fPqyZUzguLZWC/2HNxJ2Lji4gKlwogj/t/o0nK
 YWL7TszR98YVYrseLiBmWdxqrR5IZtkCGUCHCOzAYdoNKAvvF4mxTgIh0BwF4hYMRn8AkeAtM
 PxU/RBy/emwOkpi65HQTcIaprMhecc3gnQCQBPjkUj9Nrn3WZsK3cf+b4JAW3UuNKzw8QwYYQ
 xc6rBhGX1+/oaZVp8IVk6caqEj04FJd91I1ZhTWIq3Q5aMwIOfDizLE5nbSh7/+W2BllI7Aem
 QDpR0MsjHyoETSVKV+mGl+gbHa4AiJKBRQjzj6yrnd++Ep3JDjsP28C7P8QHSZgbf5KoaHa49
 MRhZKNxuLwDXKRGW9txtn2rFFBi8AjrolA1joAtodZ42UgrULxFYQ7vhLdO39YkT1AMPWGTNM
 264O1rLZU0U3X1mm7yW6+FJ27b0yXctQRHSAmgluFdcHn77C0b+4VnYM47pvfKZ0HwRvjf8dY
 hgrp60YlJyIKSoauUaKQLCbPs4Pwut+YORTwn++Grxe8uW4W+r4IrdYJigfEkX0WEmfBfUeuI
 zxe2rP9QAYM8NdD6ZuvL5s152I2Kd4/KEPB54IFfl19Z7rziADoMB/vEYgucYdEC7gscho5xP
 g8eG4S9yehxEnTqgM1gvqwxXiboKxyaPMw8AG9H7BxTIBNY5jfuc7ZRU52X3ekAVb623BZbv3
 7wNG0JQfHn/CcCt8nm+KxWrovsg9xt1918PJ9dhlUd08FFBk3KLO5EBe1yAoooMbaB3qMGQba
 bgwnWfyYVAw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Orgad,

On Thu, 20 Dec 2018, orgads@gmail.com wrote:

> From: Orgad Shaneh <orgads@gmail.com>
> 
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>

Feel free to steal the PR description I added to your PR at
https://github.com/git-for-windows/git/pull/1992

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index b5c99ec10c..78a09dcda2 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -530,6 +530,7 @@ static int run_specific_rebase(struct rebase_options *opts)
>  
>  #define RESET_HEAD_DETACH (1<<0)
>  #define RESET_HEAD_HARD (1<<1)
> +#define RESET_HEAD_RUN_HOOK (1<<2)
>  
>  static int reset_head(struct object_id *oid, const char *action,
>  		      const char *switch_to_branch, unsigned flags,
> @@ -537,6 +538,7 @@ static int reset_head(struct object_id *oid, const char *action,
>  {
>  	unsigned detach_head = flags & RESET_HEAD_DETACH;
>  	unsigned reset_hard = flags & RESET_HEAD_HARD;
> +	unsigned run_hook = flags & RESET_HEAD_RUN_HOOK;
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

IIRC there was one `git checkout` in the scripted version that ran the
hook, and one did not. The latter did not run it because it did not
actually change the HEAD, but just switched branches.

We could imitate that here by extending the `if (run_hook)` to `if
(run_hook && !oideq(&head_oid, oid))`, I think. Do you agree?

The rest of the patch makes sense to me (and I merged the above-mentioned
PR already).

Thank you!
Johannes

>  
>  leave_reset_head:
>  	strbuf_release(&msg);
> @@ -1539,7 +1545,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	strbuf_addf(&msg, "%s: checkout %s",
>  		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
>  	if (reset_head(&options.onto->object.oid, "checkout", NULL,
> -		       RESET_HEAD_DETACH, NULL, msg.buf))
> +		       RESET_HEAD_DETACH | RESET_HEAD_RUN_HOOK, NULL, msg.buf))
>  		die(_("Could not detach HEAD"));
>  	strbuf_release(&msg);
>  
> diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
> index 7e941537f9..de9c7fb871 100755
> --- a/t/t5403-post-checkout-hook.sh
> +++ b/t/t5403-post-checkout-hook.sh
> @@ -9,6 +9,8 @@ test_description='Test the post-checkout hook.'
>  test_expect_success setup '
>  	test_commit one &&
>      test_commit two &&
> +    test_commit rebase-on-me &&
> +    git reset --hard HEAD^ &&
>      test_commit three three &&
>      mv .git/hooks-disabled .git/hooks
>  '
> @@ -52,6 +54,22 @@ test_expect_success 'post-checkout receives the right args when not switching br
>  	test $old = $new && test $flag = 0
>  '
>  
> +test_expect_success 'post-checkout is triggered on rebase' '
> +	git checkout -b rebase-test master &&
> +	rm -f .git/post-checkout.args &&
> +	git rebase rebase-on-me &&
> +	read old new flag < .git/post-checkout.args &&
> +	test $old != $new && test $flag = 1
> +'
> +
> +test_expect_success 'post-checkout is triggered on rebase with fast-forward' '
> +	git checkout -b ff-rebase-test rebase-on-me^ &&
> +	rm -f .git/post-checkout.args &&
> +	git rebase rebase-on-me &&
> +	read old new flag < .git/post-checkout.args &&
> +	test $old != $new && test $flag = 1
> +'
> +
>  if test "$(git config --bool core.filemode)" = true; then
>  mkdir -p templates/hooks
>  cat >templates/hooks/post-checkout <<'EOF'
> -- 
> 2.20.1
> 
> 
