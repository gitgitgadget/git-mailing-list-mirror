Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A8041FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 08:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754817AbcIAICB (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 04:02:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:56404 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753420AbcIAICA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 04:02:00 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MJFBe-1bh1tP2HWM-002oPO; Thu, 01 Sep 2016 10:01:17
 +0200
Date:   Thu, 1 Sep 2016 10:01:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/22] sequencer: remove overzealous assumption
In-Reply-To: <18293d15-0a83-d7aa-78fb-14891efd6ea4@gmail.com>
Message-ID: <alpine.DEB.2.20.1609010957300.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <3c8c60e0799fdf176c72e7e17c257d33b2a362bc.1472457609.git.johannes.schindelin@gmx.de> <09fd1436-301a-b0e1-c32a-81a47e4eb351@gmail.com> <alpine.DEB.2.20.1608311706400.129229@virtualbox>
 <18293d15-0a83-d7aa-78fb-14891efd6ea4@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-799293237-1472716877=:129229"
X-Provags-ID: V03:K0:iAilDHH1LfDR/hZCrW5e6x3QChG0rE0ekBrFNpXNkHNTjqW+rCJ
 joiQYIXaWJbrUIR7tVoqYVOK90cdgDwwfrW+ntqWpzh2dLjAYgeEFN/WdJIMJZLjdFI7uaF
 j8v9cZKFxvWo+Jc5RSpw5aH/6qtI9XGlEOr369BRLZoN7PZu1UuThmdeLwNEKjGAoGEEk9t
 Cx4sBgtK0YPYDdx2yX7Uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QCwqizZIkO0=:qXxQBcTICCd5tJvUaoiaTM
 FcAXqdS+UhETpXF2Ac9j30TlBPKKcI27MIR/gY7ecCURbQU6ebqFzHGDgpsluhoNKzmRffTYk
 KV0AND2Wgdvy9YPNoz8iSAfEUzyt+MUC2n7/rl2JTER17P0JIyBrYOn0POu6DZaxU0bAMvego
 x7KWEh3mVUmAbP0YswY+ugOVhAZ6OnaGiuaoPdy0LzHwGFsKuadx0piH/4JsJQ9kMEUPEC3pe
 dOfFjxyf16feWLslOMajRfA2EX51cnEJFJbb+xwmYpLcXIBdYtbSvsqZLBTsTSLMVfI4vSDDX
 2Ef3lW7okgy/5H3PDGwwdJ4PDyYcSml5tHMcUjva3hPD78tQklwYU4d/43Oaw+CJGJZNLA51i
 4Fdg9w4A+JKQV/n4oPz32WrBz+GW6GOAU55TMG44UEPsLbJSDD2dYPEXHRJGTB6jQ7Oydr2rH
 sGWdOSZ5uf+7VIZj2wZCl90rZmId5H9bxf3oZ6tng9GSww7QnYSRPEhLfew4ODeT5vKcxJzy0
 WpdD4PCcUoB8dXhJYQedFhJWiq66GFUiEuJNV0HCQ1hDE0/hMCF3BlPFOC4AXKA6Ww6efC6rO
 hFyhtL1rlMONtfE4KEvncagBid396JV+K0Bl+RjQ/aRSg+HNGkr6++fZEonbAm8R/1LCG8sMm
 veGxtNaLg/OGYEXppV4r7IX5sUSGhuzx4qAp+3ZFwtF+3F6qElHb+2InUrZdB2nVYTrzGY0vn
 +VN4ajGn0fXdhT+Hi9K7Z8vJIEXaLiAQNrjXcHCJ9i0UEX2btYaEcSuQcSlBqQKltV6IIM130
 JSorK87
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-799293237-1472716877=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Wed, 31 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 31.08.2016 o 20:36, Johannes Schindelin pisze:
>=20
> I wonder: would 'git cherry-pick --continue' be able to finish
> 'git revert', and vice versa, then?  Or 'git sequencer --continue'?

I just tested this, via

=09diff --git a/t/t3510-cherry-pick-sequence.sh
=09b/t/t3510-cherry-pick-sequence.sh
=09index 96c7640..085d8bc 100755
=09--- a/t/t3510-cherry-pick-sequence.sh
=09+++ b/t/t3510-cherry-pick-sequence.sh
=09@@ -55,7 +55,7 @@ test_expect_success 'cherry-pick
=09mid-cherry-pick-sequence' '
=09=09git checkout HEAD foo &&
=09=09git cherry-pick base &&
=09=09git cherry-pick picked &&
=09-       git cherry-pick --continue &&
=09+       git revert --continue &&
=09=09git diff --exit-code anotherpick

(Danger! Whitespace corrupted!!!)

It appears that this passes now.

Probably `git sequencer --continue` would work, too, if there was a `git
sequencer`. :0)

> > On Wed, 31 Aug 2016, Jakub Nar=C4=99bski wrote:=20
> >> W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:
> =20
> >>> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-se=
quence.sh
> >>> index 7b7a89d..6465edf 100755
> >>> --- a/t/t3510-cherry-pick-sequence.sh
> >>> +++ b/t/t3510-cherry-pick-sequence.sh
> >>> @@ -459,17 +459,6 @@ test_expect_success 'malformed instruction sheet=
 1' '
> >>>  =09test_expect_code 128 git cherry-pick --continue
> >>>  '
> >>> =20
> >>> -test_expect_success 'malformed instruction sheet 2' '
> >>
> >> Hmmm... the description is somewhat lacking (especially compared to
> >> the rest of test), anyway.
> >>
> >> BTW. we should probably rename 'malformed instruction sheet 2'
> >> to 'malformed instruction sheet' if there are no further such
> >> tests after this removal, isn't it?
> >=20
> > No, we cannot rename it after this patch because the patch removes it ;=
-)
> > (It is not a file name but really a label for a test case.)
>=20
> Ooops.  What I wanted to say that after removing the test case named
> 'malformed instruction sheet 2' we should also rename *earlier* test
> case from 'malformed instruction sheet 1' to 'malformed instruction sheet=
',
> as it is now the only 'malformed instruction sheet *' test case.

Actually, you know, I completely missed the fact that there was a
"malformed instruction sheet 3". I renumbered it.

Thanks,
Dscho
--8323329-799293237-1472716877=:129229--
