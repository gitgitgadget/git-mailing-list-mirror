Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A581F453
	for <e@80x24.org>; Wed, 24 Oct 2018 09:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeJXR3Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 13:29:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:48137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbeJXR3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 13:29:16 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhSfM-1fkWqt0YPQ-00mbfA; Wed, 24
 Oct 2018 11:01:51 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhSfM-1fkWqt0YPQ-00mbfA; Wed, 24
 Oct 2018 11:01:51 +0200
Date:   Wed, 24 Oct 2018 11:01:54 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] run-command: mark path lookup errors with ENOENT
In-Reply-To: <20181024073800.GB31202@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1810241054110.4546@tvgsbejvaqbjf.bet>
References: <20181024073637.GA31069@sigill.intra.peff.net> <20181024073800.GB31202@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tJnDcZ5a+F6hcSktL4AMJQQY1nYK+nV8//qNYhzOQ1r3KHBKE/j
 4BbKv+7wDmM5B0vJx+sD5+qrcOWfNyMsWa13Fk9o3wiN1ok9aholD1CI9WpmzQ8QjigM8qs
 h7I3DtNm5lxpOALSdfLTqg5rPW+vC4tPtkY5+csHR/KBL6NMhaunhNrdHhWaeBs/EBU+yNO
 ZGo2aUhBKUEfOD/TYNcow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G3X0EkzMBYs=:p5lG/0VhPw5bBoTUXlKg6a
 jMyrfqd/aMeOzZ/aeohwaKeNtpdLP79tvX+zgnxMSghNU/+Lg5oBWW6QTuCuvZYpdFsyJlrab
 Bv481HSPRs1xLPTiS1lrASDvY/kv8AswpgxnhBCbjhrTOya8lwL8ghl55NMGMZqqofOBHYmJV
 TvrtJaE4mIgLsnF8nHHRby7zNfL5AhZgPiJkGn9XDGLWNymA8vkt0xN36Nq38l2q3eaB8bTpg
 Sl6kskQrUI70ZwmqZVTsjs2384t6/f5HFXhTmEW91vpcmQNijm4a4YNs+6p3snQpRkE7Mp1eu
 2kCvNAyV6BGb6WLXNSnrz31R5eZJyBiWYYvB+CgWgIIoGWQf3cp29+DROWuWjTQxlhULJ7QOA
 rCerMhh9vd1SH8J54ad8DvMuQzOecYi3L9iEHW1G6ot1SgENWPFHdm+PnKErB2NygXUoymGfq
 PU5SCCXVOq2ZtU/ApxR5Cn3nsv6EZ8Q8xe8EEaIl3nXAAW4cvL9FpkMxp7BSYkRWzGZrJZeQo
 qm7/1oZh5sIOw3lq6huq7qlMVDVPJQE3eoiu/nq0SlxYu4sIXorc6ZCjNXnBYtRFvvH4mzYy0
 uXpB9r4SnztuZYWNA2w8epM2izEUnsoah43odRm8BN8R/iOhmzeiXljHrJ5cqgWVTxn/8Q28L
 GwZBcAyxohPVBBlF4ZHhuPTtQfPNOfH2WVt/Up5DZsuxVPMfzEQc/PWleLaWT+yA1lKBFuE/f
 duzjYamvReHagJAP+zW+p8WH7i4PMAWHgrYhq3bmvM6zfVHTM7R7tWGza5siuNWwN8nd4dkJX
 A/IMq6yt7vE+Ll3cSUbn96fGhgKYHXu2eUwrxWl07Un7DcS29o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 24 Oct 2018, Jeff King wrote:

> Since commit e3a434468f (run-command: use the
> async-signal-safe execv instead of execvp, 2017-04-19),
> prepare_cmd() does its own PATH lookup for any commands we
> run (on non-Windows platforms).
> 
> However, its logic does not match the old execvp call when
> we fail to find a matching entry in the PATH. Instead of
> feeding the name directly to execv, execvp would consider
> that an ENOENT error. By continuing and passing the name
> directly to execv, we effectively behave as if "." was
> included at the end of the PATH. This can have confusing and
> even dangerous results.

For the record, I tried to come up with an attack vector to exploit this,
and failed to find one.

> The fix itself is pretty straight-forward. There's a new
> test in t0061 to cover this explicitly, and I've also added
> a duplicate of the ENOENT test to ensure that we return the
> correct errno for this case.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  run-command.c          | 20 ++++++++++++++++----
>  t/t0061-run-command.sh | 13 ++++++++++++-
>  2 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/run-command.c b/run-command.c
> index 84b883c213..639ea5ac33 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -380,7 +380,7 @@ static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
>  	set_error_routine(old_errfn);
>  }
>  
> -static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
> +static int prepare_cmd(struct argv_array *out, const struct child_process *cmd)

I always like when we change functions to return a value that can then
indicate an error, making the libification effort so much easier.

>  {
>  	if (!cmd->argv[0])
>  		BUG("command is empty");
> @@ -403,16 +403,22 @@ static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
>  	/*
>  	 * If there are no '/' characters in the command then perform a path
>  	 * lookup and use the resolved path as the command to exec.  If there
> -	 * are no '/' characters or if the command wasn't found in the path,
> -	 * have exec attempt to invoke the command directly.
> +	 * are '/' characters, we have exec attempt to invoke the command
> +	 * directly.

Nice. I would have probably forgotten about that comment.

>  	 */
>  	if (!strchr(out->argv[1], '/')) {
>  		char *program = locate_in_PATH(out->argv[1]);
>  		if (program) {
>  			free((char *)out->argv[1]);
>  			out->argv[1] = program;
> +		} else {
> +			argv_array_clear(out);
> +			errno = ENOENT;
> +			return -1;
>  		}
>  	}
> +
> +	return 0;
>  }
>  
>  static char **prep_childenv(const char *const *deltaenv)
> @@ -719,6 +725,12 @@ int start_command(struct child_process *cmd)
>  	struct child_err cerr;
>  	struct atfork_state as;
>  
> +	if (prepare_cmd(&argv, cmd) < 0) {
> +		failed_errno = errno;
> +		cmd->pid = -1;
> +		goto end_of_spawn;
> +	}
> +
>  	if (pipe(notify_pipe))
>  		notify_pipe[0] = notify_pipe[1] = -1;
>  
> @@ -729,7 +741,6 @@ int start_command(struct child_process *cmd)
>  		set_cloexec(null_fd);
>  	}
>  
> -	prepare_cmd(&argv, cmd);
>  	childenv = prep_childenv(cmd->env);
>  	atfork_prepare(&as);
>  
> @@ -910,6 +921,7 @@ int start_command(struct child_process *cmd)
>  }
>  #endif
>  
> +end_of_spawn:

Sadly, this fails to build on Windows:

	run-command.c: In function 'start_command':
	run-command.c:924:1: error: label 'end_of_spawn' defined but not used [-Werror=unused-label]
	 end_of_spawn:
	 ^~~~~~~~~~~~

How about squashing in this diff:

-- snip --
diff --git a/run-command.c b/run-command.c
index 639ea5ac3366..3f03795a5995 100644
--- a/run-command.c
+++ b/run-command.c
@@ -918,6 +918,8 @@ int start_command(struct child_process *cmd)
 		close(fhout);
 	if (fherr != 2)
 		close(fherr);
+
+	goto end_of_spawn;
 }
 #endif
 
-- snap --

I can confirm that the result compiles and passes t0061.

Thanks,
Dscho

>  	if (cmd->pid < 0) {
>  		if (need_in)
>  			close_pair(fdin);
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index 3e131c5325..cf932c8514 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -12,10 +12,14 @@ cat >hello-script <<-EOF
>  	cat hello-script
>  EOF
>  
> -test_expect_success 'start_command reports ENOENT' '
> +test_expect_success 'start_command reports ENOENT (slash)' '
>  	test-tool run-command start-command-ENOENT ./does-not-exist
>  '
>  
> +test_expect_success 'start_command reports ENOENT (no slash)' '
> +	test-tool run-command start-command-ENOENT does-not-exist
> +'
> +
>  test_expect_success 'run_command can run a command' '
>  	cat hello-script >hello.sh &&
>  	chmod +x hello.sh &&
> @@ -25,6 +29,13 @@ test_expect_success 'run_command can run a command' '
>  	test_must_be_empty err
>  '
>  
> +test_expect_success 'run_command is restricted to PATH' '
> +	write_script should-not-run <<-\EOF &&
> +	echo yikes
> +	EOF
> +	test_must_fail test-tool run-command run-command should-not-run
> +'
> +
>  test_expect_success !MINGW 'run_command can run a script without a #! line' '
>  	cat >hello <<-\EOF &&
>  	cat hello-script
> -- 
> 2.19.1.1094.gd480080bf6
> 
