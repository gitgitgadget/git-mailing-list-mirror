Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE48C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C87C20857
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GKIFT0TE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgDGOzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:55:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:33109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbgDGOzI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586271303;
        bh=0gpK2xKv43/NiABhn9Rf+VECfvuQAzfZn543dR6igkk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GKIFT0TEVb7XFYDZ/OSMPLsZQbH7tzXZ/Mrrha/Ix7XkbVKynhbTQNWBSn8j0/1P9
         62j6oHKFBzJPK+ePh10ZsD5KqFImC9tJMvko1cpu+RsJ/TRd/KkxzpNtCKRckS/LZ0
         VOHmz/PQsDMsSYg4hgjLPec+bo7BDCbaG4oek8b8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.75]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M9nxt-1jPO0A1jpF-005rsw; Tue, 07 Apr 2020 16:55:03 +0200
Date:   Tue, 7 Apr 2020 16:55:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Travis jobs for linux with musl libc
In-Reply-To: <xmqq5zedy8dj.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004071654170.46@tvgsbejvaqbjf.bet>
References: <cover.1585474409.git.congdanhqx@gmail.com>        <cover.1585961568.git.congdanhqx@gmail.com> <xmqq5zedy8dj.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1720361533-1586271304=:46"
X-Provags-ID: V03:K1:FddvOkEAfAgVAOGwXkPltEGyoJmREirrTS3xzoTeQxM9FKJwKFk
 RLekDgm/tACdWhK1lLUMa435wF6pm+LvNKA99Moit3QZ995BdGq4DPB47BouG9u3WZpUAgb
 PB1/ul+lY+yCviz8bvwVEkaqHMhngNe0Nr21MwOYAOYwnq6wPf1GO/C2Ohq9SFLI/0Pg3e2
 Eet0k7F9fQZ8y9NU9jQ6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c9CnmOZJpIk=:mMnmazxR31no4y2ollB6s2
 lf4I04P59cn2x7U2T8VMy3LgjLvBvdsiVkwZEwTEVVKeciHFZpA1Q8AH1oMbiDDePG/xCl0cP
 A0xyzMq1SAZoFC2mL061yXjxIksjL80GgdcSeMeRvWwnWkMQm4ZGpNtJWGqw+Ac0TO35vMlGw
 b+onSek8iVVgJN9bef7MxvQUNaSYwdkziQiql9cDShFI1xwYuDW9NmRT4IWwtHuyzKQ2IN0a0
 4j5EzmoMnFeVk5BK5ZuOjSZ0wSEdYyE7homXMyRRR92iaf6Q3847PAIOMFw2diNrk1+Jmn5pw
 n/T+/QL/NE4905v9NzUYWRUWA5Yop5ehYpBh/Ze3zz6HDknE4xNy5vkW2f2wzbcxudnxFxzfk
 LtO87A6fmzE431iezTKXc+R7jjmYL2LEiiw3xLcur+lsqomkiwCrjiNBCvOzyrNBmeW0TLjr4
 xUdjCjsG0r4qy++CoLCJjmD2/QKN8UAANX4IYxfZqd/4/cFzfbUkSKLGBoVjQeZVy27+PbYFo
 yr7AXWi5IzCKLSHf5ALB79w0GseapBh2zNg21ayN8NuphJKDrzx14EPiuXboj3hrpa7IlxfMN
 GrBYrW7/MRldOZ6sgL9YTy2RVmN0bwfax5SPb4GDKW8bcAMT7cb5BDt0BUHWoaX+zc8sjQD94
 RxSl4XPQ8Rs+t27Vn51qvuRkXuiXe2Ysi1nbZjZ3sKXDPWuPjouEVHESqM1n2PuDbYfKtdxDq
 8ConFGsOqAdYyf/iZa7m9OhBv/2NO+SoUhgEkpo+pdl2iTQIaS8fVpBA5cediPrB8z1J5EFBs
 2Zsi1xOidIl7TUAKQiXj5JuTsKyu2AZTxCHYtRcJcykMEi+0FTpKmDQ9O6UIkXlghl6kMcJSy
 xerS5Ebp3w7NKHSNKX0gt9sNT8wK6c7FDOMwWcNsB45lXnh1QTvXVS5UoEG/gO2cfQSqaX4e+
 OgWsMu6z/UP3NJjlNR+pnLJD3V1bP3Y003c95VdI4ilzAse9KG4N3wG+J6EXYgIStLE89DJ/o
 FP0XEa7bWCZwzRC11a/w3wwFYzeZJsIVei46S0QCwAx55TQokHPnGba7rJAPGbpgTGsO47tNj
 lXQ2wO47B1fkJCU/vMAME8gXMvEc9uH+MDQR1NbXPRX8e+GNeIZL54NeTkutQL4Baf8eOFysY
 as7veDE78qgfZyKhkSRULPYtq5pfh6mNy424ksYc2ksrtk0ls55qobCRC3hjBign05mwSdDB3
 yZta2x3F7YxZEWkUGV5NxmgvvrZaEki3wtnvkUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1720361533-1586271304=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sun, 5 Apr 2020, Junio C Hamano wrote:

> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> write=
s:
>
> > The series for GitHub Actions will need to be rebased on this series a=
gain.
> > 6/6 in that seriess will have UD conflicts.
> > Please "git rm azure-pipelines.yml" to fix conflicts.
>
> If you want to keep doing this, please take over the ownership of
> both series and build one on top of the other.  I asked you and
> Dscho to coordinate and work together, but Dscho seems to be
> comfortable with the idea of letting you touch his series, so doing
> so would still count as you two working together ;-).  I do not have
> a strong opinion which parts should come first (it is something that
> can be decided between you two which way is cleaner).

For the record, Danh and I _are_ working together, and yes, I am totally
comfortable with him taking the lead on submitting the patch series'
iterations.

Thanks,
Dscho

--8323328-1720361533-1586271304=:46--
