Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B311F428
	for <e@80x24.org>; Sun, 29 Apr 2018 12:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbeD2Mek (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 08:34:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:53309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752895AbeD2Meh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 08:34:37 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOBOi-1fG3Jt0wTc-005XPM; Sun, 29
 Apr 2018 14:34:33 +0200
Date:   Sun, 29 Apr 2018 14:34:11 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Wink Saville <wink@saville.com>
Subject: Re: [PATCH 3/6] rebase -i --root: let the sequencer handle even the
 initial part
In-Reply-To: <CAGZ79kYi5W+m9TQ_iEwPmEaXQ_tvpRjcycGioY5jThtfGM6mYw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804291433520.79@tvgsbejvaqbjf.bet>
References: <cover.1524868165.git.johannes.schindelin@gmx.de> <1c8740eaa916351832cbea4cf75b77e5dc965db8.1524868165.git.johannes.schindelin@gmx.de> <CAGZ79kYi5W+m9TQ_iEwPmEaXQ_tvpRjcycGioY5jThtfGM6mYw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ushl53TCTqv0qE8IBV6bsymxm3yFkQEPBHMFEJYo5+gnPAw8TX/
 GqgYaaU1UMmZLw9dENhsHf+5NoCa5lAifnHIB4AU+hzBwxlHEZr/DH904T2mxJopb+kaGwt
 JsTFBUWv9+UMZu3gsxvtJ311ZPfOidkOjhPxg4vYo/KksPD1iknHtRc8z9/TyfpFbX8vLTD
 K3TTks+3SV9QbP6UsFn6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ucY51sCiBa8=:1zZofIPKCdWmsm6HHlh65U
 GC/f5JST5uFOObsG/DlPV5hsZ6NBR2uSPaBPPXOJIaqjqY4ZqDFakwensU7K+116yio33Z3As
 1q7Lm801Jhb/E6NlFxo+aptF5KHRKMS1qQT8I232pVvELwPiScSMoD9EVOf/ro/p5qknTrDBu
 RRH3ETV2rlTqlX5/zENFX429/jh1k2nLb/hs7UIIBzy76oZpgz3b0Xvb/wKLw+KLqGKvIg+Wc
 5kucrBBNbRzpAkv0OgCXnDxX3dvAtrb6D2DrBUh9yRknFIoCyW5pLbpYWlCLyGUn52vhdf51L
 FGxfMr6Y8qnO8lfn1hgk4r0mVVRLNXKYeStD7Kb/ly6+mLu5gG/w0JajAmQpg9+wSA+r239/M
 9EaC8fXvd6NrdmpnsHcLgODXwbc3jD7ZkcRiJfia+RImgs4qILccBBkqjZ30alkELn9LG5dUe
 p/R45VNiIf4kaLgFvOp4XKCym0YyB/LIcdo8JUtMbB+32gCyQrVJb5yJqerLDcBOX8I9MwEVm
 rNyf2AEtT30aHumBAqTuYxalZaP4j/ExsFlImWwOAsrpk6yitfC3MgaLRa6x1nCQ8Dd9OrjPf
 3RONFXkdsCTny5c6hTDQRKpulb7lYJ8zqZpYZ2jUiUufL+9L3+kFw5dqJnAcvOHDIPK1lhwT/
 hsrAY7UIOTdcA116p2YCJb/38pzMwB7Uemgohuc6nVI5qwWNv+qtjaZhHOfdJtj822NNMM98i
 kcemnXraAmAFlXAGLi2aleJTHJqw6EZ2AOAm19d+8/knOQE6TupB+BGzD5iB0xtCp7SMplOzk
 tFG48hC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Sat, 28 Apr 2018, Stefan Beller wrote:

> On Fri, Apr 27, 2018 at 3:31 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > In this developer's earlier attempt to accelerate interactive rebases by
> > converting large parts from Unix shell script into portable, performant
> > C, the --root handling was specifically excluded (to simplify the task a
> > little bit; it still took over a year to get that reduced set of patches
> > into Git proper).
> >
> > This patch ties up that loose end: now only --preserve-merges uses the
> > slow Unix shell script implementation to perform the interactive rebase.
> >
> > As the rebase--helper reports progress to stderr (unlike the scripted
> > interactive rebase, which reports it to stdout, of all places), we have
> > to adjust a couple of tests that did not expect that for `git rebase -i
> > --root`.
> >
> > This patch fixes -- at long last! -- the really old bug reported in
> > 6a6bc5bdc4d (add tests for rebasing root, 2013-06-06) that rebasing with
> > --root *always* rewrote the root commit, even if there were no changes.
> >
> > The bug still persists in --preserve-merges mode, of course, but that
> > mode will be deprecated as soon as the new --rebase-merges mode
> > stabilizes, anyway.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  git-rebase--interactive.sh        |  4 +++-
> >  t/t3404-rebase-interactive.sh     | 19 +++++++++++++------
> >  t/t3421-rebase-topology-linear.sh |  6 +++---
> >  3 files changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index cbf44f86482..2f4941d0fc9 100644
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -894,6 +894,8 @@ init_revisions_and_shortrevisions () {
> >         else
> >                 revisions=$onto...$orig_head
> >                 shortrevisions=$shorthead
> > +               test -z "$squash_onto" ||
> > +               echo "$squash_onto" >"$state_dir"/squash-onto
> >         fi
> >  }
> >
> > @@ -948,7 +950,7 @@ EOF
> >         die "Could not skip unnecessary pick commands"
> >
> >         checkout_onto
> > -       if test -z "$rebase_root" && test ! -d "$rewritten"
> > +       if test ! -d "$rewritten"
> 
> I have the impression this is the line that is really well
> explained in the commit message ("migrate to rebase
> helper even when there is $rebase_root set")
> 
> The rest of the patch is covered as "a couple of places
> where we adjust stdout to stderr"?

Correct.

Thanks for reviewing!
Dscho
