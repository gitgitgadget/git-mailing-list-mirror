Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C64201F454
	for <e@80x24.org>; Fri,  8 Nov 2019 14:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfKHOLW (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 09:11:22 -0500
Received: from mout.gmx.com ([74.208.4.201]:47227 "EHLO mout.gmx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfKHOLV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 09:11:21 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Nov 2019 09:11:21 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.com;
        s=dbd5af2cbaf7; t=1573222281;
        bh=mILFV9fa/r3/R+g2E5+EgS2tmkrePr5yaVPydBKaStQ=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=BDqCkordAQtV0jaQVmbsDacPy5isolDLMQbckP62a5bjHk31Ex+aqMmvAy+S7sVbU
         Nw9tq26IQdAtE/KvNqxSTpUH15AGmxuaJz/YTtKZk3n2dRzCmXaOliIb6HfT/xuuNn
         RD5YZjr+M1NehG6AtGkQ5ki1eGDiuP4pHX0osT9Y=
X-UI-Sender-Class: 214d933f-fd2f-45c7-a636-f5d79ae31a79
Received: from [192.168.43.24] ([31.161.137.84]) by mail.gmx.com (mrgmxus001
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0LoE8d-1i0Kqw2KQD-00gKeg; Fri, 08
 Nov 2019 15:06:20 +0100
To:     git@vger.kernel.org
From:   Paul van Loon <nospam@cheerful.com>
Subject: [BUG/FEATURE] Git pushing and fetching many more objects than
 strictly required
Message-ID: <bc43c70e-861d-425d-d7c4-73a3e25b7383@cheerful.com>
Date:   Fri, 8 Nov 2019 15:06:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZApa3AT5pWfeJlhf9aiSfP5WQqOCHi99eBoN3Beoiw0bCLuqOq9
 Iue4kJMfqd48m+5LuxAYw7j11Gbau08ueDTIsoY51KiO+WG20QV3pSgk8NABBJ39ydtw61C
 n2oF7QDrYI9Hy0jsdVq4wuDyVWm4GKrFnEJuTAQPgvIeZgY2x9mdcsamLgIZBgdz8Vg4ujt
 v69iLmWdpRx7o7krUIa1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YoB2O+fVFhQ=:y+/Ap3Ge6SWan1AKF/w/7x
 pGA2OGb69OIFALTHF0JvnACCWyz62Zjr4sklNsE8m6/cuLIqRlmSjx7SrlkGxZ3VzeGr6FGrG
 l+VhQUJ1TNnTofPKKd3npM6Acd/NAlz9ZhZPOTAGlOKUlrqKS0/MPDg7rmi/d/85mR9fs9lxW
 VRivE0fKfXoPOKHWUlbeGq3zBLs3xDVu06+yNvgrTsrBCK8o49uvgL4ho1VysskmlDnd7qVKl
 WQ7QSuj7/1E0Htuv/29ma8WZ5rfqA93HApAoJOYyqDBya8R6ZyGJ8zHeNJZdCpdGUxrLmE75X
 fytIcI5M26GrclApzgLs5vGJbFq65IeQ+2g1uagId7Kq7NbstMhJ/mmvfriZZCMizPQ+I70Xs
 ZphZKNS18ZrHgfr83lNgLbkfat1kgnhbNw8x1KwtqtCyKoU/tpyqV0xDyMnEG/rRJhLjtVcwp
 ZwsZNY1fCbbDCzHUeCYFNakxfuzHFMFcHSeL0Vi5OWUisWbQMmqykJ1GkLjL7eDux1qaFyB8Y
 ZIkd2FI9vGQkPskAAaKfhIznzOLE4kIlq2FistK42ZIwrmVXzxYi0zeqf6h384H9Ald+1oafW
 +IiCscrfw06A+x/t8fsOBNkPARb2A8BLxpTBGWhKMhLehJMein4YuOkz4rFjT9ohDIpeW5B6q
 u7+XMgYUYrAFJHaNlsCESmwn96NonT7L/M0gm3zFnQv01Yi7elEAVRmF2YWiFUVAcSbnlOp2U
 13w78EivMq68v/irsHldEnIOnfu/NPMLTNAtYSDfkMLTipxuKqTy7xOD+Hw5xe4RdAnATNuOn
 EgjfNPGgY35yJ/UkW06LMw/DkBIPb0LGy0msv6nL5pMXlKMeH2EJyH+PGxITos5XWDbK0k1xJ
 msjx9cMsA+gYUwdAokEuowJJwHq2lzlPRFs8X+NKH4F2AHvbpQ0ufYDu7YZV/M+ghVWybK46R
 WyCtMrJraw9eR+SpXmHv3x7wQjdkPrVSZ3Fm73r+8i1isdR0DcbhEZIsbMm35BzjELUzoBy56
 CNISB0Xij3Hja2RI0HWAel/afAr6zCaTcIs61GUcypj9eGBaIFIFou1O4hh/7M5CqyaglWel1
 SB8D0ZC19041PeE/HimZMZGJG4z9HxSPQJS8r3XuUDp9y+oO0QyYn7dr3806u+AIK97cMS3q4
 CUmirbdeitnvg+1c6uZfQW+rpYleI+okzxEFuWt5R9lWjk/9VIgNTmr7INooSf9VeHDQlRMqG
 ZXtCQyjeDFA8mr35BYMbUqtcieOKXr2yiXxN1lAV5KcxkTgHFWcAQdjEF1GY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git --version
git version 2.21.0

When fetching/pushing to a forked repo on Github, I've noticed several times that much more objects were being fetched or pushed than were strictly necessary.
I'm not sure if it's a bug, or just a opportunity for performance improvement.

I got these traces:

$ git fetch --all
Fetching origin
remote: Enumerating objects: 29507, done.
remote: Counting objects: 100% (29507/29507), done.
remote: Compressing objects: 100% (33/33), done.
remote: Total 53914 (delta 29478), reused 29500 (delta 29471), pack-reused 24407
Receiving objects: 100% (53914/53914), 31.90 MiB | 111.00 KiB/s, done.
Resolving deltas: 100% (42462/42462), completed with 7382 local objects.
--

$ git push -v origin 'refs/replace/*:refs/replace/*'
Pushing to XXXX
Enumerating objects: 2681, done.
Counting objects: 100% (2681/2681), done.
Delta compression using up to 8 threads
Compressing objects: 100% (1965/1965), done.
Writing objects: 100% (2582/2582), 1.96 MiB | 1024 bytes/s, done.
Total 2582 (delta 95), reused 1446 (delta 58)
remote: Resolving deltas: 100% (95/95), completed with 33 local objects.
To XXXX
 * [new branch]            refs/replace/XXXX -> refs/replace/XXXX
--

Especially the pushing of a single replace commit involved 2582 objects to be written. This was after first a fetch was done.

This especially hurts on flaky and slow connections, especially the more objects need to be written/read, the bigger the chance of the connection failing.
In combination with the inability to restart fetches/pushes without down/uploading ALL objects again, this can become quite a frustrating experience.

Any thoughts?

Regards,
Paul


