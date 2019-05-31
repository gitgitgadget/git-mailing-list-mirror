Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E34B81F462
	for <e@80x24.org>; Fri, 31 May 2019 17:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfEaRYU (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 13:24:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:41083 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfEaRYT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 13:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559323452;
        bh=XxY+f+j5Cfycsivw5/MPVPNDKBpDwYXJQkvzCJD1Ezk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=K7x6OacEL/hdJSjoqhz+3zTYI3PbrRnIsr05c45lnJSCnFJ0h++2cfgEEgO/kvl23
         UDCxH3W1DSNLEqBvnUVlWnNVfRFm5SWuJvW7qS2UB97teEDYIo4Vs4nHERqKJVOF/8
         UBA/jLiz6AhoaWtFK6GEyj/gv7I+jdoi1K1OlzCk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mchyv-1hEolm3plh-00Htvq; Fri, 31
 May 2019 19:24:12 +0200
Date:   Fri, 31 May 2019 19:23:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] config: learn the "onbranch:" includeIf condition
In-Reply-To: <20190531131626.GA30114@archbookpro.localdomain>
Message-ID: <nycvar.QRO.7.76.6.1905311918510.44@tvgsbejvaqbjf.bet>
References: <xmqqh8a5k9bu.fsf@gitster-ct.c.googlers.com> <7b60e58ba554768fd915e4f5c00a97737707ed42.1559263024.git.liu.denton@gmail.com> <nycvar.QRO.7.76.6.1905311453420.44@tvgsbejvaqbjf.bet> <20190531131626.GA30114@archbookpro.localdomain>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4F0IXaRmWssfwCHBwRbHcxko5GFVu0zwFFOm4VhWV8rgcPKolql
 ITlVZX6cj2EozHeZ89AFxP5tIGzalpAXxwbcHyj67KvWi9a7B8IdVZ7PuWv2PEOXYQE6oHz
 xU6v5zBP1Y3kV0E1XtBQegzmHwUIvqC3AWvQ49SULSP3Ltc3ye1hYaDvLeEqCMkFOxqyRGS
 0joA01sXSV//x1hoMJ4Fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P/e+sv/Za2o=:vS/lMMSpwNh024cgg5kO+g
 P8K/BqH1qL8o3wMMBw8DWcJTCFbIyev5dmg1ozIfxhgOVgiEdXJqir2jKLpOgGbThboCPVLC2
 f6uyzu3mZIlr2K9SOYDdTzLfplgY4P7GHYIjJyYlM7+Xo7zPZAIcLosOurLw2XBdPG2YVu2j/
 5ioyt2t8pEIOcaGlZxF5+kpTN9aIEpr7cDPE2cwAVwMrw67MdDoWMVCb5GIUThoBKBJvvVlA2
 pexNHiPNozo0tRTqyV1ooY0jTbsS6CeASiAPJyO1ijNbx1q/uPOPEf0226Dof3rkTxgd0pMgo
 Mo4imYRuoG3TA9FZ6ZU03cM5f9vbYUMPuuJk9lnu8MWMscxIAEIR1d2mwD83PDJNlJFtrEw1E
 TbSvJfo1hkMuo8u3WuGFr+GJ5Qs8m7ANZ9Qdu6wn7emp0zoOb5YuDJxURqPXZztgFVVE3CiEo
 Bi7Q6esgDKqf39EY8842ECMXkskGMVahoRifGnevX1SvlzZfvDfU9k5O1N0ACPsieMDNCJyzn
 3es5t3OgRZ/eV8aMF39jVwmdlAsGETUBWNcg/SDdg/me0qAAGqBd8x//TCV418/VLcWsCh0ir
 0A7Y8yPSz2pgdvst3Ay8mqzouKqwC+53YaMsFxWW645PzSPSIGSRBWJJuL0aQFNhEViZnJcQm
 tYbBoi4G+6WiY0oJl8RqLWpn6wUNnhCb/h35R0qvaqDZVO9pGCAG/OQPIkC5Ylsquh/UtI5sA
 lADo9u3m5D86vbq6PagTuqG6ZBAwpi8ZY0bFP+uleVnXXC/2KFTpHkrPuZHi0LQV5xL0mIdK6
 Z6KTVEwu0mG9Wgo2ijjWW1dFzBKMJS7snoQHceaw4oZmJVd65orwZlg3fBmHs8P/ALixOCTkB
 fAeGqvYz9fRhnTIvx2n8yDbeuh2mwpMlgwxsZo25zEJG2IsmoTf5Q0SGtJDL7CLOwWr6Bifxy
 WADYumcEq10NTxqPj46UnSgY537IeDjuoop2cW50zwnS9lYNLgMwV
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Fri, 31 May 2019, Denton Liu wrote:

> On Fri, May 31, 2019 at 02:58:30PM +0200, Johannes Schindelin wrote:
>
> > On Thu, 30 May 2019, Denton Liu wrote:
> >
> > > Currently, if a user wishes to have individual settings per branch,
> > > they are required to manually keep track of the settings in their
> > > head and manually set the options on the command-line or change the
> > > config at each branch.
> > >
> > > Teach config the "onbranch:" includeIf condition so that it can
> > > conditionally include configuration files if the branch is checked
> > > out in the current worktree.
> >
> > What a coincidence. I actually wished for something like this, to have
> > branch-specific aliases.
> >
> > However, I would need this to handle patterns (via `wildmatch()`?)
> > rather than branch names.
>
> Do you mean that we should be able to match a branch by pattern? So, for
> example, if we had
>
> 	[includeIf "onbranch:mas*"]
>
> we'd match if we were on "master"?

Yes, precisely.

I would use this for the "ever-green" branches of Git for Windows, i.e.
the branches that are continuously rebasing Git for Windows' branch
thicket on top of maint, master, next & pu. Those are called
`shears/maint`, `shears/master`, etc (for historical reasons) in
https://github.com/git-for-windows/git.

> > > I decided to go ahead and implement the includeIf onbranch semantics
> > > for fun. For completeness, I'm sending it to the list but I'm not
> > > really sure if this should get merged, since I don't really have a
> > > use-case for this, especially if we go the branch-specific
> > > format-patch config route.
> > >
> > > Another thing to note is that this change doesn't completely cover
> > > all the use-cases that the branch-specific format-patch does. In
> > > particular, if I run
> > >
> > > 	$ git checkout foo
> > > 	$ git format-patch master..bar
> > >
> > > with the `format.bar.*`, we'd get bar-specific configs, whereas with
> > > `includeIf "onbranch:bar"`, we'd fail to include bar-specific config=
s
> > > and, more dangerously, we'd be including foo's configs.
> >
> > I actually think that this is fine. "on branch" means that you are on =
the
> > specified branch, not that you merely mention the branch name on the
> > command-line (in which case there would be the ambiguity "did the user
> > mean `master` or `bar`?").
>
> The reason why I brought this up as a use case was because currently,
> when format-patch generates a cover letter, with the above, it'll use
> bar's branch description to populate it even if "foo" is checked out. As
> a result, when implementing the branch-specific format-patch stuff, I
> wanted to make this consistent so that we wouldn't end up in a situation
> where the cover letter has the branch's description but is missing its
> Cc's.

That strikes me as a different use case than `includeIf`. I could imagine
that you'd want a setting like `formatpatch.detecttargetbranch =3D auto` o=
r
some such that would pick up the `format.bar*` settings if there was *one*
rev argument, and it was a commit range (or a tip commit), *and* it
obviously referred to a single target branch.

It's just a scenario that is *very* specific to `git format-patch`.

For example, I would not, ever, want `git log ..next` to pick up a
config specific to `next` just because I mentioned a commit range with
`range` as the tip to start from.

Ciao,
Dscho
