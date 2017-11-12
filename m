Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AF3D201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 20:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751101AbdKLUId (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 15:08:33 -0500
Received: from mout.web.de ([212.227.15.3]:49330 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbdKLUIc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 15:08:32 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MHYHE-1eCs5e3hlM-003KPy; Sun, 12
 Nov 2017 21:08:26 +0100
Date:   Sun, 12 Nov 2017 21:08:26 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Introduce git add --renormalize .
Message-ID: <20171112200826.GA2677@tor.lan>
References: <xmqqshejq9mn.fsf@gitster.mtv.corp.google.com>
 <20171030162913.23164-1-tboegi@web.de>
 <xmqqvaimeixm.fsf@gitster.mtv.corp.google.com>
 <20171107172659.GA11119@tor.lan>
 <xmqqlgjhobb4.fsf@gitster.mtv.corp.google.com>
 <20171109184700.GA27635@tor.lan>
 <xmqq1sl7j83x.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1sl7j83x.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:XbuXZ0lB1wzF6EwYt/xHqnc1f9B19FLQ/0b7zxx0YFyh9CMBQBc
 mlf0+Fs6IE9GT4Tf/PrLDMFYBkik6WGPJpMY75RYrqIK4bPgoZKCjKSw6kqg+akmt22QdFD
 iusrYgjLxFdTUNn+2zVYxE3Domb+SbNyQySPZL+0djlZ2NaC+UBGMsDaps6dWBMLwI02MF+
 KQ49/oFj5xih2hCBZUhug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8sTrVwN8H2o=:dCxxwM/efbgc5qawEJ++zf
 1sBLD3j6BMOCAWITV4Gz9qgM8t0tlsGeTDjVhKCM+F9AhkXqTYNV9t3pB9GfUNp2uqJbQoCdv
 w4SQfiduLaeVF3lHd5PhTV8rskpOu2yN11W91Z3nY+BKbdbVBPqvIksqK4F0k5zrpUJJRtWUV
 XYas23oExq6I8VqsTQpu3eYNIU2e4BL8BuBztvLIizsZHFutQvdBArdJfNlR1u2fSUMA7aL3t
 ey1P94HvVLmcaR2yySNY0bl/86jO1maCQijl8pEPFcoofuLFMRH1EY+DBoyRxOAWI9FqyUCwc
 JROCkjuuZH7EKhT44vC7rkwZQ1InZSit+MZn8pqC8fh8PpI2uMJyIiZP3hAH/tlc/2dZ0GKi0
 o2RVmhL9CYthE24RRr+u73b/j8CWpGoCj50m6wbFnw46Hg57YPbPv2LO65/xNerkGdzaLJGH2
 JngUjIjuPO0SghILpOzk4KDW5xAHqMA3EWKtGns4iGSmQMkFVHMmJqgQtZqD2HmdiQC0FRwG0
 CZVlX/6HOdqDEV9NCNIVKxpRvC6xT7Ugwwzs6h8rhR7iwFQeofWj+51mokQzFqds7pqtn5oQ4
 JbyAcGhcWOF/u5djjbE64S5zGXdFWLCdghK7+5kWJGvZzEX6tIsroWGtmPLZprqU3RUKmgZQd
 a579GuBHR0CuI5mU5c4kXl0HzVrP6k2lpsCK/0pbdveR2geBgQgweB169QU6LPM8WhsAquABm
 JlcdBquYT3KCtZ312+4ZI8ROmIdLRCJBp/Bh4NoIzyWXF1t7h47FeG+MGs8WsrILuAaWRykF+
 CF+E5mcwiPKHvGzE9PLLfNHL27VwA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 09:22:10AM +0900, Junio C Hamano wrote:

> 
> Taking these altogether, perhaps
> 
>     Apply the "clean" process freshly to all tracked files to
>     forcibly add them again to the index.  This is useful after
>     changing `core.autocrlf` configuration or the `text` attribute
>     in order to correct files added with wrong CRLF/LF line endings.
>     This option implies `-u`.
> 
> Thanks.

OK with the text - I can send a new version the next days.
