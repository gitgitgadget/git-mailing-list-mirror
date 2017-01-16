Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2799920756
	for <e@80x24.org>; Mon, 16 Jan 2017 10:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdAPKve (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 05:51:34 -0500
Received: from mout.gmx.net ([212.227.17.22]:58936 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbdAPKvd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 05:51:33 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtZfc-1cafZG3D3E-010xEE; Mon, 16
 Jan 2017 11:51:22 +0100
Date:   Mon, 16 Jan 2017 11:51:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        kes-kes@yandex.ru
Subject: Re: [RFC] stash: support filename argument
In-Reply-To: <xmqqvatfc0rt.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701161150320.3469@virtualbox>
References: <20170115142542.11999-1-t.gummerer@gmail.com> <xmqqvatfc0rt.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:L7nVeIvn1ccnVKASP0yTvcLYbq+A+tJCZx0ljzu9R4Qhs/ZE4gM
 r2HCahJSxVdPXFQGgytXF76K3/Xoh4OIKH9O8NaT47/Snr64CnITWwzbu++oGLW1hY6fud/
 JpsnLvdrSzMoMB3bQqk5Rry3D+wExoNMgW2Hbc6HvIkVjGWmns1TOzLs+hLmuuC5GLzAoUC
 Yw901roPL9uHEvT/OiB9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B8la46xWcs0=:cljklXQH1P3SUN7I9QDMbv
 lT/+KoSDfdMS3l2JUeXVB2FktUOhIWTlSI4zadgQBNyoILBC0x/TwGR34+wnN1Cs5cfGx89KQ
 AdN7axbkhYu+CXhXuK6YzvJL8qzquYP4YJDEBOHykjQtd3DL5DVKfZUj0foZY1GT8gtQAtPvT
 BOJYiRTxqX1JcmZ39BqUUEeluGVl86Wn/VEvDAkLH5jvlGxAe5QYZeO+39hMMvZ7DLR85V0QP
 d1A9v6rrylZUjRgzobtWEAM5oYgRwJWsODvEYPzOyRmEcjzyEgJg7f9/k9hDUv1gTj+E6vW2V
 /T7n+VNV5Qj+IfKIubXm60Uf4EiDONXO7Fb4xFA6jFtObPCDGkZtSbxXmnYnGR3YqPf9X2zTE
 g/P5ahpbr4SbD+kVdSuC/L9hVDILjQYs+Ush2eGa41BMK8R9rACQ69XTK2i7RSsi1PhVUZeY+
 lttUh8bDAraO5VTZTTl6TzAx9WbKZkELgh2T8gZJz6SwRb1ulggcdlLVUR/DMe3MVDVDaLYL5
 1NgJji/ZNLrpCgiwwcLlK68S8KTsQqfxfIrSon6/j08PeJNFZqENhBJ00qJh0QE3MvGzKVJAC
 7XiKNVyQ4VijaRfC13aVnbjsE5PJnH74ycE569g5ZEq59X6yOg2mrNahjUC8+ZGkiYxKIJqbJ
 0PzGsKQfTw2+SrHRvuyy69boP59KQkViSTirc/qUeTRwQw2kodujMGoiPBtUaEOmyzwSRTJnB
 jpIsOKUKd/TKfCbR+VL5AjcXkwgk2a4K9qtoyH3UJ/9Vop48A3fJkLzI7qiUsgkUjy5GEb9UW
 4412/9qKCZ5A462QuNuJZ4F2hfu1tGEkzl1Qo2vpPoz3gIxYI/MOhtxd+deSYQ0JeR8IFABzE
 VLpd4AoUmWqcSmHhJesNONEkLxzY71SdSaXUppSgT3pwvx6/sU5wx/38x9xZQyhdjleI+ACet
 hRX1ewOpjHbDDmApNxUfcDMRHLPC9zLcMDXoVpx2EIAm3N7Y/khpIJ0oDnZdGaixcEmCmSbKc
 16VfhPLzcRV60qzi524WZp/vYCDAHobZJ1aUEmTlx616K0IS0ffRB9mY60tkMza04w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 15 Jan 2017, Junio C Hamano wrote:

> I haven't spent enough time to think if it even makes sense to
> "stash" partially, leaving the working tree still dirty.

Think no more! We already support that with --keep-index, and it is a very
useful feature.

Ciao,
Johannes
