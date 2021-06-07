Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7C7C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 21:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5637761208
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 21:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhFGVvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 17:51:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:34839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230394AbhFGVvM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 17:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623102553;
        bh=PiJjWkI74IY0BItU4CpNhqAykNThsIuuCZyGMd4PMeQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=g8Pa5/rK6zhR2qA/tOl12gEwWkzVwOUTMx98hN84ntxJz/IIZyBKW9AAl7ZhaVI1i
         nAKco33qdHyHs7J0rUdqXyJGWG9YntyO4OvNS3+Yemk/TH9q3GAHzDYN/UDiul4CE1
         MJLkfDnbTzAg28fRTlcTi27b2EjXgPZSXtxwNnhU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.8.58] ([89.1.213.18]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72sJ-1liO6207jT-008enB; Mon, 07
 Jun 2021 23:49:13 +0200
Date:   Mon, 7 Jun 2021 23:49:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/3] SubmittingPatches: remove pine-specific hints
 from MUA hints
In-Reply-To: <patch-3.3-a61885a198-20210607T110044Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106072346560.55@tvgsbejvaqbjf.bet>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com> <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com> <patch-3.3-a61885a198-20210607T110044Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1784397550-1623102553=:55"
X-Provags-ID: V03:K1:L/7cxJnzhBjBs4Skk++mOX6geGCUd+WtNg/8EKZJzj3gPMZ0rAC
 JlF+CEsvo4GXMI2s8Rz0feGxGdL16sdcA/9xrqRMW1t/Emvi8kyVDT2wbGODgtSPShIZeqn
 ZVJngxgJ5QAjg7WyYHc4uzlqB4W0Ll5gjdsrbZ1g8fpwhkt6ddL7FsdGRqPkFsP861YwAQV
 98VaNSmdc6caWojnSiQhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6I0+95mZBrI=:OJSAYnnWmbbaHQpsgMR8+E
 hZmMxr18bhldJ9r6vLPSigNnvx7nFJEZfqsBO8xa1w4HWikW5O7NUhVMNa4rnU7EaAh2ZjcmA
 QloTohw5f7hTm92RPbQ8/mxF4voOSlEoYBslOOFiznWaXR07wMweskVE5jaW4NgR6VCxVhdzo
 D6Xaz+hKa3viCwhUR2tMvEMS0OuzicepGC34xbxTRPB0XiAit3kZNVe+VvG59uNnLm4Mb5UJ7
 cDhSfKJE1s6zD08M+O1uYFMTG049wLvMaQxAuNfnaPP0N59BUDkCmfw5s5s9sBMPD29P7In4o
 bcUx5G7slX31ri2RrwXbZM1M6O1moduRwtEYlKZW5qyY8cMN2elE97AEU0nKRfo68n+wPzfCv
 FgG0GrkVr12C2EOyJt1endVG8Wuc8vrZ06vjvRuq45BaeYWKWS/RvNvZYFyX5VVCOuC1HFrhu
 VcRhmWDjuyt2VLc7HoJZrXlq/cVqXaX+U1qXo1etR+mcdpDYL/DPDfTGYhi00YU6ZW/Be+g0q
 IU7LUBGwQWabCM4V5saaqzr8yOe0AiaeycAGYVL0hKRqFuJ13HaGvLt2LS9aFdDoCooR9/uoA
 +iaeGOhevpN0jnZ3Bf6knyQ0vip4dZL+8Enl9YSnVqNmo2TIz8WAosorzSM/RZOfCgPdkbUgG
 8f6zC+OjdbzWE1tDrhCYXxHvUWqj26i0Z4hkTRWMV5pjbpVDS9I5quFFILE+c8qFxe9Wu4nmk
 lFNs8z9g2Jdr+udriZXsEDsjyC86wz6z3D+atjuJBGUACLiF8hUcH0AvQeexE2VcyMuVAL2FM
 IrIWrBH1Lzpjyg8C04+kitxlTDN9v42Uvn1fiuEmAJQe/oJpA7tSh0BUxkYVBlnAl02S2Lnmc
 qBN+GndAEhPAkBV2KG89yBqwx+q2IArHWwBzeXd2hPtwpxsbQPi7WFEDHW8vImCPeb8EX7SpI
 zkGLs0hr24cMD11MfkbXoYZOeYvyVgKzsA+XfSPvWvz696UieG4IIeWNhF1WcdBZSe1Y6Xy4I
 asBqaPqcCoVgGvJr3ACzo6QNDk2Hr5/PIR4RvkWNek6EiQM7XOhjOb+I2dtvqNB+/jgEvX5g0
 kvWpji8oes3KLVnWVnkxw9FXyFVroEDlsUkHkyc5c9nEsZSL/pKIxEd4w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1784397550-1623102553=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 7 Jun 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> This documentation was initially added in 9740d289ee7 (Update
> SubmittingPatches to add MUA specific notes., 2005-08-26). At this
> point it's safe to say that it's not useful to anyone anymore, let's
> remove it.

I am using Alpine, with a config that is based on the documentation you
remove and that you say is safe to assume to be not useful.

If you replaced the information about Pine with information about Alpine,
I would be in favor, though.

Ciao,
Johannes

--8323328-1784397550-1623102553=:55--
