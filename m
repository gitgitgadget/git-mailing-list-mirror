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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7DB1F461
	for <e@80x24.org>; Fri, 17 May 2019 18:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfEQS10 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 14:27:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:38893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfEQS10 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 14:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558117641;
        bh=o2kG9fysEEKbFk/4bq0IVZCtucoWcc9Hvx4vxI0t0is=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Xc3PxIbzKnVJ3y1Bba1XYcVwnkbtCoyeh63bt9W9a15X1HZs9C8eJrryMR6Vh/n2w
         JBuFdTOcMaXJDFl6alejm2Zo1uk8+5j7W301mlhvtbh+60gn7YmB6Ee8HDcOaoAWSI
         gTKsFc5ZEE0A3P+hoUxKb/sYqhe4x0gLpTpERUSo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MC30Z-1hXQc01dlt-00CONt; Fri, 17
 May 2019 20:27:21 +0200
Date:   Fri, 17 May 2019 20:27:30 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: js/difftool-no-index, was Re: What's cooking in git.git (May
 2019, #02; Tue, 14)
In-Reply-To: <xmqqsgtg5cff.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905172025450.46@tvgsbejvaqbjf.bet>
References: <xmqqa7fqbahj.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905141153150.44@tvgsbejvaqbjf.bet> <xmqqef508q0y.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905151015540.44@tvgsbejvaqbjf.bet> <xmqqsgtg5cff.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9sr7139hkJJOoIcLpsFDwGCfR/i1Z1U7kgQKBWtuxFUEUZaAPot
 bJmSNUAzIETtrUA7tbE7vSI06APF/IamAHF6w0fNmSNJ2sqnvaB39MhQ9WqI4kwriP7I+f0
 ejWdOhJVypgn7YWeMQ7m+Fyfjf/Da4CYVPgYh3M4xMSlfGBrVv/tdQd/eCk1SgGhbwzHXc0
 OGbQo7lzzM2iyHgvn4GLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NYlp+Cakdbg=:N+l69bcqysMViw0cBXddUp
 0LobA5E/sA38thvpErthZSCiHQbhBfuoMElnKaFBbmudC84/IU2afguBZEnDzXxJSt5e1qNlQ
 ZvKOukAttaLFFkGD36i56hPXj51T6SentJRxhu47wn9+/SFxfikHIYjQpYtR6T2aLMzJKDFUi
 0Ji633gFnGaZ3lfrHYkeHRdlkpy4FU/dxNOmZImK/CSMSeUSi4iqmFSGF9X8BiTpVm0tyL8wU
 L9R48NU0YHP/VAhUykI4jGsgK6hZPcs2simm9HRnbpMs2czQVmNbrN5EtI1Znb3XTUyKuyUfj
 DtzkqlUWBNv/9hNq3kGRhRv001C7xaoq9Uo1dAxeHwfvLbpIiYY5lHPqDJmENplJr8X7WoMsY
 41MDPJGUAKzpCxkWalLHfbvLNf7OMVIi0/mGDSBC/ocTGf8oQywTQ1L2eZDISYDFXKCBOSctq
 OQ2Z36xfYDqEO5W4QluOKbgHkwsdKqKmEVVAcFR6NdabGDssA7lwPqcUyBWRYfRksE/gJKOTG
 12MGp3eRr4tboU+mmBJ74Y+6LZoi4J9m2uGXsJLsERbtbb4RMduipztYmKY2hPYe2MP1E2sZb
 LVfNE+PkPULPWrBjH6SS4udy/th7gua1iI4ClU1SUsgCYRHrD4EIbH4sygO1UMiZwIvzMur0s
 sqM7Dn7xXBKRYewFKiYGvBBP0PTLmwmVIxtZTzwcHL0V3cyk+RCcvefb82KI+Rg++wqNUC3sQ
 LBd8xTNaMNr2T2vZWU0OZTWhVcqK/cYPx+Wlg1rxO3UMrbCKzsamtUQ+g5LKEr0yf/4IY7CIw
 D2wsBfTTP7LCAh86aZBGhFH5sKolE/Mj6IqeevnQQMz4hUSSd2Dc917hcz6PeGV2RZtV7qRpw
 Jx5PCfAADofHAKFGBR/FnBKGURHekrIqlL04D9lGoHFcEJmYvRzzWI5mG2xM6tXsjSJdp8gxG
 bJiTcr7w2cicMWph5pSzkWthIv6qXYLY6up4g66OyZS7eqq9k1zCO
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 15 May 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> I was imagining what would happen if we treat _everything_ in the two
> directories being compared by "difftool --dir-diff --no-index" as if it
> is tracked.

Isn't this exactly what `git difftool --no-index` *without* `--dir-diff`
does already (although without copying or hardlinking or symlinking any
files)?

Ciao,
Dscho
