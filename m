Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C2D01F404
	for <e@80x24.org>; Thu,  8 Feb 2018 12:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbeBHMe3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 07:34:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:39062 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752317AbeBHMe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 07:34:26 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MfVYB-1eMLMu2rpz-00P6gs; Thu, 08 Feb 2018 13:34:19 +0100
Date:   Thu, 8 Feb 2018 13:34:18 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=98yvind_R=C3=B8nningstad?= <ronningstad@gmail.com>,
        Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
In-Reply-To: <xmqqpo5g5qd3.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1802081317320.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de> <87k1vpqq85.fsf@javad.com> <nycvar.QRO.7.76.6.1802071818240.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <1518044326.7000.4.camel@gmail.com> <xmqqpo5g5qd3.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1931537259-1518093259=:35"
X-Provags-ID: V03:K0:BQ/ETqs0ao1gwdmB7vlyhbeduTNQXPTLBQVLkoc6ryxvTPp9lq9
 BYD7/2w3EDK2kbjRLWdUvdIbZJRS59FIvqaLX8VXXj214GmCX2xBhjWSvMk2aO/wmFS2nvy
 Y8odQkATIE2UVQfHu3q/1tg0UzmTLD/NvO4/0bKGZx2AUyxgUHewlYBXZKB05GPtsse+drk
 nwPeh1KmczkK1DHk0mYig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pCLQjE1S3Nc=:pLn8xVKBDfsf5PYykgv4nR
 c1fGEKvx0TKx0Riorv7mm/Y9xoQengYwN68+VSE7dBj33L/qiLvcqPxbCCHX6nst36JYy+2bN
 OQTFAFHhACcMBuFq5QDatj31CCz8RsaJCFnfnf2Rd41km55MWrGAKmtR/5/+jZJlkGqu+f+Ws
 ZxVlvDDQ39X74ngpNgCsPTvz+gsS7i50NLomcrcyw+5rgJ1YWny/Ooub4jKSxEXSVqLDvJ08n
 0z/fzPsgql967BSl5Bfjcj+TQRfPvQetlvy6fy/vTywozAttmKp5U4Phqfy93fPUVETD4NYgT
 lZDQcYbzKv5RoBt0lid6a57HlxgnmW3yAVOsgGCPhgdmHCZv3j8+icjLVvMy9aIO1SK4huY79
 YMpN2M3J18JYtCAp2Vhp9QUO9dwicDZ9rx9xWZgv5nx+Bg+xXdEF2TNvFhAAIpA3X79EGlzKZ
 DymotHuHDkMAfCKe50YyuC0j55eTew+YBoWFp+wnlg4SGLXWM7p7xuQ3Mi7D/FA8o9LcE5h7r
 QTNiXc2c2RvXveME8OZ4jitCnIuS2qnHy2aNRZJclk7tdLYg44WB69gmPMZIiRlvwJh73P75V
 iHVdiC2ZtGX+xDkSQ7sG1KCHFShbFSKGP0ZITPaiGOIU61yfDexKo/c8PpmUUUOvQzUjKa5uX
 SKwdLNVKwqmotQEYiHs63O30i4ri9vn9A/izr4uxpm0F/gsCXCmmRcM3qx2egZq4CrnOUOfJ8
 3RtwRc/LdAoUkroDOz08fxZjyF4q7JN203gDyfUoAS7ryOpWkn/bjOl3MYQkO3+r3/dDuu2/U
 YLmIJwU/kukRYII1Z5Q0PV4ReSrCzEHcnjDNQPv9E2OlTQWDXM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1931537259-1518093259=:35
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Wed, 7 Feb 2018, Junio C Hamano wrote:

> =C3=98yvind R=C3=B8nningstad <ronningstad@gmail.com> writes:
>=20
> >> So no, I do not think that --recreate-merges --first-parent is a good
> > idea
> >> at all. Unless you try to do that non-interactively only, *and
> > disallow it
> >> in interactive mode*.
>=20
> Correct.  If the original side branch has commits A, B and C, you
> are rebuilding the topic to have only A and C but not B and then
> recreate the merge of that rebuilt topic, then you absolutely do not
> want "cherry-pick -m1" of the original merge when recreating the
> merge, as that would resurrect the effect of having B.  The same
> argument applies if you rebuilt the topic with A and C and then a
> new commit D.  "cherry-pick -m1" of the original would do a wrong
> thing.
>=20
> When there is no such fixing up, "cherry-pick -m1" is the right
> thing to do, though, so it probably makes sense to pick merges that
> way when the side topic being merged consists of the same commits as
> the original.

Please note that there are a lot of conditions of "fixing up". A lot more
than just dropping, reordering or adding `pick`s.

> I do not think that the code structure in the topic as posted makes it
> impossible (or unnecessarily hard) to give an enhancement like that in
> the future as a follow-up series.

Just to give you one concrete example: when I recently rebased some
patches (no reording or dropping involved here!) and one of the picks
failed with merge conflicts, I realized that that particular commit
introduced incorrect formatting and fixed that right away (verifying that
no other commits introduced incorrect formatting, of course).

With your new cute idea to magically cherry-pick -m1, this change would
have been magically dropped from the subsequent merge commits!

And let me pick a bit on the statement "I do not think that ... makes it
impossible (or unnecessarily hard) ...": I absolutely agree. I absolutely
agree that it is not impossible or unnecessarily hard to introduce
features *that are confusing the users because they are inconsistent with
the expectations how such a command should operate*.

So the question is not so much whether we can introduce a feature that
makes no sense. Of course we can, we are decent software developers.

The question is: will this be confusing, inconsistent behavior that
violates the Principle of Least Surprise?

In that respect, introducing conditional code that would `cherry-pick -m1`
when the todo list is unchanged so far (and only then) is an absolute no,
no, no. It would be all three: confusing, inconsistent and violating the
Principle of Least Surprise.

So how about introducing support for `--recreate-merges --first-parent`
and allowing to combine it with `--interactive`? Also violating all three.

I can see how you *could* argue that `--recreate-merges --first-parent` is
a Good Thing. I really can. It would even recreate evil merges.

But in interactive mode?

Nope. It would cause all kind of pain, not the least on me, because I know
how many people ask me about `--preserve-merges --interactive` and its
confusing and inconsistent behavior that violates the Principle of Least
Surprise.

So as long as y'all don't go anywhere near "oh, let's just introduce
--recreate-merges --first-parent and *then also support it in
--interactive because we can even if it hurts the user experience", I
agree that it could be a good follow-up patch series.

Taking a step back, I have to wonder, though, why we stumble over our feet
trying to cross bridges that are one farther than the one we currently
have to cross.

By now, it should be clear why the default mode of --recreate-merges
*cannot* be --first-parent.

And before --recreate-merges is said and done, we should maybe work on
getting it said and done, rather than musing about what comes next? I, for
one, would really like to focus my time on getting *this* patch series
reviewed and included.

Thanks,
Johannes
--8323329-1931537259-1518093259=:35--
