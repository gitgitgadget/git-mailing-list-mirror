Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 364AE1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 21:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbfIMVEA (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 17:04:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:53035 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfIMVEA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 17:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568408637;
        bh=5lK0gYfD7rv0NL7j/S7ioUAOPZCZvZPV+mTOIRl49no=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ar7vYvUZR3Qu8zYkPJy9pF6GE0QNDDbdWLVdH1D6JbkssuytLnLqky+RQfqGsAV4A
         /Nv8Ah2KFxg6wOEE9xsrHc/+BghfcnWh5/jBf0T4UV/TS6Fy4v1jN/+EdBSvc1wdq9
         RqPXlFDQfzAE8jrs9+5dFSaXiTLRfUnvXVjXuFd4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGiJ-1hjPmo0e7H-00RIIn; Fri, 13
 Sep 2019 23:03:57 +0200
Date:   Fri, 13 Sep 2019 23:03:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Max Rothman <max.r.rothman@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] completion: add missing completions for log, diff,
 show
In-Reply-To: <CAFA_24L5S1_AS1OzPYf50iXwEupi0Bus827-NWoUpka-avNo_w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909132300130.47@tvgsbejvaqbjf.bet>
References: <0102015f985d387e-f50183c4-4b49-4a9f-b365-2a86ba24bbed-000000@eu-west-1.amazonses.com> <0102016bb065bf5e-005b0752-2594-45d5-a01a-12d0c5e24b70-000000@eu-west-1.amazonses.com> <CAFA_24J8Ry5LhRX5O82eJDtrqjEodDFTEniZNw06fKEWvwvYMA@mail.gmail.com>
 <CAFA_24JW_oRXB+40M2wKtEDQeC5VYjTC0D9GLEm5oa5E_dGtSg@mail.gmail.com> <nycvar.QRO.7.76.6.1909121053070.47@tvgsbejvaqbjf.bet> <CAFA_24L5S1_AS1OzPYf50iXwEupi0Bus827-NWoUpka-avNo_w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-505128465-1568408638=:47"
X-Provags-ID: V03:K1:bVJQwQsgeXaey0UD+0IzkzwIYAq54WgehoIWtuEMI7LNkhkPHwI
 LS5BMKwLfoABB4Vj1fb05Q+vyTWnUjn6XHBDDl9w14o1vLthD2C/P6B265MMgn1JQbXFLK2
 uFJxhRUGYJTlw8Bt8+ho+o46F+4+OXSEnYIB67aC3yadoS9uv1PzbtPV599S/gZ8VsCPsIv
 XgQpxQKYSYXpWFr6qPkWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:71uqH5k2sDE=:rJR0hbppeKRVxcbVSUjOXY
 bbvfDjdfcdkdSLeHUoKdI7IN+iCk5Lfd8dWL3rExKxJw1k2u0r0bKhRz4EFhfoDvUexJ70nZV
 mK7NVLf4R0RaSant8/FJyRJRiCt2csPjxP1ZVPVqqTIFEoWitWmiT73HeZjJFcwGqlmvCDbJ+
 2CvszUNpDWh+xDBExVdsR9biPGm9y7gbAol6lEyQNhzcd8NLyYhU8L7VWeDbM+N9pPi02Cbst
 ZotYzG2V33pM/TWD0CdzO4aMdsrDynBENV0MWPiZRPVLFy9LQjrcf7zfH/mHH0/5ogOgXr9aj
 szcXMTpKm8DvFtyWgushFIFMOKz3D8TXs2cn53FrRNG5D6wEaXjtoi122uRD7sBP4wXo1JHlW
 u0lb/vmTpWcT7U2OpyYHypXmL3zjBYyaowg8O0S+96ngTqo1tv9K2TCcIww80m9H+rBbSn+8o
 pkhNjOo+PUyFmRnKPogo3o0SI9PtgQl4DOXL+uNe7MrCLnKs2dQtUsn8xZdPjIrXFrGyeLIxR
 k8Us+W+Ng36EhN63okp1A6Y1BpXZVzeNAT0sSKHYbzBggYmZ4/Z2CtamvPfH58HIABd4KcH4k
 wbajdap+x/ZnpZijc0Wl1/3YswnDdJuc05+ubU3VQFy4d7bbMcWgElA8Om4OsQea6sv+DXIgH
 IF6IPOUTjPDxH8pHtPKdUejnoODts8kvCy6NY79Ces2GmL36m3g4wrt0n0C8YuIR5dDpVfQzf
 0IvAUs3UE+afQ9mrKIEMJJiZFljUwjhtDa4dLTuuACAQRoML2aVoGFfldITWq5vladB4fiIu6
 TTBO5WqPIMLsS/YtaFdZYF+qGTCAEGKdrwNh1hf9aFDtAeAbkvSU4Dq6sXnZc86hLmaAA1yEk
 wDcWJOS7oplK971864mqBlNaUGayqrcBGPktAjxxhuBKrPugNYWNwoEmbwO2eEBAg1bDVoNpA
 FfWR1+VFqIPQIeBWCgTCbkIafpZQZoy8NBpe4FTDFz8AhVcRFkI3BUeBbsnunoi7eLGdZKOYM
 vUVJ+SUJUiVC2dv87PumzXLMOFxnI8y2RBsQ8I2SM4LAuDh1JU1IQF0rVNZ0id+CBvQexeZY3
 Qb6kUefR5PiuX0peas+9ODM5xg7oRTv0obQeTbmcnO8S3yOL6XBWQVdqomAMLd7K6qfm+dt1S
 BtotZugApTDvJG6oLw8Oyl6Cx445WBxs5mguNXIC4zBMYa99sU4t2OEOsE8Gi20C1Y3r4vqA1
 zJiCjBJmoD9pMj0y3TrHGDWZagqpUJqj9q/5i3P4likDk8AcrqPDkLHRfQck=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-505128465-1568408638=:47
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Max,

[your reply did not make it to the Git mailing list because it drops
anything with an HTML part]

On Thu, 12 Sep 2019, Max Rothman wrote:

> Great! What=E2=80=99s the path for getting this merged?

Usually it will be picked up into the `pu` branch first, then advance to
`next`, and then to `master`. Once it is in `master`, it will be part of
the then-next official version ending in `.0`.

You can also read about the state of your patch (once it has been picked
up) in the bi-weekly "What's cooking" mails. If you're not subscribed,
you can look at the current version on the web:
https://github.com/git/git/blob/todo/whats-cooking.txt

Ciao,
Johannes

>
> On Thu, Sep 12, 2019 at 4:54 AM Johannes Schindelin <
> Johannes.Schindelin@gmx.de> wrote:
>
> > Hi Max,
> >
> > The patch looks good to me!
> >
> > Thanks,
> > Johannes
> >
> > On Wed, 11 Sep 2019, Max Rothman wrote:
> >
> > > On Thu, Aug 1, 2019 at 8:54 PM Max Rothman <max.r.rothman@gmail.com>
> > wrote:
> > > >
> > > > On Thu, Aug 1, 2019 at 8:50 PM Max Rothman <max.r.rothman@gmail.co=
m>
> > wrote:
> > > > >
> > > > > The bash completion script knows some options to "git log" and
> > > > > "git show" only in the positive form, (e.g. "--abbrev-commit"), =
but
> > not
> > > > > in their negative form (e.g. "--no-abbrev-commit"). Add them.
> > > > >
> > > > > Also, the bash completion script is missing some other options t=
o
> > > > > "git diff", and "git show" (and thus, all other commands that ta=
ke
> > > > > "git diff"'s options). Add them. Of note, since "--indent-heuris=
tic"
> > is
> > > > > no longer experimental, add that too.
> > > > >
> > > > > Signed-off-by: Max Rothman <max.r.rothman@gmail.com>
> > > > > ---
> > > > >  contrib/completion/git-completion.bash | 18 ++++++++++++++----
> > > > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/contrib/completion/git-completion.bash
> > b/contrib/completion/git-completion.bash
> > > > > index 9f71bcde967bc..b6d18710135ec 100644
> > > > > --- a/contrib/completion/git-completion.bash
> > > > > +++ b/contrib/completion/git-completion.bash
> > > > > @@ -1474,6 +1474,8 @@ __git_diff_common_options=3D"--stat --nums=
tat
> > --shortstat --summary
> > > > >                         --dirstat-by-file=3D --cumulative
> > > > >                         --diff-algorithm=3D
> > > > >                         --submodule --submodule=3D --ignore-subm=
odules
> > > > > +                       --indent-heuristic --no-indent-heuristic
> > > > > +                       --textconv --no-textconv
> > > > >  "
> > > > >
> > > > >  _git_diff ()
> > > > > @@ -1782,6 +1784,10 @@ _git_log ()
> > > > >                 __gitcomp "$__git_diff_submodule_formats" ""
> > "${cur##--submodule=3D}"
> > > > >                 return
> > > > >                 ;;
> > > > > +       --no-walk=3D*)
> > > > > +               __gitcomp "sorted unsorted" "" "${cur##--no-walk=
=3D}"
> > > > > +               return
> > > > > +               ;;
> > > > >         --*)
> > > > >                 __gitcomp "
> > > > >                         $__git_log_common_options
> > > > > @@ -1789,16 +1795,19 @@ _git_log ()
> > > > >                         $__git_log_gitk_options
> > > > >                         --root --topo-order --date-order --rever=
se
> > > > >                         --follow --full-diff
> > > > > -                       --abbrev-commit --abbrev=3D
> > > > > +                       --abbrev-commit --no-abbrev-commit --abb=
rev=3D
> > > > >                         --relative-date --date=3D
> > > > >                         --pretty=3D --format=3D --oneline
> > > > >                         --show-signature
> > > > >                         --cherry-mark
> > > > >                         --cherry-pick
> > > > >                         --graph
> > > > > -                       --decorate --decorate=3D
> > > > > +                       --decorate --decorate=3D --no-decorate
> > > > >                         --walk-reflogs
> > > > > +                       --no-walk --no-walk=3D --do-walk
> > > > >                         --parents --children
> > > > > +                       --expand-tabs --expand-tabs=3D --no-expa=
nd-tabs
> > > > > +                       --patch
> > > > >                         $merge
> > > > >                         $__git_diff_common_options
> > > > >                         --pickaxe-all --pickaxe-regex
> > > > > @@ -2525,8 +2534,9 @@ _git_show ()
> > > > >                 return
> > > > >                 ;;
> > > > >         --*)
> > > > > -               __gitcomp "--pretty=3D --format=3D --abbrev-comm=
it
> > --oneline
> > > > > -                       --show-signature
> > > > > +               __gitcomp "--pretty=3D --format=3D --abbrev-comm=
it
> > --no-abbrev-commit
> > > > > +                       --oneline --show-signature --patch
> > > > > +                       --expand-tabs --expand-tabs=3D --no-expa=
nd-tabs
> > > > >                         $__git_diff_common_options
> > > > >                         "
> > > > >                 return
> > > > >
> > > > > --
> > > > > https://github.com/git/git/pull/426
> > > > >
> > >
> >
>

--8323328-505128465-1568408638=:47--
