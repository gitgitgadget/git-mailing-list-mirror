Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63D51F404
	for <e@80x24.org>; Tue, 28 Aug 2018 12:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeH1Qou (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 12:44:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:46357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeH1Qou (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 12:44:50 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Md3Eg-1gCibr48sk-00IC6Y; Tue, 28
 Aug 2018 14:53:14 +0200
Date:   Tue, 28 Aug 2018 14:53:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Teach the builtin rebase about the builtin interactive
 rebase
In-Reply-To: <xmqqa7p7lmzp.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808281451191.73@tvgsbejvaqbjf.bet>
References: <pull.23.git.gitgitgadget@gmail.com> <20180823024856.GH92374@aiede.svl.corp.google.com> <nycvar.QRO.7.76.6.1808260144570.18296@tvgsbejvaqbjf.bet> <xmqqa7p7lmzp.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jD0prrpEzFtbn8WT7IPF9QsazgOIS0eDvjqzVoFC1rRk56UTPFA
 /BtGm5iPhMBP1FKy0Kex3GEvMHUx0PJXBP/1aRo0whFl9O3FeqT33X9juhBXnOQthRC824v
 CEi7LQpvh03AK8MZ36HsEtZk8w43t7Ax9A4LBVw+TqnVvJfW9+W6viRV+h0SeBtyHiKOZ30
 Sa3xt/QXPBqn0Jbjr8m5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gc0HHOWgMnI=:qTxlCV3X9fIp7eddWCCctk
 LBiDa3vKWmCsfop2mH3qWDRMpY6nvbz0r/NEV8E+l1bFvIiMr7Kwbl3p+06vwnqvzqn1LAcnk
 iPMQlmQJ6kzcjLvb+DI3HQjOduwWxSDtxJpUv5e2NoX2qtUAQ59YrS/qsP1bbhwj41wtwUiuR
 ztBgHxn2tgUzNph7Qbma8EA0nGKFE1tm/80VqALKOk8ZHP01/kmRNxvDAtKCd6OMFxolrPwhM
 Jqr7c7ROjPhlo58bUdtSh6f+PmYHu6y7sJkz3MPPUh9+B5OIYvnSeCD7JkKAr9b7n9LIIEYlD
 BD9MwbiuOVraeA1clWkyg0JvhxCvrOBMQQt7um4w4LHfZ5PSj0z0I2spYwmMBjO7VZphvhN7w
 aWgptueVY4mww/7j6sv4OwgLYbORtPWVEF1KNjig3j490biZK7t1Hb6sr9bEU5O5gzhtUaa7G
 ZsB1mchN7JHBjKLPZUVeXHRdRxCCHn8slMA/6FsytnGaTC1inSUdCINqVJ28Nzbl2NDru4jJO
 vKTAvV5DU2n0gHnFkCtbhcWLxI74Yp8W9trolGc2JAmCQeQ16UkXMAAXB+oinjIrYwppC91D8
 FY9MvuHAFX0E4hhKh6bgpR/boG5NKxJnGEP2dPGdmf9wn/AXNarq9BjiIxx4prYAKu8zoJuYR
 bP8xD7cHukw9l9kfSR3ZKvlOAuMuhvtJEo+TWAF15jzHgLXTNcV32kDRlLeUuekxKjmgB7tQo
 VQTKZ14SU2BhaZv0d2y02mSi47tNg992XkMbpkoUboDDs60gDsJfOV0r9MwdpzlUAlkIMg67s
 Sx+IyXy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 27 Aug 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Please include this information in the commit message.  It's super
> >> helpful to find this kind of information about why a patch does what
> >> it does when encountering a patch later "in the wild" (in git log -S
> >> output).
> >
> > I thought I did include the relevant part? As to the full back story: I
> > was repeatedly dressed down by Junio in recent attempts to include more
> > motivation in my commit messages. So I am reluctant to do as you say,
> > because Junio is the BDFL here.
> 
> I do recall discouraging you from including irrelevant rant/whine in
> the log message a few times in the recent past, and also I do recall
> you never listening to me.  Don't make me an excuse.

Junio, I would really appreciate less emotional, and more professional
conduct from you.

> I think what Jonathan finds helpful is the other half of the story

I will await Jonathan's clarification.

Ciao,
Dscho

> of what you did write in [1/1].  You wrote that it is no longer a
> shell script and needs to follow a separate calling convention.
> What was missing from that description that was given in [0/1] is
> why the original "rebase-in-c" series was done while pretending that
> the other effort "rebase-i-in-c" did not even exist, which made it
> necessary to do this change as a separate step.
> 
> And I tend to agree that it _is_ a relevant story in this case.
> 
> 
