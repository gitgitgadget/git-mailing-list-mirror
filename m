Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DBD62055E
	for <e@80x24.org>; Mon, 30 Oct 2017 11:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbdJ3L3r (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 07:29:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:55192 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752131AbdJ3L3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 07:29:46 -0400
Received: from localhost.localdomain ([65.55.188.220]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LabZr-1dRZQt0EQh-00mGqk; Mon, 30 Oct 2017 12:29:44 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.15.0
Date:   Mon, 30 Oct 2017 11:29:36 +0000
Message-Id: <20171030112936.15420-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.15.0.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:n6BjjSmON60na+kDvf947YqHKu913W002fM3Y1GpVHes4j6jquK
 Nsy4VqXohBCtUjgm8croA3s7EljsLaS3jIu6ACIcvXvXfxJwOLBD3tSg/RWWSg/5bbylW1k
 N7vHYDWL2GBZqh87+3RqYiSZ5huQcxzDBpozkGIXkNtrc/r5fs8Vd8xkG9vO2J9ce/7Hg05
 qslGmFgaG//GbNH34SflQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/TPnxCaFnbc=:3Lu5g71789ju5DwLJeqlCY
 BHY4lqDsTXqm2wk3Dt5lbSYuUglahtbJTKjcNyQlz0PRHMweencDbQyV0p69MFS8E6ICTU4Aq
 0TNUV7dMuirVusRV6g6g+QC/pWx7F19I5QnUKlw/Zs2lEoLefa9pX0YFZC/5LSqdla1e28mxl
 OCDNZ8KtvtEwhvOeoBzOczHGlm2rZgN9NLaNRqUUtQaSonKFQNP/qg4VX+5BmYjAdHJFCTjPG
 Ip9Mkb06L7Miwm+pCHhnY7Sjk+cdCEWEQT55oN7bA18vOOiqow7BFBl991HNOrYmp7yY62NqY
 BxvEtA3g96QPhoX3eZ1CXr58BJkZ5oJgm6pQDf4GgG45RY7Q3uo668Y/k53dD5dksHKgVbv5F
 wg2q5IVVIGl92URQHZYtwyfcdrIFF0Pn6RAgg023c/9SlMPL49leC6nqMNKaDkAP4141GDR1B
 4fw2ZMcIF9kQ/pC4Q3T8U//1ca33zErQjoYScc+dRNUyr0Vg+vPPH1q8uh7eI+j78iXie440P
 WHwiQwI66jY2CV1WakBnOgl/gnpblX9MqLOdz4TPUZOwV5l9lTWrlIEY00eZu5lTuqVjkZt+r
 lCE/jXNhmsgMqu41Ks6Bn3JIyD7boTBe2exadJIM5t8cl0BpkZoaDCTqQkOZZEQa9niOU2Fsr
 ury89kRTTZsxNmCOm5oJ/a8r8jLYR6GYbQgxTFZYWb2dhz11gXXJjHhMsoQTFqsZ4Fna4jY4S
 G4HnKU3kO6aleHOXFK6m2HRYx6LnMzkHd82VxtUXHcra2eDeoXg/khv9om/VKf01lM3QpuKw9
 6NUaMw7mj18gKya5f4mVtB9uvKnl+HImhJEYNWdrfLl7Von+rg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.15.0 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.14.3 (October 23rd 2017)

New Features

  * Comes with Git v2.15.0.

Bug Fixes

  * The auto-updater tried to run at a precise time, and did not run
    when the computer was switched off at that time. Now it runs as
    soon after the scheduled time as possible.
  * The auto-updater no longer suggests to downgrade from Release
    Candidates.
  * When the auto-updater asked the user whether they want to upgrade
    to a certain version, and the user declined, the auto-updater will
    not bother the user about said version again.
  * The installer, when run with /SKIPIFINUSE=1, now detects whether 
    any executable in Git for Windows' installation is run
  * Git for Windows no longer includes (non-working) xmlcatalog.exe and
    xmllint.exe.

Filename | SHA-256
-------- | -------
Git-2.15.0-64-bit.exe | d102bcd550bf1aa6cd128770d1fa59a18b3879697c5045ac4d04ef07a2bf6586
Git-2.15.0-32-bit.exe | 0775f901fe42fbde6147594a45b226cc92a3ddd3cd4495b1cd0b6aee0982632a
PortableGit-2.15.0-64-bit.7z.exe | ddfb4242c78eec03c533e733d0192e0e3d8ba10ad9af39e46ab305805e4ebbc3
PortableGit-2.15.0-32-bit.7z.exe | 9229e0f1100cea0d89d3c5f879a2cca78ac151db0a4020808cf967ef4e47b64d
MinGit-2.15.0-64-bit.zip | fb5aad5e18a9f9f86e33a94e6fc0f0d88d0defd227e43f10316d871f2123c0d4
MinGit-2.15.0-32-bit.zip | 69c035ab7b75c42ce5dd99e8927d2624ab618fab73c5ad84c9412bd74c343537
MinGit-2.15.0-busybox-64-bit.zip | 300fda25b364ba692bae66406fcfc1a9700f9823693167fe29f809bf350c4803
MinGit-2.15.0-busybox-32-bit.zip | dcaea2b1721df5da464fe4b52fd6b3fbf1f60cf38320dee122fc0355161f7949
Git-2.15.0-64-bit.tar.bz2 | f347c2a2841ee59dc5a61db416935e09804b90d288fe4a1a8a07c1c9f7c9f4aa
Git-2.15.0-32-bit.tar.bz2 | 63ce81c0992dbb557c27c6357649d25d917707595962d8a4188dcf3244cf0907

Ciao,
Johannes
