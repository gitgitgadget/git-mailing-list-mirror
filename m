Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83F761F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeCIRJU (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:09:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:40869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbeCIRJO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:09:14 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ltr89-1eVDJX1rwD-011BfE; Fri, 09
 Mar 2018 18:09:06 +0100
Date:   Fri, 9 Mar 2018 18:09:07 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <xmqqfu5bx9zd.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803091759250.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com> <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org> <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net> <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com> <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net> <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqzi3k23fu.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803070804440.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <xmqqh8pr21f3.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803080801230.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqfu5bx9zd.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KrLoqlIX1s9G84mJrSokoKe1eHKG6kIAih585fOdEj5+/kwMH3f
 dNn8a0DzKSsD/oPh56O/AFSouEiTT5YQOnD89PlN9ExaUJdGSEoBNuA5iFZ5cvo5PDuctYp
 m1UlWwU8FKIRuJPErxfIE1ek0Iq36LqElJiUW5sV1RRnBM760Ywt39pxa7w/ke2wNJY3Gx+
 cdGjrUvvYi97iOFf9LEWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UDyb5529Yfs=:k3+GSA5/0OZHN+VA7NriYY
 FquXTqiMc9a1a1mkqVjcNzw6GFX3WYEEP3MfuMVLk42Nt8ObMze5UKlTOmYysaztbY+ljEzQz
 5hmnUhlk1oJFC3v74k2Jdkmh9pgEzJ18fclRJqdPs6IRRXoOYzSWfVz2dIUYB2jQX/HWpSS35
 8R3lMXCibGeF80diiGpnTLlYQ+s5KF9xt2GKM8UYZFW1pfNgrM7V13LWFkZb+QCb7ICqFOLRs
 yieyp8JsSxUkJ5QlSq3AdHXAlbJblPBDO1RDqOY5goRAJ3YjRxF/7obGJqjOIflV90GRK/Ru9
 Ko+hFVPuxKA2cR0Idr7DcUgZ2Vln9PaHJLgf2/6Z9azlzrZGn2nejuhKkyB1SYyZjypmkl4pf
 3XAILl+iYYdjtHENv4H/AbkcNOybvaO5/OgoMDK4NxA3OQ4U6Fe0XqCxZcgOn201xO5OJgpyy
 +z/mi4fWfrc7s2ZyayNvnoBrcDuhU9+256/2rOp2UXu7k0gLmIceLAD5uzcs+GBpfEz7DR/qk
 yeVawDqZlIN0/aHt+qIMeFNQVskblUveBw/60x0rQguU4y1XDEY7rWQ0DZ44FANxnjg0bqg+U
 Tl92ebEXlZmNXJgql24eLJXopUo6L9+6fbxxnl33a7sZLGedpdRbjv0eOxAPN0CRVS0FlnhZT
 4IF/vUAMeJYx2cZNaMCLevD1SqaiitAexOeM/NKWubfw/SsZYFpzh8mbIS26VYH2s4yvEA5FM
 Vphb/GmJSR7xWSCyweR0dkostxu/wMiAGmH8FvdxfYeKFXrkjLoe3gD8b9lstPiSmuSRHmnpR
 6pN2WU6sBWsaQoQZFkT4fDFhcJBIoYErYfsRDUNSpALh3svsHD6r+osojXk8UFfItotUVgt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 8 Mar 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> If we are talking about a drastic change, a few more days may not be
> >> sufficient, but we are not in a hurry, as this already sounds like a
> >> 2.18 material anyway.
> >
> > It is not at all a drastic change. It will actually make the current patch
> > series better (simplifying the "can we fast-forward?" check).
> >
> > I just want to make sure that I already have Phillip's strategy working,
> > but it will be yet another topic branch on top of the topic branch that
> > will add support for octopus merges *after* the current --recreate-merges
> > topic branch ;-)
> 
> Oh, if the "not redoing the merge afresh, but attempt to reuse the
> previous merge" that was discussed is going to be done as an
> update/addition to the "redo the merge afresh" you already had in
> production forever (and I had in 'pu' for quite a while in various
> polished-ness during iteration), then I do prefer merging down what
> has already proven to be 'next' worthy without waiting for the
> discussion and your local verification of Phillip's new thing,
> especially given that you'll be giving an explicit control to the
> users which variant of "merge" insn will be used and the addition
> of the Phillip's thing won't be a backward-compatibility issue when
> it comes later.

I would like to stress that the `--recreate-merges` functionality has
*not* beed in production forever. It is a reimplementation in pure C of
the Unix shell script that has been in production for five years
(unchanged only for the last half year, the last critical fix happened in
January last year).

So I do see the value here to use `next` as test bed, and once the patch
series will hit `next`, I will also merge it into Git for Windows (as an
EXPERIMENTAL feature).

As such, I am quite comfortable with refactoring a bit here and there, for
example how to handle the case where a `merge` can be fast-forwarded.

I think the changes I made in the last few days were an actual improvement
to readability, even if the only reason for those changes was that I
wanted to accommodate the "rebase merge commits" thing.

FWIW I am fine with bumping this down to 2.18. I got a little bit of
valuable feedback at GitMerge, e.g. that --recreate-merges does not (yet)
have a mode where it can update refs corresponding to the rebased commits.
(This could actually turn out to be independent of --recreate-merges,
even).

I already pushed out the updated branch, and it can be inspected at

	https://github.com/git/git/pull/447

The reason I did not send this out yet is that I want to give it a final
look-over myself, so that I do not waste people's time again (as I did
with that monster interdiff that was pretty bogus, too).

Ciao,
Dscho
