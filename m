Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D331F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeGCLrQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:47:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:59569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752342AbeGCLrP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:47:15 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsTjw-1gG9uW3gt6-011zQz; Tue, 03
 Jul 2018 13:47:08 +0200
Date:   Tue, 3 Jul 2018 13:46:52 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: jh/partial-clone, was Re: What's cooking in git.git (Jun 2018, #07;
 Thu, 28)
In-Reply-To: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807031346320.75@tvgsbejvaqbjf.bet>
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9a0toPa0iLtd5MhLQ5nvIZ2eeqEQuwOgJxbGa0skESxO8zHNFPJ
 aolGvrnCCShmsoCt0LBxuP0oXagO+uBRG8+k4VYDESsp5LUlb80FUrHGUalUH31kfSNLtQu
 b37ofk4a+GwET0MuV6xF1XlyHJG6pDRlfLnPOrJ7Qe7vSwyukdb9yHRr3V7KVqPbHmyQ129
 dCX1kSMSNl0epnY48UBeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z7peuL0fd1E=:PnZomvZCHiBOSoKlGgZqul
 lcy21lLLpmlSnG/KgZkzJdmNw7Y8/GH062lEZoWxQjrBRRxVWyuSBmeneroXxuETyM9brwPZJ
 P7LIbzEOy5UybFm09V86EaHbHxBTC6oitQ1VBzBfB6cF/RcOphzX1rkvcqL5P0ETKp+UzWUjk
 9no/tSbc4AMzxYKErIoxy4cR9/12zYn+04n/+wxIZhoOjHMOaHrClGPfMAob9qTM0uyUq6C1M
 03XPk1QYKMLgR4+IKW4QT3wY9vzAi61ezqsSa3ipbwT9enzJPlRuR+WJD36oPwo6h4fcp4P1w
 v2mVxDBBAnYDW7iU9nswn6zk4/mPYvUroM5GregfwiFs/rjwUoSFppnKHSypqPx/I3RjEadE2
 iaTnN3M8XEh9BLYUGmuWm7WrXzeynIh8ekIQQfQT73o8ySKZ2eyWQj3pI8ojus5pD7LnTKoyq
 YVcJ2QqbK0J1lpI4aZmCEc/FIMk/l0ZY920I0JybU1qdp2meG/t3Ofvl1kLx/6KFWbU9wyg5F
 ZnutAA2ZBbu0vKYLF6xM4Nivvbwu2Pkgwx2bQ+9Bnurgq4WQwFtaadsodxeiOkJnI5S1VUdx5
 NpZS5ttgX+pLVSG7thIH3g91NIC4IMjCbg5dUwkBkiia/PSRNmN/3HBx6Sd3Yd0Dgo5QgUd8P
 nuOsm0qMdM+vvi8ncH0ZfXSV6bSVHzTX6+ps1gU/7Zx5U7ahhVPXmCb95MEK+Qw2alBnsEBGb
 bpk5nP6C4x/MsceglPCV9waPE1DhN+EdrzMa0rJMLWdaiM05E6+bJKZhLE8hSjgSY+mcvcuH2
 hatuqGo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 28 Jun 2018, Junio C Hamano wrote:

> * jh/partial-clone (2018-06-12) 1 commit
>   (merged to 'next' on 2018-06-13 at 818f864b0c)
>  + list-objects: check if filter is NULL before using
> 
>  The recent addition of "partial clone" experimental feature kicked
>  in when it shouldn't, namely, when there is no partial-clone filter
>  defined even if extensions.partialclone is set.

Is this `maint` material?

Ciao,
Dscho
