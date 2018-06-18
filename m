Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB42A1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 21:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935031AbeFRVqe (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 17:46:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:39937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934667AbeFRVqd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 17:46:33 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mc9U3-1fodCH0VaJ-00Ja1A; Mon, 18
 Jun 2018 23:46:26 +0200
Date:   Mon, 18 Jun 2018 23:46:34 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Todd Zullinger <tmz@pobox.com>
cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] rebase --root: demonstrate a bug while amending
 rootcommit messages
In-Reply-To: <20180618164958.GO11827@zaya.teonanacatl.net>
Message-ID: <nycvar.QRO.7.76.6.1806182343421.77@tvgsbejvaqbjf.bet>
References: <pull.3.git.gitgitgadget@gmail.com> <d59805a43ddaf4bbd4528a2b7afa9809eca9b86b.1529177176.git.gitgitgadget@gmail.com> <484fe825-0726-a027-1187-de00df6406d5@talktalk.net> <20180618164958.GO11827@zaya.teonanacatl.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AZjkQItVrTFeyhh1t+9g7Klgb8n4zRvHvnC03oTA7QOF8eX8CBs
 sILnVriuvo1BST7BtIo/c0Ny4fPoboiwUK3EEGiWcu3BJr4B/nZ7DRQOiLiqkPtoPAIqX1N
 AeMBZJxLPiALJOyY+jEeCb9lc0Q5ihp9WLkTrvXZmZYO1fM6G3BARkMfcyM6V9D57lbZ9NL
 M8ha694QdsDyevngzItEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aNnmqP5YJzw=:tMVULaBCr4bEOsLF6JcWnM
 hPRAMPht54zOhV89Rs/RewSI6bzWVCT0r2qdbWObq+YXyEqYa7qbsJaGYH+JVvIpIm8aZYWGt
 JTlVbxcd8LJMuf6ntSknX2dFWqPxQBrgZzvMaJHOu8QOxbU46tB43YX7FBrKwyoHas1+tL2uc
 G2qlKy+JRaKE3jJuLaFsi08fNneBJeqwzZeUi/luSIGBIN8WrcVxcFsqzo5iGKxg46EMSgV7C
 qjSUORB15akyRGzfZ+/J/JaK/2+5bhobJ2FceyaLwkYfJu/JXgJY0KP6E6DqqphKX1czHztB0
 2Km4BooK7xguqAdcxaRsby4/pgHoIGCz58jCFhEpnSi9hFrBq+QG10oEUAtd87AspGr71qZhw
 o7OsZfm5P6iZUSJ7UMnbXBAYQ2CUHYXMsU4GzNj93y/8v1mcv1s1nK0nMJ/qjrVsZNpYDNfUN
 GmCSmrn9MJF6O9+giX3rx/Xq9HmU8eyC7MFslcBtet/3tJZsd0DtCVRvMR2ugOkJnnmFuqY6c
 RtZJj8NiGzbKI8gVGCtbalTLV1bHTDTswAWe1Ptr5HNmfOldikqfbOBUHyMusxFPr9/uWVxD6
 2xi/X7dDHdgUnzfjZ4IsYHuZ+xNSlSvph6ohxo8mH+s4yi9zzfYFx6hq4cZXM6sjm8/IxrHr5
 Pg0iUElLBBI58oRpK1lgycQ0h6HIUYEEpJ9tql23QbOfwr3v8a3ariD6LtlLF3tB9evUvxA/D
 nfBfHkeiVfZVSwpLogQtXCbofn2QneU+a17mqxgUkduic1JB3KWlVurnAsYA819ETxGkkiOK/
 yS9y2U/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Todd,

On Mon, 18 Jun 2018, Todd Zullinger wrote:

> Phillip Wood wrote:
> > On 15/06/18 05:31, Johannes Schindelin via GitGitGadget wrote:
> >> 
> >> From: Todd Zullinger <tmz@pobox.com>
> >>  
> >> +test_expect_failure 'rebase -i --root reword root commit' '
> >> +	test_when_finished "test_might_fail git rebase --abort" &&
> >> +	git checkout -b reword-root-branch master &&
> >> +	set_fake_editor &&
> >> +	FAKE_LINES="reword 1 2" FAKE_COMMIT_MESSAGE="A changed" \
> >> +	git rebase -i --root &&
> >> +	git show HEAD^ | grep "A changed"
> > 
> > I wonder if it should also check that HEAD^ is the root commit, to make
> > sure that the squash-onto commit that's created and then amended has
> > been squashed onto.
> 
> Hmm, is that something which other tests don't cover or an
> issue that could affect 'rebase -i --root' with reword
> differently than other 'rebase -i' commands?
> 
> I admit I'm not well-versed in the rebase -i tests and I
> focused only on creating a test which demonstrated the bug I
> noticed.

I think we should test this here, to make sure it is tested, and it should
be as easy as:

	test -z "$(git show -s --format=%p HEAD^)"

Hopefully you beat me to it, otherwise I will try to take care of this
tomorrow.

Ciao,
Dscho
