Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3375C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 09:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC0C361183
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 09:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhJVJh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 05:37:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:43971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhJVJhz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 05:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634895336;
        bh=NWt1/j1EkpmHH/mIDMzV24UyBZtxT8qczZgbzcrupko=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=KdJZ0N+x0ZMVvVMBbomk3hroroRsyjrDtFoxS8S04DHnrtOyef65b2C+VVhMx56qx
         HfN820XlqG3RkrAH36wUWOWSkPeikPHdjKkRp/vaOgjo1mc6ksdpt2ncK3su5F4ns0
         x1OEvF30azlWL3v/SwHiBwo7wqBGq0LiLU549pHc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvrB-1nC6mj39pt-00hKc4 for
 <git@vger.kernel.org>; Fri, 22 Oct 2021 11:35:36 +0200
Date:   Fri, 22 Oct 2021 11:35:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: Re: Missing notes, was Re: Notes from the Git Contributors' Summit
 2021, virtual, Oct 19/20
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1M4s0t-1mefuR3UZj-001wNu@mail.gmx.net>
X-Provags-ID: V03:K1:BYCX/izrfKp8Qn90WYNhnUGpYMSkbWBLQWlo5YOlI0VlevcI6jL
 7xHZT3IzgMyiEFYF66aqwi1mZ8ijkylyR04DxvjGW+HT4lK+LxQXFlMAJLIwpLn/bHwnP5H
 3GkX9t0BY6mpoham/mCYimHbQWm4tLCYSSH9sNl9S1OUb1uiR5P/2Txn0cluO2FQcEbZ2qa
 +DvkVSNuRrxKaD6XNOJrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z0mSrVHzc4A=:1NjoYjm97nS1cgdsAs4D8j
 jkzGkntLv0ywcLxTme9+QZSSCZ3TI6UmFdQISQKymdUmlkGH/Hxluws021eeAewrQ+VnioX1m
 I/IRMqDPCyHBTP5dEMqnK2RsalpnSq4vtmFvxwoLtcZ6H1cdFuBjivdySI+vwOvJZUkiAleEB
 vdibHoVQhZK8ObUIHnGHYnGhKgOnTsiuuagALLRii6mpsTlwypv279r/PObR5I5ROvnLcTHES
 5uygUEykYRQ9UHfpPPGP+cAQ8Qk6f7LLm/L605bliZ3Lk2Bp80kBA0Pb0DgLMQjivisCBQLdr
 9tkIoA2EI5kFxU4NvmndW2bDzGZgWBXMZiFGDz4kFab105jBaVw6dqlycV8kUmIb6B8VWsatl
 tmp6zJjJl/+iwG5axYZ3ctTdDolMz99jUCh1rh/xQZW0r9JsD7eYEI2oGZwyZrWBzAsAgDAVB
 bpIyNLAaMEZl+y0iRGxwuy/AJJZBSLwhrowoPtmu03tZOIwhSxmfksa7iK/ORtSYerZNSSmEG
 nBJqgS/Jya2i6aIGDOZn/vellQCTdMfiSzLNT4wZ5sBFZIgVkh3JQCwRfbcm+2aIhsfQdP8rS
 Cq9bqx0gYWEwTHEglxzNvpXIUs2PUIDh+sRFdhDiNAubkJvtGXOx2yfKNe4iYM2OESpJFKfmF
 1wNEPd1ktfFTiJqHKUN9ZEskZNNLwBH+jkY8gAPhPPOQ5GBS49RwMRZF7AGgde1mcsmRmnvBB
 5JYTOdcgxmkxOIF75WfTB2/6eV1ex4YJWBvTOdNPgGGbiez17hDv9pQ01GyYp5DwRS4DDrDE/
 OOQWFTpB9vE80/8lhXGdM9qiq5EuUhHal+Wnnn8whi+RRDZGmHuB+OwAJXunylfzZrRRs/kQX
 aqIb9ymv9945EQfL5ZXImJf8nWfW5JmZeEJZqOfR4UV3r3Eu2sQvWE5tHItl0QT/Rk7q3WXrK
 YAmulEeCJs93zOSjPhvCQfHp97R+g0JxMyItRcLk29XxI1LPAwAKe5JxQTiHuLBiHyhLuk3pa
 KDY/VlDkttwjVGtEOtAmGuaenn9SKnW5zssFd9XKeDqQX4oUqCTgeJGGRjiJ0kueg6H1xDZUv
 mvquCxvWvedIeY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

If I did not have the impression that this was an important topic, I would
definitely stop trying to send the notes on this session.

On Fri, 22 Oct 2021, Johannes Schindelin wrote:

> Then brian m. carlson offered the idea to be considerate of reservations
> by participants, but also accommodate Git contributors who would have
> loved to see the presentation but were unable to attend due to
> timezones, time conflicts, etc: offer it for viewing only for a short
> while.

CB then said that it would be nice to see the other contributors face to
face, and that they really liked the idea. But they still hoped that this
new Git talk series would not replace the other things we do.

Another point was raised by Emily: in their internal meetings, they often
talk about Git patch series that are in progress, or not even started.
Some ideas to improve Git might even be rejected, and it should be a safe
space to bring up these Git ideas. In other words, the discussions are
somewhat ephemeral and therefore it would not make sense to keep records
of them forever.

to be continued

Ciao,
Johannes
