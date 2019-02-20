Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A67E1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 20:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfBTUQc (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 15:16:32 -0500
Received: from mout.gmx.net ([212.227.15.18]:34357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfBTUQb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 15:16:31 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfC00-1hOyA829hw-00on12; Wed, 20
 Feb 2019 21:16:12 +0100
Date:   Wed, 20 Feb 2019 21:15:55 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Max Kirillov <max@max630.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?Q?'SZEDER_G=C3=A1bor'?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
In-Reply-To: <20190219201536.GA2354@jessie.local>
Message-ID: <nycvar.QRO.7.76.6.1902202112420.41@tvgsbejvaqbjf.bet>
References: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com> <xmqqftsn4nik.fsf@gitster-ct.c.googlers.com> <000001d4c624$da8e05d0$8faa1170$@nexbridge.com> <xmqq5ztj4l3j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1902182008270.45@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1902182249140.45@tvgsbejvaqbjf.bet> <20190219201536.GA2354@jessie.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Dffrzjb9qua4XF50dE4oBUY26C7IiPO40Moa+zHppdy9oUZmxRm
 IjJ+XXZ+lX/nodHmoc26e4oW+C4w+IiDn5ywz+FnHFFr27umedPcRxESfmiksTg13Z9cwel
 LU/0R0WJIUtQlwjKl6pGm/tv6og9aLXUfVAMoKuq4SOLWRNwHeObKUjuF2fdphnzDhaNZ2q
 xyFlPm4zJTcXm5MQKlz5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h/JtxkBB0Bk=:/WBl0XbtXYRW2exs3QMjcg
 F6LcXNYqbA6V6yJONUTL4QZbmnHf+keNDBvInLdxHqewE827xLeDt0/2qOeMamtMXIq4NGcVU
 CxTZpMRoZfi3ARhIJ0ZeW/ujkNeqoIvb/q19aLGgQQCekXClo1nOUQcjXE8EmrhwRnNbodkF/
 e9f2pq10BQS5LAfhxBenBiPcBeWN3BULwOUML00uFzAbEcQNz//AzR8JuokxCX2C5Ns0TIZfK
 zxpCJpz99HvHtXObmlIq9XZfhjnRc95QXy/ARg6Uje9S/PihHM89t4CTCX4XroKCiNvCTB7D7
 zrox2xZA0dpCepI0UP3ZmrT/o/vz32J5ftLBabOhl4MoyiP5Rft3vQfQ0J/qd8kWA/G4kWp1Q
 RTumI7FkL64gTCBk+scJs9hY9wo2sOn56TZsNA5Bdm1F0W52sFhEoE5ZLsopIwknSUvzZlBZO
 yoKQzJdpY8PSXPAmTLS9Xsn+qsIY7cqaBRV0NWCvB1AxZyTktOmoCt+ISs30dbSzkucYjz8fe
 CVDr7ZLqwyO61EDS5vRjnCdaHvMLeY2PelRxMMa9V+BGF36NqcL1THSTu9vDFLMGT1ibmNj8C
 otFrQTO9DJsxlkAu8LDimo4t7nvSKfn879P7+T0lo9mi7SMjN7cSQHTOSJIX2BxT8Ywe5+ljK
 mmOb3MLVbshdIrKMebD7n4F0tR9F3hHNsxrSiea32K2k3M7ML4d0VDdaqdDal//195gSuDYHp
 4bGD190Y4Rurfdn2pY8o1+WJ3/lFBdKKNCsu9gzZJvBu8gibaKbH66IstwA00zyp6g+3htI3K
 tyFNtLY0Pa4Hf2kRlIch20iPdL6Imvl05XD6xo2Gb18ZazmmHE+8cpGRzK4cv+pZQGuphPG7+
 LfOP3yhFx7TXeyRlHPZmgXlbS27Cb7B4JMI7G7zLLgxMjOOp7udEfQWUu/kRsk5ylcrfddY2U
 79ryMr5E2dg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Max,

On Tue, 19 Feb 2019, Max Kirillov wrote:

> On Mon, Feb 18, 2019 at 10:57:13PM +0100, Johannes Schindelin wrote:
> > I have to take that assessment back. So sad.
> > 
> > After that build, I cherry-picked the commit on top of shears/pu (which is
> > Git for Windows' ever-green branch that continuously rebases Git for
> > Windows' `master` onto git.git's `pu`), and the build seems to hang again:
> > 
> > https://dev.azure.com/git-for-windows/git/_build/results?buildId=31291
> 
> Hi.
> 
> You seem to be talking about the hang like it's some old
> thing, I probably have missed some earlier discussion. I
> have not heard before that it hangs on linux. The 60 seconds
> hang because of lost SIGCHILD is not it. Also the hang
> observed at NonStop is not it as well since the no-reuse
> hack did not help (though numbered output files probably
> would be more sure to avoid duplications expecially at
> Windows where you cannot just unlink busy file and reuse its
> place in directory)
> 
> From the tasks you have posted there seem to be no details
> available. The test is not reported as completed, and the
> overall build fails, and there seem to no additional data
> except the log available.
> 
> Have you or somebody else been investigating it or is there
> otherwise any information about those hangs?

Sorry, there has been so much talk about "hang", and we got quite a bit of
things mixed up.

What I was talking about, in the text you quoted, we an infinite hang in
t5562.15 on Linux (but I could not reproduce locally, it only happened in
the CI, but there it happened *reliably*). All the builds timed out after
60 *minutes*.

This has thankfully been addressed in the meantime, so "my" hang is gone.

Thanks,
Dscho

P.S.: in some other thread, I was picking up on something you said about
that hang that *you* were talking about, the one timing out after 60
seconds. I did not observe that here, but I had hoped (in vain) that a
quick read over the code would turn up something useful (which was my
suggestion to close stdout in the gzip case, but it seemed to not make a
difference).
