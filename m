Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3084C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 13:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5623623372
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 13:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbhAGNBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 08:01:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:45311 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbhAGNBw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 08:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610024417;
        bh=+fF1jto2L3u+YA0fJUhTIkqHsuj0P9e7pPmhyVtZAvo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BYBZ/gZ7LQS11dDmQ8V5NXs6++jyJAriIqQtp3qRFY2Se9xn1wmnTwMNWqtwFCZ9e
         1JeUK0JSWonFsgmnTBSaW+RElu/5Rg8Ptmx6zfwxO4hoOWaFYEIOLuyG/TSp+40xIj
         QeQrOKnIn7TDp6DDtxeKk4z/9oe00s/n37Nx/5fQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC30P-1kpYo023Th-00CPMH; Thu, 07
 Jan 2021 14:00:17 +0100
Date:   Thu, 7 Jan 2021 14:00:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Michael Garza <michael.garza.embv@statefarm.com>
cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: RE: Submit Git Bug
In-Reply-To: <bae4a7fd47f948e1856aec69a51b2ff0@statefarm.com>
Message-ID: <nycvar.QRO.7.76.6.2101071359030.2213@tvgsbejvaqbjf.bet>
References: <65b88444bf544024a434dbc25bd6a487@statefarm.com> <bae4a7fd47f948e1856aec69a51b2ff0@statefarm.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eB/5Eo3XF74e/UGPzQaiXZiKIHgZaLZpLfoXv0efzbAJTN+DV1Y
 YxYBORmsKb9W/V16ROyRd/5lTJxFs/ETmTvuoh6LjrHXHVJsY/9O7MKusmCBpzq2Jk89Mca
 uJu4CvuM3kQP7t7RF9SbqY3Zp7WEx0Maj1veAr+uspGy5ukB4+nNc/mvWPiOWAGDXLcOu3h
 y3RKsktlfZ0droUoQQKjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kSPHeCNx3UI=:7rkbUL4GsQ6yRUITCE25lq
 BYA/jHhzkTERiFdHMiPFkb/GNDhph68rJ2JuNwDb5hcndWIl2hYfFUJc1fkSkZRmfU0Wo7Cbc
 Q7sRoEzcyndd2hi05GTnMXyIyJJUmwTDAHJH5RGH2WeVqpGfBIpDsSvJClraVm+h7RptfKaQm
 B/ioFeysN/pqxw7XzFD8YhoiYLrHPaXgD659nX4B8yYpajdRRygjwLcA+dTNc1VuPcvp9kPfc
 sfUKD6ayA7JnMuH+VOo2QHnYCdtVZKrLhQpN7uFcE1/8HvzclDdB0zIpV5MxDFqYpkyZG4s8n
 QAGn/+mSv+CXrWykZHzIr+Q9QVMKnIZn/cQZseFb53e8htfabVArz4beTSZVLbVouoNbL85eC
 9f6OubqHNg+PCvJdN9iALwyiXZgXtdJtnOfNccONuUrF0brTKpYv/5MXNTs3C2IRZAEgumdXy
 utHyrBmdA0+XGhZOSGLGtHudKY0Xs5nE4a2HRd7hzodZXnVi1SXYBYAFfcpCjY2QBfoCNDAri
 bT9v6uq/xGgVneYXev8tWDpv84a5WSr/QAeBl698W9CEGjMbN3seNUiQKnBZ8APnnmO+APBbT
 kumtTSa4QGJx+lHepQsFNZRudtx3acF+gq397qDZn5zRuJyVnwp54vsFK/7W1TSXpktG5qdl3
 9afuai6GRFv2sh/DtrMuVkADpSkSLwTLnKsy2VeJLY5Rfs0oqFTgU7anPCSNpasCKdcWi7dMl
 WessAfrdgdbRFBIofqqadta6JibEf/HI/lVdzlWSqhvcaJL8IXYKtvnFqK9zWBfFrL6IAxq83
 vhHYi2e2FiD2gmSjeYkMcq7DEdKuAw/hYMBBh5Iw/Ft2UwrBAnogGbw4x+0F0o6uQbblRl2PC
 aMiupliC8OtaQxyJHfOLrtXXX8Z8OTo5Z2tbClh8g=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Tue, 21 Jul 2020, Michael Garza wrote:

> What did you do before the bug happened? Initiated the cp.exe command to=
 copy file(s) from one location to another.
>
> What did you expect to happen? I expected to see in the Windows Sysmon E=
vent 1 the entire command string.
>
> What happened instead? The log captured is only that cp.exe was used.

This has been reported in
https://github.com/git-for-windows/git/issues/2756 and it has been fixed
in the meantime.

Ciao,
Johannes
