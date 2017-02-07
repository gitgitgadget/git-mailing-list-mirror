Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 621C41FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 23:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932544AbdBGXZG (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 18:25:06 -0500
Received: from mout.web.de ([212.227.15.4]:58140 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932149AbdBGXZG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 18:25:06 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LjaR6-1bzzP11Cci-00bZ8j; Wed, 08
 Feb 2017 00:18:27 +0100
Subject: Re: Trying to use xfuncname without success.
To:     Jack Adrian Zappa <adrianh.bsc@gmail.com>
References: <CAKepmajNz7TP_Z6p_Wj17tOpiMOpKkvQOBvVthBkEiKabAppjg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git-mailing-list <git@vger.kernel.org>
Message-ID: <271989d5-c383-0c0d-bfcb-f4118f9fa2aa@web.de>
Date:   Wed, 8 Feb 2017 00:18:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAKepmajNz7TP_Z6p_Wj17tOpiMOpKkvQOBvVthBkEiKabAppjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:uA51Jkf8EOmRWYLXX7p9wPxHp9IKoJCO9tuqisyIZANqgEKNrah
 ANhjEFIX5DCPK3DkvpvJrte+TUfgqk8cx5XyDXpiHeUmTOa0JVJpynPSEmpJCfYB9Ryyuse
 xaTIcSte255ji32BNJYO8pfYm3a39JJMpWEO4vKzDMj/X7CWahUf6df2UGTALt/nXk++7GI
 3xsFgKoP7gWjSUz3mNjJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3di2pPDZKr8=:VwsdjTQ8WMwZ3HsVb4IGx7
 rqdNMERfArqkuenfHL0dmKr6ZOsLtvAOuhF8lS8sPqIZpnVFxVUmBfFA6RBFxvS2/A+DnjVHe
 H+T9i5MB/AmHO3F8aYEFf+mxBHdEaeVzLYasF1pz4C9uHMbIWZu0i8nDwiexidsKH30nYLxKu
 mhsdxtBVSshHWNYN9fYfY9W3tJ9g5/wXV0scbq51ABIU5bE0xdpS3XDmU6V6NTRMMXEOiWumT
 dH7x9/h8UqhzqeljGgGr4KfY8PIMotBj7j9IjQ+JuZ9FwJ2vq6RbdxHw8j5bjIBz3sUFa7vXT
 FpHLUqFt/XFKuuLSM7D6fo+vEOjS6WEh5m0TXbwwAAPaIIzLyIkY3pVpLuvzd+/5xYRKPUlRL
 lqEFPT+KFZn11YtZJMG9BvkNZukrqfi3/FNTItIwdXwFqkniKXILKJ4AaT2JH3QBSbmIbX4/Z
 H8TwtCxmUTmr9odoMDBFlg1D7waH3AgytvGKV0k6DnD3urgkntGD9HU3DA7gkCF83EJTzDJPx
 PkzmeCO+EqSdtmAghpjlaj6tKonhlFJxctX1sJpFGNG5CnLtcfsXvu0DN2zTi4iM76RNSd4lm
 kXRS4QStxXUVZVJbRUHLg0iyXyBnId+HtmeLUzhfdtiZJlMsMOMRIA7MNeQvOiH/bRNXlMouD
 MofJeQuBdHx/JN2CczZlSLu5+W+LxKuT05H8coyojhcpx6VyR8X5ncc0c2UpfIJ3dKvWDybsm
 gV+vRzBwuzWML4r6qVx50MVQDwShWXfAp+/cSUOPnjLAiYi4Dantc1kTXIe/hun/ACCJ26TN6
 uIA25rU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.02.2017 um 20:21 schrieb Jack Adrian Zappa:
> I'm trying to setup a hunk header for .natvis files. For some reason,
> it doesn't seem to be working. I'm following their instructions from
> here, which doesn't say much in terms of restrictions of the regex,
> such as, is the matched item considered the hunk header or do I need a
> group? I have tried both with no success. This is what I have:
>
> [diff "natvis"]
>     xfuncname = "^[\\\t ]*<Type[\\\t ]+Name=\"([^\"])\".*$"

The extra "\\" allow backslashes to be used for indentation as well as 
between Type and Name, which is probably not what you want.  And your 
expression only matches single-char Name attributes.  Try:

	xfuncname = "^[\t ]*<Type[\t ]+Name=\"([^\"]+)\".*$"

René
