Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC19C433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 07:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052EB227BF
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 07:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgLXHGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 02:06:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:44231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgLXHGp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 02:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608793513;
        bh=oJL60mJCXh+1PO8lCNQR2wVBal48aiKwea4NurIixqg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=LuGHHDTZBvpjDtz96tXIRy3uiCxHeZ0DlIn2xZOIQQYeILRw1KtPa2LZq4JejzuYJ
         98S/ssSXg84fCsJLGcZyAvW/9xi7dYE+hFNBw0rMEjPT/2zHEG5c57e+3n9GZZH0Lz
         g6xtu9om04NtPOJn8ZLrPPzrfwmkJAW1438/jYGU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az767-492.5lddj5nhskye5nqdycyv1orejb.bx.internal.cloudapp.net
 ([13.90.73.113]) by mail.gmx.com (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MfpSl-1kQ7TU2FYn-00gEx6; Thu, 24 Dec 2020 08:05:13 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.30.0-rc2
Date:   Thu, 24 Dec 2020 07:05:11 +0000
Message-Id: <20201224070511.6232-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.29.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:DjdFuNWX3kE/TosMt8zBTdx/M1I4xIZjMQi5+iI6UqevTeqClNJ
 cXuVdsxHMGTL9JAs046JRYoWP7l3+lldAWAgX8gW2qb7xtn9UAtoNYQ6pGR4vwBrG00oOFJ
 2y+N0cO43xzCmPbWmpIhIQzvhDHq15MS6pswchNdLtzgQpzs+pasqupa/2HsbMzlXTo2Y+H
 Jcq2gxdsooIqJhmLMpZGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nOqfG+Lasy0=:y2uuKxRgHkKhi4oRmSy5Wt
 g8ZKd1n6UovTWpYKxZmPathMFdbYDhl9pL8RZvqzFdJ8yYBuOcA6z8Ibld0sBjhdtiTwOuy3u
 kwE9/dyigZp6E31CYSbEfHExmlM23Uo4aWzUUHk0VWhRtkokjg1W2+9JjvHDzgL+dOVRgOBGo
 f5lF/uXUYK07+936hVyKQK8sTxEvJITYyJgiPL1pAe7nf4XlqPqZO2YH365hxNesEhFcGUcTs
 VG/55qaYY6WeQtoS3yyt0rUwQHSBi28x5CRuxZxjLsH0JadkNC+H/K9CfKpE217c/XgumH8yu
 rw5fM8ODBjAI/pv0ffV6t0LLyqb0dJ/f95Pwv74lxMs21+YMLF4z3DjnU6y1Wll5PXWL/gTnM
 l7qebAfV2MKBBS6OClKID2OtaigoOhAgjQIJIe5Oz6mKkyql+TGPP9Z0X0F1c4aAnvqXAeuqJ
 HCqZpA9TX/r9OiG9IHyMHzJAMqCCNcSl8OSYZpGbci/Qlxi155gRXuSnArZyz99E4s9uxaY+k
 O+VjYWtObMJLIQEUe+M56xM0qYCq6HkoBzanpmCsQG6OzGNi2qXL2SATUjuRPq2RZgLTlZt2O
 4jcPkW67jI5lC4DHU7eqcu2ng2ks+qsuf0hvwPjLTbNtavPAQ9F5DDhAfL4MjjS0UDx0Ev0Hn
 HEbx/q4NoOfK3JZFGShhL2uacd00YMrTYVIQgfgz6yl60NlPCVMuLrU8e0tE32ItMAkJL7Vy3
 zQyOuVAy20R+w8XaYmGz3ZDubiNPMuYtjkcoXdapB01MImktYYGfZsQwTVnKORUVl1w77ZXyV
 4qBTInFH7R0gJ/PnCq+ajPonMRKmCEvz+omEhAvIM2/9jUszZgwd3J3ymwpHwx0D/tcy6Mhqo
 hlxJiSoFxw7Tf3d8JYQVBMNJQ3CaVPKXxtZKWUtWI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.30.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.30.0-rc2.windows.1

Changes since Git for Windows v2.29.2(3) (December 8th 2020)

New Features

  * Comes with Git v2.30.0-rc2.
  * Comes with OpenSSL v1.1.1i.
  * Comes with cURL v7.74.0.
  * Comes with Git LFS v2.13.1.

Bug Fixes

  * The auto-updater now shows the progress while installing.
  * The credential-helper selector (which is the default credential
    helper in the Portable version of Git for Windows) now handles
    paths with spaces correctly.

Git-2.30.0-rc2-64-bit.exe | c7cf3671dfaa679ed91ff6416e84e51d2195197621244c973bd44caf16f754aa
Git-2.30.0-rc2-32-bit.exe | 7b89bbf1eea88b945f78c6fd904edbba0d7d4c50574a8de4d891235c3439050b
PortableGit-2.30.0-rc2-64-bit.7z.exe | b8a398e3b173fe2f77fb853667f143d1050bf9e13441f5791553b63da1b49ec1
PortableGit-2.30.0-rc2-32-bit.7z.exe | 35d2b34ee2e5a051957c689a549d945d2119735a3a0016952e0012e7caf47497
MinGit-2.30.0-rc2-64-bit.zip | ffc50bd9128650aac4fb8ca0c4d674fb0ceb4b31b2fc21e7540203d8c521dcf3
MinGit-2.30.0-rc2-32-bit.zip | 559e6861420aa471e96e9a2c29ece92eb1934a230ec8ea50f2dc11ae98afdc84
MinGit-2.30.0-rc2-busybox-64-bit.zip | f29b3cb5fcab0a2daf87200a3475482ebd62efcb3c3018cbf91cea3ac85654a0
MinGit-2.30.0-rc2-busybox-32-bit.zip | 203f68d7d3ceee33777d347f7ff081dfd7aaafa4b398c2ef0007370ec98e08bd
Git-2.30.0-rc2-64-bit.tar.bz2 | ef284402da72399c8a3f3109baab4df3722edef63a7842d7969e041633824912
Git-2.30.0-rc2-32-bit.tar.bz2 | 0d49c663fd3bd8d444000996578e3532564ce925487de267cf984fd1e3adc5c7

Ciao,
Johannes
