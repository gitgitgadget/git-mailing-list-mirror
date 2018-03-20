Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F9561F404
	for <e@80x24.org>; Tue, 20 Mar 2018 16:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbeCTQ34 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 12:29:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:42321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751594AbeCTQ3y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 12:29:54 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lhwt0-1eCYsM1pGE-00n5NA; Tue, 20
 Mar 2018 17:29:52 +0100
Date:   Tue, 20 Mar 2018 17:29:28 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC][GSoC] Project proposal: convert interactive rebase to C
In-Reply-To: <2564070.6kGkNsz7Qa@andromeda>
Message-ID: <nycvar.QRO.7.76.6.1803201720090.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <2564070.6kGkNsz7Qa@andromeda>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2143385921-1521563392=:55"
X-Provags-ID: V03:K0:BUq29no9btpnjVwA6izp5c/yA4zS+Q+viEh6HAxrWDP5BDXFEp+
 9UsaGd9KDvoEBHfG9jxEdKwSAPAYLZBPfY8gbfhD/XHhmzsHntchLtZ4RlFTd2ST7urYnJh
 A/rwQ69uqPs8BZVG8yB0IlkGaZgFsCtTNBy/zKUf992EJ/yKIzj7bXa4MAIwLxM7x8pPg+V
 Xy4wvR8qeWmLhOl4wD8EA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:14+kXwN5RJY=:NdNF6YaYckaCQnSepW+DTQ
 7PWgbVWcm0cG6q9VefF3AH2Ym13z8eDTZQn1jCQSkk5IqFCv+8CtWqOrEuKe0zFov++AjNBVj
 8Jou9A1CfGJwgtcR+4smKnGHlDxTYRlW1pwaXyT9rlp1yMTxibl4b1zcTj2Bb+hW68DQ749+6
 Jos3RIKUvUPG+d6ILf12oMHEirSYVBcNWd52+OnB2DEXVlEo7VcfIjbZHmwDsM8v50z4ZHnPH
 XpxEjtCnVkRL9Gm+m1jKqW7qOcRzvpfqJ/R/aTD9f6N7FQmYNb+5x73YRz1ENyGmA2IotQH6a
 Up8tvANi2hQd4kfVzUCoyvCMZ504oRF53VAaO9m7CaXvZNT/G66WQssHAvUIYYkushUDT9n9T
 Z7VPaRyq7DFYE8vHX8sREdWIpEIgK9l7IQX5PDyKiYPjihvRlM4TGtoYfraX1/GdXjZS1F42i
 iSiPENT/5uKd1TUoq36Tv2T+1XXjU19w2OUTRU/YUQ8DSuXQBicvAP5kK5+/okEbXLBsiMSmG
 98u0LKtK4RkMpV5u76mOHWHGbfPENs3a93wrWXakNZc3gYdhxP8mVkgP59NIqIvzznUcCjHOg
 5v0U9X54ydEVC4XlpZzmbsfOmjgsfyrjxJv03XM1mHjuTk2JdAUJn0Dohnq0JL7lY4Z4kEjbC
 30PWlz6zZQjkHWRaMZMMSWrzKHXzJe1uUSKSOMznwuO7YptwYvCG3KIcmBS7rwYvkFJEn5eKp
 Me1WTyFYugbkurkxjj+vL8mZYB22poQlzLJXXd7udoW2lXioB6zUJVgMj8vILnsg8QOtv/02x
 9sU8Tt7ll+Jsf7nReUrffhvQUN99tp4+hZHOW1w6zpgDcEMHow=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2143385921-1521563392=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Alban,

thank you for your proposal!

I will only comment on the parts that I feel could use improvement, the
rest is fine by me.

On Sat, 17 Mar 2018, Alban Gruin wrote:

> APPROXIMATIVE TIMELINE
>=20
> Community bonding =E2=80=94 April 23, 2018 =E2=80=93 May 14, 2018
> During the community bonding, I would like to dive into git=E2=80=99s cod=
ebase,
> and to understand what git-rebase--interactive does under the hood. At
> the same time, I=E2=80=99d communicate with the community and my mentor, =
seeking
> for clarifications, and asking questions about how things should or
> should not be done.
>=20
> Weeks 1 & 2 =E2=80=94 May 14, 2018 =E2=80=93 May 28, 2018
> First, I would refactor --preserve-merges in its own shell script, as
> described in Dscho=E2=80=99s email.

Could you go into detail a bit here? Like, describe what parts of the
git-rebase--interactive.sh script would need to be duplicated, which ones
would be truly moved, etc

> Weeks 3 & 4 =E2=80=94 May 18, 2018 =E2=80=93 June 11, 2018
> Then, I would start to rewrite git-rebase--interactive, and get rid of gi=
t-
> rebase--helper.

I think this is a bit premature, as the rebase--helper would not only
serve the --interactive part, but in later conversions also --am and
--merge, and only in the very end, when git-rebase.sh gets converted,
would we be able to simply rename the rebase--helper to rebase.

Also, I have a hunch that there is actually almost nothing left to rewrite
after my sequencer improvements that made it into Git v2.13.0, together
with the upcoming changes (which are on top of the --recreate-merges patch
series, hence I did not send them to the mailing list yet) in
https://github.com/dscho/git/commit/c261f17a4a3e

So I would like to see more details here... ;-)

> Weeks 5 to 9 =E2=80=94 June 11, 2018 =E2=80=93 July 15, 2018
> During this period, I would continue to rewrite git-rebase--interactive.

It would be good if the proposal said what parts of the conversion are
tricky, to merit spending a month on them.

> Weeks 10 & 11 =E2=80=94 July 16, 2018 =E2=80=93 July 29, 2018
> In the second half of July, I would look for bugs in the new code, test i=
t,=20
> and improve its coverage.

As I mentioned in a related mail, the test suite coverage would be most
sensibly extended *before* starting to rewrite code in C, as it helps
catching bugs early and avoids having to merge buggy code that needs to be
fixed immediately.

> Weeks 12 =E2=80=94 July 30, 2018 =E2=80=93 August 5, 2018
> In the last week, I would polish the code where needed, in order to
> improve for performance or to make the code more readable.

Thank you for sharing this draft with us!
Johannes
--8323329-2143385921-1521563392=:55--
