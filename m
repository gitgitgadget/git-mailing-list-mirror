Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A861F453
	for <e@80x24.org>; Tue, 19 Feb 2019 20:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfBSUPo (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 15:15:44 -0500
Received: from p3plsmtpa12-02.prod.phx3.secureserver.net ([68.178.252.231]:33610
        "EHLO p3plsmtpa12-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725875AbfBSUPo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Feb 2019 15:15:44 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id wBnlgvbgJHcJvwBnqgAAqF; Tue, 19 Feb 2019 13:15:44 -0700
Date:   Tue, 19 Feb 2019 22:15:36 +0200
From:   Max Kirillov <max@max630.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Max Kirillov' <max@max630.net>,
        'SZEDER =?utf-8?Q?G=C3=A1bor'?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
Message-ID: <20190219201536.GA2354@jessie.local>
References: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com>
 <xmqqftsn4nik.fsf@gitster-ct.c.googlers.com>
 <000001d4c624$da8e05d0$8faa1170$@nexbridge.com>
 <xmqq5ztj4l3j.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1902182008270.45@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1902182249140.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1902182249140.45@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfFMtOBcOxp3eDBUnzUmHyr4/SgBzjFsPkxK8277Pbsv6tA7frg6HevUMM/ozluMMTkFEmSttsXc09bgWk9icz/EQoqs3e06LjSKQmQxXz97EEftY8og8
 xiHoVmSEqGs1Ad5xcW1WXB4sl1Mz1ecuehDk7mXes1T9Y5Fj28Lj9Cbpx3jHpsJv9Rv5uUwmqFAsVXqFChslJIxUdWPaarJE4EKolA/hNm8h8YaxcWgEEBXV
 aLukjq+hWxgsyOY6KnGYUGhh25rGbvvbCb1q+a4hXgEmV0kBtkeW1QbHnltil3vV1TncqYdJxHvdAGTMTYwV+iWrMUBAdu8m5KuwaMSmEmc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 18, 2019 at 10:57:13PM +0100, Johannes Schindelin wrote:
> I have to take that assessment back. So sad.
> 
> After that build, I cherry-picked the commit on top of shears/pu (which is
> Git for Windows' ever-green branch that continuously rebases Git for
> Windows' `master` onto git.git's `pu`), and the build seems to hang again:
> 
> https://dev.azure.com/git-for-windows/git/_build/results?buildId=31291

Hi.

You seem to be talking about the hang like it's some old
thing, I probably have missed some earlier discussion. I
have not heard before that it hangs on linux. The 60 seconds
hang because of lost SIGCHILD is not it. Also the hang
observed at NonStop is not it as well since the no-reuse
hack did not help (though numbered output files probably
would be more sure to avoid duplications expecially at
Windows where you cannot just unlink busy file and reuse its
place in directory)

From the tasks you have posted there seem to be no details
available. The test is not reported as completed, and the
overall build fails, and there seem to no additional data
except the log available.

Have you or somebody else been investigating it or is there
otherwise any information about those hangs?

-- 
Max
