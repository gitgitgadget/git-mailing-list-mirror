Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC9BF20305
	for <e@80x24.org>; Thu, 18 Apr 2019 12:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388699AbfDRMl3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 08:41:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:42361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfDRMl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 08:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555591283;
        bh=AttpG3iIS17hK2rYKolK1pP678GnyzSMpyVs1srJ03k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bW0NKRM7Lh5HqXoRNlr+I/xxuVszdcq0cQkKrkszM6dIxc8SiHyrB+lYAws83ebMv
         5Tiv6EINOQa4C/Z1XFNGszHu0k9JTtZCO6HGvOM61TM5mX/rs0Gr68eRnmwby7JXSf
         aHw277z2aJe6TJwltikx1zkJV3fMGUKvOIyAlD+w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1gbQwV0uqW-00g2rQ; Thu, 18
 Apr 2019 14:41:23 +0200
Date:   Thu, 18 Apr 2019 14:41:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/7] check-docs: do not pretend that commands are listed
 which are excluded
In-Reply-To: <xmqq4l6zsplq.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904181424330.46@tvgsbejvaqbjf.bet>
References: <pull.168.git.gitgitgadget@gmail.com> <96ced7e17cb40c4d0f15955c482857196862ab80.1555070430.git.gitgitgadget@gmail.com> <xmqq4l6zsplq.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:C+JvvBAl9NF5ANfTk/OGk/14lybSr0OpnMVZXGIPsHYVFPIJfj3
 s0ceY/mG8kXIn/eGwGwHBtLNthkCPwdyX07qZfuL5oRYT7g+zETNVVw/AQdnLW/j3eSzNv4
 fc8zyXeD4N2IxjUpqZPpySU1gKp4SyATupBsdY9HPTndHO5bYSoEnJwhXaLeUcSvFqDR+on
 7eE405Mxq8Ets5lTdISjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JywqsLdmvGY=:30W2UQSbsDItYeSHUHUKpL
 G2HWW/aRqdF0fG9hL59DbI0rbVkgswF7GL+O3tTXjPWk1mO6w+h5JOpB22oQctNE4wuMpnhqA
 D9wvJ2z5kzHd37zOmx0oPNjtqgRlz96rEpstyoRgySJkmjtuxPPgoHSKyLA9tqeAAk2kzYGFl
 gG9Cqe0E4/Yc0sJNIth08wEf8MM5ici3FwbO4u1rDpkl3gjCVcS5Vw0CcL8YNyvJEf3Jvaovp
 9v/Oeg30QFSpGw1OsRAcFXDuiqYp11JRGEQLhJ5EK56iamgTSXN08qlfwAN+FZ60mk86uiCtC
 oEID+0/w2lCt1D6YBusf57wG9jxWZ0aXwFFubctmEG/haUEn7tJVNmjy9sLaeraO/Nw5dlyTI
 aRZNmmV6c36566oqV0YToBdLLP2nwQyb38aHf5iU7qMfoIQrVPASTMarJncOV5eKNQE1gZCOk
 FQjatGetFglW9tdYJGjT7Yb5168z0PDQ8+nCBrBL9cBzvD9FOBYpjtyoF1bnxWJNTLzEVmoC2
 eGO7M/wa0Phpz2PPSFHlQfCCsHcHwrtTPrY/7rPdP0kd5hGiPNj5y/VIh/fppBrImftFQqszn
 kRCIS0IRXlWHA4MuYCjpt/RkOxwNwo0AHEI/EAAX1jw4KdIZiUXDYmmHG7EYUgNduRHL7UVKc
 1VuU5DMh5Fw+ef0g0sFB/HJ+5ERsVUd+Vl0M+21mdqjqx47hhq/OKxrT/MaPB1YyYHkyOTgbC
 3tCgjsKqpX7FnR9KzmecQhNnW81+15tshp9gfs5psyGgrh7dsLPyuShUSDazQTS97DnVcKCHg
 ZT+HcaNAOn6shet8Vu7tIxZkc6sBJSJeUy0/FpwA5N/6l2/YbMZnITOhzAn0odPNjJyARRjfJ
 luhk+mk75eIcZHAUclLtCPOCgs6VvWaax/JpFlZBjkmJTePN8Zbc392WWZ2TE7ECHwUjf7UcT
 UOqRs3zFlUw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,


On Mon, 15 Apr 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Subject: Re: [PATCH 3/7] check-docs: do not pretend that commands are =
listed which are excluded
>
> Sorry, but I cannot quite parse the title.  I am guessing that you
> meant "do not pretend that commands, which are excluded, are
> listed", which is a mouthful but at least can be parseable X-<.

Well, what can I say, you're right.

> > In the previous commit, we taught `git help -a` to stop listing comman=
ds
> > that are excluded from the build.
> >
> > In this commit, we stop `check-docs` from claiming that those commands
> > are listed.
>
> I think the result would become more readable (and I suspect that it
> would at the same time make the title parseable, but I am not sure
> as I do not quite know what the title wants to say in the first
> place) if you clarified the verb "list" here perhaps with "listed in
> command-list.txt".

I was actually coming from the `help -a` side. But that is not obvious
from the commit message, nor does that Makefile target handle that `help
-a` output in the first place.

> The output from the sed script that filters the contents of the
> command-list.txt file is compared with the ALL_COMMANDS list, and
> we complain if an entry in command-list.txt is no longer in the
> ALL_COMMANDS list (i.e. a developer removed a stale command but
> forgot to remove it from the command-list.txt) [*1*].
>
> The step 2/7 marked the subcommands that ought to be on ALL_COMMANDS
> for the purpose of this check but that are excluded from the build,
> as a preparation for this step, and this step 3/7 uses the list of
> excluded ones to avoid complaining them being in the categorized
> list of subcommands (i.e. command-list.txt).

Right.

> We can read that "stop listing them" is done as means to some end,
> but it is unclear what the end-user/developer visible effect this
> step intends to achieve.  After thinking about what the patch does a
> bit more, here is what I came up with.
>
>     check-docs: allow excluded subcommands to be in the command-list fil=
e
>
>     One of the things this build target makes sure is that all
>     entries in the command-list.txt are about subcommands that still
>     exist in the system (i.e. if a developer removes a subcommand
>     and forgets to remove it from the command list file, it needs to
>     be flagged as an incomplete change), and it is done by comparing
>     the entries in the file against the list of subprograms in
>     $(ALL_COMMANDS) variable.
>
>     However, the latter list is dynamic---not all build contains all
>     the Git subcommands categorized in the command-list.txt file.
>     And such a partial build would falsely trigger the check,
>     complaining that some subcommands are removed but still are
>     listed in the command list file.
>
>     Fix this by teaching the logic to use the EXCLUDED_PROGRAMS list
>     prepared in the previous step.
>
> or something like that, perhaps?

I rephrased this yet again (to reflect the way I speak):

	check-docs: allow command-list.txt to contain excluded commands

	Among other things, the `check-docs` target ensures that
	`command-list.txt` no longer contains commands that were dropped (or
	that were never added in the first place).

	To do so, it compares the list of commands from that file to the
	commands listed in `$(ALL_COMMANDS)`.

	However, some build options exclude commands from the latter. Fix the
	target to handle this situation correctly by taking the just-introduced
	`$(EXCLUDED_PROGRAMS)` into account.

> The same logic to warn about "removed but listed" commands that are
> not built (hence missing from ALL_COMMANDS list) is also fed the
> list of all documented subcommands by looking at "make print-man1"
> in the Documentation directory, so that it can issue "removed but
> documented" when a developer removes a subcommand but forgets to
> remove its documentation.  Don't we need to teach a similar
> treatment on that side of the coin?

Yep, that's what the later patch "docs: exclude documentation for commands
that have been excluded" is all about.

> I am wondering if it makes that easier to instead add EXCLUDED ones
> back to ALL_COMMANDS on the receiving end of the pipe, rather than
> filtering them out in the sed script that reads from command-list,
> i.e.
>
> 	# revert what this patch did to the upstream of the pipe
> 	(
> 		sed ... filters comments ... \
> 			-e 's/^/listed /' command-list.txt;
> 		$(MAKE) -C Documentation print-man1 |
> 		sed ... -e 's/^/documented /'
> 	) | \
> 	while read how cmd; \
> 	do
> 		# instead add them back here
> 		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(EXCLUDED)) " in
> 		*" $$cmd "*) : ok ;;
> 		...
>
> That way, the documentation side can be fixed at the same time as
> the command-list side of the check that incorrectly reports "removed
> but listed".

I did exactly that, thank you for that suggestion.

Thanks,
Dscho
