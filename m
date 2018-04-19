Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1581F424
	for <e@80x24.org>; Thu, 19 Apr 2018 08:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeDSIOe (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 04:14:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:41381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750974AbeDSIOc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 04:14:32 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMkDH-1f4Ox21lpH-008dNI; Thu, 19
 Apr 2018 10:14:27 +0200
Date:   Thu, 19 Apr 2018 10:14:10 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Deprecate support for .git/info/grafts
In-Reply-To: <CAPig+cREYENM7Y8SqtG2ket9+oJ6w0OU1_Qa8f-+O_yDyH=Aww@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804190944470.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de> <CAPig+cREYENM7Y8SqtG2ket9+oJ6w0OU1_Qa8f-+O_yDyH=Aww@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hCOU9cgdM50jeU6rerFBfOmBkI5FKcrYR1fnL2Q6x7S+51fs3OF
 s2yU5zJh00M+ZKn9lsgVBKgD5DpKnIVXThOtPnt5ZLA4lcRq4RRpI6vE5pa/JRqnGbuvVlo
 0jJYf0Dg0JCWukb5N6a1IYrawRhsHXzQ6W4Jup5kNdfv+v5BHNeIA26Mok16PhGFnGADeCt
 vnxKBtadshYUMuBIhuegA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3oQ/0Jx7lFI=:A2YXgWNpPpi5vXIKYXNzEa
 qDrE2zkzAZKPCS4cxMnscGTpCO4PknAOEgMYyDOSbDIBOAD3x/XZT/H9O9A5vqvvEty64/4TK
 qh1uXrrKi96dXwCACFRd4VprNsI2ZXAs0Q7EMgzKuD/3dpUkiWbPsID0oCIQzRXfildQ2eshK
 AkydYhqATJwDr5uZS3IjQa3+MJDtcg2IWfbxV7xY0QkI4RuyXXLnhfKO4ciiSM516bCd2UxXn
 cSGH1mimgLbPnKYwZg598V7pa11KHTlbdBxtmL8q09ptDa1n+KbTjnSUrt+5udCemrXKKo8Fl
 CiU0W5purwykePZhQhQo45T2BctwE2ahmUQG4+QaVAf6n5YKy2qhiTGf3AsA/o1Qy5plridsF
 FUjiTSoRYzv9bLrqFAZlCmmI1Zydd+mlAF/k3b24tUySLU7068nQGvyp9NHZB/48Hze9TLCVN
 RvPx0nh/Kftt0Q1MsgKonJQJ/HYuhziWQehol7xRYL0Q7MD26i0d80c8QhYUTsNCnhFVEsizH
 6a6epvLT8uEX2iApDKMikFgpysLGioYAWXZtAkpzX9xFdOTTEx+z0bqcp8sRzVERyfEDQ7zaI
 46+gLzacWGvIehDPg70Vs9iStqRcoj2JTT5zCb0MttuS9xp/15ix1tyNpk0ZmLuB/FNUrs0th
 iFMCYsvKEsavRFhnKxLrNWybfH5sz/Gsb7dei46cjq6r/JEy3ucKO4VxMv/esWYInLUuTYcnb
 Sh82sYzl19JI9a/N2TAhVGeypx2vA4M8erzpLDrlAyALpAU916scaM9SvF8BReyOYQE6DzNTl
 iCZgbqRo7Bj1UGRYhbfk3lsh2KoRXiu4UQAxvVFwCcLTi1AG8U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 13 Apr 2018, Eric Sunshine wrote:

> On Fri, Apr 13, 2018 at 7:11 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > The grafts feature was a convenient way to "stich together" ancient
> > history to the fresh start of linux.git.
> > [...]
> > The much younger feature implemented as `git replace` set out to remedy
> > those limitations and dangerous bugs.
> >
> > Seeing as `git replace` is pretty mature by now, it is time to deprecate
> > support for the graft file, and to retire it eventually.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  advice.c                  | 2 ++
> >  advice.h                  | 1 +
> >  commit.c                  | 9 +++++++++
> >  t/t6001-rev-list-graft.sh | 9 +++++++++
> >  4 files changed, 21 insertions(+)
> 
> Perhaps, as part of this deprecation, the example in
> Documentation/git-filter-branch.txt should be updated to suggest
> git-replace instead of .git/info/grafts.

Good point!

> Maybe, also, Documentation/shallow.txt should talk about replace-refs
> rather than .git/info/grafts.

Sure. Internally, of course, "shallow" is still handled very much like the
graft file. In that sense, it is probably a good thing to keep referring
to the graft file in technical/shallow *in addition* to replace refs.

The reason why the graft file should be deprecated does not apply to
the shallow file at all, either: the entire set of problems with grafts
comes from the fact that you can *replace* the parents *with other
parents*. That allows for pushing corrupt history to public repositories
IIRC. The same problems do not arise with the shallow feature, where you
can *cut* history, but not replace it.

There is a notable difference between shallow commits and replace refs
which I did not think about earlier (it actually only came up in testing):
we currently disallow completely to replace merge commits when they
contain mergetags, i.e. entries in the commit header that record the hash
of the *tag* that was merged (if any). That includes the case where you
want to replace the commit with a root commit, as would be needed for
shallow commits.

However, there are more reasons not to conflate the shallow commits with
replaced commits: by nature, the "shallow" attribute is a lot more
volatile than the "replaced" one, as we want to keep it easy to deepen the
history (or to "unshallow" it).

Ciao,
Dscho
