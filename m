Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2EB1F462
	for <e@80x24.org>; Thu, 23 May 2019 20:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbfEWUFy (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 16:05:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:56681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387455AbfEWUFx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 16:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558641938;
        bh=fdzdXILDSg2XS9OsW55n9MTeyIRK4fJWLrpcmtqd3rM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AzfMkwYc30nz7HT/RCq1Ql/1KEynodmfszVb4mRc1OKtLPGCfUnbT5VMe98pAR6w8
         0bOkAN3Alz9KpAETNSRbJy0FyRuW9wRravuhqX+QfmbpG5Zc2QulNbMsu6egThKSck
         5LbjfzQr7Rdlg6ugB5lSnMe/YtHxjbEPx8aZ7O8M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmjw-1h52nj3rZq-00TG3L; Thu, 23
 May 2019 22:05:38 +0200
Date:   Thu, 23 May 2019 22:05:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        'Git Mailing List' <git@vger.kernel.org>
Subject: Issues with t7519.19, was RE: [Breakage] 2.22.0-rc1
 t5401-update-hooks.sh
In-Reply-To: <004301d510a4$bbe362e0$33aa28a0$@nexbridge.com>
Message-ID: <nycvar.QRO.7.76.6.1905232203130.46@tvgsbejvaqbjf.bet>
References: <001501d5101e$db98dfb0$92ca9f10$@nexbridge.com> <20190522004825.GC8616@genre.crustytoothpaste.net> <004301d510a4$bbe362e0$33aa28a0$@nexbridge.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:31WTnJ3jW/YulDMpqAJKGq4BQzG0/+nlge+gPjVNr3xLS/hWRXV
 h0DO97YrblTdawNfModtZiDDPpGlkfV+qFjOz4Dzs+9KIwSjhr4It5lDWAEfQ51dEir69OM
 IWzgcfOGjTBXtcCJgOdhwJMyigyP3EyPYYczXHlAcUOvvNgk5ruwtPhxJQatqLvVRjQZTFS
 gsH4tKUXkIIvJw9TT634w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LDb3Z1MDQ5c=:cdXuQW3LbH5y1jtvl3qYpU
 V2AxdmUL72LN+v4c0pmYgXwDQrj/1Ks9z5YkoBDLE4o4rcin8tTsvXiHqXXTFvvQdK1jPKH/I
 VwOrbs3QpGyXp9cUSfL0fZTAeH3RQdwrEpteEk9akjfTBpoCxBO0d1jAIlyaTKmFkoBXF4l8Y
 S41YQqoEXvKiyHgvmORKDoE8z5H2qrcwFvABPleax2ogj79DcIF6QWm15WFcy3h34BYDn/nNE
 I2PdGOmAWNC5efDfRr+3Glf/2mhVNgc/zjTU++qcLxuEcQQJQ40HusIEtM7SA6+30M/yKJ42H
 w8pRJRpSQvlhlhHC42eJBVDgcTacuBRKD8O6+8E3Wvgh5ZC2MRdFeLYraPzak+F2bDBpGQ1ER
 O1zvFVVI/mEzUAkHhimRGyRz2hkkHJmJNWwCKew9dxaaMyTBgIN+ZevngBq3xJ8zxJbmxJTmW
 X+F95V1YP68U3lqFjRH/Uyq3x4dF3dEXmSFaRfTmiTHERdxuY9TcB4cQo258EdV2qsqXZk1xZ
 osqw5iQbWbNZ2sKcukC+Lkq9t23Hgb/1lwRnMlYHwRqfTVmjMD7UQWQ2ee2pvfdFsipsULPSR
 8tp+hi/qd0/JTNu7Wzb18Kfz4eXfEEX2t9dWMjNyPuyz9rCLlRqTcb+MHCgyqsPIVJevpDiW7
 rkWYafRNb4xCtRvS9NyuVc9PYhIMJTt5RwlS0EB/TCWZzP8EuqThMNlvAte3UN+f8MQCc7nlv
 HbOrQwkYE/WumJ8IWloMOW004QZzfc7SHLCttJou67CbjT5cFQTR0Q4cUp+TRqSubSCb+j9pC
 wm/g0fJ6z8pmmk+I4tB3FA3G7oMWBgshdyL4Cdh7lp4/Am29Mmr6SPKQpeXd5qlUFS4DBXjUX
 CzOtgI/UCS+UrSaWWupf2aLpWCWtr2VfRsxsCrBVAswfe1LdI4fIqtAUOR56k3ftTEvz5JEUt
 Bfz79rvUh074zCnygLr9W4OYNEWb7bNaLf9imxTrcb2SGFLZP1aZS
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

On Wed, 22 May 2019, Randall S. Becker wrote:

> On May 21, 2019 20:48, brian m. carlson wrote:
> > To: Randall S. Becker <rsbecker@nexbridge.com>
> > Cc: 'Git Mailing List' <git@vger.kernel.org>
> > Subject: Re: [Breakage] 2.22.0-rc1 t5401-update-hooks.sh
> >
> > On 2019-05-21 at 21:47:54, Randall S. Becker wrote:
> > > When running the test in isolation, it passes without incident
> > > whether or not --verbose is used. So far, this only occurs on the
> > > first run through. I wanted to report it, based on the inconsistency
> > > of results. This is not the first time tests have acted in this
> > > fashion, and I realize it is difficult to do anything about it
> > > without being able to recreate
> > the situation.
> >
> > Does running git clean -dxf cause it to be reproducible?
>
> I will give it a go. Having exactly the same behaviour in t7519 subtest
> 19. I wonder whether there are breadcrumbs not being cleaned up. Will
> report back when I am able - may take a day or so.

I fear that t7519's problems are *completely* unrelated to the t5401 issue
you reported earlier. I hunted the t7519 problems down today, and I could
imagine that these patches fix your t7519, too:

	https://github.com/gitgitgadget/git/pull/223

Ciao,
Johannes
