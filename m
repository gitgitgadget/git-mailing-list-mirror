Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2021FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 13:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757901AbcLON5v (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 08:57:51 -0500
Received: from mail-wj0-f173.google.com ([209.85.210.173]:36117 "EHLO
        mail-wj0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757568AbcLON5u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 08:57:50 -0500
Received: by mail-wj0-f173.google.com with SMTP id tk12so66459963wjb.3
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 05:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nOba0bVx57x2gHprnLmf7KmYG8Jo8ToRK11OTTLWYzI=;
        b=nW4dWg4pf1okJJYCbRE7ENguyb+WiBFF2umrmZsjcG6pO6O7NBSk2L5QJQL3G8aFwP
         Spx1u9TwJSismb+OKv9AqKdRc5S1EmR4afQ8KYyzVr68XerUsovloj0zibA+XjRf/zUK
         T0bSCU9om1Dr87PfiDkcioGrhw5yu/FD1ekHAO0CpM8+WfaHgcjGldyRsh+wedZDjQWQ
         caTa+9+8OkrBjlryr9bSt5o34hmJPU38rPpQJ+epwqU8BjDMS1j9vgNiW9BLtiePwSEZ
         qBO/Ggubt4n+4rQTuRvh/B2LipW4uvZ7ts3mfoiPhfUjHnVPSbL+BvkHbLU3ytPw1g/S
         LoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nOba0bVx57x2gHprnLmf7KmYG8Jo8ToRK11OTTLWYzI=;
        b=PVzELXDcFbQ06LR7FuMk++Hyax9cnuGUD6vYjGLjjR60IUjZxGw7bHuL3AXayxcKH0
         57NYpeW/TsLk6rNEryj8BglLZBz8rXJFisHKRk0PE2KB/9hyZBfc7/vNAdz39i1b07zv
         oYymdiofLrXR9YUJ+aXat3jwCeLo4fYSSc0JbaNhtsr5TrNgUKffTBVfLuSl+lvyGX2N
         ZhKD9v7FW45vIXZty8N4SvGNxGj3BDvqWblQd7u3IdQcAV5X0vGOIfWtkvaZHouD1jFr
         cFAPB6jft/DH5Yqb393m2KLn8iaE+P7ZJwSXfaabk5wnS4wmiU2WwqV664CCHmVNtO+7
         ZylQ==
X-Gm-Message-State: AKaTC00dJ12XgiSUpWa5t1UVR+hY37xVmatmlMLxNg0udJCT+tx3v2dE6NYrJEq5Cw0eLheDfzowmXYxpHU2sw==
X-Received: by 10.46.8.9 with SMTP id 9mr609814lji.47.1481810268857; Thu, 15
 Dec 2016 05:57:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.114.78.5 with HTTP; Thu, 15 Dec 2016 05:57:18 -0800 (PST)
From:   Chiel ten Brinke <ctenbrinke@gmail.com>
Date:   Thu, 15 Dec 2016 14:57:18 +0100
Message-ID: <CAFw20syajXbjCQRcrqCv8pS9JwSge7-V4Hsg96n8SpYv2jJneQ@mail.gmail.com>
Subject: Additional git hooks
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Would patches introducing new git hooks, e.g. for post-fetch, be
eligible for acceptance?
If a more detailed explanation about a specific use case is required,
I'd be happy to provide it.


Btw, the link in the README
http://news.gmane.org/gmane.comp.version-control.git/ is dead.


Chiel
