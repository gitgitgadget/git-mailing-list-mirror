Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F5D1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 09:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeKPTr0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 14:47:26 -0500
Received: from mout.gmx.net ([212.227.17.21]:42205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbeKPTr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 14:47:26 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MO7Ca-1gQtvU1oHs-005cxB; Fri, 16
 Nov 2018 10:35:40 +0100
Date:   Fri, 16 Nov 2018 10:35:39 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        gitgitgadget@gmail.com, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] rebase doc: document rebase.useBuiltin
In-Reply-To: <xmqqr2fllmft.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811161007030.41@tvgsbejvaqbjf.bet>
References: <0181114090144.31412-1-avarab@gmail.com> <20181114091506.1452-2-avarab@gmail.com> <xmqqr2fllmft.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1290934975-1542360941=:41"
X-Provags-ID: V03:K1:ii96tXFUurCRMUmoACf2QTZsQlB3efdwpWQ/ZVD8XSrl6WtBJTD
 M0nmoq8oI/5XUomybjam71a33IVq4l9aIAuHGK2Yt73Jhb1SCh+2Ca2qqP8XIFb9+o4AFKp
 lT/TVTrmrZ+Z6RRjHH36ctWD95gHUGwqdFciYi05cIS1Czr8w4dxcTABfOwaeKljn/EvOLe
 /pcPFItzfxmJvwbOjNl/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hTVHhrsvIL8=:LYeS8EKiKty2VCxt1A7eSJ
 BoXhSqlknjTtm+ZC8BT+uotpXGgkOj41XbJZ1NFUX/GZU4bslXuoOJ9R9g3AddJ/5K3xZFMqJ
 7Rx/Bp2+W3Kf9+VEtARLk3jnRfM1hTaNXXvGvqAu4MDEtXAmLGE2TgtDgkDMMAmjoUXkHzVkl
 HpB4ra0AnRL5M/NqXcXbuXNZlCr/PCf1IZBWd1HqnwHzEnlZDWJ9fWcttxMzFbYgMGFpPNGQ3
 ZFk/CCGf0mCBkUAo85Io9zKSMguI9odeCZ+PZUgdGZIJj04VjhCMllu45sjQfyPcMpF84N3tN
 PIu7XqHE7jriPjjFnhpgjdc4eVFhYklB43s4Iw5Lcdh/2efE6wcrLYn4Bk+RxC0e1t4AUFxKJ
 mcEMWc6hB2FcSzGsQsKtcWUReSPSOPwuV47XO3YLx7VVuPv3XpS1k2Z2KNRYLOtngu2RK3UNa
 UlEYbb6+PDT2TFOu0Z32AFmwSDyVimcZ7Lti5ssmzEhkmDW4FtYHvzAaLoOL5i7hk4exIjp3p
 /FO0UZ+TWRE6FWmTv4sPCRFAfQ3/zfm9SToyR4CmVJuiUNo7PF93qm26rPHShpkKCvQ+1iFHz
 UmtXFayRApuze1ajiggVRlu7DH12p5FW+65K7kGB7y5TdfGtUDRE0K32accCgjP+b4Jp7BKrG
 JttoYcykQk7Ma2gB4FlRSRdXKF0xfGparqnw9ij5dmt/DXFM+ObHZRAEjSZ9AfTU72W2fuFb/
 6Rn3crqjGHf5w1qJv9TDLfwCuYYNILMPyQtr/8eQEttYIm8HKivXasFsMZ4YwAchT3DuHLKXl
 242/AfZRvqz9yAJNrUGEb3+deudnztHjF5ve6W4o3IhinSo2mMpApQ56v8oXaS1R2p3OUkQeD
 llaRJBscsy8jxdJWJgr1aFxleX1v9cjr+3L1goVNVP2/f/ETKwY/AgaOKFcN3Nj9jFz6VJsir
 qsyVXwIP3Sw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1290934975-1542360941=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Junio,

On Fri, 16 Nov 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > The rebase.useBuiltin variable introduced in 55071ea248 ("rebase:
> > start implementing it as a builtin", 2018-08-07) was turned on by
> > default in 5541bd5b8f ("rebase: default to using the builtin rebase",
> > 2018-08-08), but had no documentation.
> 
> I actually thought that everybody understood that this was merely an
> aid to be used during the development of the feature and never meant
> to be given to the end users.

It may have been from git.git's point of view, but from Git for Windows'
point of view it was always meant to be a real feature flag.

> With my devil's advocate hat on, how much do we trust it as an
> escape hatch?

As you know, only a fraction of the bug reports about the built-in rebase
came in from Git for Windows: the autostash-with-submodules bug and the
perf-regression one. By my counting that is 2 out of 5 bugs coming in via
that route.

One of the reasons for that was that the built-in rebase that was shipped
in Git for Windows v2.19.1 was marked as experimental.

And the way I could mark it experimental was by flipping the default to
executing the scripted version:
https://github.com/git-for-windows/git/commit/cff1a96cfe (you will note
that I added the same escape hatch for `git stash` by adding back
`git-stash.sh` as `git-legacy-stash.sh` and imitating the same dance as
for built-in `rebase`, and I also added back the scripted
`git-rebase--interactive.sh` for use by `git-legacy-rebase.sh`).

Meaning: essentially, `rebase.useBuiltin` was defaulting to `false`, and
if a user installed Git for Windows with the experimental built-in rebase,
it was set to `true` in the system config.

There was not a single complaint about the scripted `git rebase` being
broken in any way.

So we *do* have some real-world testing of that feature. (Obviously I have
no numbers about Git for Windows' usage, apart from download numbers, and
they do not say how many users opted in and how many did not, but Git for
Windows v2.19.1 was downloaded more than 2.7 million times so far and I
think it is safe to assume that some percentage tested that feature.)

> After all, the codepath to hide the "rebase in C" implementation and use
> the scripted version were never in 'master' (or 'next' for that matter)
> with this variable turned off, so I am reasonably sure it had no serious
> exposure to real world usage.

See above for a counter-argument.

> Having said that, assuming that the switching back to scripted
> version works correctly and assuming that we want to expose this to
> end users, I think the patch text makes sense.

Indeed.

I would still love to see the built-in rebase to be used by default in
v2.20.0, and I am reasonably sure that the escape hatch works (because, as
I told you above, it worked in the reverse, making the built-in rebase an
opt-in in Git for Windows v2.19.1).

Ciao,
Dscho
--8323328-1290934975-1542360941=:41--
