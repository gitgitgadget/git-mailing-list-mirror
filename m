Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B763E1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfA2PdK (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:33:10 -0500
Received: from mout.gmx.net ([212.227.15.15]:49869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfA2PdK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:33:10 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M86Cn-1h22601t45-00vdbp; Tue, 29
 Jan 2019 16:33:01 +0100
Date:   Tue, 29 Jan 2019 16:32:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -x: sanity check command
In-Reply-To: <13f14cc6-e437-3f18-7f24-1d6edda1cb23@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1901291632070.41@tvgsbejvaqbjf.bet>
References: <20190128102620.18222-1-phillip.wood@talktalk.net> <nycvar.QRO.7.76.6.1901282257570.41@tvgsbejvaqbjf.bet> <13f14cc6-e437-3f18-7f24-1d6edda1cb23@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pfTONvl35xehqdOT//OCdaz1fNJz3g1daYpbce1kHJxr20IOeun
 0NbEKMLPHJKM2mjU60HRq+PC8DhnHyhAqoViilsGoI9Z/5Cw2AauXDl6V4EbL/k+q1G+zfU
 mRLLeW2UpTvgw+uFIxXkdH6fhLTH5uelpTnfYhwIKH/xvGG2okqj0Quh/dF7s56XzWumFTa
 2o07CYK8xFb8f1fOzQ6gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZlLvX/c/ZXM=:vKItTIOWrplQ59J2KbAv8D
 ZwdxM7T+XIhXHfVZdhDEkWpVa5XlBe0eRihuYUN6OA3VAWG75wFlhtqjAgd2pfDCrBbM2gEcR
 MGxzXxPplBU9wHYGsW0AFxnIP6P/XROf70EZnVONV1zJN2a315bksm7mXx3QG+3iQHS2GJ30B
 kWyT2KMGYOfcQxQTtbyqxAVj7VtzMATFQGlwjEY/Ogw1RkA+9qJbNfHidkuiRMHd98YX9/9lQ
 yYViLGqGIGlpARVOFhDMnV+pG/SnWQDqjCu9N98x8FuIRVZd6UZY0LgkHPimPGpOsX4e17VLC
 MGBQbJdkwFsWpcT2Ap+mLf5KzrIORuNPs53b29cGg1/Wa3dFoojJantsRfji4NMuDhNYGsjuj
 feqrMLKq26l8za0/eL+WRb9dmFgZB382GMA/7lxHI5lB+y2vooBI8vtI37M0qloBfzbEV9qi/
 toBZd082Q6xgHQuxorzeDM8Oh3bCI7dXgICzAEHQ5w+QIf7f3EQ+0SBHJs/OXQNbFT6plxT0f
 tce6Qm1hHhIzVTrBzzw6jitA0ReuCwif2lfj7DmKdNUI5mh+oKiJvCv5hBDOebhWgG1Bsw7RS
 dShHKuAyX+Sd3HJDqMnInHtbf/YjzWk9CqiOpGbFDUoFu9H+8+kCW8hcv1xkd6hILNGXrDbhw
 PMSLi4LUmAghs3RASRIWeyzLpJX5YXwucS2kVUYZr7jdMVK5OK8jqImukaYoontv3ioIcXCx4
 5JUVTWRE1OWap9bVmJR21HVA0aZXmrJJBo3sRTKAjwOumHRt6UV/112bGtb/z6Qw+djXnP7qC
 wVedGROiOydkFo2JeSYP2OzjXHw40MxuYyBNDLZ+mIO5aUOyTZ/r9XxIxsxZApve/eyKI0seb
 PhNlViRux4n6oaYqAcBVMQxGQ4dlXgfiuBMSJU9a0NtpbCteapY2Sop2qnU7jnsFjjHL/UYWS
 a/+NKHLc0xw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

[sorry for the double-send, I dropped the Cc: list by mistake the first
time I replied]

On Tue, 29 Jan 2019, Phillip Wood wrote:

> On 28/01/2019 22:03, Johannes Schindelin wrote:
> > Hi Phillip,
> > 
> > On Mon, 28 Jan 2019, Phillip Wood wrote:
> > 
> >> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>
> >> If the user gives an empty argument to --exec then the rebase starts to
> >> run before erroring out with
> >>
> >>   error: missing arguments for exec
> >>   error: invalid line 2: exec
> >>   You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
> >>   Or you can abort the rebase with 'git rebase --abort'.
> > 
> > And that's the same if you specify an incorrect command.
> 
> Not quite, the issue is that the todo list is invalid, not that the
> command fails - it never gets that far. Those errors are coming from
> parse_insn_line() and parse_insn_buffer().

Ah! I misunderstood "then the rebase starts to run" part.

So please let me withdraw my objections to catch this error.

However, I still would highly recommend to use `strspn()` to simplify the
code.

Thanks,
Dscho

> > In both cases, I would probably heed the second line of the advice: git
> > rebase --abort.
> > 
> >> Instead check for empty commands before starting the rebase.
> >>
> >> Also check that the command does not contain any newlines as the
> >> todo-list format is unable to cope with multiline commands. Note that
> >> this changes the behavior, before this change one could do
> >>
> >> git rebase --exec='echo one
> >> exec echo two'
> >>
> >> and it would insert two exec lines in the todo list, now it will error
> >> out.
> > 
> > This, however, makes a ton of sense to me.
> > 
> >> diff --git a/builtin/rebase.c b/builtin/rebase.c
> >> index 00de70365e..b6c54b03c1 100644
> >> --- a/builtin/rebase.c
> >> +++ b/builtin/rebase.c
> >> @@ -793,6 +793,24 @@ static void set_reflog_action(struct rebase_options *options)
> >>  	strbuf_release(&buf);
> >>  }
> >>  
> >> +static int check_exec_cmd(const char *cmd)
> >> +{
> >> +	int non_blank = 0;
> >> +
> >> +	while (*cmd) {
> >> +		if (*cmd == '\n')
> >> +			return error(_("exec commands cannot contain newlines"));
> >> +		if (!isspace(*cmd))
> >> +			non_blank = 1;
> >> +		cmd++;
> >> +	}
> >> +
> >> +	if (non_blank)
> >> +		return 0;
> > 
> > We are not in a performance critical path here, so I would prefer the
> > readability of this code:
> > 
> > 	if (strchr(cmd, '\n'))
> > 		return error(...);
> > 
> > And if you *really* must,
> > 
> > 	/* Does the command consist purely of whitespace? */
> > 	if (!cmd[strspn(cmd, " \t\r\n")])
> > 		return error(...);
> > 
> > But as I suggested also in a reply to Junio's answer: where would we stop
> > to validate the commands?
> 
> I'm not trying to validate the command (and I don't think we can/should)
> - just generate a todo list that can be parsed.
> 
> Best Wishes
> 
> Phillip
> 
> > 
> > Ciao,
> > Dscho
> > 
> >> +
> >> +	return error(_("empty exec command"));
> >> +}
> >> +
> >>  int cmd_rebase(int argc, const char **argv, const char *prefix)
> >>  {
> >>  	struct rebase_options options = {
> >> @@ -1130,6 +1148,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >>  		}
> >>  	}
> >>  
> >> +	for (i = 0; i < exec.nr; i++)
> >> +		if (check_exec_cmd(exec.items[i].string))
> >> +			exit(1);
> >> +
> >>  	if (!(options.flags & REBASE_NO_QUIET))
> >>  		argv_array_push(&options.git_am_opts, "-q");
> >>  
> >> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> >> index 7a440e08d8..c98f64eb2d 100755
> >> --- a/t/t3404-rebase-interactive.sh
> >> +++ b/t/t3404-rebase-interactive.sh
> >> @@ -147,6 +147,25 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
> >>  	git rebase --continue
> >>  '
> >>  
> >> +test_expect_success 'rebase -x with empty command fails' '
> >> +	test_when_finished "git rebase --abort ||:" &&
> >> +	test_must_fail git rebase -x "" @ 2>actual &&
> >> +	test_write_lines "error: empty exec command" >expected &&
> >> +	test_i18ncmp expected actual &&
> >> +	test_must_fail git rebase -x " " @ 2>actual &&
> >> +	test_i18ncmp expected actual
> >> +'
> >> +
> >> +LF='
> >> +'
> >> +test_expect_success 'rebase -x with newline in command fails' '
> >> +	test_when_finished "git rebase --abort ||:" &&
> >> +	test_must_fail git rebase -x "a${LF}b" @ 2>actual &&
> >> +	test_write_lines "error: exec commands cannot contain newlines" \
> >> +			 >expected &&
> >> +	test_i18ncmp expected actual
> >> +'
> >> +
> >>  test_expect_success 'rebase -i with exec of inexistent command' '
> >>  	git checkout master &&
> >>  	test_when_finished "git rebase --abort" &&
> >> -- 
> >> 2.20.1
> >>
> >>
> 
> 
