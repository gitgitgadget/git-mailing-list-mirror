Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F771F45F
	for <e@80x24.org>; Thu,  9 May 2019 20:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfEIUyX (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 16:54:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:54715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfEIUyX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 16:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557435258;
        bh=dtFd4oTA3mPbyjqjR2hS0DP6HzYJreBI9BW2ssAo6J8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=l2STg/nJU5fr2BAAtNrbA6udoKtWwxwPKIsiiOGetDwome5cq/YTG5MmKXkKJaHRY
         2sT4Fi4wbg79tpcWJP17+V44JgeYWc3t7a4cmvUol1SzaUimde67whZ3NaT0VPPSE/
         akdTtNrkrObqWX4LOlGMkmaEQ8hvMCAwqeqU0t2s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7i8O-1gcwDj44zy-014nql; Thu, 09
 May 2019 22:54:18 +0200
Date:   Thu, 9 May 2019 22:54:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org
Subject: nd/merge-quit, was Re: What's cooking in git.git (May 2019, #01;
 Thu, 9)
In-Reply-To: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905092251200.44@tvgsbejvaqbjf.bet>
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JaKqxiWsShktWNJEaCXrukqKftZLN/05eyx/TjOnNY6UV3Y1GLo
 ek3VP1ws/S7axs3Tf4hGrWPCtz/ljTT9NxEXlXxQyqncnFlFTnrEyPrMCqXHtn5cwBaypNA
 nBkHolMVRjU1Fv1HfAhbu9iQ1PApQYUg/WI88wF3x806Buw6AaKm03BXBsEr9BsnnTmUM8u
 tYH5iYMLXPY5HhEu8hPCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+K1TZrKFDYA=:BacUlK8Do8uIpxyUUmu5S2
 96laPnAWnTVPEfVwlHQ1/puI/aRSiO9OhwIxcXNAglxYS+wPNfZ/QCFe4d5D3xOtRVyDxUtoW
 UX5n8jRA7fPMjNdLt7l7yTe6CNniBvhWyRZxpuIG5Lw71NYrzgWbMb9nBwfQpRQU74/H31DBO
 Dj36lmhtgf6f8tpe8HTRcuyUNfIR6z2y4NXFLuCSB4SeQdX1nZ3V5qqFGLdD649kbC8m4Vw7h
 J9ZjY08wbgjFbmiG/mgMuOIhDfqi2QqCIDI4oVsmXhh3KC7VD2+PExIVRnLUrCRYztFUw0Gdm
 aC4DrD15kcMQwMVpRherr2Fl/799u+Qg0bxeUYK+lPF8nDCvW8eOIHYwWZsSH6LawTyZqMl5h
 K1h2QLToTRsZAEu66Mxv0vjFUEFsCGI30hiZXqNetCfB3eqVdnLdyET6PNr5tFLMX4MLvPgGs
 PwDxZ5YE6BJ2ga2dNgxsLX+heRt6qqCexEZcmpssUEo00hlMghx3V8xYQ2dVlqAhVYNvAZL2x
 l4ZzWNmL2v9up/9azLf68c3h7WpdwZd43DVgpw6rnv3Io7xeWCoVq37rexMnf3+F9Y+g4acZT
 YOnB9IQBZUX2tMrBMRXHYHj6oG4dYvgLQn4fgAU8NxxPwo2LdoEG8sFWUOXZWHL3f8sjn8kby
 g+JzCr2uS7Rw+6MPLrCBBQg0WGTyfGrFOD66KdqtD4rZM95NAzXRcPsOV4yyf/+DomJrmTU+x
 JCPmsuIF3H33Z1oIO2OPHSlBOz50Je08/ExdJihahp0SHjbcSM7xT0+gSM9DDxtQpZCiDwx3o
 MRehpHstCWRoNtlb+qZf5AnZN3mLOWH0OQlqRu76LwKVE57mUCvSM5kOBSCJznsviM9YGQ0Ta
 IP7zfl+vKQTW1Uo1JlrTlyCWYSQAX0mLnxo8ik+wudOopU3/tr14q1GPZILDsXklQ7tuySbsI
 853jmybeTYQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Duy,

On Thu, 9 May 2019, Junio C Hamano wrote:

> * nd/merge-quit (2019-05-07) 2 commits
>  - merge: add --quit
>  - merge: remove drop_save() in favor of remove_merge_branch_state()
>
>  "git merge" learned "--quit" option that cleans up the in-progress
>  merge while leaving the working tree and the index still in a mess.
>
>  Hmph, why is this a good idea?

It also seems to work *only* on Linux. At least the tests break on macOS
and on Windows:

https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D8313&view=
=3Dms.vss-test-web.build-test-results-tab

Sadly, I ran out of time do look into this (I am pretty busy preparing Git
for Windows for v2.22.0-rc0).

Ciao,
Dscho
