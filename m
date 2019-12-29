Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7C8C2D0C0
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 19:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBB920718
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 19:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Kew13X9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfL2Tjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 14:39:44 -0500
Received: from mout.gmx.net ([212.227.15.15]:38701 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfL2Tjo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 14:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577648377;
        bh=tIO0K65WbSY9kDdySio7jjRPk+GWrBtlbCD+ZLPM/KI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Kew13X9zEKSuKq9VwWv37jahNb7q9nYqXlFvG247B978sfLE3IDBYFjGn9ZM9Hs8n
         bpFKXjMPoacNef+0WHVr7NnULn27uyXhaP7tdQi78A/H1t64YBIfXUaUkPd2+vEOf3
         UgNfK6i88sCxWEY8WmdlXZbP7VpME0ycpK+jbBmo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLR1V-1j3b2I284x-00ISGn; Sun, 29
 Dec 2019 20:39:37 +0100
Date:   Sun, 29 Dec 2019 20:39:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Git for Windows v2.25.0-rc0, was Re: [ANNOUNCE] Git v2.25.0-rc0
In-Reply-To: <xmqqblrwm65l.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912292035430.46@tvgsbejvaqbjf.bet>
References: <xmqqblrwm65l.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5sGB+Nn2YlaNB6v0HGMv1kswKGuw+ploE/9gAU6WR5soCOVC8qO
 Rgk1aJijwLCdWUqxHTmRJAp2pg+l0wMoLHQnKePU60kJbM4yT9EhXj0yDpfvKjdYkT5PXyS
 jXZFZrQMQkURIq84Wf7ykgEs3aT98pg+UfpG9cRvps/535EESJgGJmdDiy7S5TXydz/v2/A
 ks80RVRSxWfBeDXDuOquQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r6ZfmheiW7A=:9X7CFt0UTVCBiZeUoT+Dij
 HdkAyQ4Rm5FEBXP7Ix0zJaJ3nn4wz8Bbst5sozfMPjXu4pjxhXRUV8+ZLfHWkCpsbD1918V05
 lQnlnbnBtXuD8CM+CsGPmrAVzIT0a2gSqweYvOjZqIu2AlC/evgqmbqMc2FwVG8LdcEOp1gI8
 PaRU0wR+Qk2K4reJrPLSt/JlpDjniKjoNzaiKQUftnvWT5JvbvhdWIZc11hVZ1kbWbSmLDQ3j
 RIKHsIVj8Ji/vbcfkeHXM5qBKucEnI7SNQJNdkodv7FgC2P+61r+0Xg88R3dwnlTrCVWJJqD9
 ajqA9wcsqYw0wz3bDGAgNIbZProeJau1ATO5vu6oeOCLCkDxBTD21azP69xY4V5Zh/G7V5zVD
 jmRetq3yeQ5fYPzHJhT5YRJUfe72XG4rTGGGRJQQO3Q1TjC0et7lV6c5Gphub3r/JSvfhbQiT
 dtbYWWx13sCVoo3OMqgrBKfNfy9ocTVK+1xG3oO3qTCasD93yoNC39etotFxBbqmPFd4EVdWZ
 zEEbmfPB38RrUEFiRGjEN7Mp49aA6I8O8c8S1jgVJjsmllylKC9EJl9o65pLPztk6ypAaXMNH
 Qy8YRmbgsUg3EJ1t/WHi0SAMh6qi9c620lnLjpuiJsa4r3PNVXvq2N1ljuioc+5YQic5iMcMf
 rdeiNN44UNZLTtxe8NlN7eiUJOpGQh/rtwzUNC/AbZeJ5l00jRMNsXLZGAUS1vbWuNjnLIvNI
 jC3LedULrA+5mnWtVMcwF1nlupCGmWkGtXDghH0pklS6FYjNiMMncfPUBMh/oUv50nRRLD++2
 /Capzsa4rpqEPmfZdE+MxhF5QL6Tn0GPUz3XylkmZg3wp1scBQ40EtHbkzn+ovBi69l5+4nlA
 w6RIit5Skm0VV3nnU6WDMY7eMwZCOTHIVCswC+knKN06ZJeeSyFwZhdTWlj77kVf6U6fnxTL1
 jnw3HY8MlMHWOlzePgr0+Qsu+tKFGabWJVYc8qT00fz81wquBUsQTGqCILkPyho8kW0vopEu7
 z7476qqe0zRg29PTb/utsHeJksQo+s5PB4+UDhUtE9G3E+RLnR5F0kBLTbJA5m3fXEO/pXVhD
 NesJ4TZMf4lFZP3/xDjZH3DpKBrLO+mX+Ri/+04JAwjSIOS6p/H235S8TcSmxTK790Rhy9FMj
 w+gC+XPJcc9umiMkVhE8xz3EJLWhzUON1ycRiEg1tmnVScA4J6ad+51B0XNaBNaf295//gphC
 T2vVWfxlw7iWLd0KifWCvCij9hQQFrVhR2yRBvca0DAtj6hlftcrlL2UBR+s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

On Wed, 25 Dec 2019, Junio C Hamano wrote:

> An early preview release Git v2.25.0-rc0 is now available for
> testing at the usual places.  It is comprised of 531 non-merge
> commits since v2.24.0, contributed by 61 people, 24 of which are
> new faces.

The corresponding Git for Windows version can now be found at

https://github.com/git-for-windows/git/releases/tag/v2.25.0-rc0.windows.1

The improvement most users are likely to notice is that the installer will
skip over most of the installer "wizard" pages when upgrading: if you saw
all of the options on the page before, it won't be shown unless you
unchecked the box on the bottom.

Ciao,
Johannes
