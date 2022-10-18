Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BE9C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 14:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiJROsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 10:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiJROsO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 10:48:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445C5D77DE
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666104485;
        bh=gF9wIL4JSIGxF1W8ll0G9HUFh7t4ZRMQa84TsK4EMa4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UTHRKNRer3stXa+U0XISV0/HFCKKqEUT8BBBoP5UhW29Zab3YaMcGb5MllVhlZ+Rn
         SJWvKq8nGF8xD17WEaDZK6pBKMedc+Vl6QOabHdklD9o6qET2ezVCwOuEMNNSO5bo+
         Hhot968U7CxSuQXHYq5eJvUsCloJMNDcrTocI710=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.67.214] ([213.196.212.100]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv2xU-1p2Kjl296u-00r3GP; Tue, 18
 Oct 2022 16:48:05 +0200
Date:   Tue, 18 Oct 2022 16:02:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Eric DeCosta <edecosta@mathworks.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: RE: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
In-Reply-To: <BL0PR05MB557123F87157E0E091A43494D9299@BL0PR05MB5571.namprd05.prod.outlook.com>
Message-ID: <s2r033rp-5r9n-48op-57qs-n1s2833n049n@tzk.qr>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com> <xmqqwn9256cw.fsf@gitster.g> <BL0PR05MB557123F87157E0E091A43494D9299@BL0PR05MB5571.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1721226974-1666101765=:174"
X-Provags-ID: V03:K1:CV9AK3IYGnWsZirDjzV6hMw0yy/6Ao6DYLamZBiAs/ZFJse0/rJ
 k7+lJjhIXPrEDrYGYbrUGpZSulymF/unywpbeReS3DSgyCbhbfsC3AqdVw7MWDAag2YspDM
 EUjYWfCthsh1TvzCBV+xD6EG9VL7tgtHiHhxHNc883SZ8mJoISACW6lTzzaxZ19Qj2Ioo5a
 eVptp1W4iJEpmMTlHtwlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+soiXRc/U7o=:DlIOgLHeuC7EfLbHItD6KN
 JQE5fxoBiYlgCWT71gwrzIiORwSQ7vkDe+dPLwuH7RaNvB5vcIvZws3uvtKjND+qMNssM/uuX
 YGnBqJ48AKUla/7yQPloB10gVQnx1xrcICopuPRKBKMazxkZQOJmRlJGUvRbTTAj7gQXhHSzq
 49le4M6XnHRCwdwzI4NGt+8gbzQkcMme9FJ9yMW/X9PmcVS2tOOSktpqZWV9YSGtTWAbmt2jm
 QBdgFDvFAmyZGURr9/3tJReNOIsCWADTRSC4o5zAg154Fp0p8L53imNnc/LvUODKL5uXNpOo0
 bfvYGb4ekOx55Hm1Tdc3FlIXVmsXPLIAovpJeqwYZqB7MfcALmLoYrNDs8gSf5siEKlnK6XVd
 eLoUlf3c306pVfY82I9mlVk0IF0M9N2f1r/TT1qsoQtZqa8Q9KDJVoT/LLUQoWs4XKKYu7d/c
 CCTzAWvB8Vfu9NMTOHMdkU+SQacIVOpwfAqvIls1h52/8WVDiaGmWt5+nmFyZIhuuUtAFgbKw
 XNLsakCMMqBKxPA9TEkSfTaX2+Kf//aVklVtqP5SF2V5lkQpNIQg0p0QwHlnMztkmM0d+KiL5
 q6ueLvCO1qQu2UIIquNwXxcrI17z+JHRVfgqafrzNrsmQjzd6apIfJ/Z5kfzaOCWm79fGl6mx
 3i1/RhS5CZrCQ3r9SSMixUYTGRGf9jQdMR8fA/1we6HKengFxZKiBp2Y+Dcm5u4+6nVl8hMha
 ab638wO8hy4ioD3CJJ8Ed0reHvziSZpTFsNhWlZGFWhaYHc2Zks9wr2f5yFSfJbVYyJ6mSYaM
 sp3jzfvQoT+nQmcFCbe3alJMW1vJdERWFo/5SToQyvesGn32dKzdcQ2vmnVZMAH4meMGOC2ux
 exgVS/iAXrNrLKVeu0Z1QGFrxuUlbgO0CtHG+YtUW6HgoDPlvziJTNwoOq+l+sWLLQS/dsLPF
 EPrwOJiZgZTqkxQaZ60gtumAvRuY4+XTiI9pLyG1sxh5Ih75zjCh6DV+3UkZr6GRq8Pbr8flV
 coSd6iJxFsJ4F1vRo7hweoP34Q6Yn7IkcJBpXn02ofB+rIV9GQ5DdWD6UXQZoM5qqQYFN3ocd
 TgY0sergZPTMyrMpTm31g08eWmwr8L22fzdlRXzJkozJuVOGfTLiio9zNAVFU1/5uZLlkd9Sd
 md+LhwfDkxcxGGOG7yA44OpFrYWBG/R9rbiBJP8DZJaDD1vnRCHsXzKV/3eb3AD2yMl3Ny7kd
 hJe4Nm+aemXNbzZBoZOwP22sI4ci0HBr0uKc6pqtPjI5xr//I83JlfuoImeEb1A5m5+Cj25TT
 xNdAPJQw6Av7DZZVOXZsdj/R/ouoWqD75Wt7RNcn2ZLHkcjt5ecEL8h5pnccHccYqVJwahVkg
 ueSgF8xvITTBDeyrhlNbxcZMOQW0aZgGpnQUlcRvakTB7PbJw4Emcn9Ws+VLNdZUoytn8ElZz
 33HFRW64kcJd5ifnHiTEY0E3bwOIb0Yc+2drwzqqsZ7kLXYYxfxj2rGYJSoHGXI/LOWcrhWvG
 XIuxQKz939BDxn5CHtDArRyIbErn1jitP/wCP6KmgnLX09YCceLIXqkFahcJmKEh7pA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1721226974-1666101765=:174
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Mon, 17 Oct 2022, Eric DeCosta wrote:

> > -----Original Message-----
> > From: Junio C Hamano <gitster@pobox.com>
> > Sent: Friday, October 14, 2022 7:33 PM
> > To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
> > Cc: git@vger.kernel.org; Eric Sunshine <sunshine@sunshineco.com>; =C3=
=86var
> > Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>; Eric DeCosta
> > <edecosta@mathworks.com>
> > Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
> >
> > "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > Goal is to deliver fsmonitor for Linux that is on par with fsmonitor
> > > for Windows and Mac OS.
> > >
> > > This patch set builds upon previous work for done for Windows and Ma=
c
> > > OS (first 6 patches) to implement a fsmonitor back-end for Linux bas=
ed
> > > on the Linux inotify API.
> >
> > Again, the first six patches are a part of what is queued as ed/fsmoni=
tor-on-
> > networked-macos that is now in 'next' but lacks a fix-up commit from J=
eff
> > King.
> >
> > I understand that it might not be easy/possible (e.g. perhaps it is a =
limitation
> > of GGG?), but I really prefer not to see them re-posted as part of thi=
s series,
> > as I have to apply them and make sure there are no changes from the la=
st
> > one before discarding them.

GitGitGadget mirrors all branches from gitster/git to gitgitgadget/git, so
if you open a PR in the latter repository, you can use all of those
branches as targets.

But this PR is in git/git, which does not offer that.

> > Anyway, thanks for an update.  Will requeue.
>
> I looks like I can use GGG with the next branch, but I will have to open=
 a new PR (and close the existing one).

No, you do not have to open a new PR for that.

You just hit the Edit button on the top (as if you wanted to change the
title) and then select the target ("base") branch in the drop-down box
under the title.

Ciao,
Dscho

--8323328-1721226974-1666101765=:174--
