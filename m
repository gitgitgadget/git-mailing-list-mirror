Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D15831F516
	for <e@80x24.org>; Tue,  3 Jul 2018 09:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754665AbeGCJPQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 05:15:16 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:57768 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754096AbeGCJPP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Jul 2018 05:15:15 -0400
X-AuditID: 1207440f-305ff70000000c39-96-5b3b3ea2dde8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.AD.03129.2AE3B3B5; Tue,  3 Jul 2018 05:15:14 -0400 (EDT)
Received: from mail-lf0-f43.google.com (mail-lf0-f43.google.com [209.85.215.43])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w639FCE3031690
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Tue, 3 Jul 2018 05:15:14 -0400
Received: by mail-lf0-f43.google.com with SMTP id h7-v6so1000775lfc.11
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 02:15:13 -0700 (PDT)
X-Gm-Message-State: APt69E1Zgxl1inB7j0JY96Fyz2As4rEJh80eFdpE1o4l4/lcHRL9QAvK
        W6ReFBeIm7SDKMcy5fOmQiAiXXrfJugCVLi47wk=
X-Google-Smtp-Source: AAOMgpdluQksZ9ZJRpQ5vpO1eXMjq+wJXsqkfWJ69bVQQyPQ1xNhcwNdz8QugKnhz5hslr7EEcauowEc+lQGABt30vU=
X-Received: by 2002:a19:1749:: with SMTP id n70-v6mr18476059lfi.54.1530609312692;
 Tue, 03 Jul 2018 02:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAGZ79kb0FOafEsuXU7c_BTwPtcujFeyWVhzSuzFHRFtQHp9weQ@mail.gmail.com>
 <20180629202811.131265-1-sbeller@google.com> <72ac1ac2-f567-f241-41d6-d0f83072e0b3@alum.mit.edu>
 <CAGZ79kZzrdswds4ejCJrhJD1UcJeODdhifX5-UREuK5wPUM-rg@mail.gmail.com>
In-Reply-To: <CAGZ79kZzrdswds4ejCJrhJD1UcJeODdhifX5-UREuK5wPUM-rg@mail.gmail.com>
Reply-To: mhagger@alum.mit.edu
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Tue, 3 Jul 2018 11:15:00 +0200
X-Gmail-Original-Message-ID: <CAMy9T_HUdszkq8c545puzCpjvh1pKAL7MWtnrZFagNndyyxK7A@mail.gmail.com>
Message-ID: <CAMy9T_HUdszkq8c545puzCpjvh1pKAL7MWtnrZFagNndyyxK7A@mail.gmail.com>
Subject: Re: [PATCH] xdiff: reduce indent heuristic overhead
To:     Stefan Beller <sbeller@google.com>
Cc:     quark@fb.com, Git Mailing List <git@vger.kernel.org>,
        jamill@microsoft.com, mh@glandium.org
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqLvIzjra4NsEE4uuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGV8O3WXueASc8WJqZsZGxg/M3UxcnJICJhIzH24gbGLkYtDSGAH
        k8TZu7/BEkICD5kkHr3RgkhMYJTYv2QDK0RHucSsV81Q3UUS585vY+li5ACyKyUWL1ABCfMK
        CEqcnPmEBaL3F6PE2XMdbCAJToFAic51/9khFshJvNpwgxHEZhPQlVjUAzGTRUBFYtGJjSwQ
        8xMl5m3sZIcYGiBxdd1yZhBbWMBGYuKhD2C9IgJqEjNXzQabzyyQIXHjy01WCFtTonX7b/YJ
        jMKzkNw0C0lqASPTKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdE73czBK91JTSTYyQIObfwdi1
        XuYQowAHoxIP7wVFq2gh1sSy4srcQ4ySHExKorwSDUAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxK
        IrzbVIFyvCmJlVWpRfkwKWkOFiVxXlaTvVFCAumJJanZqakFqUUwWRkODiUJXhZgtAoJFqWm
        p1akZeaUIKSZODhBhvMADb9tC1TDW1yQmFucmQ6RP8VoybHpUfckZo5JKycByT/vp05iFmLJ
        y89LlRLnXQ/SIADSkFGaBzcTlpReMYoDvSjMOx2kigeY0OCmvgJayAS0sGebJcjCkkSElFQD
        40rhJ1uU2T1MFx9/u724oSDlWXvksv8qml3bsrL+Mfibfwyudfy05nwo593v5q/LdI4ZRT59
        OVm5NeXXTj3X7sRnAYy2PyK4lB4/Da0vPvinRt1wwcEjxsWyR6NO1MSuvLxhZrSmc2KNa4fO
        vLOML1aoyJhLLX318zv3ibV3/TanTeFTKrbsUGIpzkg01GIuKk4EAGiLy7klAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 2, 2018 at 7:27 PM Stefan Beller <sbeller@google.com> wrote:
> On Sun, Jul 1, 2018 at 8:57 AM Michael Haggerty <mhagger@alum.mit.edu> wrote:
> [...]
> So this suggests to have MAX_BORING to be
> "hunk size + some small constant offset" ?

That would be my suggestion, yes. There are cases where it will be
more expensive than a fixed `MAX_BORING`, but I bet on average it will
be faster. Plus, it should always give the right answer.

Michael
