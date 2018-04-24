Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9907F1F404
	for <e@80x24.org>; Tue, 24 Apr 2018 09:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753084AbeDXJEO (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 05:04:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:48757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753257AbeDXJEH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 05:04:07 -0400
Received: from [10.49.234.97] ([95.208.59.141]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LvVYZ-1eSNwe3aYl-010ctP; Tue, 24
 Apr 2018 11:03:48 +0200
Date:   Tue, 24 Apr 2018 11:03:45 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Philip Oakley <philipoakley@iee.org>,
        Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v8 09/16] rebase: introduce the --rebase-merges option
In-Reply-To: <xmqq1sf56vvb.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804241042400.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de> <0c92bdd1829328544269722cbbd3edcd169bb148.1524306547.git.johannes.schindelin@gmx.de> <E8BADD438B3F4D20B33BCC2CD92BC004@PhilipOakley>
 <xmqq1sf56vvb.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aOrrk+AnfoOi3k8tQCLMQq8RD/L3WUGNgsMXk44N3Q9jQDctKM3
 /5deqzrBEnYcY+4n67aXsq+3W0ciXXmECjzlOBklYek1je6M97bmfnV2zPWKmQlRMlovPLS
 slCoS3uiAZ/617R4Q8ePKk+1Ne+SNXTEjous3Sdm9qJAr7+qzNHu9y6S5H07ttTrxH+6b6U
 1RG/nwo0+0/jDti3Ddvew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uOOYzLNEDXs=:KbpIT3boaqO0yy5mFlPG/8
 GQZ2Bf1Sh6TKJZXLCgupWy50DJ3SKsAanSwkxVDbji8NzjfxkQlQIntrVyZUtXUfxR7XE5IgH
 n/LtyPuxeG9DTRIXk694LCQNugmYPwlBobhGbjSafgQxphueg08krNTsxWL7y+Q/orBh+Emsn
 6qIPLHhiH78Up7mwKfeU6V7CAQYM97gvGYDR+JYhiZDxmzFwhv8/I5E3ob6cwWFU6+ha9XUd4
 MPeCFItmlJXOj+KN7Q3RmV3eYphYmqGqbRmuaJcWme/UO7i04NXDPX5rS5l5G9i3lnhmQe34A
 CHa4nH3sRxtGDhC4RzPf/1AWiDfTZh6tfwgE7hYKhJu3UmBcUnKCQLIV67K2anfBcsCRTSR1u
 dhKP3xc3EZH0zajWvyWvirFFjAOkJZLYX1THcRPQrjU8d8KzJXjKsv+oyXmlbk5JDqhIMPZEE
 dMfgw7Hu/wYn98p7DimIMHWXgCq+pZ/YAlHiMDzqoWVEmaYZutHu85S8Xk+8JIMcePSrkrTkz
 5iuz0mvgwcHfSlo9eFqByh1yWlSPAR0UALOkUX+YzT3E6wvFdMaTPLqCyXRd6HcHMy4im3HXO
 +4DXK2xVYGpXW283OaxITl9jRwxy+Gxv2lsy6wCclmfzpNlPMB1pdgUPeuAj2lcbhERw7Uc2+
 qSMOlDzfqalbpiyezmwTXiRZtqygHQp3yqkkUsVhffiENMt4oogoPehwuwWepWr9nbqAcy8CH
 e4lH48nzdHyjJnH5iXRrqxo5Li5LnLy3hw7SKZg83TPe8ZiaMGDpu8X/q+BSGmoE+kI8ow77g
 9hXMn0Jrba6FMvrLhvHiIi4PCi+avkjJg1lEcI7t0nTzIDrGXw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 24 Apr 2018, Junio C Hamano wrote:

> "Philip Oakley" <philipoakley@iee.org> writes:
> 
> >> +-r::
> >> +--rebase-merges::
> >> + By default, a rebase will simply drop merge commits and only rebase
> >> + the non-merge commits. With this option, it will try to preserve
> >> + the branching structure within the commits that are to be rebased,
> >> + by recreating the merge commits. If a merge commit resolved any merge

It is funny how nobody caught the missing "conflicts" in "If a merge
commit resolved any merge [conflicts]"...

> >> + or contained manual amendments, then they will have to be re-applied
> >> + manually.
> >> ++
> >> +This mode is similar in spirit to `--preserve-merges`, but in contrast to
> >> +that option works well in interactive rebases: commits can be reordered,
> >> +inserted and dropped at will.
> >> ++
> >> +It is currently only possible to recreate the merge commits using the
> >> +`recursive` merge strategy; Different merge strategies can be used only
> >> via
> >> +explicit `exec git merge -s <strategy> [...]` commands.
> >> +
> >> -p::
> >> --preserve-merges::
> >>  Recreate merge commits instead of flattening the history by replaying
> >
> > Flatten is here in the context lines but its just a blunt statement that 'it
> > is what it is'...
> 
> The first paragraph that explains --rebase-merges talks about what
> happens when the option is not given, and says "drop merge commits
> and only rebase the non-merge commits", which is not incorrect
> per-se but does not make it explicit how the resulting topology
> looks like.

Correct. And it would be the wrong place to describe in detail what a
rebase *without --rebase-merges* does, right?

> I think it is easier to understand if it mentioned "flattening" as well.
> If flatten is not the word you want, perhaps "make it linear" or
> something like that?

I fear that we all here are way too deeply in "Git think". If I ask a
random Git user what it means to "make commits linear", I am sure I would
get only puzzled, nervous looks as a response.

So I am rather certain that the suggested wording is something I want to
avoid.

Besides, we really should expect the reader to know a little about the way
the interactive rebase works by the time they read the explanation of
`--rebase-merges`.

Therefore, I think I can sidestep the entire thing by saying this instead:

-r::
--rebase-merges::
        By default, a rebase will simply drop merge commits from the todo
        list, and put the rebased commits into a single, linear branch.
        With `--rebase-merges`, the rebase will instead try to preserve
        the branching structure within the commits that are to be rebased,
        by recreating the merge commits. Any resolved merge conflicts or
        manual amendments in these merge commits will have to be
        resolved/re-applied manually.

Thank you for helping me improve the documentation part of this patch,
which I think is really, really important,
Dscho
