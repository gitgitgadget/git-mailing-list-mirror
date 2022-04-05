Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA727C43217
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 05:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbiDFFFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 01:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1585402AbiDEX7y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 19:59:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277A53AA43
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 15:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649197032;
        bh=gezuDgECNvpy0mgzR/vu7cBGZkOsX8aIoRhm4oEpITI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GMykfa05xX/UsmeS+uRpNYfRvZmN4wZdicF/l2WEMjcbROe6U88DDMZDyC9FajCW+
         ElsbOb/eDbHPQQoHk+/GvmWAFqMFULe6cEkUq1akzipeT5GREBVtBn469TrcaocOCK
         acFQQ97GxJYec4TnztcCMZ5EllRJHg8SdDVhq3J8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.56.235] ([213.196.213.50]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4s51-1nbZyJ2n9b-001x0H; Wed, 06
 Apr 2022 00:17:12 +0200
Date:   Wed, 6 Apr 2022 00:17:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Markus Vervier <markus.vervier@x41-dsec.de>
cc:     git@vger.kernel.org
Subject: Re: Covierty Integration / Improvement
In-Reply-To: <10fd679a-eb94-5380-2070-699f1b56a7b1@x41-dsec.de>
Message-ID: <nycvar.QRO.7.76.6.2204052352030.379@tvgsbejvaqbjf.bet>
References: <10fd679a-eb94-5380-2070-699f1b56a7b1@x41-dsec.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1429005-1649197032=:379"
X-Provags-ID: V03:K1:JHkvKwlRrl6lbAyiK5EyQCIPnej83gXk6wTHKYGlmBVz0HLHJf8
 TvDRMfEmg+/fBlg+aZoLaBz2xqBLh21IlX1fvrO0Aw60iCfkImJwAseMyP0/6S6tcil4irR
 CLeI4PcAmB82Kt1GnpY+llzVmuKjSXoqVqdJW8G7ENHLlMWdOzEHLGMP4q1GuYqXsoCAokV
 KtdBgux3aEIzSWS73FZPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z1WxodC25uk=:En8QU3mmZeAYY3fusFQK99
 q+BwBO9PLPRKQB3LwHjNqJyhZIFLkQ0grbla2/OU+YcGlVQk8L5q0lYZmQeUWgIWmyAT9qp5d
 p6TprOtxRfEma6p+r00Pus1B2K13Yx8grUnEoktiwR0dX2TRpjS/aNEINzdt7UgttvD20EU61
 SLcCGCCSAt2txDt3zZ4DfyLfrerKzo0uWSUiaxxv0PCl0l08C2EoN9Fbgnub1kWxawNgBaXyF
 vFmUzsOSOvzV0kGH5uLiyWczwcT98GzyVXWWJOkBd6nCS/xpzXA0UhfhnwyC8xF9ESDlvAIkp
 awU+Bt33UpyJbteSEmH3MRQVGxLx0m01EtMuI4mow728TM1SmwSyKu7rqdLxyE5MO4NZeoGkZ
 cggzo1jHuUIZs2O3vkNnsG/pXuW+MrZRM3AVdkuMiJuc0h3SN0i0eWJM226Rg9juSaT5pq7DY
 3B98Sykxx2rYJR21P/vj8o03QY+ZvfwptiHBPT3Tj1p13J+/oJj33ALt79fKG8AcleNNDbyWB
 MHJG2Nq5qf0FCRDQ+rxTOSZ5WM+/Fa1M8zmTuHwj2WvLaDTCTRiacygGuKG8bTChBLvHLmF5D
 upqdYIcKYbfzJdCSGN3KgU3pujMTpOBF5u+4phrxoLDl9FSWWeT9DGCaWwauhV0xN7oRW4w8s
 T89tdEYM4BQX0WIczgM15Arh6D98XNfrrl4TjAyXa41GgmhE21Mt/Z8WmZ1Y7MyEV1HHq6MDU
 avsdl75Ytj548MMD6N9ygnPoYXNc4P0rP2WWyqGlu5G8PhwvYORmoofg6/W98Y7E143tWtfzg
 HOMDR/SZAWS9TrqA7cRwPXPUG3qWqf4gfLaQsM4Ooilc4N3liCUeyZNLTK/BCTS+QGXe6kGhQ
 Ygwl1b6qy4LUaN72nsDGLZFSpO6ZoJ+qh06//zpqD+IcFRfZZcEw3cLMeRW6dLRLcD27PxM/N
 hOtFTO8yQBr0nRuVSS8ziyi6M1JSg4oX6Hmh3mUaOny8nMbzpUZuC/lHcMg0HmCckolObggu1
 IWJcOZveB6zDdHNM8Rz+b6mVMRJfsTnn6I6J5vo3aXFTpWZwTrfToxQws8v4sGDeWqmifWmLo
 /mrUl5c2EvJaQk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1429005-1649197032=:379
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Fri, 1 Apr 2022, Markus Vervier wrote:

> Dear git developer team,
>
> X41 is processing the current RfP

would you kindly provide a bit more context? This seems to come right out
of left field. Is "RfP" a "Request for Proposals"? If so, I am not aware
that the git developer team submitted one...

> and some questions came up regarding the
> improvement / integration of Coverity Scans for git and the estimation o=
f the
> required work:
>
> - Was there a special purpose for the Coverity integration (e.g. custom
> queries for variant analysis or regression testing?) or did you try to
> integrate it as a best practice / general security hygiene tool?

There has been talk about integrating Coverity into our regular CI builds,
but nothing actionable has materialized yet.

Git for Windows has such a CI build, but it is currently broken due to a
backwards-incompatible change in Coverity that will require a human to
adjust the CI definition, which has not yet happened due to lack of time.

> - Could you tell us more about the amount and types of false positives a=
nd
> problems you've faced trying to eliminate them? This will help us to
> understand the expectations / requirements for a successful integration =
of
> Coverity.

=46rom the top of my head, I would estimate about 60-70% of the results to
be false positives.

As Junio pointed out, we do not consider memory to be leaked in one-shot
processes where memory is allocated, once, in the equivalent of a `main()`
function. Sure, we could add a slew of `free()` calls right before exiting
the process, but that's kind of pointless.

Another major source of false positives is our string data structure,
which offers a small-ish static, read-only buffer to get started, but
replaces that with something `malloc()`ed/`realloc()`ed as soon as the
string is about to be manipulated. Yet Coverity insists that we're writing
into a read-only buffer, and get out of bounds, which is simply not true.

Similar issues are reported with our `strvec` data structure that has the
same allocation pattern.

Since the false positives outnumber the valid issues reported by Coverity,
we have not been very eager to sift through new reports.

The list of categories of false positives listed above is not exhaustive,
of course, but combined with how cumbersome it is to get access to the
reports (they cannot be viewed anonymously), you get an idea why we do not
pay all that much attention to Coverity.

> - Could we get access to a sample of the scan results?

Sure, if you direct your web browser to
https://scan.coverity.com/projects/git, there is a button "Add me to
project".

Ciao,
Johannes

>
> Many Thanks
>
> Markus
> --
> Markus Vervier (Managing Director)
> X41 D-Sec GmbH, Dennewartstr. 25-27, D-52068 Aachen
> T: +49 241 9809418-0, Fax: -9
> Unternehmenssitz: Aachen, Amtsgericht Aachen: HRB19989
> Gesch=C3=A4ftsf=C3=BChrer: Markus Vervier
>

--8323328-1429005-1649197032=:379--
