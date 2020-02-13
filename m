Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AC0C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 13:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A622624671
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 13:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lRi+ucO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgBMNC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:02:29 -0500
Received: from mout.gmx.net ([212.227.15.15]:39071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbgBMNC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 08:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581598943;
        bh=sqltgop/Mb2/Zalzvi/4HR0+MdvXoJ/KhZ5ra2l9e8E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lRi+ucO+R8GamQ0PlfETv17a/rAbvngh0aKj5aajizkhzZii0ORe811KGIhw3vSYK
         jHAJpqGS9RmVn2gwKjJZDfZkxIxmE4PfknlmpTurbTjCuj6N+IJgcAm0/swxZGfgkW
         43uDMfngnJ5BOlp6SKTkg9wYjwx6RoTOQ/GlFG5k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1iqcj248cg-00Px4Y; Thu, 13
 Feb 2020 14:02:23 +0100
Date:   Thu, 13 Feb 2020 14:02:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: yz/p4-py3, was Re: What's cooking in git.git (Feb 2020, #03; Wed,
 12)
In-Reply-To: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2002131401130.46@tvgsbejvaqbjf.bet>
References: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9HhLc7rz+XEpBdGMoApXbi+75PdJCESp6Ri/wLMb8FpOdKjpxku
 D2yLO+BNW2WDk5AkhMcE0VUwlV/6DmpN+uF0FLeX+TvErNGaGdG33tnXJ1rk+p8h33y56yk
 bs1S6fjMDi8SXhczoBt7WBl/5dFhCyd0/0OTbsJ0k3bS5HbyHbMv7SvCIobYL/Feb6MzQL8
 CjmybCe2PwGQy+Qt9/a9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h9ucNLZqBvU=:+DL4UAkWzKUCs95u0zzfPC
 XEpgjIH1tcavnLxaDA8isVItY6380o/hZr/9lje8bNnztrnXyJeoodXHInWGM5+U/LrQVnmkc
 xKvLIijWqWUX7DQOsJeYTtSH69w+vBP04nyoFTSIvEdxpTqyKJqgfd7NmCxH5FIWOEEOABAcn
 FYwsYmqSzayv/uwmOhw9nP+CLQNfh1Wu92172WRGt+VKC9FuBN23LXhRafDGqC7+NtzGMn2T7
 B/bru/Wz6gxTBToWKdLSZ7YNGwb3QdNAjpybC4boqqdUWVuU8gjImqrkTuATNUIO3eAtN880H
 opCM9oVIzxZDYula7uTOCn79ju9BjAmNSeG66/z1FKo7mJGpM/JpDaZbIFvqZF8oqok0zj4k/
 XHxhpmDevHaAqU3ZN1tBJLWswMMqciiAlhb9RrWxMfqrbv9yvqAwm0J7nNN/+uwblFhwLn76J
 7NZju0C48+k5FbZJOMNED+69TEIFYiPGf9NN9xVjnsu3IySTBIaSGxRm6MkkL/Xq3cTt3mmkP
 yiSp7lolhXh2es6v1NSofitIJAhgjH9Qc4Vh+ay/8CwRjrTiHxU5FijwfVpiD3ZOykkwlgkWi
 NMUNwdL5nzYIC4O6OJnE7Iioz4zolj3B1VjNFNpxcNEROhNXVeoIGMOhWDsJqkBpFzEgpCC8y
 siWNAp3uKm8hzsOLQHWbl4T56RxjIOUP6fHBMy5sXsARHDlTJ7/sBQGzYCMudYFFy0iZBv2aY
 FeQch4undJu4omgkkz/QOpgCBezWsUWg93XyVWDhR1E7PFeoy94MI6Ov+IT5XdrJjwehq3eOu
 f8jxX1kJYy3SmvP3t/2cFO46TYzJdrJR9yZYqX488nOabgklDSFBr1fIsKGa1ZWl6vO4KjH2G
 dp4fxMXu7bHYuFFNn2/fMWR8wPf71EyCC0ebxuHfHKhq+GQxAFI57/1LeTM8XneucV30ZU8/4
 BQO9oP6rqC1GjGqcBOIduycTamb6bk73i04zIkOHc1PJIKpjkXfbydR3RZY5itOdYh7tGHMfG
 YqbVC3APgbQGhmoA+zTt7EWQLl3zBrrO0BjzW+6a5LwAW0sB6PH2kqVT+Bi3SO7sAmN36Ia3T
 5Lj6nXSDHK+Mben8IfMLvhpBGxbANJDwRz7V58M9bi4xzGBpmoN3bQmn4IWoCg7ZwD92JZBVp
 49vt2N7nftjfSR70DL0O7kCP6/84NZu37yULkxLdza1KVSdFd2AGKUBHVMzmmKlqX8kqYFKPo
 8ayBbFqLhFMyHdPhp
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 12 Feb 2020, Junio C Hamano wrote:

> * yz/p4-py3 (2020-01-15) 14 commits
>  . ci: also run linux-gcc pipeline with python3.5 environment
>  - git-p4: use python3's input() everywhere
>  - git-p4: simplify regex pattern generation for parsing diff-tree
>  - git-p4: use dict.items() iteration for python3 compatibility
>  - git-p4: use functools.reduce instead of reduce
>  - git-p4: fix freezing while waiting for fast-import progress
>  - git-p4: use marshal format version 2 when sending to p4
>  - git-p4: open .gitp4-usercache.txt in text mode
>  - git-p4: convert path to unicode before processing them
>  - git-p4: encode/decode communication with git for python3
>  - git-p4: encode/decode communication with p4 for python3
>  - git-p4: remove string type aliasing
>  - git-p4: change the expansion test from basestring to list
>  - git-p4: make python2.7 the oldest supported version
>
>  Update "git p4" to work with Python 3.
>
>  Hold.
>  The last step is too wasteful to run full tests twice.
>  cf. <20200122235333.GA6837@szeder.dev>
>  cf. <20200123175645.GF6837@szeder.dev>

All right, all right, all right! If we cannot find any better way than to
just use Python2 in -clang and Python3 in -gcc (or was it the other way
round, I forget), then we cannot find any better way, and I won't hold
this up any longer.

Ciao,
Dscho
