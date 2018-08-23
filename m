Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 180421F404
	for <e@80x24.org>; Thu, 23 Aug 2018 21:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeHXAkZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:40:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:39725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbeHXAkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:40:25 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MH07e-1ffBCn0HvW-00DqJh; Thu, 23
 Aug 2018 23:08:47 +0200
Date:   Thu, 23 Aug 2018 23:08:45 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v6 18/20] rebase--interactive2: rewrite the submodes
 of interactive rebase in C
In-Reply-To: <xmqqzhxeks2g.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808232306010.73@tvgsbejvaqbjf.bet>
References: <20180731180003.5421-1-alban.gruin@gmail.com> <20180810165147.4779-1-alban.gruin@gmail.com> <20180810165147.4779-19-alban.gruin@gmail.com> <nycvar.QRO.7.76.6.1808222310220.73@tvgsbejvaqbjf.bet> <xmqqzhxeks2g.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pFdlJcuXCSvKULcf0vCAu+G/JMoGsrCo/GX9sP13qf+USSgc08n
 qa6RXPsr0zzfZ943bGTCpSKqaqkxZDs+jSWjM7KJ8Y+F5OWei7IVLEwWdpJ4cDRTV6AUftt
 Jf0b7H37IkS0B2t/8NrmnAMcD4h8JcJWGwpczQJ+SSPVLyfn/NkhERbC/Iz4OyzzLTRCjbW
 QGTfrgWbah1jgq7/aeDEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9CKzXlY9SmY=:i+n5bKfHp67b+ChH2BDvqg
 OI6UXjThFNQJqm4V9G31mIiITRCpNc6rxszoS13I3sj5YKYXisac1lwxRWvA1mzIdWmGhX5RK
 pym5K3KihkC5YUy4vYmxKvnkSdJg4zNGezO6ErQopAvMatEfwGCRQAccU+vz/ORJkryTOYaL6
 ioyFAB12muWMyB+vLP+quaHNjp0IxGiGWM9Jqnv/UunFJrwR0vegFDHvuT50XDs4871+xN3Db
 fnWQeqxGS5PMaYSHiFWHVXjvIefMbXlzD5LDwyxvUas47HmA10deWdygUtAnAQY4Ly13c0tGF
 UIrbrZ24aoAqCRK1JuKGYQFzySu0z+ZjCinNZXisnoDgjH+yyHXj+MElLJQVrphXmMHW3KRKe
 BX91cKHj20F+KxzmbtsF/rLdU191QlVeZRGMX03U4mqwquaN6w56tuCIka+8XUiHu02JTdgqZ
 Fd/bM6SToCRw5FSPak8smuyN4tk4o5QzeExB3dMLqFOGgpT5K5sb8BslkQur2Nq9VOKpIxSst
 WvMp+CgdA5N6/ipUPOc68DOGy0MrvCDZGTvdxylIYb6enJpUJKyaXmoXB2HhKTqmpnYAudTbN
 qphB33TIRyIBuo+Pdl1dUxAYT+dAQYPFglhtC9G27AKECo1A5/jh3YQrL/2kXc7s43pCHXSNe
 yRo+dgXOHMpQpdtNr5FNFYtmQUKUwriLI5s111GF/0TvNymPzrE9fmLZW1aLMuZyldK9AJ6NE
 APZj+5DtNPUn6xVVGP3N4vWOXyZOZ6OWY033OmMs2bI28TdcvLdOVTeFui9Bk5CjbPqcUkBJh
 TjvCRRY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 22 Aug 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I made this same mistake over and over again, myself. For some reason,
> > John Keeping decided to use the singular form "revision" in 1e0dacdbdb75
> > (rebase: omit patch-identical commits with --fork-point, 2014-07-16), not
> > the plural.
> 
> Perhaps we should give a synonym to the option?  Renaming it to the
> plural form may keep the existing usage working as it would be the
> unique abbreviation, which may be a way to reduce the mistake.

The obvious plan is to switch from spawning a separate process after
parsing the `git rebase` options just to execute the interactive rebase to
performing both parts in the same process.

In other words: this option will simply go away.

I'd much rather spend time and effort on designing a nice API for calling
the rebase backends in-process than on adding code that adds some plural
form (which might not even be appropriate, given that you really can only
pass one single negative revision to restrict the commit range).

Ciao,
Dscho

> 
> >
> > So you will need to squash this in:
> >
> > -- snipsnap --
> > diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
> > index fb0395af5b1..7600765f541 100755
> > --- a/git-legacy-rebase.sh
> > +++ b/git-legacy-rebase.sh
> > @@ -145,8 +145,8 @@ run_interactive () {
> >  	test -n "$autosquash" && autosquash="--autosquash"
> >  	test -n "$verbose" && verbose="--verbose"
> >  	test -n "$force_rebase" && force_rebase="--no-ff"
> > -	test -n "$restrict_revisions" && \
> > -		restrict_revisions="--restrict-revisions=^$restrict_revisions"
> > +	test -n "$restrict_revision" && \
> > +		restrict_revision="--restrict-revision=^$restrict_revision"
> >  	test -n "$upstream" && upstream="--upstream=$upstream"
> >  	test -n "$onto" && onto="--onto=$onto"
> >  	test -n "$squash_onto" && squash_onto="--squash-onto=$squash_onto"
> 
