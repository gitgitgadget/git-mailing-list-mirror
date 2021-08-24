Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA96C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 11:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6368610F8
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 11:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbhHXLgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:36:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:32839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236205AbhHXLgS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 07:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629804933;
        bh=9JbMdO19NahTWtP0Lv24nSMQ04FS9jP78r7CupOnyLE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=SP0Me9qv+LyZz0rZIO3lfsfXesOG8Qcua3tIOKR1pWBCGrlj2Vp6zXZQ5ucwAYbxH
         UNtbbulT18UFky01EyPhp2SOLg6V5ZNn2X+9gkJMeWtj6xOmjDdB4speAYXCHyTPAX
         cQA9ryuDx8lFRXn62xJoFac6pp4q2tetG2J3FOFs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az300-839.vd3bvdt01soendqy14x1utznud.bx.internal.cloudapp.net
 ([40.121.214.72]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1Mn2aD-1miWH53Vod-00k4KT; Tue, 24 Aug 2021 13:35:33 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.33.0(2)
Date:   Tue, 24 Aug 2021 11:35:30 +0000
Message-Id: <20210824113530.5539-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.33.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:fH5T3wLcwVIWf8cqY+HDc4kKxxHyHAGYMKbSxtHckoG1DoVhbec
 4w+2/tuV0+5WpBnY0I490/yttTKYj5t2wfdu1BDwV/3W60634OZBjvn9nS5EB7S7bRpryE9
 rvQBm0S1UO9rQZqkTsYVtNaRyXdzFvgc6tJFFkTBmkvatLN5ahbbgiFFa7V3CCqRtEmXnYa
 dYvVgoYGVqj6vpK1q/XGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nv5HN7Ci5FQ=:nt/JYrGmx1ktknLKEdBpov
 R04Yg9HX92D79ObBaKY3qgDOBmdkzc8Ep1MR5kIV+iL4yqXXF+L8AAIUYxbIFMbiTWWpjyt0+
 ZgjFvN7Q0dbE5Z4PJE7PYBCW9EhrYfaG+myoouWQwgpfiHhpwlNy5cvS8FqH8wiRh4HQcepM2
 0YwUYYv7oavqQ0PqpiuyfzgY6O31xy3FRzVdEixl86tMBxgtLjOwdjg3zvzlYnTiic/jYl5Bb
 2eoW1kNlrjRSPBIytCnlR6xGGmyaeMQ+iDx3G/adNeIaZEIbHD6SyOYiUFhs4DSzf5NPgDtCV
 IS/JDZeSTx6vqmZ5A16tCYwxEXhQB0uD6isIqbOKWbSnbAbCaSXKjNJOeuQfrEHwfreu1xQS4
 j4zkWTtxqyWzpu45fiEyQMRbPrkwp6wFFLjtXOwrs0k/AVd9uo2tne3UtN3zBLMeWRgpkxRrB
 y3tCrSyXa/sbcVonRv1c9c1I3UXlwLZLbUjlB8L2td6Ttx8PD3Fo0iKA5jPdIQugUeeKiRIdo
 /z2UdOldEv9urr5HWuU18mUPXiBoG4ki/SzF9RMz4W2pN1MV64EpQk2qQIMgtsKO5Uqkvo9te
 C7r/O1dTNcW3O/mNhkSt25vwi4fkMRrp+JIf+ZffKiCRxXZgUHGJSd8qX5OS4Fl1MYoZtVZzX
 giC4ic64mtmtFw/kl79VIV5LkmFZWAu9NkUoQnrE+bdbYHTUOU6czq3xfwva/n7utrGMGVjVl
 nYA53kqTaYtSIxrE7HrLtQg36mlt+Kl3k7mOOUQW6c293/S52ZYh064cpUfv9kfrPLvbLMn+M
 F9DVp2dLkTnpZ7+acidQgEGDyQhrPo6eIE1PSB61WSOzA9ffauqK6GvVHPd/qHe2v0WLS0IeV
 IGu+YPvVHWZPlcWrc3995X9i0iLK061qCcT325hxWN2xwSCF34ki1RhumddkZ1gdqbyB6k3tk
 Ynm/pyHVRjsFLuwpaLSuA9QRHABuToM/LL4spL0X6mm930f8sdKp9+zF+2B0p3ws17kA3tqtp
 SS45N/jcsriXKoZvnF0FAaqWVFJP6acORHH6lVzcvX623uhnrwKs2H+YJeR/5yBKHuc+Ahwr1
 mdOd5vtz8nGoUtiEhUEUMTfouvjg/EnQ2HKwYnInhHwRwXoKqCkwOAwNQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.33.0(2) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.33.0 (August 17th 2021)

New Features

  * Comes with cURL v7.78.0.
  * Comes with OpenSSH v8.7p1.

Bug Fixes

  * A bug affecting older Windows versions that caused the installer to
    show the error message "Could not call proc" was fixed.

Git-2.33.0.2-64-bit.exe | a5704733c219e9a0c96bfeb0febef62bc2518bdd4e358bc9519dbc5e63a3b5fe
Git-2.33.0.2-32-bit.exe | 764c153a9e16dd7121a78ae36deb33fb07975d2fe9030c620e99050a97f6dcd8
PortableGit-2.33.0.2-64-bit.7z.exe | bc030848e282d49e562ae2392a72501cf539322ad06ffe4cea8cf766f148dfe8
PortableGit-2.33.0.2-32-bit.7z.exe | ca65539faddd27a7036a4b9dcda3b1ecd4026f59258533d919c5cbe34727d583
MinGit-2.33.0.2-64-bit.zip | e28968ddd1c928eec233e0c692a90d6ac41eb7b53a9d7a408c13cb5b613afa95
MinGit-2.33.0.2-32-bit.zip | de2d93251b233b2b437487f96b59625571fa55ccbf1c4d244c7bf7d8065354e3
MinGit-2.33.0.2-busybox-64-bit.zip | 273f55e881094d00877d64f56570b0c997c4da5dedcb26738d56481033c1eba1
MinGit-2.33.0.2-busybox-32-bit.zip | 353b4838172da8dabd3c6ceb887d4e76bc1e69aec686e9dd4b933c3f37b9a490
Git-2.33.0.2-64-bit.tar.bz2 | c47cffee0518a2a72e9137dd47903a75e72194864c182c5ccf58c8623d0b755e
Git-2.33.0.2-32-bit.tar.bz2 | e64ceb2ff8dbe4cfe8f361472a42f55ce44ae2ba3d142ba911ec86175397e351

Ciao,
Johannes
