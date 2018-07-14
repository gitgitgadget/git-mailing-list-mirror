Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62FB51F915
	for <e@80x24.org>; Sat, 14 Jul 2018 22:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbeGNWlT (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 18:41:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:36263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731182AbeGNWlT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 18:41:19 -0400
Received: from MININT-3BS5S37.fareast.corp.microsoft.com ([37.201.195.126]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LyVIk-1g9pBU3J38-015oSF; Sun, 15 Jul 2018 00:20:42 +0200
Date:   Sun, 15 Jul 2018 00:20:41 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] git-rebase--merge: modernize "git-$cmd" to "git
 $cmd"
In-Reply-To: <CABPp-BHrjqHVpV3bwR+aa5Q4yvARMyna10TrXPXBuKpDQ0r_tQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807150018060.75@tvgsbejvaqbjf.bet>
References: <20180607050615.19598-1-newren@gmail.com> <20180627074600.32149-1-newren@gmail.com> <nycvar.QRO.7.76.6.1807121743040.75@tvgsbejvaqbjf.bet> <CABPp-BHrjqHVpV3bwR+aa5Q4yvARMyna10TrXPXBuKpDQ0r_tQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1664776162-1531606842=:75"
X-Provags-ID: V03:K1:VQWW0AVWSY7YKEPRhBn9812nstSZbF9BJYH2iIu1AXUQ/NrOrFs
 h3bu2oYTC1w149faxb47S7obUz7lvy6Q00J2euKHvv1VllX46RrXALDK/YZcuBoQB+auUhg
 xvZstNhEJ/59u6ko0HzUXCUSGGLFIrI/1yE/E4PstX/FC+yiEDr+MsqYxsBY3ofX6wIi6sl
 ToZ6QqIAVQ0i8SMaXmytg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7tE4AhOzvrs=:1WqapdwuMnD9v+TUYqrfOq
 94ei32Wegahma8dKrhfCWG8JiuPO+UPOMrWvW265yBpk3gJyJvcAa+bsbbrG5ssTsMkPf0KI/
 T6uLHEgC4yu+hUY0gjywRw6oN44crJ8hyzoUhHvYhnUQ3awowK5/kLeNLIk8VOwS63r+OdkEs
 b2uaqpX02l2ibxca0A2NqNVQYwHNzkOow3qgc84C4jeoBtbtsZOPrSZ9sdjyuLLY+5nsAmu70
 44CVAfMtyjoR3BzUJ+FHjZrJ6/FdXR5mZSFgW27ZKZ0pRq2+TcUZVOXK47qRpngQZKuzJscw7
 LmwVdL4M1/SRjWkD8MuOTvkSAAScSmtzTt5yVzbKtT8Z7xqC4SajGs/vrovXeJPz4UJvBj4C0
 hRAXZNk3aq1Skiwq9wCgBMYsVyU68dbAFNyQxt+t3/fjR+w28SnPoB0pPdaZnDr4TmiCrq/A0
 T4sLgh47HbdLh0XSm08SeuvM0tOyWqtsKE51d4T4e7RMoJssYgKWCwkGVJFlhrFwSombVAX1i
 dBF0bxs/8zMsqur5vb1Wm/792ggyC18owiu29zcDjrPzOu2JZOBltROELii/t+oQbujAOlstr
 cenbYal+LkTYJAOqaljsb/qBeK00Uza8OdL+hf+2a1ejSgJS9/b0SWPnrs9yJdylk8ky66qx8
 cyQR8ZTxUUyiG/yDn7QiN1ZFQgFr73K9TThf/aNWeIy6V005rmmTEgLe2zVuJC9NbESzorq1o
 AcGKcL36kq0Fws9zPD+fneg1Ign8HHJOJ4pSPFzZcj64GVIF8b6RRjK7hZuId5zJwCRXSF+bF
 d1QcB+h
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1664776162-1531606842=:75
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Elijah,

On Fri, 13 Jul 2018, Elijah Newren wrote:

> On Thu, Jul 12, 2018 at 8:49 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 27 Jun 2018, Elijah Newren wrote:
> >
> >> Signed-off-by: Elijah Newren <newren@gmail.com>
> >> ---
> >>
> >> Changes since v1:
> >>   - Fixed up commit message (move below comment to below diffstat as
> >>     originally intended)
> >>
> >> Long term I just want to make git-rebase--merge go away, so this patch
> >> will eventually be obsoleted.  But since I'm waiting for multiple
> >> topics to merge down before re-submitting that series, and since that
> >> series has some open questions as well, I figure it's worth
> >> (re-)submitting this simple fix in the mean time.
> >
> > I carry essentially the same patch in Git for Windows for a while now
> > (more than a year, to be a little preciser):
> >
> > https://github.com/git-for-windows/git/commit/42c6f1c943a
> >
> > (but it seems that I either missed one when I wrote that commit, or I
> > missed when it was introduced)
>=20
> So...I helped you get your work upstream without knowing it?  :-)

Yes. Thank you.

> > There are more dashed forms in Git's code base, still, see e.g.
> >
> > https://github.com/git-for-windows/git/commit/4b3fc41b117
> > https://github.com/git-for-windows/git/commit/c47a29c373c
> >
> > I would *love* to see those go away.
>=20
> Are there blockers or more known work needed to get these ready for
> submission, or is it more a case of you just haven't had time to
> submit upstream?

Time is the main problem.

I also meant to accompany those patches with a commit (that I did not
manage to write yet) that optoinally skips hard-linking the builtins
(except `git-receive-pack`, of course).

> > FWIW I had originally also "undashed" the use of `git-receive-pack`, bu=
t
> > that breaks things, as the dashed form was unfortunately baked into the
> > protocol (which is of course a design mistake even if Linus still denie=
s
> > it).
> >
> > It would go a long way to help with platforms and packaging methods whe=
re
> > hardlinks are simply inconvenient. Because we could then finally get ri=
d
> > of (almost) all those hardlinked builtins.
>=20
> I thought they were symlinked rather than hardlinked, but yeah I've
> always found them slightly annoying.

They are hardlinked, with a newly-introduced option to symlink instead
that =C3=86var came up with IIRC.

Symlinks, of course, are just as impossible to handle portably in .zip
files as hardlinks.

Ciao,
Dscho
--8323328-1664776162-1531606842=:75--
