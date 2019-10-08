Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 695A21F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 08:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfJHI1P (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 04:27:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:48407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730362AbfJHI1P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 04:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570523232;
        bh=pXr9M5qmn5Ad8wNPJjZFEvQHma4nj9L6OvCD+kpzmho=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YO8sqOVEasz8lUO97qVrVjCcZh8cU7Rke49blnxxZaLWi5A7oChT2a+fD5aAf3ZeJ
         SZuHqvRw5LEJrSfKHltWQKsJ8eJQjjcRk4rp4HD39w5gCkaX/3GmDqGtE3URqn7hCS
         UtwLlGULH/xX0soogTErqIZPOIQZE1V9SMDi/ORQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpSl-1hcNc935VR-00gHZR; Tue, 08
 Oct 2019 10:27:12 +0200
Date:   Tue, 8 Oct 2019 10:27:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     Rajni Jha <rajnikjha98@gmail.com>, git@vger.kernel.org
Subject: Re: Outreachy
In-Reply-To: <20191007203654.GA20450@google.com>
Message-ID: <nycvar.QRO.7.76.6.1910081024550.46@tvgsbejvaqbjf.bet>
References: <CAAe2+-RUhQDuw2kR4xCh2Sjh0CvpuBsWtK2iLmHih1iWtcP60w@mail.gmail.com> <20191007203654.GA20450@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SG2w/D/3zwKr2NmZe3i8/ckjh30GVYY3ZshQLLnGA3xv/X8H5ab
 sl6FeC4MU+V7CB6yB6mZKs4LXdYubouVKo2WkhCccoOC7g5zBr2hkmxzOh2qKu1Uojzc5f1
 NBYaP2SHAV8FYzxvI741AhP4TjITCr0o3rTShu2nRKne6Vqsev0uchHeI1UFYMJx080G1OG
 CdrjVAcKTUO/3PMDKlcLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kpJBi78sgvY=:j6v5ZUI8Vu7VdQsKdPELD3
 tDZSixtw5KFf6KyFB1Tt1PaL2ChjWZideQ8DX6UCJUFswlXrfYnQxs/JdNDM3W9ZCJ1t3Q3BM
 kq3+T5BcQemsi0kI+z1OhXxL68w1W3Iv9DPPxrH2dkPfddVaP0IOqlZgilj8rR6+N6Ykuj4Zn
 DnmsR7pTt7pWLNk+sBBw1Z+gOk9r9T2phIAYvvchyXGdn4I592Pu6mAf+Pkil2QJJntsW0GAr
 MDeVJFYIdlxMD0INfldv+3Ygt0FUoPN8AF3COSVR5j6B9iDG61Xtqi6EHa/UAjPrizuvltlwk
 1PKyQ0R7DI6ZiHAIP7J3Vn2jQUGV0GLer6w8PwcqxNFCRJKJ5N+5RddK3UgXJlkhN5zzSOmBY
 Hl6BtRZbn/ad6hb8Trh5M65IUdrhgQB7VktObWE/FoxX/25ugzfMpGJPNyCL1RoNuIPdkpj6m
 iH4/ndbmjPI+GwKOTn49ChdsU4dMsG+ovo9e7xAluOoToTHMHVcKIxeNE+Qw0jqGg3SPshcKy
 Gx51obmtoeriPE/5Ec+H7peeLfF3bJeW/9nLeD0bJG6lITxR16T8ZF0GTjpMuXZsYNV1Skfh8
 Fj5xbe56363EvvyW/cbpwWImNZsYWZyhGTPQvKbfQWTginYLR/79SXTwuGWZM0hkto0YUbUDg
 EF5CDgn1McoN1RtuB5PaxoAdJLtEaqfXiMcRiuVDC2EFI7fHkH93rEbo3ZE+Ag/IluLAUyZO0
 JGcZ3iZSWeomchZsVukRc9GH3APQ8no+V2wGCGWlLjNkAbYnFkBFkQcUAak2lzXN5I0A7cO/v
 s/ysmU7RKWy9hSvGWEZdqL+zG1BH+MqWA1Ly0bEH7PyTaf5DVD0mrDjCBt6HvSSQvm+eRbOg0
 umP8tjmb2EmKtnsrEFpuDqo/MCudWy9qiDRaceUizWBGTG+uWxMzZGjBhWvo+PmJT/yGZNf+7
 w/X6oHXKaxdD38KeC7irJnA71OsvjNDQiTKdVAEqL32LcN/pD6RY/jOg6Ndwpj1UjEes2d/le
 dFqinH40Zaoh74ItRse5NLptHwBXpjJVjHjJ6xx9TBqFJHQ5VBNlAwe6SJ9Pp4fSUtcHj0bVh
 6YYYWUZ3Ob0Qyv2hkZW0QKTxw6lWrzXSzRxP+k1NVwgH6rrGO9zRzqCX9q2nI9HjG5y9EhOfs
 1za896O1rCTny4UEcWki3I6QTtg/5R1AvVvqA14Vvx9TDFyvfVNOjwaDVrOHmLfmC3ZEMj5aU
 7mR6+2TkaJ300t2dx/Hv63awb0kOO3oR1P/rQR09P1UItSZ1B2Vls96Rzths=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Mon, 7 Oct 2019, Emily Shaffer wrote:

> The community discussed the list of microprojects for applicants to
> try in this mailing list thread:
> https://public-inbox.org/git/20190916184208.GB17913@google.com/

An email thread is immutable, so maybe you want to transfer at least
some of the projects to https://github.com/gitgitgadget/git/issues or to
https://crbug.com/git?

(I find the former easier to use, in particular because it makes
labeling more obvious, "good first issue" being the one to look for, but
I do understand that different people have different preferences.)

Ciao,
Johannes
