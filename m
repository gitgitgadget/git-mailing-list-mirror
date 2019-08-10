Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,SUBJ_ALL_CAPS shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601541F731
	for <e@80x24.org>; Sat, 10 Aug 2019 07:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfHJH5H (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 03:57:07 -0400
Received: from mout.web.de ([217.72.192.78]:54487 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfHJH5H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 03:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565423822;
        bh=l0u2srzCH4u7gj1d9DhSh9f10Bw48R1n9oP+3WVDrec=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hnS1BJhdmZ/JLN8aOFFBOiq4mfqtveNTH/oiZxfeJklnHwsvxRt6eho87sZ4pnnFC
         eZitOYsIHVotWjcWPiMlCcyZds3e0kj/7zO4gFOORI/77PxN6OpD3eIfVybCRDNXyl
         pkY1lbE5QDgR0n8vKdgZkR9VLsUaSBU0RK7MHMqc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LtFUV-1iKJFt0mLL-012nT5; Sat, 10
 Aug 2019 09:57:02 +0200
Subject: Re: [PATCH] SQUASH
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        johannes.schindelin@gmx.de
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        michal.kiedrowicz@gmail.com
References: <nycvar.QRO.7.76.6.1908092325480.46@tvgsbejvaqbjf.bet>
 <20190810030315.7519-1-carenas@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f78b57a6-9ede-c87c-fc42-292851d79fad@web.de>
Date:   Sat, 10 Aug 2019 09:57:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810030315.7519-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fqcd26x6Jhw/lmFi6vgP6fm1HNUKV18i67WMnKyu4tagj29CTr9
 qCA0PefDV0AGixeOzEy4SBXLO7uAu68RR6tGPQlMRw/22JgiHQAg88TTruYReZVCabq8vg1
 z1LeS0agPnQzeLrcupBJkA1+yfBb7ACnuiFLPN0z9HSZ/cqkRB5RgxncRbrXFheUeKoh45g
 Y4P2Dh8mgBnY4AA9yyNgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wWaFOPoXtLg=:CQn9weX4pa6N2kSg90HsPL
 5d3K+yK5oYneSa+VIktZZLRqC+/AAci19eTqF/Bpih44indVEcAE4EGyikjeZcqCZjaLdwz12
 FXgFxLO4J+iQT0ZGsMK6s2TgO39tUfEQgOz65YoJdF27tLhiBwcUwyRoXvY5uDBSVYhtj54Ms
 IWBIPBsXumGotT+xZ6mnfSMUhwBLnb5+P0r7HgUZgmo9/XyJLUKXHyBzgtHQARQ0Xek+5Ox29
 HtHnkeq7l4LHe1qW8ymHtsg7VAVb9sHpw2LI7LGZTAetfpNK+EtShmqdWEtjKt0lVk42qmecB
 CRjuxDbdM5fJuDUYpXVuz8dl7ZTyRmVFESgQ04BGeaccN3OZsspC3Nj5KDNof1dvmjvXb1dcW
 Q7io6U1Z7Tv2ETIOt0OWMPvspIhsWn+LZB5pWa8f93ipmQh8NFbxnAUfOisM3uAQIZzsoOL2a
 RbhVY3vkdXJ+I7i/Yan5f89hnsPfXAuDlFkoP6ZAhWnHBUgtFJWy8c0WLS/TAzAF46rLjGtF8
 i40rNXhIwzE9pQ65A4tCZsvWl9SgkvX7xK90O022jgPehevm90oz8GnNjkFQWcX+0C5z+QU1H
 YLbicCEN7JXXIpvOyFwYIZle6yc5P57ZFX4LpcNsdQC3G4o8lHB5o6+OL2thqzZuIp+bZOSdd
 jofU+Veh+ZLB4gUs8Rrc5meOsGGLpA0vX3TeOjeSANOdBrh7Zu2yUz8RVxU9RPwpQ28muhAad
 XbT1wvmF3cYb3qOyZmaIcjGa2efIp9EazQoklcOouNfV7emtqpAoEoRKtzy6TLoLhsnpFGgJn
 PlQ+5vRKJ5dDNN6thNHZEJes1tf+ipIAiIdoCTp7RJGenRrQ1VEhMlcut2kJpKf471epc6M9V
 KF3d25TLCtLbll5/b6gHBGInebiylU6tHe7pQDxF4mkQgSpxTfdS0egVYV0Yv5jDrw2qjDTr8
 Yked6JmvQL+x3Qs3reWIGz1BdR0t6M3wBAotZafurNo3A2GYVbQdXzf/T8bvkb9dix1ZeD5kN
 BMD4G55XLbuPA5QbTp92s07Y3g+Q/ORNrwgY+H1lJr8MqAjY7MF7cvDJWwgzijPGcUKoWWvl/
 jbv+iXtz3tUEk2BaoWEL1kp+dAYATODw5IT2qraxAXD6JvL7Xtsmp+2eiRUfH12vI9oI1q7EZ
 ThwqQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.08.19 um 05:03 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> Make using a general context (that is only needed with NED) to depend
> on NED being selected at compile time.

A custom general context is needed to convince PCRE2 to use xmalloc()
instead of mallo().  That is independent of the choice of allocator.
So this change would be a step backwards?

Ren=C3=A9
