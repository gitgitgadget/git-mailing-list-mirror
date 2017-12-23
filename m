Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996F31F404
	for <e@80x24.org>; Sat, 23 Dec 2017 23:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbdLWXBp (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 18:01:45 -0500
Received: from mout.gmx.net ([212.227.17.20]:59677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751529AbdLWXBo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 18:01:44 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.73]) by
 mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LrZOj-1f7d3m1PR7-013Q2i; Sun, 24 Dec 2017 00:01:39 +0100
Date:   Sun, 24 Dec 2017 00:01:38 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Carl Baldwin <carl@ecbaldwin.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
In-Reply-To: <20171223210141.GA24715@hpz.ecbaldwin.net>
Message-ID: <alpine.DEB.2.21.1.1712232353390.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com> <877etds220.fsf@evledraar.gmail.com> <20171223210141.GA24715@hpz.ecbaldwin.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dqiya4sFNAmum8jounJnshLPrHkz0G06m/2aL+RYsSfy0S5fWcX
 vefZEwlxl+d/D+yYvgHOUQRbmG8g9Kr1h/IlcExmgyUkcgfd/lAuSNZsgnFjPtCLyHa95Dq
 TYYgabDv+Dy9FnG3K+izyBBI5G+Vvc1MVvFbCnRhqtmhlvzVUE6p+8HCTDG4QARcUR75zTS
 458JmpGllhOt5dWjp2D8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:21/obnC4iIY=:jmBHz6wW7GQ/fw+AHzeTvA
 SAtPYpSb7nJZiFcIkOLNMGA+CROcr9KUdnbdPsXFJ8KU7i2d8LhLygeyHmL1sGau+pzjWSIL6
 QrHGcL6fUjDHB4381lqeydrppUxo4b0M4/5s2cIp0ogy6t0JiQ38h/twEaIE5XqR2AhudPp6U
 /H/vhXQEnzK3Lv7vgqMgU83Jrioe/RNO19JbN78s0QwUMUK1ZbuYKFcsbrHwDKaYjSHGdj497
 A6M9WzwEyjrSJo6uSh+cP05K1CNj9cTpDA9wES0/FmjvmCtjE3P89aMVhrkCcpojrHBHnkh7n
 f+spnFZkTUkiEzLTTUpzQr0Rp36cSsBouZl2NZYHEeRRR3RSLESKz5a35R1iAlxTh9n4K5ZFt
 mUoJMcwHn23w6Ka2TLpffrMf+skm1ZByvmlwOUcfTBfqjPo3TkYfpHsV/4mYkNFOCphBlAI1E
 1ed0nMqRsTJvf3x7D6Mw1QCDnc+nUePQnfc56navVzaUAPsqgBLKF0SR53HNvu1aZSjqltUOJ
 EDv/P7wIDRzEhHXn8uFkjz7MOMVH7SZb2XKnCmbgL0rOIF7VyWNbsaVZkei/lCRwMPrZLBlPE
 y+ktLr5rMeUR/QhVS2t/ZX2LsPJue6TkzUox1mzhS6eLL7XQBE/uRoR5tmg7+/l8ypqkRj/Kc
 fmdEeWWi/xetr/iGTt6dYLmrr2Q4PHY7Dgyz/sX9xIaG23drEF/92/Q6s0ZWTkeuPQkrV+SCL
 yEio4NA0Kq+Cz6uBSSP+9OzBlIip4+M6CTxuy3BFpPHoQsl/OCAN5d0d9ph71/+Rf8ZjQHYX2
 0FlPNhzLMMHzRFCf8R97WF1ybgI4GMx61smWFuv7jk0SKDYn1k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carl,

On Sat, 23 Dec 2017, Carl Baldwin wrote:

> I imagine that a "git commit --amend" would also insert a "replaces"
> reference to the original commit but I failed to mention that in my
> original post.

And cherry-pick, too, of course.

Both of these examples hint at a rather huge urge of some users to turn
this feature off because the referenced commits may very well be
throw-away commits in their case, making the newly-recorded information
completely undesired.

Example: I am working on a topic branch. In the middle, I see a typo. I
commit a fix, continue to work on the topic branch. Later, I cherry-pick
that commit to a separate topic branch because I really don't think that
those two topics are related. Now I definitely do not want a reference of
the cherry-picked commit to the original one: the latter will never be
pushed to a public repository, and gc'ed in a few weeks.

Of course, that is only my wish, other users in similar situations may
want that information. Demonstrating that you would be better served with
an opt-in feature that uses notes rather than a baked-in commit header.

Ciao,
Johannes
