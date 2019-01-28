Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814721F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfA1V4b (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:56:31 -0500
Received: from mout.gmx.net ([212.227.17.20]:33665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfA1V4b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:56:31 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MY3Ho-1gjig20G92-00UpDT; Mon, 28
 Jan 2019 22:56:22 +0100
Date:   Mon, 28 Jan 2019 22:56:05 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -x: sanity check command
In-Reply-To: <xmqqd0ogbpzn.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901282253200.41@tvgsbejvaqbjf.bet>
References: <20190128102620.18222-1-phillip.wood@talktalk.net> <xmqqd0ogbpzn.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9qMIT2FVeVY06DbuDRznLOcyHZeH15MuginXOCrbxzRc5zoLJ9X
 wEB8RXM028AWg3avWR6HA0fw14tjlHu4FMn0a5bRpmZCPkA/I3QasxarN2DM804hrii5Gx4
 jUQhoX+LBDPff+1ZaETHNtz26vxcucoU1LRufnXlsCIbQd2HqgbcHlxPUISRdIgc2/QeSpw
 cnQx13y7CsIcb05pP2+Gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PZ1PGydgmBU=:OlPMABbmNJbFo9HTP5SLOX
 8zxZNp/mtuVDJJdm0IBkXHkyBKRL/+fcUzZtLyrGVrh1BT3watEvsYj1EEMXmTWkJcheB03p6
 XlhQzW/X+ITwqdy9CRFsIA7i2YJwaUfCzfzj/RsxyVIEB7J9WmhXsmv3jA/WcZ3K559ATMUjF
 wagzFR0+GqiscM1har30itJHkJbXiw3vwzp09qUdFimTSd9VtmBWYb0aARyTjZdfSc/yKwFky
 QuBns4dHZJkhVMSQV1rzccfgJ1yKdKV16jheRzBuNSwhMO2BuAtolgZF0Hs+deUhTqfXlpjdx
 hyzk6GsgN+J14M4PjavbUYsGHo3EDbqY1jM2FHJIs6RRWSnZ9B0LPHv8fWzHaVGQ1HhIlowDH
 TPr+9pR4pLT6N5TOqVmAPofy+wpeuW067wMZiwLs+LT94yVq0iUn2m0zh9b4OcTkGg/meq6Q5
 pmIxmILxgSxba8+3g9GrZzvUGubkD92cgAO/JxY8kDlapteR7p7O8oqZMCIK3WXxlDCRF3VjP
 papWF8VWh1Iz5HrL6lVwd8O449uiBG3wsc8W6GWtqPcLib6Fj5h7yl+MioeZvYXL0VUCiqaC2
 3Y+6y28VJlmQ45+Q4/I4EBn1qshlCS92PSGl2WNGTJ2yMn0Stj/8g2I4Bw2mPrOk+DFst+xMZ
 2UdTmLeHYFfusmYzPqjmgQD5zF4aHi60gBjCwx5VWD6ktZ7eqaFutT/NbDT46y1mekNLwoFtf
 /W3wzL7ZqupHEvXr6yrRs0JdraQqYn+6qhE5x+ARsWKFtqp//tY/F75hB7VEGCxXYl+dT7P1O
 9dVfOzdDtGrhcWmXpyX/9s7jJ4Lp3evr6x0sMApEGCrzus1fjGxHR9EXAn9XKBP7jDNfGF+NN
 kOpYjdzA5+EdENZkQbs2PxtGuPy8yetyLTNfu7UqUyq5FAQ03HP1xWuoHHLwYyYor7HarzCmM
 rAIoLuZ9o/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Jan 2019, Junio C Hamano wrote:

> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > If the user gives an empty argument to --exec then the rebase starts to
> > run before erroring out with
> >
> >   error: missing arguments for exec
> >   error: invalid line 2: exec
> >   You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
> >   Or you can abort the rebase with 'git rebase --abort'.
> 
> Hmph.  I do agree that the above makes an unfortunate end-user
> experience, but I would sort-of imagine that it would even be nicer
> for such an empty exec to behave as if it were "exec false" but with
> less severe error message, i.e. a way for the user to say "I want to
> break the sequence here and get an interactive session".  We may not
> even need to add the "break" insn if we go that way and there is one
> less thing for users to learn.  I dunno, but I tend to prefer giving
> a useful and safe behaviour to interactive users other than erroring
> out, when there _is_ such a safe behaviour that is obvious from the
> situation, and I feel that an empty "exec" is such a case.

That would make things unnecessarily confusing. An empty command is not
`false` with a gentler error message. An empty command is a missing
command.

I am, however, concerned that special-casing an empty command will not
make things better: if the user called `git rebase --exec=fasle`, they
will *still* have to clean up their edit script.

Or just `git rebase --abort`, which I would do whether I had forgotten to
specify a command or whether I had a typo in my command.

> > Also check that the command does not contain any newlines as the
> > todo-list format is unable to cope with multiline commands. Note that
> > this changes the behavior, before this change one could do
> >
> > git rebase --exec='echo one
> > exec echo two'
> 
> It is very good to check the input, regardless of what an empty
> "exec" should do.

Should we then also check for incorrect quoting, missing commands, other
errors? I am not sure that this path leads to sanity.

Ciao,
Dscho
