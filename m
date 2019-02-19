Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7790C1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 10:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfBSKFm (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 05:05:42 -0500
Received: from mout.gmx.net ([212.227.15.19]:55411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfBSKFl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 05:05:41 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1Ee8-1hBEhy3ekS-00tBfp; Tue, 19
 Feb 2019 11:05:19 +0100
Date:   Tue, 19 Feb 2019 11:05:01 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
cc:     'Junio C Hamano' <gitster@pobox.com>,
        'Max Kirillov' <max@max630.net>,
        =?UTF-8?Q?'SZEDER_G=C3=A1bor'?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: RE: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
In-Reply-To: <002401d4c7ba$d95a1130$8c0e3390$@nexbridge.com>
Message-ID: <nycvar.QRO.7.76.6.1902191103050.41@tvgsbejvaqbjf.bet>
References: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com> <xmqqftsn4nik.fsf@gitster-ct.c.googlers.com> <000001d4c624$da8e05d0$8faa1170$@nexbridge.com> <xmqq5ztj4l3j.fsf@gitster-ct.c.googlers.com> <xmqqef852awh.fsf@gitster-ct.c.googlers.com>
 <002401d4c7ba$d95a1130$8c0e3390$@nexbridge.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7mOirRZBj0+oavKeVB53lWH9m7YnXVUGiKKI67z8GAaYrkJXHTI
 BaeSOG0wi51TXzxL9UzsPdcI2kdc5MHZ/P4X8NN/kUqLCsH0Z0LgvYZqZbyDHArARaurpXe
 wZ76ZUaBeIjm/cPiM/WcS/OmRsz+XWdGr/Ezk+YSVVP8/bI6GyFcFcAmtoRnbMJT4iRDUFX
 xAWK/dbzBc9pUF4LER7tA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5aa8ijTIfyQ=:ZOAe5AxR0zxLg2aEt8j6dO
 +zPvH6pTcNY6QneRzejDg9jgggY/wgnn5KArDrp6pZUjKNY0lw7Gibd53SOxGFA9yNVu620qF
 5ALrGfFWBg0yqczUSJFW+kMEj6lX3c249+KQk67f6cqW00ZIgkR0BJLRdzN6BBZOxVzkPNbel
 tXrDTxw75wwcZj2/rC77vrIegsxFaL2l48L3BsUFlj3Zt1jGyqPVUlzj3O6o7Uehuelj5MITx
 vLH8T0HaBwADZCduzmu/lOcIH7DTLLclkRLGAmKhqFWmkVO33VkYoHq8UQj09x1udgzkZABVR
 88sPPIksacqop+QOiQBRGN7JfrRi57g14iBG/z7pYVgHGy0ts8WwuVk1G8WOo2dpvMTu2fTh4
 /kj9CUrASJ6RkUTHdd1C9dRdv5J9S/EhiXdD7LE6jtOi/dICRzJZkbAF5tpz/JiSmcDJMpHsL
 Td1xfo620P8CaBgTunz7Zb0S97oIEQYZBrBX3PPF76zqvVEn2A8l8s+w1nD+1kEyxkFBjZxqu
 yof5fdt9n/lHExglC6y/WxGRH7NfXUesRVbNUBfx2hSbM0MztD80B4OizsszS0hzp0Ae7aWL0
 sKYTkqPTYupx6Wzh0sq2jD74028iBL7sFolbBqBbZj4pRy6yRvMeC+pZbW7RmA1GBJ5E9S0ZI
 WyhTDVa1CdVuUqOKqWQ3/tX8AKhldcq8dATyEqyoGDP/ruyp5O4A9NH+j60b27u7jHBmnJCAG
 5Rp0MVbvu1qQYSSbeF9OVcIBc1wFufVaQYeFhJ+7k8lsLhtQg+T72WkWUK3b7feSKMi7AYfLQ
 h4ZhbScTjKobrgzhxbZ3KN3bYbifRRXPUc6nA0g8eQigNKaiSM2hdXfxAAlhxXrcpKI6XzEiZ
 t9plaeWoALqKq/ebctVigfigG8Yr5fFIHKVc9BbIzhuBk7z65deAiNq1FAD49kDvbsWVw9NQX
 9eVHlzMWiig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 18 Feb 2019, Randall S. Becker wrote:

> On February 18, 2019 13:46, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > I have been wondering about the whole /dev/zero business.  Although we
> > > have b46221ff ("Merge branch 'rb/no-dev-zero-in-test'",
> > > 2019-02-13) in 'master', "git grep /dev/zero t" has hits in
> > > t/helper/test-sha1.sh and t/t4152-am-resume-override-opts.sh, so it
> > > must have been somewhat incomplete to help platforms that lack
> > > /dev/zero in the first place.
> > >
> > > We haven't heard from Dscho in European timezone, but I'm inclined to
> > >
> > >  - keep b46221ff in 'master', not reverted.
> > >  - apply Max's "t5562: do not reuse output files"
> > >
> > > to 'master' and hope that we can declare victory in this part of the
> > > code ;-).  There may be fix-ups for other topics before -rc2 on top of
> > > that, though.
> > 
> > Just to make sure you didn't miss the exchange, the above plan is still the
> > latest ("Max's patch is [1]).  As I'll be offline most of the day today, you still
> > have time to stop or make me change course to avoid disaster by interjecting
> > (which would be very much appreciated).
> 
> No interjection expected. That is what I have been testing, so anticipate that this is correct.

As I wrote in nycvar.QRO.7.76.6.1902182249140.45@tvgsbejvaqbjf.bet, Max'
patch did not actually fix the hang on the Linux agents.

So unfortunately this plan won't work,
Johannes
