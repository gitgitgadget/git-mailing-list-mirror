Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5D420A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 11:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeLNLb6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 06:31:58 -0500
Received: from mout.gmx.net ([212.227.17.20]:48205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLNLb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 06:31:58 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LkP8Z-1h8DNM1qW3-00cMjy; Fri, 14
 Dec 2018 12:31:51 +0100
Date:   Fri, 14 Dec 2018 12:31:34 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] mingw: allow absolute paths without drive prefix
In-Reply-To: <70faf8fb-5e98-9247-9955-71b8fc983567@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1812141230310.43@tvgsbejvaqbjf.bet>
References: <pull.96.git.gitgitgadget@gmail.com> <50ac31ef7f4380f37a0e2d3b75e82b324afee9e3.1544467631.git.gitgitgadget@gmail.com> <11b17e5d-e843-463b-77da-263e8e3b7598@kdbg.org> <nycvar.QRO.7.76.6.1812111134250.43@tvgsbejvaqbjf.bet>
 <8a484f86-1d43-fc0a-22b4-39c770cda6cb@kdbg.org> <xmqqmupagn0y.fsf@gitster-ct.c.googlers.com> <8efe7938-12a9-7db3-8f95-825ee2e32247@kdbg.org> <70faf8fb-5e98-9247-9955-71b8fc983567@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1025270910-1544787111=:43"
X-Provags-ID: V03:K1:Lbmx+o9hK6OCv2ddCN6CZg0vyX8wH/V9Wspza5/7eFMN0Ms8yaG
 2vdYCi36vckHBEBqFwadNepAb3OTMpgMoFdL42OuFRTJdQo5zWB5J5TiPtD/8YaTNVL9B4m
 hA0Bw8Wqiwb0vX2il+AGciyOrzwUye/wa5TJofJdAdL8J3HM9OhJwkmO/fHRte5L3Rq2hcb
 hfOGmbnOn3CkST5/7M6Iw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9rIOMR21FKI=:jkkH0XqwJk+Eb5H/OhQPMb
 w23TxNWDJDRHdnB4nai0P3DmQ3x7P0zNK+zN7tUZiyDtrNu3sbAVXSUwOZLiSCewHqpUVon6p
 VWvCHa2ioNpg3+XJQYY7lpnwteAZKu8qm1h9w83omeG9cCbiz3GG7lDL2huSzK6YF7YqeD6Yr
 JvI8pTAO6WebpCpDG09U0FhTOoQxpA9FfaeQRbBwLbRCtEF8d/tEgwvOlZ85jC9RaP3UYgfKg
 iky+/D8UFEgLCayh51HjXXLsRvQLKtgnuImQO9HZBXPTNSBdNTuhNROiMCdRXOrOhim9kkQkk
 6HIJFGvc2kHAvLxF+/m/St4qhYfOVvkrmh9kkc49PKFgYtNo9BxE+TV7ziWaXKsd44Yg30sf5
 8GQ0syh/IRMhUpLQznTCmpUy3LUzfUuAjauQ2LQMnOZEKFDE7W8gGkfHY/dbtE/Mo3vtE/AUl
 CsXBWnGxNi0AW4tyAwD3xuhoFrZBgMQaUkNacv9XkcipyMO+FDd9SQVL/HIIaERl1gky0X2TJ
 dta7U5NadxGWph0Pdvr7fa9Q+KTBHIeec0nvd/90DLKR83xKlkXTtk26QgSasP7Fs9hVhm9uO
 M0NK71BKUpUxOsiI1BzUql2EVRzIHaZn0v1oS7CHLWuKNrRytksXhr0RhcPvXvemy9Tvc2lTK
 KPD8NwTHfcl4y9kw/Bm3CVFs7QQqu4bvW/Rj0enVa8GnCeSMmEa1agmcZ1r23hjg1hezvgQB0
 1jICAn4MHr8p3t3MjRl+9/81MpKNAMjRq+bsru9hcC03dhWNExgfsw57KRYri2NeVhFgnnoxe
 nkU4uIBM8Wi07YjyH2or2TpsHgvaok1R71vTmmgbZr9+O6rYNah5gLO2ERrUa5/IQMmhFev0G
 NsXlFgJLHpSfpjpWtuZBsFSXhP1AuHtfTQQqz6O0iiKAaWb6BQmkiqLRJW7Yb8R06s63mUzXi
 h5Yk6VqkuAg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1025270910-1544787111=:43
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Hannes,

On Thu, 13 Dec 2018, Johannes Sixt wrote:

> Am 13.12.18 um 07:25 schrieb Johannes Sixt:
> > Am 13.12.18 um 03:48 schrieb Junio C Hamano:
> > > So,... what's the conclusion?  The patch in the context of my tree
> > > would be a no-op, and we'd need a prerequisite change to the support
> > > function to accompany this patch to be effective?
> > 
> > Correct, that is my conclusion.
> 
> Moreover, there is no problem with your tree to begin with. I cloned into a
> destination without a drive letter:
> 
> C:\>git clone R:\j6t\expat.git \Temp\expat
> Cloning into '\Temp\expat'...
> done.
> 
> and it works fine. If I understood the description in patch 1/2 correctly,
> this should have failed.

Thank you for the analysis. I'll look which patches in Git for Windows
introduced that regression, then, and fold this here patch series into
that one.

Thanks,
Dscho
--8323328-1025270910-1544787111=:43--
