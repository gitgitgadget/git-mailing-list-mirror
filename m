Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FED91F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeCWRnV (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:43:21 -0400
Received: from mout.gmx.net ([212.227.17.22]:57305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752284AbeCWRnS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:43:18 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lusmr-1eYvfk43nN-0108FQ; Fri, 23
 Mar 2018 18:43:14 +0100
Date:   Fri, 23 Mar 2018 18:43:12 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Wink Saville <wink@saville.com>
cc:     git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
Subject: Re: [RFC PATCH v3 3/9] Indent function git_rebase__interactive
In-Reply-To: <34f2b9350324772dcce9cead650188601a35ac15.1521690197.git.wink@saville.com>
Message-ID: <nycvar.QRO.7.76.6.1803231842240.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1521690197.git.wink@saville.com> <34f2b9350324772dcce9cead650188601a35ac15.1521690197.git.wink@saville.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uCdi/AmzvyEE9u8Rk0R8iAzBsTm4TMLvLSyPo99BQqpHhfjBaWG
 Br0hgHTv4l0ctjQ5gPsg0F68xiCTBHMOoeyKV7TXnOqIeTiURMb3UJVDqwXAm78tcYA8xAZ
 IVHPYb439iysNjKu7u69CcGwv8c3ArE1lMkamqyX0MCdCi2h3Kr/2OzpSrU9UHEnBztkdBX
 GV3vXKiHn0yUDJP4SeH5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4vTUAPv4jRs=:yg+ARHvaQ7BvZJbRRQHoLa
 //sVEVuAtAg9kShj3tFRLsFa9qqJ2UGwQ07+XtVzTRo3mla2MhG/eLj2KUZe5xtFsEXNCTk4N
 grXM0QsYlCX1S3cMLYcO+/GgP1TgzwibtleCMSMPa1yKE/fui2XGQ4mDc4kx6s0c4vov2BW3h
 egN+JJ00ZoiJI1zpJuU/DyNDTDWxebr7p0l7pN02niQ+fQBkl5S6PnMgpmyyY+oupOdKZCKtg
 KxbOZuY8u74ZmEXCNu6aHNbRjrZSMe2YwWZV91WNDaYJpw0RvTp2YBfLIo7uK1b2/TZBiSzhv
 JY710tfrcbbzGzLTPX93tZmFTl8AUWraTIyRcKA6Lteg9JCSa5cgH0kKLz4/pWwK4QEztxJzQ
 acEfB7mXwstSQPq5LQOTsOSKkPgDYwFkyNkEdii54cm2iJ3hDNd4zNIE6ZSOicNJDC52geFpm
 yHCgEGuVQB/EpR3IROi8oBDrkpOLlJFPU3BwOSmSUPwOZmeA4u9ZzZdVc77Atb6B25w1QKcM3
 0oAy9SVakQOzXgfovqxbW/EbQ/fh0x1CReQkwEAanZRCAqsy/m+GZu5TBWjvUGpcS6u5xs6gZ
 7YFnCjvZGJNudrV4ZznMLlD9TMDShcORQhEBAgxNce+XYY6YrTZOWTaKD7hxk2Fqh9DN4tttH
 pLyvZqQckfnJDsbXLOLDcYVnPCb3x5U/KVLCwFSUbIjRcPbQY/5ft+TU6vfu/J2siLak2UtLM
 78/kGQeBbOpo6KnEwZv5hsqJHoQ4Gc/XjN7s6f5BpVmxwoFt7WFLW4WX4GhzjRTOPTBk06CxD
 fK/3PVNZ9yPuaa90X06q6SloR3NJ2YWOcR2T2DOfZn1SpiDWZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wink,

On Thu, 22 Mar 2018, Wink Saville wrote:

> Signed-off-by: Wink Saville <wink@saville.com>
> ---
>  git-rebase--interactive.sh | 432 ++++++++++++++++++++++-----------------------

It cannot be helped (at least for now) that this indent change produces
such a large diff.

I am fine with it, of course.

Thanks,
Johannes
