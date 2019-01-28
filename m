Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD7851F453
	for <e@80x24.org>; Mon, 28 Jan 2019 22:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfA1Wec (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 17:34:32 -0500
Received: from mout.gmx.net ([212.227.15.18]:57605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfA1Wec (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 17:34:32 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3zne-1h5E8Z0FEY-00rcDv; Mon, 28
 Jan 2019 23:34:25 +0100
Date:   Mon, 28 Jan 2019 23:34:09 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: sparse job, was Re: [PATCH] test-xml-encode: fix sparse NULL
 pointer warnings
In-Reply-To: <a6b689da-b002-0aa2-e9d6-755d004bc320@ramsayjones.plus.com>
Message-ID: <nycvar.QRO.7.76.6.1901282333350.41@tvgsbejvaqbjf.bet>
References: <68a8c70e-dc42-1df3-3616-c096f63cb848@ramsayjones.plus.com> <nycvar.QRO.7.76.6.1901281706440.41@tvgsbejvaqbjf.bet> <a6b689da-b002-0aa2-e9d6-755d004bc320@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LI9+3myyQIxRRlGjEoCEVcQmhku7f8gWuSdQQryf7E65u1w7UNe
 TnAsoLi4gxxRtyFrSxB86IsyPcZP2jkpSpPAP05DAUmV8LDJoZZJBq+SqDMnyPwvLoPuplP
 G0nm6M/EoRF9SuyTY9q62ISq5ISHOLaKfEwgy1ZWbUXBIMasNoLz2OjZOl+UhhNEIjoi5RP
 245/X1aMpR8d1ZXHccMGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vsXPi5+vccs=:5FJOPCzNEPWS6wiC327xWy
 ycaO0TM4fQ1G/6l4YSNZ2l6z8XT7i4rA/X+jNpnTZRUGN3ooYqVrnt3SUudjdJw4GdwJakssC
 OA3JvYA2zbkcwcFs9o9V8is/KLE+6TgrLS6FxtMJCWkK5wVjVqEtRWVV5ay9c7R5NiPTF45gL
 3GcSn2BcBo9Hc67ryq/iJIb306udDhdQ0HxwdLJbX/fBHIXBH0OUfUR7QcTEth3WZO1JN6LGe
 jLGr9KJfTVGtTCRPcyHoAZ68tnd4ucWgvtnjVkd//wxM58dwjrbnmog+2zO33/V44V5kKF2Rr
 okbvyPugGVQ2eMPNcRino3k9AEBeQ1FsCujx605Ty0fbnBAA3WajzxMWVrIquvuJU2h3DkJrp
 teb6ya/Jz42RhTNJbVNyxechkJDusB+IVykWk9amd5D/ebLFCmFCLk8zk9snN35fsXoY912KY
 AOlDe2qV8Ip2o3O3ubX9qNBC2QhXJ/vtWp+KHuXej7ROdgF8FzIvlLLRSPgPrAri2Ir8lcTrH
 0NX4kZvlrJp2ujGn6d4l4yW5WuW+PcXOhVJ2RKvQ81k8LgZ/iGINfFEMddtT/arFSyj73Wz77
 Rxo8FNtS051lgeNpOYpkIxNBBOap4kf2+EsW1iKNjDiY31lwuSP+M6fm8pCyWgco4O07GkeCl
 2lSx5+6ITY4GsIVHJons2l53wUgEwW0ivLu0fyd2vXPCAlZH7N4OzxltHno0+wCtYx5yXc6zL
 ycmnoggDf6chRVMJx3i/+nmi5EKbYt9xvewi+Ti/PglTd9gHziJfPkyV3oa6P69mbHRIpbUxH
 4r80gRl3TZBsJfBDYjJuVMJeJcagG49vTz9GbXb3q/tGjVeuUAgMZZy9yZ2ry3OgYqoSQZOLt
 HqErYdJ1NpijxN0GA5AuCjcfS9j6APUHmoV7ZI+T+/GEIQyrre37iM2Sh3x9nmbYo6dxtL1n2
 hPvkNwg9D8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Mon, 28 Jan 2019, Ramsay Jones wrote:

> Hmm, I've never built an Ubuntu package before, so I don't know
> exactly what would be required (spec file etc.) to create a PPA.
> But I suspect you are not talking about doing that, right?

I would have gone for `checkinstall`... That still works, right?

Ciao,
Dscho
