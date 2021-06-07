Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A7C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 13:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3580960FDA
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 13:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhFGNJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 09:09:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:46691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230194AbhFGNJY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 09:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623071252;
        bh=NXpZDPd23lEgIh8bLN73vldqHhuQucwff3eaZIxmcns=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=EMLBPAd4SXSUSuo6553t0Mjll2c3tstRhnI3kv3bQXDO8ZWkVmP4Rz3BWM8WKqtlW
         9FEfAlzqeCJdX1CvTqghKXriBd06vkgWTswImmQhl2B7vW5/4JMVSsHTvEzL5UBJ6r
         iHO3H8pmEd64WK6XnFyIldGtPMJHxxukE+cQ001Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az94-167.4g44ktyaxzeuxfnuq3afdkdpfe.ex.internal.cloudapp.net
 ([20.80.10.241]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1My36N-1lQqrc2Yl5-00zWUV; Mon, 07 Jun 2021 15:07:31 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.32.0
Date:   Mon,  7 Jun 2021 13:07:29 +0000
Message-Id: <20210607130729.4854-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:meNpJ8ieE//Cs0A5bW/3RUjb0ECDYKZLVlnIabgSylbg7sW52Ui
 XWx7jO83qga2gNJojyp8omCIVYgK+OLIsDWnA60navd/1n5dyBsMogXwxfL0KfBvRnMPomF
 B1Ga485+Gbvj8wsDAqzs8e/e/S2nSxU4rQKeJmYP2WGhlD8MxKdOsVi7thTmuWVJ/rtdzPp
 1eAIHIf1UuSLSIJR+PL+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ttHLCMI2dwU=:XtisHSjrdxuC9ooAmMupif
 gTewVWKDRHHcy2lyAykUWY2rDMBAz2lsS+TUaXs8/vXy0lsKgHFq2RQcRtzPWLsa/OwSj6cRv
 hnBz0WLmklQzKdXn/mFU/mNYWfTWwQsxO9H/nYI62oGkt6CrrtbErCMwmly84qFV0B9VEI8v4
 gwot5wtJfpO+TCrhCtnRzVUSy06y5fkBxN8b6YDaKL2kxwvr9hqNpgsUbznu6k/8xb5kbFJMk
 vqo4V3bMsj7lZ5vGLxvS8m5c5cuImWAhbisE3Z/Pq5+W8ult59kmMZL4SRdXCqr9dHWo9pRUZ
 ftJE3IaUu9ozEc3iVGDSAaE5sKt3YjLB4hkbfQoBhKIDr+5X/2IBkXFTMqce9yAoRydhX/52g
 TXIDjqGrt1XEAv9q2mDobRodCi5v0Kc5ldApoUuDwrDHKkNDUoABiebXTZymuy62DiabFQTr6
 AlfrOrLZ068lq7GBNWep4g8OMDjdTmR3DzL4GNyMTIdNKRKB9X7sp6eoiF/Vmw0Bt+l49L25Z
 ka8KsIqtq8obJ6kn+QKrCClf9M3FV/oBqelds8Ac6J14xNPslyy/MhJuy5gq1sXHf1Y6ENUjq
 7+bkFFNlqYWvR76BeBg9cKjQ92uWMYYBZ6ICvkyDvw6w+JH8janBSthrfwg0SUHq7mIMZNavr
 NMizrxUP9JtnBlG6WN2OuWVk6dxrHQ9yC3YnrHrGoX3qYBST4ZA06OpqKeUMm9AmSLIMS1+ZJ
 OakXwh58VaiW7DLVjlJKZL3VO/HRvgFYevxCieSec2CicBB3ZBYZVoeEtOxVGI255neL8rpkX
 dqKsx+N+S6DioG13O9/fiE518XBXjj3eDRK6kj0NKMqeL5kvYT3REGU76XJt6xI3EWLdk/ycN
 IYcIMdlZhvDDmBrY/JoCxZaB3atR6cMUDEXOlzQcQdsYlY54KTd2Z3xNTfqpfO8Q4v+kvXsCh
 CxjIEJnKZGtTiXnW3utpnCCCxMFig06JU7q6rGcMNRV6iuRBzVhsTA3aaTBwezHcX35Nw9sqG
 OcmKekhUdvGCPCiMRQRuccvBBxIadJFyYcqWohsVKftVzraNKx83XXxTY2hVjAOSGVvH/WzD2
 fL3UVp4+zI9X3yINE2nmjpCpHZqj6pX1BSvwXVgGVCZ21nugBpiyDiYPw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.32.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.31.1 (March 27th 2021)

New Features

  * Comes with Git v2.32.0.
  * The installer now offers to install a Windows Terminal profile.
  * Comes with cURL v7.77.0.
  * Comes with PCRE2 v10.37.
  * The experimental, built-in file system monitor is now featured as
    an experimental option in the installer.
  * Comes with Git Credential Manager Core v2.0.474.41365.
  * Sublime Text 4 now gets detected by the installer.
  * Comes with tig v2.5.4.

Bug Fixes

  * When testing a custom editor in the installer, we now spawn it in
    non-elevated mode, fixing e.g. Atom when an instance is already
    running.
  * The meta credential-helper used by the Portable Git edition of Git
    for Windows sometimes crashed, which has been fixed.
  * The auto-updater no longer suggests to downgrade from -rc0 versions
    .

Git-2.32.0-64-bit.exe | eed601ef835c3dac08d2e27f6f38b5db7998747c753c87a45b326fbd6c710309
Git-2.32.0-32-bit.exe | 5239b465b893ea595f6a73fde20691bcfc9c65661fa1b74441d9ce7b98848ade
PortableGit-2.32.0-64-bit.7z.exe | cc561200eb89fdb19c75f901aea2740ffa57a627a31c1a6ef86a8d37e3186275
PortableGit-2.32.0-32-bit.7z.exe | 29495a17a58ee5fb0345a18d25bf410bd2d1ead86896ba9d2eecf0b690d78f0a
MinGit-2.32.0-64-bit.zip | e55a73125ea2fd6d1d71470e089a97cf19e6f1c4aaf7c25958d1a9105112a6de
MinGit-2.32.0-32-bit.zip | 6463c624236cbd2c9772be12ff88c5137f83a3fd550a1dbe9bcb307d0923d8e9
MinGit-2.32.0-busybox-64-bit.zip | 51b90b7a857d6407b5f10c2d657a4bcc71f461438bb23958576893c2b41b9780
MinGit-2.32.0-busybox-32-bit.zip | 937330daccc3be48da4ee7b30381f9a00271d5c1ee2c56f9d70005c5c68a1144
Git-2.32.0-64-bit.tar.bz2 | 5ddd62781c33535a8bfab894b5861e47d1024416f9196eff2d9047853c636728
Git-2.32.0-32-bit.tar.bz2 | 699ded239282b56f7d120e1e2a0aab3652e63c4586400b21a618d1b31189c9bb

Ciao,
Johannes
