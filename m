Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8E0C43217
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 21:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 440FC61BE3
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 21:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348300AbhKOV2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 16:28:08 -0500
Received: from mout.gmx.net ([212.227.15.18]:49593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346385AbhKOVSb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 16:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637010924;
        bh=fbCOeWWnjQeeFEFGYr6iYvuPSj6qlZRR0ZtGTyfnx0o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Hp1ZInWK9Ynkb3reHVrny5meTxUbxAnlGIzOJcGnYJ45z97tnlu+BOjiXUVFQeQK1
         W4DLH3V3M3Dk1q8TluD4k6ZFfXpn7iS7wHD6geW6g7lmWvSp4nNzHfkCTtZI9znQLd
         XnOxvWAuOTUS6zAAIU6iq3aAGh3Yn4aIH+2WxzHU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MN5iZ-1n5d5K4817-00J1E6; Mon, 15
 Nov 2021 22:15:24 +0100
Date:   Mon, 15 Nov 2021 22:15:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.34.0
In-Reply-To: <xmqq8rxpgwki.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111152213180.21127@tvgsbejvaqbjf.bet>
References: <xmqq8rxpgwki.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Fx9UW2CeF1au8Z10OSc49xlw1ZvjJmqpw3n8EzmIGjy34SnhUpk
 WTQRNw9xl4O7OJ0iA32lpHpFHlFxORrAjEx2cAliaxGPqHVt+S9haTQgjQjKqtuT1PdfDVD
 C3OA4ub/XP0I+vSh5eSBHbdUD0UGZX7asuj1thD7hfAoKoI+TMMtMs6Eljn0GCKKyP5J98j
 7ZQDHDzbP4mL/EXhIMOZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NObj6WPghEA=:scBuw3xItL1xVT2HZgz3fQ
 NdMVFtVzj7R7MzLLTqsJxvPrsc5TmKWeiHKwv1a+2wxDAqYVB/OrWdN2yzU8Ghx04K19u7WPA
 pEfbNv9ui/1BVRfQ1kKjWNtCH5Rlc15V13VQNNQwYqXdK+2EPT9wM4H0yu5F572WmYr5WfO4T
 DYOf+TjyB6S4cYRVcktXrKd/v4els4mly3hYH/jyvUPyPbDkNWZIJVUrwguv0SOCCJcfV68K4
 Ov7r3Q7iLhDBmojUq3ERkpIgZ4jnINoK8VVWTvnYvZZUIWD/ir2TOz/sZ5mrhsqd0bdhFOj5l
 DyA3TpVkGWSSzEs5bfuaNjsYtoKmvrxYW3wSLgaQ1HzoJhZQUEZOyaV7pSDwpySVrOgNvwC++
 3yowUCKo45nW3sS+BEsq3jjlvcL4xbu6yz1ukJ/olSIb9A2E3BLoXofl8No4NR/VzPE3q2iJ2
 EgrsPvW4sv2Ecso71N2Rc4wTWWmG1jHPyErCD9diUEIxUhoCGC/G7nwy1VeeLOxRstx6jDaQQ
 5MGrtkFeWlyjHnMaCmlJgwVhyVUbtzZLs2dc2+Q7s8Pg+3fxmbdnzB1XxASJ9Po+DuukZsErt
 W4xrQNkpnHzy7VBb120Aai3NI5F6aTqMAJV9jTUNQxsWp3QCS2NXwb+95KuDtoPsaSwmEJ3w3
 aw9Cx8sX/EPgpwGdDJedVm1IfcHsRvYwJ7Cjf1hFeCr7iUUoQph9ngOw/PcIcm9+Y9quKihq3
 COebFtzCog/WAeeIeAU2K7ajM3X5VltwjGvkYLQm6KVLyrAfp/z2P7Uxmn5ZSPtHmXBqZVt+w
 I3gzW/iB0QnFWGYQNnS5A2Mgr9yXFQCi6rd6s1R2cWxkD0U1IRmvQmtdxvWApvjBl+vIRnmzy
 li/iRBqeCR4Rj/zuYgYqT2/u7ZHUK5ewfmebln/YQNtQyhrj7LLAWbwiw6LHFfNGZqH6EMKV4
 hZEaeXADwQJOEAXQ+rJ4HpllT7AeJBVDY1nIighNGX4tCdoQpNCb6m4S1igiV+3gQe8QTxz2p
 ubEqaj0Rb3gC87tZPNFE0b5qYFoidaKxlepiX3F0V7BD4AqUWq/+x/tWadZ2uF66YAqTeXUan
 OTbTwKEfgvB36E=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 15 Nov 2021, Junio C Hamano wrote:

> The latest feature release Git v2.34.0 is now available at the
> usual places.  It is comprised of 834 non-merge commits since
> v2.33.0, contributed by 109 people, 29 of which are new faces [*].

The corresponding announcement mail of Git for Windows made it to the Git
for Windows mailing list and to the git-packagers list, but was swallowed
by vger, it seems:

- https://groups.google.com/g/git-for-windows/c/NSiWc53CGYE

- https://groups.google.com/g/git-packagers/c/C6qNP5SRESY

Ciao,
Johannes
