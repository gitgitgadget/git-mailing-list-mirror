Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C954A20A10
	for <e@80x24.org>; Tue,  7 Nov 2017 01:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933663AbdKGBCx (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 20:02:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:56886 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932751AbdKGBCt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 20:02:49 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDyFr-1eShen19jz-00HKLW; Tue, 07
 Nov 2017 02:02:42 +0100
Date:   Tue, 7 Nov 2017 02:02:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 7/8] sequencer: load commit related config
In-Reply-To: <20171106112709.2121-8-phillip.wood@talktalk.net>
Message-ID: <alpine.DEB.2.21.1.1711070202040.6482@virtualbox>
References: <20170925101041.18344-1-phillip.wood@talktalk.net> <20171106112709.2121-1-phillip.wood@talktalk.net> <20171106112709.2121-8-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ET6MwBdIrEc0IcU+lKC6XQBNMUDOlqR0gPG+csB22RWYgViDU8g
 CUTQcRXCCpkfydeQmkh46o2u4vJ+74fHHJOK1IZ6Vc4thueFdsdI7H8CU6lTKXGNeKMXuzq
 WmE7az+v9duduaqLnB28tdMEdSFZHJmtjbocjzErfnP5RRPWQa81isZuuGnjJEDZlVeH56A
 pJdNqVVddqKHklAWh8lZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qCuWrUnaQRo=:nhkBISlX00LLs46gpQiTo8
 cyZ5Y7rQBRKIlJgqxcYzI6h6b0i4wvPwRzVYZJfcIcjKHH8R11ZXa/TtedfCbTb0JJf+yedVR
 QfdSZmoLL/PqWv89oirvTmlHl7DZruMpG6lbLPuZVQ5GjVcC25Lw9Fup9b0UXkHOMVfr3Wfwd
 1s6xJfykXC+HBriUmjjVGhUlGySTEsypotZljvn2tSLTekErDUFeaHA5hBA1j2LLhPHEMWz1n
 V9pj9yjYaCqhESBJdBRwdkl18TqDUGV8gA7gqt7xwLlz8Wf7Tv8tu0AkcOdQo7hYwaUayhJcu
 u6BQvjuLHtLU97XSchLUUipZCu8x8h8yo2xjtsfqUc4aYtwnHPcVCnxcns2r82e57LVIwHHNB
 oHkRdp9yzB+FHoof+B4f1Mo+KJx47XXkfrQslgiwGnsAE6hLLO+qTkgRhG6kfS2LmFyJE7Cwy
 Aa2nZJF8fOu4ufDqha43s0lrf8AHnVAubf5RfsPxfzcVvgQmHV6TsBALc+LgHOuxNHsKwRciJ
 eby/KvL1p1SL/bKn2MBum9dmz6Zu1qwTXGfvYhOd9ooyyMsyZgxLWeKjYqrjd5fNY4cdbTv0E
 l9fMDBbm0UO+JIskXcI3pcS3U5dTUrW7LntZ4mXzm34nZ1Q9CpQ8pS+MMvAriR/rpCPQW0dbP
 EtnpiDrt2HACWtu9P6+9FaF6PKZgOSYZtpAopXBMyZ9O8IrKxl/fKkgIpNV1wnKsmKVCppFCu
 7SnjALQvhvmsNeHL/TMLvH4tilUcjvAt8vokyK8j8gZPqptXcSjCA0dQke3bRrIh90CXyHOYY
 wyR3ixca3nUAhZNxsocDPCN2b4DmtXyh4AIMFyQg3CwFi/QLNM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 6 Nov 2017, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Load default values for message cleanup and gpg signing of commits in
> preparation for committing without forking 'git commit'.

Nicely explained.

> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index f8519363a393862b6857acab037e74367c7f2134..68194d3aed950f327a8bc624fa1991478dfea01e 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -9,6 +9,17 @@ static const char * const builtin_rebase_helper_usage[] = {
>  	NULL
>  };
>  
> +static int git_rebase_helper_config(const char *k, const char *v, void *cb)
> +{
> +	int status;
> +
> +	status = git_sequencer_config(k, v, NULL);
> +	if (status)
> +		return status;
> +
> +	return git_default_config(k, v, NULL);

It's more a matter of taste than anything else, but this one would be a
little bit shorter:

	return git_sequencer_config(k, v, NULL) ||
		git_default_config(k, v, NULL);

A more important question would be whether this `git_default_config()`
call could be folded into `git_sequencer_config()` right away, so that the
same pattern does not have to be repeated in rebase--helper as well as in
revert/cherry-pick.

> diff --git a/builtin/revert.c b/builtin/revert.c
> index b9d927eb09c9ed87c84681df1396f4e6d9b13c97..b700dc7f7fd8657ed8cd2450a8537fe98371783f 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -31,6 +31,17 @@ static const char * const cherry_pick_usage[] = {
>  	NULL
>  };
>  
> +static int git_revert_config(const char *k, const char *v, void *cb)

Seeing as it is used also by `cmd_cherry_pick()`, and that it is
file-local anyway, maybe `common_config()` is a better name?

This point is moot if we can call `git_default_config()` in
`git_sequencer_config()` directly, though.

> diff --git a/sequencer.c b/sequencer.c
> index 3e4c3bbb265db58df22cfcb5a321fb74d822327e..b8cf679751449591d6f97102904e060ebee9d7a1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -688,6 +688,39 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  	return run_command(&cmd);
>  }
>  
> +static enum cleanup_mode default_msg_cleanup = CLEANUP_NONE;
> +static char *default_gpg_sign;

I was ready to shout about global state not meshing well with libified
code, but as long as we're sure that these values are set only while Git
executes single-threaded, still, it is the correct way to do it: these
settings reflect the config, and therefore *are* kinda global (at least
until the day when the submodule fans try to call `git commit` in a
submodule using the `struct repository` data structure).

In short: this code is good (and I was just describing a little bit of my
thinking, to demonstrate that I tried to be a diligent reviewer :-)).

Thanks,
Dscho
