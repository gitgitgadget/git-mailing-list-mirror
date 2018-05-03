Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE8ED200B9
	for <e@80x24.org>; Thu,  3 May 2018 21:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeECVDn (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 17:03:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:56015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbeECVDl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 17:03:41 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKcdH-1fEclr0ccx-001yA2; Thu, 03
 May 2018 23:03:36 +0200
Date:   Thu, 3 May 2018 23:03:36 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 11/18] branch-diff: add tests
In-Reply-To: <87r2msy8yf.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805032303160.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <fe12b99a0b4f78ab75fcfbcf51c5edffb190c4e8.1525361419.git.johannes.schindelin@gmx.de> <87r2msy8yf.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-664082584-1525381417=:77"
X-Provags-ID: V03:K1:48p5MUwIth6bhOlhXoN7MqOWKKpsU3j0I9IIu5gWPCh/VF7CUPV
 A1oARHqdJMHBgJvdTdkPIINOnj4l3x2RTdU9CuiCWd7wYwkJaKtXSeI7zn+7qCpmpbZCJIR
 OoqqWLJpui9L5SQUVce6Iv/DxE81cUX1RnDPuwkNfmo6vNlR7t7rUivTC3I6hRUg9Syt+4d
 zNiVBkYcsDi4b6bxQ9Ihw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5mg10ksf6Zs=:PE2jtk1pjgaIs4sw/Tt9Xr
 BxymFRPVuTyPG3+nbp2tsAAH6tGupkDNLVXAUBh/7MZtieBqcdjcX/B3uEBWTjIgryt0wuu8F
 RtwcSeggdhJpAFXL2FgxW8A8w/pXvmYPuXzs6lJ5HI2PWDLcAmC/K2YFTICpEJ6CwWmRcPrSg
 EEDbwQI7YMLpxA0ea61yvFIKbUdoQG/+aXD907DIBBqbyoA/sDF/785/qcjT0pLgnRdi3TH4q
 mSu9VH/3kNbuBwG/gELlIFu96aVUmz3Wq3i5gSVMZ1zk6S45tf9pA+NGKfeqgfpvz4vrjTlfD
 ILHOYdkRGo4X58lN/wQszxLCOKxS+ZectM2FUkIBiXMCOcPuyo1cPt254TOVPGZ0WYtZXPpWB
 nvrCeD4e24/5/Aq/4WXY9wqMSrzpm8noFzRWDnzczyo7vqQS2cr/VeK/97gb2v3IBsXbPTug2
 c2pwHi5bvd8lh4KtAzpP68denZWIWh1FmpZMrUAKtRJCuh/pwebO5S24HS55R3dhKNnXpzyCP
 Jbmxzx7kOhp7zuiQwsHaMC6JECpoTLrUiCpy3O/qELmUDKzXMjlbdFL5pNroIRS7qWhdse+fr
 PlGd9nB7TWqxGsKWGL5pGYl4O8aK5DilR7SZqIFPkXR2ANSTOftwlSNBX486bqJrxOSrFOC6P
 VaJdqUFupgzhBmDT7zFLhCKuzmJk1wiuQhMQFaTamKLzmlCP78MGwxljhmktFYHBM84KcaJ3O
 j63VIcUN+MYp5+RFUSZ8RnTecu/AAteM6aXeZfe2wpqK/+nTDpMPLQOzxR90QHXP4574mmXD+
 TOETYuU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-664082584-1525381417=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Thu, 3 May 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, May 03 2018, Johannes Schindelin wrote:
>=20
> > *before* the existing emtpy line. And apparently xdiff picks a differen=
t
>=20
> s/emtpy/empty/

Thanks for the spell check!
Dscho
--8323328-664082584-1525381417=:77--
