Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48AFA1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeCORYS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:24:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:57713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751314AbeCORYR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:24:17 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LkBPy-1eKQxI3nac-00c5dB; Thu, 15
 Mar 2018 18:23:27 +0100
Date:   Thu, 15 Mar 2018 18:23:12 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
In-Reply-To: <xmqq605yz8ue.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803151821270.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>        <20180314192736.70602-1-dstolee@microsoft.com> <xmqq605yz8ue.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:52egCp5m7/2jKMIrzERXBYqeax/z/tG1dZrzxTxnc2ZrN0oEXq2
 kIFzjFWnzGqjeooDobby93hevRtmBPOkTpgea+w/7dyZfbLzqpo+K/N3B/FS5AYOdZxARPD
 mTRUkK5f1pqdJFVJYm+QrHmzQOnsyKg+UXNOjyWUnEQaajKTUq9G+xHn3DD85kgfUbcJ44+
 sdXyeQimp1VXCGoBjclcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kkriuCyn64w=:oR4ewyGuBQmxz4m1vZVMOl
 SDoToGN9te9weayoaHpMLY3dsGuHfBnbLadIqJj5VTF/wUmuHwXee8Uwe5o4eWhlRFKTfCcve
 baBhG5a+gHQ0Dk637nG3/zhZBrTANRzz98lPE7xowtrXvrZJX/fp4rddq6lnWhYu6y2kTImb2
 wSX35a+vdYkUAHvlhh4ksaA2tYYQaNrdH5LKV6aiawGHU79pwIRztp5XRdX4/bh6AEiq29Kbi
 eb39YXc4mG0aTKzspX6it1b3tNKoHmTuRdlfL8r9mOvT+rcvcqIihbnI+vYrDW/XL6t2GB9Ir
 RoJuwZ1hYXjdQeWT9utz8lcDrA5qOx+1gXdZAD49nExOIsuHhAzfPA2A6p8D1sOlhotMJyKeC
 mJYb/di2ZSSH7ejJl9ubcCAbTrFNXxrEP7AjxOHr3BOtnxIHmH8b1TBYI7lWJEXKq9jxKpp4p
 k2Lq0Y+0lVyuRi8CKt+Y8lVr13bs9H+0xkuSoxLO9q9CzqeGpRZDdZPOZCK6Lptlc9AVNKp/X
 6KAASfU77s12JFmOXNLLHrjKSOqZIbBsMHVJsHG3PtbmQ+Kids8ontZAMzgnjD/Qtp8au++5c
 Zg2p+AA8vBe8y2/Jp9jAvE6WlLI1P4bv8CTw8XB5XPJNzxKhnL0AjOHbEgaDu0Jn/yIcq8CLE
 KKj0RnWiOUWOZ6tiBNeEEAwgWGt/cc1RTBILjKvTDeE88QBtB5teMLJJNKkAbeVBcGIIx4vXX
 sWaCh5xRi0xQSXTC8sHpb+m9M3VbI0G1vpaMvULdFf29DsrHiKeQAVllfsl+O0v6f5DXq5YtA
 73dVDGzD1lxgghoi1s21aoTZx0mvlQKX6oOf5/nv3sGMifS8U8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 14 Mar 2018, Junio C Hamano wrote:

> A few patches add trailing blank lines and other whitespace
> breakages, which will stop my "git merge" later to 'next' and down,
> as I have a pre-commit hook to catch them.

I wonder how you cope with the intentional "whitespace breakage" caused by
a TAB after HS in my recreate-merges patch series...

> Here is the output from my "git am -s" session.
> 
> Applying: csum-file: rename hashclose() to finalize_hashfile()
> Applying: csum-file: refactor finalize_hashfile() method
> .git/rebase-apply/patch:109: new blank line at EOF.

Stolee, you definitely want to inspect those changes (`git log --check`
was introduced to show you whitespace problems). If all of those
whitespace issues are unintentional, you can fix them using `git rebase
--whitespace=fix` in the most efficient way.

Ciao,
Dscho
