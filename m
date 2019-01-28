Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B231F453
	for <e@80x24.org>; Mon, 28 Jan 2019 22:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfA1WDx (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 17:03:53 -0500
Received: from mout.gmx.net ([212.227.17.20]:60271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfA1WDx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 17:03:53 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNZVG-1gprq430HK-007ApY; Mon, 28
 Jan 2019 23:03:46 +0100
Date:   Mon, 28 Jan 2019 23:03:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -x: sanity check command
In-Reply-To: <20190128102620.18222-1-phillip.wood@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1901282257570.41@tvgsbejvaqbjf.bet>
References: <20190128102620.18222-1-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:C8t5stOo0OQJNi2MPpQwOBH0XUVbnDxWt5U5fGhwa3luYzpq9lJ
 dE9fk/6SVUpdBRZoTXDeugAgt9WHXTbTkcLojrsdrx0dlN88eYDR+/gkKjmBTQizMD1vUpa
 OFbis19EeX0TFYcA+/HvvtbN4Yuuqs4QeiVfVvEzRQonMZ/nzz0gJElG7ExKJRWlbjYAGJs
 DXFByDMS0bSeTSdX9Ko/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i4Z3/Jk7CP0=:qVAogbmTC4F81EimZDNLrc
 7/U5TX75D+aOXAgmaGfyLo4s14mLWYXWzZ6X2fJOephQzR6/1ZHBdVRIBCPePWnEiKWJ4cs0L
 qtjWNV7HSXR7LS7MNPjPYxSzeanhMfsuc3mAhQsjQZIflskd9NqCfupmRdS6PMbZ3iDb0MK7r
 gvNl9yaooetHPCSMGJpKWCNyXl8dRKvk6m10Y9VYzUM/WYQOUghFnJIk+ve1yVidw/gqJC0Sa
 rQoii6Z3rs+Iamhgj7mTNcE9vJIFE53jxnh1xfBRoKDIeCZB7Y0bWJ8S6YZBykvKjBDC6sQ8w
 VTi1K2TqIy5mwpFMedqdcYhNwQix7R4UW4hG/udYnSAD6Opq3WY87HA1M7EHcQyqKnY+YS+3+
 vR0LklcQCoDlAUkkvP7o9T+vpw5cqFVjBsBSlEoFtzooZhIxcNfcFi5SMsbCOxEEr3gDpBYnJ
 VtVfz2U0St2sOHJVDumvvlGTiZ0b2j+GxGx0pierf8q47wPbP+Rq8igw9s5mv91N3sMiLP1Dp
 cSMLwQm9J3AqGpUGR8RnXigE19U7/8DW82tB9gKn135Pc8J1od9Q/Y3o6V0K8LdhbsVxC+hDA
 Qk9bCluwHwWgRxVlHHHEPzDPhy5mzd1L3ic4uKToX8+O26mQsoDUJIFJEHEmNCvQ57ATp20cp
 jWLQ/2XaMZdrF44+1Pie1YKauoU9hviuz19riBXLbaNQ89nmbiAkc8eBsTe01xH8eGqJmW5nZ
 UVcIzmBL5f3aUtM1zhbRJcvOa4tb11rnGb6Wa+nNQ1ybTMAx6Ewo6ZPSB/Qb5Et7nllaRt60D
 N/Kbmvc24F6KNdXa0jLh3nF702gRu0D4GlXGe7aqbm6dv1m4G9beDWA2uS63GueRr1T42m71q
 xc/SBgFLt1DikmAwJk/H0zc7wnq+LGB2Z5i8hnFW18i2281JXiY2ZsowoV4v1zmOc/91CraBb
 cAA2TsajjOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 28 Jan 2019, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> If the user gives an empty argument to --exec then the rebase starts to
> run before erroring out with
> 
>   error: missing arguments for exec
>   error: invalid line 2: exec
>   You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
>   Or you can abort the rebase with 'git rebase --abort'.

And that's the same if you specify an incorrect command.

In both cases, I would probably heed the second line of the advice: git
rebase --abort.

> Instead check for empty commands before starting the rebase.
> 
> Also check that the command does not contain any newlines as the
> todo-list format is unable to cope with multiline commands. Note that
> this changes the behavior, before this change one could do
> 
> git rebase --exec='echo one
> exec echo two'
> 
> and it would insert two exec lines in the todo list, now it will error
> out.

This, however, makes a ton of sense to me.

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 00de70365e..b6c54b03c1 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -793,6 +793,24 @@ static void set_reflog_action(struct rebase_options *options)
>  	strbuf_release(&buf);
>  }
>  
> +static int check_exec_cmd(const char *cmd)
> +{
> +	int non_blank = 0;
> +
> +	while (*cmd) {
> +		if (*cmd == '\n')
> +			return error(_("exec commands cannot contain newlines"));
> +		if (!isspace(*cmd))
> +			non_blank = 1;
> +		cmd++;
> +	}
> +
> +	if (non_blank)
> +		return 0;

We are not in a performance critical path here, so I would prefer the
readability of this code:

	if (strchr(cmd, '\n'))
		return error(...);

And if you *really* must,

	/* Does the command consist purely of whitespace? */
	if (!cmd[strspn(cmd, " \t\r\n")])
		return error(...);

But as I suggested also in a reply to Junio's answer: where would we stop
to validate the commands?

Ciao,
Dscho

> +
> +	return error(_("empty exec command"));
> +}
> +
>  int cmd_rebase(int argc, const char **argv, const char *prefix)
>  {
>  	struct rebase_options options = {
> @@ -1130,6 +1148,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  
> +	for (i = 0; i < exec.nr; i++)
> +		if (check_exec_cmd(exec.items[i].string))
> +			exit(1);
> +
>  	if (!(options.flags & REBASE_NO_QUIET))
>  		argv_array_push(&options.git_am_opts, "-q");
>  
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 7a440e08d8..c98f64eb2d 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -147,6 +147,25 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
>  	git rebase --continue
>  '
>  
> +test_expect_success 'rebase -x with empty command fails' '
> +	test_when_finished "git rebase --abort ||:" &&
> +	test_must_fail git rebase -x "" @ 2>actual &&
> +	test_write_lines "error: empty exec command" >expected &&
> +	test_i18ncmp expected actual &&
> +	test_must_fail git rebase -x " " @ 2>actual &&
> +	test_i18ncmp expected actual
> +'
> +
> +LF='
> +'
> +test_expect_success 'rebase -x with newline in command fails' '
> +	test_when_finished "git rebase --abort ||:" &&
> +	test_must_fail git rebase -x "a${LF}b" @ 2>actual &&
> +	test_write_lines "error: exec commands cannot contain newlines" \
> +			 >expected &&
> +	test_i18ncmp expected actual
> +'
> +
>  test_expect_success 'rebase -i with exec of inexistent command' '
>  	git checkout master &&
>  	test_when_finished "git rebase --abort" &&
> -- 
> 2.20.1
> 
> 
