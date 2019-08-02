Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2FE11F731
	for <e@80x24.org>; Fri,  2 Aug 2019 11:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbfHBLeJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 07:34:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:40553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfHBLeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 07:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564745640;
        bh=kEAt00fLV0qBbXotFD3tSMaJdG/GL1UD1uDTbmuSKKY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=P+Unpyb1NlsFNg0AzreS/Vda6wiccPXoTU7kc/iMuLpw70H9LpsX14z/VSzXmapIq
         GiQ0SeXiM+W6sozPzuaQmcK0X4pWQPZR1WuWIZOcNMvHDweqO11Ld3oIZtNpvZO06M
         rbJpDZV4tVuJuairX5/AM2JkcR8lOSuoS/Ds8Qeg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOkQc-1hxL2s00nu-0065gk; Fri, 02
 Aug 2019 13:34:00 +0200
Date:   Fri, 2 Aug 2019 13:33:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Support for --stdin-paths in commit, add, etc
In-Reply-To: <ab333992-35c6-a5a9-0bcb-cef51f004679@syntevo.com>
Message-ID: <nycvar.QRO.7.76.6.1908021331590.46@tvgsbejvaqbjf.bet>
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com> <20190731171956.GA26746@sigill.intra.peff.net> <ab333992-35c6-a5a9-0bcb-cef51f004679@syntevo.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hTwFnff51v5r2IAPnA3Beq5go73yPSnOzuJ/jYx6f2ootn0Zt2w
 Dqxl4UeVRdzDMsLVH+l103TvCFRm6QHQMF4xQbzhcf3f5Swj2seWF75TbHr91vPuBx5e+Zp
 VdbXVpXOHXfyw+hoXUmeoxC8EJS33E+IVRUUpylQb+7ZgL6DjbdPZT5nHqgwmXwW6J/rB4B
 8BtrY1okXitkKGtZ8oj2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:duSzT7+480w=:XZM7y3e0wRCt6Dfbp0JExJ
 ywnBFZfQlMeTgsr3oBVwdUDvOO5llZYOHkWNZEvR2UeJqO3ZcmPchw9yzWOJoPL9Q0D/EemWD
 ipzrd9ajzIk1ZEnCPejfWjr3kPcGN5+gzyz3vH6kIwklU0M+ss8G+DlxcDMZIIUF5VOxMdCRv
 TlyWllnrNqDTGQgZDchSqv31dHJyeszeFZMQ1DBZmW8oQ+F+Xi2RdhYoZcORqZQFxfZfdC+ME
 FatdL3IrZomE2qp/7tED0yXhI3pHCyhI7U8dWOXzpcif9Q9OcpEs/5iLG7aO8JLBgOjLhZobe
 BM4Pyfr1bUoWfUTu801PDIvOI3xB1Ux0Y9Se8dZWgLHNmjm0vf5zOLfzVe0Bfki5j/dJi6q2b
 jFucE1Kx9Y5QD7LAYEj8cipopbZTVWAWaBfqJXxm8ZbeiD9R3iMZaBDbqw4hUNGcrPItdpTen
 3qLEySW54bslK2b8NjbcjmE+bfCtC0Dg9ZZn8f0uNHKNeJzAxYclKhODKHn1+lej4SoYoRG4Z
 /octpUfD6HOBKv+LzXu3KVsyibNvBdi5SGZelaiQnv9ZyakkE4TED/KvJlb/f0UhF15bW2sem
 wn3b7NEb2LejlE/UYYB4Q1xGpSkGqcE429R5NaToVE/s0HpF8FHQnsSq/jZ7HC8XdGPnoLUix
 yLw4dPlevqoRur09b4zSVvOptnInCIeQBHlMRFnRS8zj/etNHTHEX0GO6x18TgoGI9/CnzDpm
 nBixBrqbNvQ9YXAk9nUOhV1+WzzxAxdFpHfKh9WRvMH7TUzY+LJ82WGjadcKRE6ST+jcnBs7w
 E5sJ9wn3gYq0KJpg75lxopgoHuwSM1BoiFASWAIsioxiHmaC0bQ/bXE5dDyxNPxSbsxWd5uOj
 7KqcS8MkYPIkZn9xvq626+D1He5PYjkhqtX4nvEMKSVRLJMcJ1mgvjMbcIYNvohzV9K4QQqDb
 D0l7K5MWmVS3Emg7FUa2Q8SOKWjTWSx8DiSO30d7/AFl3XwSBpWZkdYVj4sbm/+Ydir2SxZOo
 aq1ZnVJbXamiI5XqEifH4102k+rpQONsh28Cvv5o0fWf1+hG8anJtqVhCcnIWFb7e+9tqfBn2
 o64hg93rL1YicP9cjJO55zIZGPl1lyTnjj4a18dWTSNwWDDSP+LzojG5zUQZtg6ySG6you7zI
 lO/WM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexandr,

On Thu, 1 Aug 2019, Alexandr Miloslavskiy wrote:

> 4) git reset

Please note that I have a patch series (currently on hold because of the
v2.23.0 feature freeze) to teach `git reset` an `--stdin` option:
https://github.com/gitgitgadget/git/pull/133

Ciao,
Johannes
