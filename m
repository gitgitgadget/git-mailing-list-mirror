Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06BF31F453
	for <e@80x24.org>; Mon, 18 Feb 2019 21:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbfBRV5a (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 16:57:30 -0500
Received: from mout.gmx.net ([212.227.17.21]:55349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbfBRV5a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 16:57:30 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M35iN-1hDw7z2g4t-00szcW; Mon, 18
 Feb 2019 22:57:12 +0100
Date:   Mon, 18 Feb 2019 22:57:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Max Kirillov' <max@max630.net>,
        =?UTF-8?Q?'SZEDER_G=C3=A1bor'?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
In-Reply-To: <nycvar.QRO.7.76.6.1902182008270.45@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1902182249140.45@tvgsbejvaqbjf.bet>
References: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com> <xmqqftsn4nik.fsf@gitster-ct.c.googlers.com> <000001d4c624$da8e05d0$8faa1170$@nexbridge.com> <xmqq5ztj4l3j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1902182008270.45@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SC3gsXfJyXE0pz+pDgr+j+vk143rZzAizSGGFiBfhSc+a8eIYJY
 jsYwqyoT4r+CyYAMNb1BZg6C2bgDEASnukjw+/Pi8AqmYEO36gBlqRwScyLdZ3kWAX2cSsL
 B/l2GgRwYk/FrbjjbfLHpGTqShbhvxrRJGivRZopDv6QHnbc6ZrjDwNY+Hi2LNGsZWfG7kW
 kVDs7rMfc2oAbu7bl7SnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o2iMJ8152nI=:tJF9Ki1NE38p7STr9V8CF6
 LnMaZzZ9qdLj9smD4dwr7VPjcRP+x6YoSKHEhU8nG8z4d1YxyCipf7O+OxQfbZBXh1H+rAk/W
 ub5zBK7sJPRWP2RgQ7jhC7jgWn7tg0DP3+FY0HDepylexN5jXzyldVuXIKBo7gpxkU2kY0txa
 oX9d5Lb6//CmNQqMHxCsJnot3lzFWeampoNoNJge/9jRXC4N8ZDehpyVDZEB9jvNiA9OC98Dz
 k3qB+09TKKmKUDQVDct4pEYcaAkRpyz9N26I7f7DcjqeQsizww37tyPLDKsJ2Naay48bq2Ds6
 OImSmrGKfFjdnIS+ZSLBMW1EYZdtVzU53Kua5TDcM7g6NCL50qj0v9R0z895x9Oq1imk9sEv2
 ZQVArwBrLQgYMwUC86ulfJzwmb84IsukwWTHpzi3LSUXUJ7LmJvqvI9bmdQ/yuMpFTiyy7um/
 hZCrvFBZqsteWImsLpaN2MHGY2nygbZ6HLT4AxbkNEK5eq5ItW+uz3CGF//OVA4oEEHWOzjAl
 iYGohKhDVh6MvIkYFQzLeH0nqbgslViCIyyU6jEPspF4eBO4Zu+wDiHSMHaeG83cZEO/xIGQZ
 0/KQQgKb8/883loxtsDXJznR/SZ0PhE0WUtL7uFsMX8rffSkeGNkTPuVnIlgJkZZciGpRT8cG
 mKtKeDigbTNCZy9/9yXRaULtwIUb9LQUu4Cqc46GaRhKmk25haXA49CFZFrl9+s1X3GtdgAY0
 HJ3JGx9D34HkuPzYH2Yca9wiZgNekjuqlZGdm27WeULoYVULXY8feNqUCrm1tf8d6Kqfua3zw
 I7yYMW9+Z2bv3fGjb2YyP87e/zsBB0Yqg/MCMlp95UnTkb5dz7Fzh/a6ZzbC09l83gt2L8VvM
 oOHpERe94JAWosGcOYPvLIxU1r2OnJtMR7zBPYaElvkD/bAYEFWoiqS01gKiDRLiRQMDnrTcW
 2D6c452GxyA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 18 Feb 2019, Johannes Schindelin wrote:

> On Sat, 16 Feb 2019, Junio C Hamano wrote:
> 
> > [...] but I'm inclined to
> > 
> >  - keep b46221ff in 'master', not reverted.
> >  - apply Max's "t5562: do not reuse output files"
> > 
> > to 'master' and hope that we can declare victory in this part of the
> > code ;-).  There may be fix-ups for other topics before -rc2 on top
> > of that, though.
> 
> [...] in the meantime, I tested it, and Max' test seems to work:
> 
> https://dev.azure.com/git-for-windows/git/_build/results?buildId=31274

I have to take that assessment back. So sad.

After that build, I cherry-picked the commit on top of shears/pu (which is
Git for Windows' ever-green branch that continuously rebases Git for
Windows' `master` onto git.git's `pu`), and the build seems to hang again:

https://dev.azure.com/git-for-windows/git/_build/results?buildId=31291

I kicked off another build with Max' patch reverted, and my `test-tool
genzeros` patch applied on top:

https://dev.azure.com/git-for-windows/git/_build/results?buildId=31293

I won't be able to wait for its outcome before logging off for the night
(read: feel free to check its progress yourself, if the linux-clang job is
still running 10 minutes after I send this mail, it is probably safe to
assume that it hangs, otherwise it is fine), but I am fairly certain that
it will work around the issue again, as it did exactly that before in
several tests (and also in v2.21.0-rc1.windows.1).

Ciao,
Dscho
