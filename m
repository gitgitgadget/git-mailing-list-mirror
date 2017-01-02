Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7790C205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755774AbdABPLu (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:11:50 -0500
Received: from mout.gmx.net ([212.227.15.18]:52463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755748AbdABPLt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:11:49 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbOoG-1c7UpL1Oey-00InX0; Mon, 02
 Jan 2017 16:11:39 +0100
Date:   Mon, 2 Jan 2017 16:11:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 05/34] sequencer (rebase -i): learn about the 'verbose'
 mode
In-Reply-To: <xmqq37hr1orb.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701021610590.3469@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <1d1f8d8b0696769bb85dd8a2269dc281aa91eede.1481642927.git.johannes.schindelin@gmx.de> <xmqq37hr1orb.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:i5bymDRQPYat7GU5/AQnlDfJJDXQdhOUh+v5njDt/wSzn+KDNKb
 3EC1a+rk/0R2wREomR97r8LAcuXBeBVWVbSmsqCq9Au+8VRhYqLmWQ6BR681pBwYZQJq4w9
 gCEsYJyrK442KdY849Uo2Sql2IfXOdAj0+igYnOMCtN68jMGqMRKgyRDo6VyL4Zp0B8Gjoa
 YN/U7ulKYpNzST47Q7SEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZKLQr+CiFxI=:Objb9cqTdUwXNsdWGyM+N0
 HrirSQAIC6aFr9t5z+xDLOy7EL9Fmu4rhUwx7EOIua9gPA/6D0JFJH5AIXfNXDt5zyB8DRZ+m
 Q2UbBprscL/1nNypq6R77hmifBgJCXap3/2/RccisMXEACzx/2/CgehhVHNhiZMT4yOE2wFJf
 AfotrqGBxBQhoGm0TIOm5S/kWidpRU1mLzW3NBeQQ43PyNaQ+SY+1F/dzrrDYNxz9Yvph9DXq
 hlp8YTX6uxgqeo/R1W9U3j0LROFKcSqXUygDUigtLoYMrYLQir2Aqz2/mx79saHfkweIirggC
 AZrd4JkGA1PkUYzritQBdQ3OcwENhamDW4iR0PAaVsw7llLImDjJj+DtqJdUYEYfleqoZFjqL
 +G+1nbNZN5zArTeBJ9qCJtPuKPVG4CHKVJYcKFx/8vcBwGGOhb67QV02BMVY47GyQO7OljE8z
 0o59GUuvy/qM39VBEdck/uyMVtnU16+2KiyYtvyhR8qhZg6Gd74zncpG1U0rOEwoUteljWCeV
 1T0STBDEReS+1lNNrobNsnkvcqWdHchoS8CVbOPvR7maghkiQiOTpscZe2S7jXSKZydQWovvp
 0weGmmEarsqPSUDMVuEsN7zWenruA1ePs+tCPiw2Hiaa+4sJKRNZZAiAhUbFDlSy0k56WEbRn
 nGXj6YH2PaPhEzMCRxqqrVJbxdokJ5mwCgp0opwSxlFddfZIh4vuQt8+l9NTAjdBe1MKAdwnE
 y6cqiwuOqqPJsTkFQoLwheop/ocKHeooG8wMp3RQ2iIWI5z8LNu5IgdJijDn3mSnyEvCWTupP
 j3vOMr6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 13 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > @@ -1493,9 +1498,26 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
> >  	}
> >  
> >  	if (is_rebase_i(opts)) {
> > +		struct strbuf buf = STRBUF_INIT;
> > +
> >  		/* Stopped in the middle, as planned? */
> >  		if (todo_list->current < todo_list->nr)
> >  			return 0;
> > +
> > +		if (opts->verbose) {
> > +			const char *argv[] = {
> > +				"diff-tree", "--stat", NULL, NULL
> > +			};
> > +
> > +			if (!read_oneliner(&buf, rebase_path_orig_head(), 0))
> > +				return error(_("could not read '%s'"),
> > +					rebase_path_orig_head());
> > +			strbuf_addstr(&buf, "..HEAD");
> > +			argv[2] = buf.buf;
> > +			run_command_v_opt(argv, RUN_GIT_CMD);
> > +			strbuf_reset(&buf);
> > +		}
> > +		strbuf_release(&buf);
> >  	}
> 
> It's a bit curious that the previous step avoided running a separate
> process and instead did "diff-tree -p" all in C, but this one does not.

I guess my only defence is that I tried to be a little lazy.

Fixed.
Dscho
