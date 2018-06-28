Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D32E91F516
	for <e@80x24.org>; Thu, 28 Jun 2018 09:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbeF1J6h (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 05:58:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:60647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbeF1J6f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 05:58:35 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwaQZ-1gDtWD1fl1-018Nej; Thu, 28
 Jun 2018 11:58:22 +0200
Date:   Thu, 28 Jun 2018 11:57:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Aaron Schrab <aaron@schrab.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer: use configured comment character
In-Reply-To: <20180628020414.25036-1-aaron@schrab.com>
Message-ID: <nycvar.QRO.7.76.6.1806281157110.73@tvgsbejvaqbjf.bet>
References: <20180628020414.25036-1-aaron@schrab.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MAh94aJP+jIih08UJo5hthxK0zb5oglylUL6wn4MUvSUtrsnggv
 HkRx+n5K1Fy6XbLKOZyVkXjIghRKMK0lDGhfHHd5WEw1oJ8vnW7v0WIlG3jLxFHB0LNcMAB
 t4Cke+MtXuEKMqea0CnwzWV0AAXI+rNjAb1fzaIu/LfRQRE21KtJY43VMsXxMCBu5dsipJb
 pbIkxHiGOZIoU9ClPyoPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HzNRhi8vqhc=:/VJJ+esStz+VNljhdY96Xv
 90dAdrafAkt5HfJC/XiefT+ZeMiTu53yUl7eTiBY13Z5wDG4/OlgFCFQ3YuVGrE5W7k9/v4Tc
 3NZCCZk41VsLuUlAONg2GfK1WZRVyV5N+/TtUhPLFN8usnlGvJhf7Z/cA9iuuVB176iipq6Jl
 iBZ0QwzyomokkbPgVjQtdIraVZZz11PwyyTR4DZJTTYNE1lgLO+evkM/imFkPLcAhr7TXjKF1
 UC3ty+pfKAEDPfZj5hS6hj0BRlLzFTclAlqgbfKTiJJzZAvCYYViasnzd2Z5z6RndRcqjt2q9
 Y5P8wsTagECDFrwjSowf7y9ynOuzH79cZedpv9JuGtKPelJYwKtd/UW9xiXsTqOdYPc8nwWwW
 xDbiKBA88C6+qg8f+ssql7HkfDbvZzUCAZ4gy0XC4pXFGBriMreLbrOCuZAuLsQVs/oMOodbl
 RlKvEWw9hwU1uhZ25CINC+y6oCm0OiYOQS38CYfI/hKJGwzd4u+9Je2bfSYczW1fIfJ9ljf5X
 lbLSTGDNvC1YZPMoYusCq4cud2oxgk+zMnKSSEwOsf+IwmnfbSnFAclISyzg8V0wCAygvHJGD
 5vbSDwb8+dX9KS2j3ETUZ39J9kq5MiEH0YMBPeoedh7dpWzMqR39hnuhyNr+WiT3RP9FAzjRQ
 /af1A7cunkm37smaErUbzQhHDK+kCacvXb4O2DR88EmxJ4/ggITBcP/v8OeYzuRvNqGiJmmpo
 GhnlkJ/uYtgK2KsFZns2I6iPJuW/b1MYtF3z5u+c0CRmSJvkpXVqPhPDBCA/6mi3pefXBxbWr
 ODMVrOS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Aaron,

On Wed, 27 Jun 2018, Aaron Schrab wrote:

> Use configured comment character when generating comments about branches
> in an instruction sheet.  Failure to honor this configuration causes a
> failure to parse the resulting instruction sheet.

Good catch.

Now, if you can refer to the "todo list" as "todo list" (or "todo script"
if you must) instead of an "instruction sheet", you have my ACK.

Ciao,
Johannes
