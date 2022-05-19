Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695C1C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 18:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbiESSRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 14:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiESSRU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 14:17:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EE08BD2A
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652984228;
        bh=rRZ+XF56FQBCNvdtS44+B+PJfcCxN6tF/MDotR09Ml0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kHzndsrGo3muOeYNuMXbr3Zeb2fqvQuYEwLW3t1R8kwwHVMpdGMgeicMqdng/QKxm
         BiG6RCmbAuA4tqcdp+v3/DN432tEkSaIV0OdHwQu48qYyLN/7EQPo94gAhE9wf+rmQ
         zGIHYOt6DSHzp/DDAB8rVwChwQVLoMc8W4zurgSs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.215.85]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY68d-1oO2ZS3fvZ-00YP4R; Thu, 19
 May 2022 20:17:07 +0200
Date:   Thu, 19 May 2022 20:17:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     rsbecker@nexbridge.com
cc:     =?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?= 
        <avarab@gmail.com>,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?'Ren=C3=A9_Scharfe'?= <l.s.r@web.de>,
        'Taylor Blau' <me@ttaylorr.com>,
        'Derrick Stolee' <stolee@gmail.com>,
        'Elijah Newren' <newren@gmail.com>
Subject: RE: [PATCH v4 0/7] scalar: implement the subcommand "diagnose"
In-Reply-To: <00f201d86a02$c6399150$52acb3f0$@nexbridge.com>
Message-ID: <nycvar.QRO.7.76.6.2205192013140.352@tvgsbejvaqbjf.bet>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com> <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com> <220517.86y1z05gja.gmgdl@evledraar.gmail.com> <00f201d86a02$c6399150$52acb3f0$@nexbridge.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2084058205-1652984227=:352"
X-Provags-ID: V03:K1:DwqQ2Ruyu2KW+JqEeNfi6gYvl+2jn6YxjtzPPDOouQsKI/A1nOW
 vSn39COkGBihQ0kRzLon4DC/V/yHorT4OyLWP1WEBVK9NxJr4Ef+sv48Z1Mp/G40kd24FEy
 EVLBDw29SrGJX0RoxZMBdD8K4TPSJZmYzDcP+/OAg+byet0qJVGJ6vGeCq6T82R46GXWuLs
 NcECk2b3LPiEm8nzFiu7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1LpLDAjoglU=:Bz96UuAF0+HjEZea347PWv
 8eStex8iaUwZBiTtOJLRTBY4uA8UDIQtULXAjwOsi0Ue0B3SI6/Ie0x6RMZKA8/rs0fKv2bQO
 k/KX1NefvtC8GWfTtQgo1wu/DZZW3uTjmWiHTysPdWgr4sNbQZCRoL+WxoHtFhKJ2KF2ekbjk
 RrQIPO9R1TnQ/p1vV5n4YTD4YXwhZOInCodaMaxSMz4OltVn0fr8VuYmOD1QRvJTo8TJQK8n7
 SDX7adaHhhFPWLp+dZkBFScV3BGneDObkWHtOpRgyiQ64JNJkdEr+HYgBaTy+YmzEKtjt0QW1
 SSHiU3t4DIR98l+tAjP0gyef6G0AuTpn8szKZWYDbPmft8kpd0Mw08rF8E9h4P2k7WVdkkBm1
 Wjoo0eIM1er6B5NacH4gnPr9xFc+JcFpkzn36kzOms9FbJ9D45G9wcgtEMNTwzw2MJye6Ee4f
 o7BYWn4zrj6iGd7VDwuOBiFfzmg5MBf7VCJMI00cm6gEaO6dDgJpy1eVa3d8Yq5kV2HjL2tT9
 pTu/H5Lyh7FFbaqPYPNAEUkRptVnw9zYCyh1W7U+DFTYId4ZhuuS2mnEX7i5DrODoAw+RfZRj
 uups9DDc2xPMoKkXLELc8F185l6ICdFnBMfFnI1wOiAeXt/CcwDiGOqJlmMwg6eRdnKh9UCyD
 TfInljVplvJZ8S79IZNZTwS/m3DC5B2fnG/1u3zp6yiqmSPUV60V2EaFfQ2HSW3Mv2d/O1Vpb
 4XQt8IsSGwVorcLHphuqFohD+VA6M0237QwI5aRHvYKmSE1UlS0qPHv1aM0KN7KRZQu9zhrep
 zJ/1oELnN2bCX8jZLTtUuCcwoZ9o16oPELTlGKMby30GnbOzpaUhcWY0dSC0/xR7zKYlPE1hg
 trg1E8xzwtEEcSAkQ2UT6aldGixcrkehQl6pa/+HcP2PQt4mXTasOwLKfQ1/9a5tIzxrpibZ2
 ffXHOHtYCY5msqyYvWZ1EcFks2FIUMErcm9Q01RDHVSUp6edddlguvwWrWnhcHIsL71lLXAlI
 RT9I7gXVhtZ1JniOVgGePYIsd4Vs7X+17bMFG6yg0PWV8mkqCIeE8/VgnuOCw61H0MKVizWiM
 GNgh6EvsKkT7sNsEbp31llDJT/gr0wQDlxJy/WYzLdAlsR0LhdJlqjv+A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2084058205-1652984227=:352
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Randall and =C3=86var,

On Tue, 17 May 2022, rsbecker@nexbridge.com wrote:

> On May 17, 2022 11:03 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >On Tue, May 10 2022, Johannes Schindelin via GitGitGadget wrote:
> >
> >> Over the course of the years, we developed a sub-command that gathers
> >> diagnostic data into a .zip file that can then be attached to bug
> >> reports. This sub-command turned out to be very useful in helping
> >> Scalar developers identify and fix issues.
> >
> >I don't mind this as some intermediate step, but re the context of the
> >plan for scalar "eventually going away" (discussed in previous threads)
> >I wonder why (especially re the earlier thread upthread at [1]) this
> >isn't being added to "git bugreport".
> >
> >Is the plan to integrate this into "git bugreport" eventually?

Potentially a variation of the `scalar diagnose` code could be useful in
`git bugreport`, opt-in via a new option.

But that's not the purpose of this patch series.

> Could this also not be useful in fsck, as --diagnose? That's the go-to
> command when there are issues for many users.

I can see where you're coming from, but `fsck`'s mission is to verify the
integrity of the local Git database. That is very different from the
mission of `scalar diagnose`, which is to help diagnose issues (whether
they are truly bugs or usage patterns causing unfortunate performance).

Ciao,
Dscho

--8323328-2084058205-1652984227=:352--
