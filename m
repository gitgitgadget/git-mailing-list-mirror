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
	by dcvr.yhbt.net (Postfix) with ESMTP id 00FC21F463
	for <e@80x24.org>; Thu, 12 Sep 2019 08:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfILIyk (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 04:54:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:54367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730268AbfILIyj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 04:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568278472;
        bh=NcW8eIjsSlEhJU8SpUZK055A+GdcJ8Q/ks3SIlTbh98=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W1k3FbU/XyU1MmFno4fuzB2c90k5DEecYkH8TGZB0oGNNEXkfEqwPyVJ5ZUgY71ZS
         n2dGQIrTjkAg/rsVQIji+C4PjLbqtG15fPx3+Ho04pCclNFOkv8RvWKF+DQJFXrFF7
         REiMQrAIKb8UeMgSd6HjWh48CJ2qhMlLoLmp/KXs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiacH-1ie6al1Xbb-00fmFC; Thu, 12
 Sep 2019 10:54:32 +0200
Date:   Thu, 12 Sep 2019 10:54:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Max Rothman <max.r.rothman@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: add missing completions for log, diff,
 show
In-Reply-To: <CAFA_24JW_oRXB+40M2wKtEDQeC5VYjTC0D9GLEm5oa5E_dGtSg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909121053070.47@tvgsbejvaqbjf.bet>
References: <0102015f985d387e-f50183c4-4b49-4a9f-b365-2a86ba24bbed-000000@eu-west-1.amazonses.com> <0102016bb065bf5e-005b0752-2594-45d5-a01a-12d0c5e24b70-000000@eu-west-1.amazonses.com> <CAFA_24J8Ry5LhRX5O82eJDtrqjEodDFTEniZNw06fKEWvwvYMA@mail.gmail.com>
 <CAFA_24JW_oRXB+40M2wKtEDQeC5VYjTC0D9GLEm5oa5E_dGtSg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xglikgC9761frkOMAZzyO5uRJn+pYgqSxRNvSwlm1tcL6pjkrIX
 zrXCwf6izRLsN1XJhWBx5kdqB0Ua49SniLO8ZcJ15YC9FiI0HNBvon5QYUWDGDgCuI+wvEb
 LxDcTCJ9AVOBzubJ2fhDrav9pv5X0ew1lxloZHZmzIswJ3KPBXXRsMKcoHyefDRFdt4a72r
 QfIK79pGk58woGwMiDm0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AllltqRrIN0=:l8v/haKrc31xVj1hTDLctg
 LIcmljXTKqWI1w05l/iQ0ONVVT8ac6wBXXA/6e6c/f265WwONE2KuPtp7c2KoSJuDHEDSuiYE
 b1CuVY99mF/xQmaOAxIcx0v1TzD28JVKhdrkVKRQYaWbJkKSOwMOyrWzAXqpK8LCCtymOCCf9
 nGgd61eS6uAUGR8gP1LPpF0rk8+JVyIHP2m0dN2PxoCBjMXkYd2axNlVI656/rHp5JeAVdV2a
 J8rVAnPYkllztBELxH0BDcwt1jWtUjCvXhYFq/by8B/bYjdwy0HMPAaQls05fiqvtHMNaLIDw
 w/nuTu8iNHgxdDzS0pl0srE1DptytzPxb6M4+X0oggSbyvfd4VTMSQJbNOcWILMjfs0SPH72J
 gYV2fnBvpylZVJ9SmUgdQMWFzwmehUrZQikPv7ALAE4xJH695mRWqmGpurHusMt0P2bPScv73
 1VQ0Qk4QaSTTQ/lJoZpptwyGKO9yXYSQZYoNbk9IcjbJcBE4dMQjxfn27TE4eAhTopwDsEvCP
 G25iuefKDgkWBcDIE9SKdVxg4WhIsPRJhDhMF6xzwfNHXjfxMfzTtvV3+BBIOsMGh4xriZPHU
 Z4DiQeR2TJddAjwpY1lo7muPCrd5IIfcqGXrKq/yjmDjXWxY++XHw79iSdn8Hvlyfv7+vls7s
 3F6XphaZlukbq9+8fFE7EYn3Xgy6kXX8Y1ouPnxEJL++9QvgMJeJ6qVSRrgq3G/HT5dKL/XEI
 UmE9pesI4FY86jqA7TNxTdOid/W4TgNj1xFQx0/giMW+MXYP6LraDFUuS8gz8fMBm0caJr3BN
 YE5NZGnlpg5ViKxEPeAHUZpu+5q1iGsNvxl8N7dyMWuczXCycB+kojaNckyvEgyjjytRmbVhQ
 A7D22hsvuHenHJaEgeBji06a0DbGqoy56uFrfVnBE2mmcRyOfgp6U3JFP9lvpdzII/uAoRfPZ
 v6dQsmgGzvLDFz47aG7IeJ5fq1uU0J4xnhWdsXqnmKb85h9smyui6MQy9cce0fwDVkLziMI7o
 DGjDWBSV5pNM2JkYpttmoJO2TcY5mFJVZAzf1i1eTVd3BPaUZPRFl2Wv3XiNfTY8KW5s7rCts
 pAZZarRHbtJ/vuZwpvrgkNERIGBS8QxxQBoItrKc1KQT045iAqWEuAdqEwlP+Pn9j/n/3grOz
 PIdRcD3tUR2EmhS0igP9lq4NAhsTjyzaNpUG0+RIMqpOy1ImGQPxItbOqt2u1VJGJgmYu5S3y
 4cBqAkIYFkH1W1Uap
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Max,

The patch looks good to me!

Thanks,
Johannes

On Wed, 11 Sep 2019, Max Rothman wrote:

> On Thu, Aug 1, 2019 at 8:54 PM Max Rothman <max.r.rothman@gmail.com> wro=
te:
> >
> > On Thu, Aug 1, 2019 at 8:50 PM Max Rothman <max.r.rothman@gmail.com> w=
rote:
> > >
> > > The bash completion script knows some options to "git log" and
> > > "git show" only in the positive form, (e.g. "--abbrev-commit"), but =
not
> > > in their negative form (e.g. "--no-abbrev-commit"). Add them.
> > >
> > > Also, the bash completion script is missing some other options to
> > > "git diff", and "git show" (and thus, all other commands that take
> > > "git diff"'s options). Add them. Of note, since "--indent-heuristic"=
 is
> > > no longer experimental, add that too.
> > >
> > > Signed-off-by: Max Rothman <max.r.rothman@gmail.com>
> > > ---
> > >  contrib/completion/git-completion.bash | 18 ++++++++++++++----
> > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
> > > index 9f71bcde967bc..b6d18710135ec 100644
> > > --- a/contrib/completion/git-completion.bash
> > > +++ b/contrib/completion/git-completion.bash
> > > @@ -1474,6 +1474,8 @@ __git_diff_common_options=3D"--stat --numstat =
--shortstat --summary
> > >                         --dirstat-by-file=3D --cumulative
> > >                         --diff-algorithm=3D
> > >                         --submodule --submodule=3D --ignore-submodul=
es
> > > +                       --indent-heuristic --no-indent-heuristic
> > > +                       --textconv --no-textconv
> > >  "
> > >
> > >  _git_diff ()
> > > @@ -1782,6 +1784,10 @@ _git_log ()
> > >                 __gitcomp "$__git_diff_submodule_formats" "" "${cur#=
#--submodule=3D}"
> > >                 return
> > >                 ;;
> > > +       --no-walk=3D*)
> > > +               __gitcomp "sorted unsorted" "" "${cur##--no-walk=3D}=
"
> > > +               return
> > > +               ;;
> > >         --*)
> > >                 __gitcomp "
> > >                         $__git_log_common_options
> > > @@ -1789,16 +1795,19 @@ _git_log ()
> > >                         $__git_log_gitk_options
> > >                         --root --topo-order --date-order --reverse
> > >                         --follow --full-diff
> > > -                       --abbrev-commit --abbrev=3D
> > > +                       --abbrev-commit --no-abbrev-commit --abbrev=
=3D
> > >                         --relative-date --date=3D
> > >                         --pretty=3D --format=3D --oneline
> > >                         --show-signature
> > >                         --cherry-mark
> > >                         --cherry-pick
> > >                         --graph
> > > -                       --decorate --decorate=3D
> > > +                       --decorate --decorate=3D --no-decorate
> > >                         --walk-reflogs
> > > +                       --no-walk --no-walk=3D --do-walk
> > >                         --parents --children
> > > +                       --expand-tabs --expand-tabs=3D --no-expand-t=
abs
> > > +                       --patch
> > >                         $merge
> > >                         $__git_diff_common_options
> > >                         --pickaxe-all --pickaxe-regex
> > > @@ -2525,8 +2534,9 @@ _git_show ()
> > >                 return
> > >                 ;;
> > >         --*)
> > > -               __gitcomp "--pretty=3D --format=3D --abbrev-commit -=
-oneline
> > > -                       --show-signature
> > > +               __gitcomp "--pretty=3D --format=3D --abbrev-commit -=
-no-abbrev-commit
> > > +                       --oneline --show-signature --patch
> > > +                       --expand-tabs --expand-tabs=3D --no-expand-t=
abs
> > >                         $__git_diff_common_options
> > >                         "
> > >                 return
> > >
> > > --
> > > https://github.com/git/git/pull/426
> > >
>
