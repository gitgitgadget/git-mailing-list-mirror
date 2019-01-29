Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7F81F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfA2PgC (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:36:02 -0500
Received: from mout.gmx.net ([212.227.17.22]:33939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfA2PgB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:36:01 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSp1l-1ggz2V0cz7-00RnmD; Tue, 29
 Jan 2019 16:35:54 +0100
Date:   Tue, 29 Jan 2019 16:35:37 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -x: sanity check command
In-Reply-To: <4e4e46b3-9745-a3db-56cb-58763f7cf994@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1901291633440.41@tvgsbejvaqbjf.bet>
References: <20190128102620.18222-1-phillip.wood@talktalk.net> <xmqqd0ogbpzn.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1901282253200.41@tvgsbejvaqbjf.bet> <4e4e46b3-9745-a3db-56cb-58763f7cf994@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SH8xx6MDx752dBoYTr10nfL8yzqztJWmc2U9rb6XkV8MThjRgXd
 jWmVxpnLNEolIPFzGKh5gDUuduQYbaygImVLNNWonF+Pk5AvPEJblA0gZwQHgMNeitkOE6d
 2yv9z1Pt7XyzD/1KozsrUXlslC3BQD2bUeorSNn9DgejgsjuTWzSFIXElTwXhP4lHNyy+cG
 KqReWIJnmWbCBGOnoRYUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x4MM+pQJLU4=:sHOTfvie/4StH6KAo7tXOH
 Zb2GrPv0wrAhUgCa2DOHQk9ZZspEuN97D7Usfxw6KkCOw+S5Yc7ahJXvrlSEQEuZ0lipmRaW4
 om2AHYWA+v3hwkKYhS4e+HOtOK960IFFwQVaQVVUC7/jsW2X14abN9soBcTJpHeYOo1gwyTVJ
 Oc/ZwSXOhBeTe92XwBOIMkqqSSeOCKZRFgcqDZYabhyBFdODEyRqOVniS7fRmiXW6KMDezPB/
 c6PAEomXZlvBqCWJUmR6uf2ZNoO7y4iPoS//+ZT3ZMyE0pr0b6K8pjP3ErQ77urnWZS03vGUP
 Zosw9oJcxd1lGn6XX2GlxYZ4r+r73hDCjUtHqrqV1KKn5E/McT9UAJLGN0G9I1aONjLvfMFxF
 MFAPQf0TS5r63j1DRUMWxHt3SlyezMQR+lEbl3l6BrtSjRGEUi3NQ8GoDaSv3JQCKYJ008Ozg
 ZDuqVbFaO1fLAtxtKJJjeIvXj2ysvaKxc4mN4rVXpkMsEN7b3l1B18PVx9wIm9EXlOV7itOW9
 g1F7QU8rZYiRm/agwH35YzUTZQE9Oi+YD2HifXDdxwYGJM9zqA9N3l9oDzQpLLAKuQC405tOw
 D2kcRCqpNqf/BIniF+C1We5ELJz22jCxH3m2RpsYC4c9kh7xF1rjYS4XV3VJkWsXSlCZI3lQF
 iF0eHl22fxpIidtQzGn+QW+iWg2bq83gtf+DCAG6cIurgd8NlZroAyA6rkxUB7t1qagtBrhQ1
 eKzlYd0Ovj452L/PG4Y7eym+FQ+fS/YIScdsYJhGrbV7ptx3x1jAFXtxylHJURNlOfDp1ourE
 X52oSWrFJtDx+b+U9iVYlrN9zJy9EycxBi0WyLNI17dTs3OU0oHf2czJxAFWop/uKY2rtn97i
 gASD3qTaVuVHdWfENLjJqk1xlsQ/wzp6QOIlktuY34autWi+uPcLp+cTOuKSD+kTIVPU1rO08
 aTPO5FjOJQw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 29 Jan 2019, Phillip Wood wrote:

> On 28/01/2019 21:56, Johannes Schindelin wrote:
> > 
> > On Mon, 28 Jan 2019, Junio C Hamano wrote:
> > 
> >> Phillip Wood <phillip.wood@talktalk.net> writes:
> >>
> >>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>>
> >>> If the user gives an empty argument to --exec then the rebase starts to
> >>> run before erroring out with
> >>>
> >>>   error: missing arguments for exec
> >>>   error: invalid line 2: exec
> >>>   You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
> >>>   Or you can abort the rebase with 'git rebase --abort'.
> >>
> >> Hmph.  I do agree that the above makes an unfortunate end-user
> >> experience, but I would sort-of imagine that it would even be nicer
> >> for such an empty exec to behave as if it were "exec false" but with
> >> less severe error message, i.e. a way for the user to say "I want to
> >> break the sequence here and get an interactive session".  We may not
> >> even need to add the "break" insn if we go that way and there is one
> >> less thing for users to learn.  I dunno, but I tend to prefer giving
> >> a useful and safe behaviour to interactive users other than erroring
> >> out, when there _is_ such a safe behaviour that is obvious from the
> >> situation, and I feel that an empty "exec" is such a case.
> > 
> > That would make things unnecessarily confusing. An empty command is not
> > `false` with a gentler error message. An empty command is a missing
> > command.
> 
> I agree that having a special meaning to the empty command would be
> confusing. Also giving it on the command line only helps if you want to
> stop after each pick and my impression is that people want to break
> after specific commits to amend a fixup or something like that.
> 
> > I am, however, concerned that special-casing an empty command will not
> > make things better: if the user called `git rebase --exec=fasle`, they
> > will *still* have to clean up their edit script.
> 
> The empty commands create an invalid todo list which git cannot parse,
> this patch is not a step down the path of checking that the command
> exists or is valid shell - I don't think that would be possible in the
> general case.

Well, at least the error message is helpful: it suggests --edit-todo.

But as I said in another reply, I understand now that your patch validates
the argument as necessary to produce a valid todo list.

Thanks,
Dscho

> 
> Best Wishes
> 
> Phillip
> 
> > Or just `git rebase --abort`, which I would do whether I had forgotten to
> > specify a command or whether I had a typo in my command.
> > 
> >>> Also check that the command does not contain any newlines as the
> >>> todo-list format is unable to cope with multiline commands. Note that
> >>> this changes the behavior, before this change one could do
> >>>
> >>> git rebase --exec='echo one
> >>> exec echo two'
> >>
> >> It is very good to check the input, regardless of what an empty
> >> "exec" should do.
> > 
> > Should we then also check for incorrect quoting, missing commands, other
> > errors? I am not sure that this path leads to sanity.
> > 
> > Ciao,
> > Dscho
> > 
> 
> 
