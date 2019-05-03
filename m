Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFCF71F453
	for <e@80x24.org>; Fri,  3 May 2019 09:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfECJXi (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 05:23:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:48187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfECJXi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 05:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556875411;
        bh=/xM3TGrqRbgbaFVgKpKaaRdBn9oZJqmp1WnFDVZLHQs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SygQlBtyNFDtQQQ08f3WJYABJgD7hR1BEd/Rxg8558Z1mnurG/jYUoOXgm2f/JG1o
         qsacp/DfsAk7YacqPu/AyAvHEEjSaYPqQBZZ1zrL4HOAAYyQxMEaHnUr3QfEvWcWN3
         pUefUj+p4GhW2IxBpmv0FysKpaY5pjna3Uq3UmLc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.123.157] ([95.208.58.119]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVayZ-1hFjbh3db5-00YxeC; Fri, 03
 May 2019 11:23:30 +0200
Date:   Fri, 3 May 2019 11:23:30 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase -r: always reword merge -c
In-Reply-To: <20190502102249.9071-1-phillip.wood123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905031123150.45@tvgsbejvaqbjf.bet>
References: <a226ffff-212b-d81c-11fd-bb496b84a78d@gmail.com> <20190502102249.9071-1-phillip.wood123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qYmqCN+ffhCdKaQTml0L/LGyqvxRfFiIvud0i26kFH0p/BHgatM
 tjBstTyjFm/GX/mt0E0t57MUYk3eAqJX7benIC7SNoEmzD326/ty8j7cVmIXVav8m4ADjZw
 lHMw5HirSgyXcCL3ztOSofNrx6zBuQq9M3kW1G5oY+OalJ4NFqvIXeEyPn6oubZ2y9qqVqw
 F0JZGQdfkHUUdKE4fHHrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hcVCYxvVHIw=:RUc4SSsVp8gpLrckLldK+a
 JsbDfolcAyBXhvV/Yw0E/6Ei9S8MeafDOxlMQA9t5NV/0w5zalAabDhJ5+mSc+bRs8XgNXulv
 uZ8tljW2VMRMBl41TO0VtmMV4jtiq7DsUF0qVYbvNkKSAFEDWbmTtlmffHGlSBl63PPKcMYCy
 Ls4o8wu/aUJxhDi5aPl9l8i9nbr3WzP1NnAQlEp1ZLHNfYOSzzZlqkMsefpD56lpd+3QXBvoE
 09B1wXR5bGzT87ku2GEynwlIbYFeZBeBhFo77njzgfFJ8XYsTN2/7rdAB/q6mU9fBh1LGaFKf
 JFG7qQwdxJwWlHPvCLGoE2xl9FinyD79XH1LCOHWxIN7HNK8NNoAQ7F01fP/+BN1P4noP9GaM
 ed7Q3DAJauIEVtkyX1lAVq/mF3zL5vDECoZ3bn3/yvSs0o17W3ukNf1C0VewRGjmrn9nRV0jv
 Lay3uM0TLE0KBJi9HevnrWoNDWDxTL03FMgDIWCvj8IkFg5zjP3gOFKDb7oOScTSONEUWy6Yz
 uAvobUrmp/e7Y5IUaqEhUtu0Mo3HxeP53U4zMrFisatiHU6WBbbY0NB3ofGkN14p7YHP80wAH
 yNBSbeSN3/CrNOAIPpo4MvQtMSvhZKiPLqdBaBbj23Qer8tX+9Z/uShHGFR7eMiMd70bIY+lf
 c1DPn+1S1886YKagz1s/AOHysFX+saRvCvktVT5VIlL4sObNe4IbqWHlr4f5Pa6MCRjdHjfgz
 VYzFwuSdMvuHXCz5KznFHhI8AZIfqwcKAmQ60Y9gCH/BvmE4Tysayr1am8QfKH+kKZ4Rgjgzp
 sCwNI5zhGnWKZqJDn7N/uo4yNCWvbmMvtKXnmDrzK8XUIRJkMXUmXWWcIDHcE/tGIi6yW/88U
 Gn8/3258Hx/vRzZx5Gi6ZqLVYx5f+g1Z2/TY+O9+C3dPlawKXTSV3fdE3F6/Kxiz+gIoIVFCg
 NkLirvIWsdA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 2 May 2019, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If a merge can be fast-forwarded then make sure that we still edit the
> commit message if the user specifies -c. The implementation follows the
> same pattern that is used for ordinary rewords that are fast-forwarded.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

ACK!

Thank you,
Dscho
