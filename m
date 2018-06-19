Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9EE1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 06:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937261AbeFSGyK (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 02:54:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:51097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755803AbeFSGyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 02:54:09 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4nt7-1gPU8t0akf-00z0xS; Tue, 19
 Jun 2018 08:54:02 +0200
Date:   Tue, 19 Jun 2018 08:54:11 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Todd Zullinger <tmz@pobox.com>
cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t3404: check root commit in 'rebase -i --root reword
 root commit'
In-Reply-To: <20180618221942.GQ11827@zaya.teonanacatl.net>
Message-ID: <nycvar.QRO.7.76.6.1806190853450.77@tvgsbejvaqbjf.bet>
References: <pull.3.git.gitgitgadget@gmail.com> <d59805a43ddaf4bbd4528a2b7afa9809eca9b86b.1529177176.git.gitgitgadget@gmail.com> <484fe825-0726-a027-1187-de00df6406d5@talktalk.net> <20180618164958.GO11827@zaya.teonanacatl.net> <nycvar.QRO.7.76.6.1806182343421.77@tvgsbejvaqbjf.bet>
 <20180618221942.GQ11827@zaya.teonanacatl.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6SjFxtIBHoSoWV8501A0QT04EoSm7tMA42DIb8FRymPjd3YPidu
 ZWpeJXKF0B04emC0QAbH77Y5GOU47XuXR5J9pBOZPdsl4So4s0yB7ZTFfND4qZViogA8ADD
 iPLk8jmyBvOcQN4PjgM+q2mOJ7c8F7HYkTQ4W4J4G2IfEdRMl/yUvNjMjcHJ6gUqFqax7SM
 ousamBojft9rPzErO4NfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dh9T4uO29RM=:2sPCi7y/4Esz/rbFJsnjGV
 o2oGsE+gkc1cl29/FvTeJHtPn/LmQgkGUEvaD6A5uNec+YDzsW7AioQhKpsHk9OT87fI9AeLN
 MrnP3juUb8MhnN811uj2h+oWqjROD3eqbncZ6ryp1RpjWorR7LD/1y87Mp9UQcsQFdjbmTcHB
 5lPZ0a+n4wZDi/JExBLM8Lh13+pIz2RtjVcbe8ibRjIFmpYL7GVGiSnI2a/5nVUsuxo/rotfX
 xteB6u+zHQwBmmW/HC1vdeOUFGye8BYsWUAmxFdgtP1+YEf0gee1rq6NeCSoOcOviONooSxJr
 cv69x54HMRlspoRVvOBCvFUeFOxQ5Rs47KdIFkvani0hYKl+oKGhTUWi8NHqhEzJDTYO+x///
 SCXPsiDR2faCv3c3n0P99MfEeba0PXP+tVpuphVk0vyp2F+Gll/p3i7O4iz9TisFhzxxuoRAV
 /ndGDEe4lGNDRtUuujo4UvJa/xqHix0Pv/4l6OTlItidOm3EYMJLOiUBjljlqsTLwefCS1bfz
 J1h/R6PAe1lRItCRr+M5lSx/WhYNeqFuZfiZtzYpY+lvvD6cvebgy5Itn0LrCH72esCUnme4s
 pLw2B+c90qDounJONHEbAe+INgv7gJdoOT7EJ61q3h9AlW0de6FeNR656KJQtuwdYm0YFiWs1
 psvlb4Dr64KUNY3QdtBOt20XohddIrhmc3npKN30rcqYacgnLCZCk9MBqk1wBTv1EpoCL5NeH
 3LvDTHgWzS8DJutBkGFfWHSBX5EUinnzvh8TcjidWPGBkXA1HbJ73jyxOpa+2VMwf40IoTWc1
 Rgdqgc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Todd,

On Mon, 18 Jun 2018, Todd Zullinger wrote:

> When testing a reworded root commit, ensure that the squash-onto commit
> which is created and amended is still the root commit.
> 
> Suggested-by: Phillip Wood <phillip.wood@talktalk.net>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>

Trusting that this test passes: ACK!

Ciao,
Dscho
