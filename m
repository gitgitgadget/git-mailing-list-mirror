Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1B81FAE2
	for <e@80x24.org>; Thu, 15 Mar 2018 10:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbeCOKMC (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 06:12:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:43649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751488AbeCOKMA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 06:12:00 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lb5Tp-1eCfuR2xeT-00kdPr; Thu, 15
 Mar 2018 11:11:50 +0100
Date:   Thu, 15 Mar 2018 11:11:51 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] rebase: support --signoff with implicit rebase
In-Reply-To: <xmqqh8pizgxg.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803151110340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180314111127.14217-1-phillip.wood@talktalk.net> <xmqqh8pizgxg.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aW5wG8DTuKQenOHQpsMZjJ5T7qZi9WDjW39Ltgc22i3v+6OAiSz
 9P0aExjdU1gRROkNNb/kFuBaUrhjyCq2duVhBQdmzJ3zQiO4scsF+dPn4F5/b/D6IVT1muU
 5sAeNzTh/3GqI1ZVETqd184lRS7URFWPFJaVgvF4IShA/Xm9cWbuxMG5G5HkVGGCNHN3GXj
 ywzO7Hu2ICz2wPqCJ6cHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uIuO0ugESog=:dVCoSL/QEw36chUSVS3Jeh
 +0Xtz42IdrFGaQ+fgFtKIktdb0jRQz/NblxWDZNs3FaWjY6YzUsDM0WB4DRZc6j333mlfcVEG
 NuKS3yixuvBkgmMXvB3cVvk7pZ5ZXm2tCHOrDlNbIJCVng07ojPFp6GnbBR4oj38MfmgThVcz
 yLrIKOUo1DdKGjSc3m+WZjl3XquJJrFupQDbz+nSsxPKtZ/NKck+Tz5q7wmosCaWIO+Ah3AzX
 Dl+uw/EmK9hR+5uKEFgP1NJ9nqZ/XsdCB7+cshdco1tDOpXhBmpejlAyNGqIqjUx97XSeV8gB
 Rpe3UsoqJJTR8isgmbbQuS581qhV+n7wrphFAlcJ/ABwK/xK59z8iRtn7bYNdGrErbuD0xofb
 MIl7tCOBhzeneVIOUmQWJofgI1eEKDN6qclXpYbnHHOd93vAwgemAHRVil9onSYGIwMMWX4vm
 fBFnZ1ObXUTy5/GI78l1pzuHmkMLjn5Mz0FBbVIvmnB3x8yyhL/GJM1k+E6Khtnm3Hw2WuJyr
 Rx2UcHS9en502aOQcon1F0mZ9P9htxaz3Ri+tUGiSv7/ZOPmoNLqXZtXIWlrYuM1/V4zwJ7yC
 T6p1O/AhKx9NO0GHikTPT0z/PXF+IiZu3NQhzJkHRAv38frV95ukHH+FZe/wmPe7Ucik1z1ve
 NKjhh0x/bHtlAGoKVF9WOfMBVtiOYBDUP1v9Kap/cmjN7hAL60AA41LzUIMtH9v09u9RJWV93
 i3mDMJJ2y3GzFARoPlkVLUI90YKUTJeVOYCXOxgtTeQ4dDLdetmb2HXwmjLJg5w72n/5X43j/
 XVpfENdx1i+0kHddDcr9SOqz5EqKOhPgrpQbY8Jq+L678ehHXM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 14 Mar 2018, Junio C Hamano wrote:

> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > This allows one to run 'git rebase --exec "make check" --signoff'
> > which is useful when preparing a patch series for publication and is
> > more convenient than doing the signoff with another --exec command.
> > This change also allows --root without --onto to work with --signoff
> > as well (--root with --onto was already supported). Note that the
> > failing test is due to a bug in 'rebase --root' when the root commit
> > is empty which will be fixed in the next commit.
> >
> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > ---
> 
> How important is the word "implicit" in the title?  Is it your
> intention to actively ignore --signoff when we fall into the
> rebase--interactive codepath explicitly?

The patch makes the explicit case fail ;-)

> I offhand do not think of a strong reason why it is a bad idea to
> run "git rebase -i --signoff", turn a few "pick" to either "reword"
> or "edit", and then expect that the editor to edit log messages for
> these commits to add your sign-off when you start editing them.
> The "pick"s that are left as-is would also turn into doing an
> otherwise no-op "commit --amend -s", I guess.
> 
> If you are teaching --signoff to the whole of "rebase--interactive",
> then "git rebase --help" needs a bit of update.
> 
>     --signoff::
>             This flag is passed to 'git am' to sign off all the rebased
>             commits (see linkgit:git-am[1]). Incompatible with the
>             --interactive option.

Good point. I'd actually be in favor of having all rebase modes support
--signoff, but I do not want to pile onto Phillip's workload.

Ciao,
Dscho
