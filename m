Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A4161F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 19:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfJUTfW (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 15:35:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:41987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfJUTfW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 15:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571686516;
        bh=fIH73jW8zsnReWJkAnzmDUnc1CrU6NWOQsNK2H+M0rw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ikC4cXrgc2q2lCsMKmCErrv4ESWg6Axiv7ZuRtzBKSu+DcPsONa4TaMTBJCWt2Hoq
         2yDygLHuAcVVbY5JGbXRzXCJRXaravaBBYt0Y4kuO3n6D9ANS4YjLpTGP0I/IPN595
         Lcb/nolzxEX76gRksQ84BVI/mnxM8w5xJsmzTSqk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeR1-1iZgO71jRz-00Vg1S; Mon, 21
 Oct 2019 21:35:16 +0200
Date:   Mon, 21 Oct 2019 21:35:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] path.c: minor common_list fixes
In-Reply-To: <20191018114202.5452-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910212133540.46@tvgsbejvaqbjf.bet>
References: <20191018110618.GZ29845@szeder.dev> <20191018114202.5452-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1958295104-1571686517=:46"
X-Provags-ID: V03:K1:A/mDGzH6R/8GUHfdiSqiCwwwl6G60fLoWbmMQ7FxNEnEGBp3iAC
 0EAR8TuhBsI0v70+nSkU7GRXvzQCQxDWrfszbnFaudlK6tSOWVGvjs8gVdzWh/PS1k2NK6e
 YQ+NScztaa8FsKEP+uSgKvvo+J8hOLBw4iQMzDcTMKl/EzoFNAMhUkKB+kdvNs6c5Z9cAao
 Fpm5IZ6GueE32OzLRnnIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8rsElG9EK5A=:pb1Kx9RqPT56Xz3aqgFkcf
 fPmvwomGw2tfiGOC8VBpQ6iYjKhXsPvd6Mkw0MGFyO53YfI8FviPou8K2lGo0rtgUMC+Gtbrf
 ouiQEYkNYMdb89FSRu1dXA/gmKtQsAaMXc419Zaf/WeYjMU2uVrQoOv0YO42yZ063x2PVt/Se
 INGQPe0Gx/xm4o1uyJ3JRXuMGtPaUyu5JLs742lhInnEJ5sx/rSFiBvhiWbpRXJGoJep4YPMy
 T72ILTN/W8/GgWym1rJ+jk8RNm6jMmWgR14seKkaAWMHdKGEJuyiYt5xkZIzuGNENVQEv+W7T
 zj3fU+4BkkXc1ncUch0qexTnUV6Ggf4fOTyCeTrrraOr0G2DZcxBPyfm8n39APcUEkMcD0c5L
 hV8r7IzKWWz9Mwt4GTjddZJcSpi9TC5pUUTCpvYW9tUOhE6NM9D3/ot0yLpYwt4UVyvtg/6QN
 ovviyLONQdosIZPcSIVoc5vKr4SzELEyLVrTZuzDrv4aCt7UIrbBXr0iihbk9X8rjqxY6gi29
 wqxni2xDlcFXCjTpljNxw0RZo8K61zWZs2aZiQSvR5HHQwO/9+gsW8T28yZq4jX9+NEPoWGaI
 7Y7NvF71toZOBhFVvQW8HQjVtZfvaAngjgxfFNduj/um/uReDjepuMvVQIeWwXV5WG5sNUXqa
 uub+rUlX9UR4dKCsgngvZqIByUA+h6r+eKJERAQmnGexiSdkFthsXyPYc1pPOEY6dEyVsj3+C
 wE0wT/DHLMVWgHhOQa5dQjogZX8/tZy0PFQiDrQLq/uwnWd+d+2Um7NbJduGkoNG3edoatn0T
 N1+wOCZBzG0rzvlNrYJ/DQ9n7QjX3RiANEFtFiHdjNBagljzcjRm3x8z/spq5y9kDL1dXwYsX
 6HJowgK40XpoKsXt6/819emAaVmagfMLMEZ88xIccqno9uvnLTRW0P4ig30mlvIE9G8NHKM79
 iee/ttjd/2Lc5R0BgAVIZRPR3p2jE8VauSGz48jFyPtV5Q02Rx3mMCg1r11XomuxMBsweuZY2
 CKtnV2BQmHzWOyuhp8vHvTxmAZgNXDd2KPa6dExVRuEFA0dhO7/l2hSSBcvTlq+x7dFXbke9W
 LtScOPLcvnqncZJQLfX3Gfy0iSUeSEMPZ9fKBdn3NYcECOH7qHKnWFRVuj6b4bNYqO/BNV9wo
 UXr71xE0fsxdd6UcHRzpavFrm7sHYLNxTKeWXpAlFloHBHnHCxDnQVUVUMC2CwNoW/h/2kc/z
 xO9DtMLM2GUEWMWqmyYHCNL2ILa4P9C4VlMQTq4V9iq83UBMDDgCPIiezcPU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1958295104-1571686517=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Fri, 18 Oct 2019, SZEDER G=C3=A1bor wrote:

> On Fri, Oct 18, 2019 at 01:06:18PM +0200, SZEDER G=C3=A1bor wrote:
> > I didn't look yesterday at all, but now I did, and, unfortunately, see
> > two more bugs
>
> The second patch is kind of a bugfix, though luckily the bug doesn't
> actually manifest in undesired behavior.
> The first is a minor cleanup, so future readers won't have a 'Huh?'
> moment like I just did.
>
> SZEDER G=C3=A1bor (2):
>   path.c: fix field name in 'struct common_dir'
>   path.c: mark 'logs/HEAD' in 'common_list' as file

Those patches look very reasonable to me.

Thanks,
Dscho

>
>  path.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> --
> 2.23.0.1084.gae250eaa40
>
>

--8323328-1958295104-1571686517=:46--
