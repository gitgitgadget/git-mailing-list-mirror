Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4411F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 09:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932531AbeGDJ1z (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 05:27:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:47509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753046AbeGDJ1y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 05:27:54 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lqm3a-1g5pxP3jWs-00eJ4y; Wed, 04
 Jul 2018 11:27:49 +0200
Date:   Wed, 4 Jul 2018 11:27:34 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: js/branch-diff, was Re: What's cooking in git.git (Jun 2018,
 #07; Thu, 28)
In-Reply-To: <xmqq7emcnf37.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807041125450.75@tvgsbejvaqbjf.bet>
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807031504130.75@tvgsbejvaqbjf.bet> <xmqq7emcnf37.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KD3GkHeKa5PTHn9884osbDQWuQFf0x4qjXLPkycnFz1OAi0C8jS
 /9OuaERyd7bnO45IPJaZewiAroyiiv52xV0tC+2g45844USRuayajgyEyIYdhwFCb/F+am4
 IBSsF18EYKJ2OT3R4LwRYCsoqllsjvcgtBNgPSm18XU8N5jh1A6ZVhY5felVOV6DT0JTmpX
 uED88bBBuSaUnoXrLKKrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3hkGC+QDjas=:Nw/E+qKc+Q5FDZxzabzHoa
 eo1Pk2tK6aIkbeW1xYy91CWPPUoyWcA4JVYpoNPcCVsd/2cWRZN73L/uGX57Y5ye8LN4vdbrY
 Pfum915xQq3woL5FeZ7OQu5itvHfWv9InbqQTq78APUcHfBxc8qdI9Mj0G8Ji+N/3jdhTLxHW
 YLLEsAo8JUWJr+SoiDhoOzcxws/HiZ0h3RTsE4mdJ4Wrt06yGsC3EnrVr3DY9Yqdn/biTYu99
 rDVpMam+AYBw1jYrDzpRKTif5tGb/vFGEpHEIrJSwENbWXNLQN4z/JLWq8232ozpwrMZIxbue
 Z8LHYMpKoVr9zUCJvu9IM86r2gY/Irl0LpTzo8JVThKLCjnLik8FIb1gAurH6/sl2t4IY3liP
 eYXLFRVMMmkHvFjLHQ7alaRMVi/rlI5nmlQcSyIrvN+SNXdp9a4OK+RFaJMgH96X7obZdHmgU
 xEUbkDfMg+H4EmdVXatItRi7KqZSEtcyK5Zz8Ps2WU9U1/Zxq56nG06zdBv3hZ2EbVOukOkBp
 W0hvVj9FA0x9z0Y7IeJryJxTq/SHxv67jAolPmRdD4WLTJ71CEMX/D4P6o1uzgJt8cOyJB4mP
 UigmzCLl2vt5v/VDyh3rO0skVRtfThLbMeDjSDX51vfuD+vwWecNGbZro2CJnDkLKNUhd+6SR
 LBgKJML0XThxAch7TMfJL/YNMgGv8zNB1u8qV3yQs4Re2KcqoVuVr8uT48PjotQWq2njmHZo6
 XOaAkoHKQr5fkJhLveyhg6mD/hXdb6D3McgG5MO45d24Ra0nWu/D/J3MFCI5wOQjZVi46IpnO
 BM0Bscz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 3 Jul 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Seriously again, I sent a new iteration:
> >
> > 	https://public-inbox.org/git/pull.1.v3.git.gitgitgadget@gmail.com/
> 
> Thanks, will take a look but it is likely that I'll run out of time
> today, so please be a bit patient.

Sorry, I should have clarified that I do not at all expect reviews to be
performed *right now*. It took *me* over a month to get this iteration
out, after all, and as the changes list suggests: there had been a *ton*
of changes.

While I need the functionality of `range-diff` myself, I'm quite fine over
here with my custom build (which I use via an alias from my default
git.exe).

Ciao,
Dscho
