Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924A9C00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 11:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiHOLaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 07:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiHOLa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 07:30:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967ED26CA
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 04:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660563017;
        bh=zNTcVpp7zssOBLnpclbFRhq0tl4q/kpEZnzTkTuL3zA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eqjLV/jWLy3deAwP3j8Y3LLaQ1B3oP0wPDXxA2fBJwe1eFDZBeAjlYAU2RRvVfGW2
         YGvgr+VMDoygDHUZV+fOb8xzIY/YCw8WseUHMRO+5+eUxqku1pbYNMYy0wjNTMFl7k
         h0pNe0VTL1P3TbytgSjTKwZ+a1VfAd/rRQ+sNgMU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQeA2-1o2BOp090o-00NmHE; Mon, 15
 Aug 2022 13:30:17 +0200
Date:   Mon, 15 Aug 2022 13:30:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Victoria Dye <vdye@github.com>, git-for-windows@googlegroups.com,
        git@vger.kernel.org
Subject: fixup! bug, was Re: [ANNOUNCE] Git for Windows 2.37.2
In-Reply-To: <xmqqwnbdct1m.fsf@gitster.g>
Message-ID: <16r2s842-1r7r-p05n-82o5-q01921r35oqr@tzk.qr>
References: <20220811214252.4351-1-johannes.schindelin@gmx.de> <0e859fe2-3f23-4526-083c-082adb0028fc@github.com> <xmqqwnbdct1m.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rF7pWHu1+O1MNROIPLID7Bt4whP6xc1qfxb1B07K7mKI+jSsgjb
 mM8aEZPgGc30khaCkciPptYEUTJrw2kgQ1zRT/cAtp6ztVsllF6jOPwrLw6BMkSOOWOPKvc
 K0RVT4aO4el7SIb1NxpAWnYFsW8+G6aOQVRyqohYMZtZXEZdiWyIiPxKDbmJi5hPAuR8ipd
 7sDuARBVVD7Sgpqgm9Vrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SZqrFO78D4Y=:59xuwtF3iRegRO4wo1inpk
 OeSY5/Vd3RpTzUWLXRlFhj9t/Y4gkA8a/F2nFfqYXw+ov+VG44mKHzw5TAw/Wmjoz8Rej1uLn
 CqL+qUIQhpzKEf28JSQt0Sl4REoJ4gnuFzlc1SBN7BbbLVPZ80NTSotxXdvp2fOwkglGC3Gah
 qFnrorwMd1EFKqBX3T3bPtb1OHbLkAJ2rVch9v3nhwU/1JbSK/PES8AHR1BOzasxwprg8Jo3I
 bQQc7ZtSLP0D8WwfQgrN7tKAYoc6Bw70g3t192EdiEYTaATVX3rOpwhOzH3D9SETtr8QyWwC6
 TRnZ9tgxA2F/pyFsnBdj/zwo7JakKCB9gjVxEiFC6BQwwYWmg3aPMMcid3ZG5vakxXVzCoKIn
 5fFa2ObgOzHD+W4yYyrzJbaTe+KFY3oeCj5m0vG7oNH5d9rAE9OfkbZvVXFeU4ugINGCPiBla
 VDqy8wibCbo8OJYU1dti9Fnxjvq0Ej1kUWOtDKlDfrhZDN1qlufOMNDR7EdhOGJ1SN1lHC0EH
 I+6slM5W8vSVQvhFHqAiTSMWl6Zdh0/uidJyHz2TNmKQSYpjF/cHs/Yaxhu+V3oSEFrz3b4/N
 JxTFmzJob8PctIEpkXBTNtAon72gvi15Tu7uoC4fK+7Bt6iHXxPWdhFdreAG/Pgs6sApYeuhM
 5rfSIxpYNMr7wzmniw1KRyd3H/3FAvw5jHBToIAeng3P2GKf21jbPJbv6cuD/cyyE/uR27H3b
 brllDMkwgbxqlKKpvVcvDp6D6Kf8yYf/9DOKrxDimbyv9Rn9HB/0IvNBXLJHgWiP8c0vBaxoe
 riIarjqu9eb8vee5ctgH0iozTyPj7yLdJIShBog6SfWTDK6OUtVR4p5X74LjYmSkxAEqdeH/n
 4tYopHGDZ2USDKbauHvwBHTlpR9lJ3zRpSC7GZVEOR9xFoIxWiVo50XWNiUuVGl4uYrWcDYsK
 N/+CP6qA9qNLDKzizTuVMM+wGgBEPR09qiDimEvu+v6LDopQoRJWAFM/wCCU8HQNshlpkRbXM
 ULuCsex2tPH0m+ghzTZURrdVgHljBe/OqUa+w7upHgverJSPmsbEOkFUs7E4lMKPyfWzoRgwZ
 H24ClvSP1QmlKoUruZZ40sHL4oaxflaKoBG59wCn+CPWTc+ajwelnXrZg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 12 Aug 2022, Junio C Hamano wrote:

> Victoria Dye <vdye@github.com> writes:
>
> > Johannes Schindelin wrote:
> > Just a heads-up: there was an issue with the process used to generate =
this
> > version. ...
>
> Sorry to see that it caused two cycles of release process.  Would it
> have helped you if I had done things differently (other than "not
> issuing maintenance releases that are not security relevant"), perhaps
> giving a notice in advance by say a few days?

Thank you for offering to accommodate Git for Windows' needs.

In this instance, we tracked the problem down to
https://github.com/gitgitgadget/git/issues/1321: When a rebase has a
`pick` & `fixup` sequence and the `pick` failed and was skipped, then the
`fixup` is still trying to amend `HEAD`, which is incorrect.

In this instance, that wreaked quite the havoc, dropping most of the
Windows-specific changes due to mistaking the initial fake merge [*1*] for
a real merge.

I offer a more verbose version of this analysis in
https://github.com/git-for-windows/git/pull/3981#issuecomment-1212856115

Ciao,
Dscho

Footnote *1*: In Git for Windows, we use the "merging-rebase" strategy
where each rebase starts with a fake merge of the previous commit history
("fake" because it uses `-s ours` to avoid taking any actual content
changes). The idea is that the patches will be as clean and ready to
submit to upstream as possible by rebasing them, yet still be able to
fast-forward. For more details, see
https://github.com/git-for-windows/build-extra/blob/ab941145aeef/shears.sh=
#L12-L18
