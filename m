Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A3CC2D0DB
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 14:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F009424655
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 14:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MyyYJJaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgAVOPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:15:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:57571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgAVOPv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 09:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579702542;
        bh=bqMDZpVg2/D1BdQaAVynwQonUP7LClzepdD2pbVSe9Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MyyYJJaB11gMeA3+Pm8F/U6MxMTfZ3/rtCbXl65JSTSmflRtVAthmHN19TJ1Hftna
         /a+pzF+kV6bAy5sBjnSYb4DL9JhE7dtvqn2GlQrb/qjIFCrCDQMeGygjgtsv+8f3Ls
         bmUxm8NQPr+J/0K+bz1KZF3ePUYlm3jvypqoetAs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK4Z-1jlPTj0UcL-00rHnk; Wed, 22
 Jan 2020 15:15:42 +0100
Date:   Wed, 22 Jan 2020 15:15:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: GSoC and Outreachy Summer 2020?
In-Reply-To: <20200122053455.GA51054@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2001221514490.46@tvgsbejvaqbjf.bet>
References: <20200122053455.GA51054@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FA0Y9FIsZMsiYG8rYp/1PecrWk5mMdaatnDCZV9tcbMGFm9k7bw
 w1ZsShInmJnD/pGcWh8vBDr5QpWVVXyHmCkSuhuCtZoNM89sNMwktyq9wUeMApXuZkQKc6s
 mcTCm8n4454gNVmS97gyYUP0snBvoAGfq0DTEH4GxPRGMPAHgOLEtLe+buFfoHhH8iJxGwx
 40xoBR6AbyaUwx1DtDjIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4TmaWYJB/vE=:sJeTUj5O2uQIPXyPaaPf7n
 h2R2T2zlI6he0hFlmWdbtRwZyDw/+H4Goa1u4u6GmsbenIPz+0dNCPBUA3gIx1lKaPryrkXfY
 hlN1/3x2qrvUJtfy1jdE9Q5PpNn5Vl5feh5rFLIojhbWew/m4T8ktijMEeomlZJy4L0+cQPr2
 fWnZ1ymc9qmcNBqnkavtICe75N+kJZmHW4o2oKZ0+IcamnINpiZW7CJ83a0BJCOzokImT/KRd
 VoL7oB5aIsU0FtjWfpufHG92Rr0uV/n0AM8WZtCnw6GbIgMD6WvOT96CfIvbpFAWk5Bcefr7u
 dlreFjEG9FxSUTkwSC0PpCocNiZ9DU/cpegTPfkHam3cM1DHBdJDIlhHsrpdOaGnO8R4z/We/
 CIY/AsDzs1YKWETmD1kfX/E9fu8K7bwZuhyLZZ8N8cKJL+Y/wOHyYefk0HI3iCDHbP5RDwwDd
 2oFS4+MT94eoeED2eBKqe2YaYOv/LXu/kySRNFyjG5dRieFnChLoqUJnq7iLrtDB7BVqWqSud
 S0CdgtRrsmYJj9mL+KZhjppiqTjFjcQ0Xw7fUa6PK1bPPLOfrC/7Fp/FGVgjsYpXqsXIlLnj5
 hPYjSt7sUoRrDBq9Z+eenT+P6KLs0rA54lNTTqU+5MGk983c0t7UWx+HrZTAv0jcf31w6Jgvi
 nLIYcJDg8DR7TnAqaQZrKQWZhaVLnR12ZZYE07SmBpASr5BAzUPoyuIxn9buNf9T+0npi/4a5
 pbgYxi5YHIFP8ILyN3NCTYzq1JPhCcB50TeYgknGj3rVvPyIdlk113wv0iHau09iqZ1YmEU2z
 BlzkAIic9lvEJ9BtFttl32eT5bbnKJdsYQ+/Xd/e5+R27xo3n/6d4UhtE5FFnkq3P80bKeyNI
 jgaTL+qrtgU2WxxZMH2fkHoQXb62MB3c3LQzHe6iRg7YVYxoIrC9CKz4o4YAolF5fKd/XVKs4
 pblW7047yuJ1H6sF6FPx1WorWxK1UC7VMYETHQdTTbKuWd3nygK+B+lN19W7rV79D9qfPmnM5
 kIPBwQD+P6yWo1WyS4p97DlT694b2bkLMEoNwj6W181iyo9u49RPs10zDFTVYFrWONhRLgNCw
 VRTlxkuMKb9vHep8r2Ye2m7SYX2Hyc4S1egUK0n3hPL7bPBq18gLwdL+WIP+AlKS/rhH2uoKy
 Tatr+vZwai6jcAr8kUwlyMfcG8E1ZU4+iC6SjmiVvg2UZq/YopNIeuDsN0KePoKGQWglNSzMU
 O3cCgnfz8GLcF4XaE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 22 Jan 2020, Jeff King wrote:

> I notice deadlines are approaching for Git to apply for GSoC (Feb 5th)
> and for Outreachy (Feb 18th), though we still have some time. Do mentors
> have sufficient bandwidth for us to participate?

If there is funding for Outreachy, I am willing to mentor one person.

Ciao,
Dscho
