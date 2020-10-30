Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEC0C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 15:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89CAA20728
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 15:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AgDx4Tkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgJ3PWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 11:22:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:36703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgJ3PWR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 11:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604071335;
        bh=w3KHHTactq7P5HTYRgd2QJFRNNBAFKrJKAr1nZiOBlw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=AgDx4TkzeVwih+/1nBDvZEJ8OqJM/Mz+u04ugI5IFNVxYxMAY6bnFaT7GyTpqiwuh
         Z/ZMKa76DiALI51LolsJ41bybrzll1qrcM+K2DsX0cFe/rTLbgetxhQ4FAC7vLdw3M
         nNMVGErQ9fxgXR5VS4XZaIHW5f5oUiYeZeUZ5drE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az767-460.40n00jx3uhqe5lw5nh1ebuf5ie.bx.internal.cloudapp.net
 ([168.62.53.69]) by mail.gmx.com (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MXGrE-1krnvk3Q0k-00YmYJ; Fri, 30 Oct 2020 16:22:15 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.29.2
Date:   Fri, 30 Oct 2020 15:22:12 +0000
Message-Id: <20201030152212.7235-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.29.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:hR4jJ6uzodV6rzUOOj9jwAKrcDzdduSOnjmJklbcwwywY9yD++p
 BVm73pRiLg7U9nSO3W1orKs3DyQctbfCh6leKXxpybOz45wP1J9zSvJXOcpvU116IaqGjB9
 iO6OQ6WvIrLBAxCuwicx9PPo1R7cRGFD84OPFGX+0jG6ZAIiPkNThZpZeLQJeoUE9O/WQ4z
 h0np+nagvKxkFPM+dngYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9kNakk8JS1k=:AVAzJKaaC7K0OndMX+OgOp
 wUlHe/sJnHccBjxqLbtKj1mxlHPRCTBeapGydK2Mztwc7jWwdRLPhbJbZhl9K8wUkoVPVsrvL
 uuL+mpZYBAb1qwOp8OzRxH2/hvi2VPQ3lckU5RnhrwfzgguyGo7HfvZnf/ATW3+loQTaAbR20
 GmypIvr91io/2WjRoEI2t9m0VzItiL3Az/1Q2FIN59UzPfqCAghjTSxXPD6YGvTo2/tZNsGB/
 yNRpa2U6OqPvG4OTXb+mKoXZcEWUMJvobUWfQeaONT/TekZcoXomt7MYJtEvO7OpIVUX+30r7
 /v8uW+Cy8pcsjityE0LF3Or3XotzvUEjHUw1OH7geNuLyW2wKikoSlwqPgz5ZLylX+meG0+G6
 67Nws1QX9rkbxMWVe4d6ldgZ/2Igvm8C1ZDmj4L1VoJDt+0UASu4aEAmFX8+T8EI8UGmVdbHJ
 VleDBtVTruT+r4I2sJrF4nEBrbgXF8sxAnbPPzGhdtJ5DN547RqJLxPhYE0E+b8AB/Dlod0YR
 iITFHhkvLMUFfbqlTkzQnt3BJ37Q3p0K4fiibSPHcKpLW8hxlJFHyLbiCU+WynRVpLdczwC/P
 7unprWlBxwzLFFZIhUTlx1IjAMLQSP4qzmkG98Pdd4PDvqwrTPY+TC8VRwlb4pAm425PfSJx0
 25L9PPV8/INbfFHnjMLoWUnSZkbvzK5rcFbLoOsFY9kA+ulr2IXeyXSb5W5bmF3Th0omnb/rr
 ESBxO5nb3ER4G/fbMsmFgw1c5WN+vB4bmpb5yt24QICGbMabhoKgMcx0+2/ostOOR+8IXSfCf
 dYJsmO9egq9XAIHXkw606uQFT6XvnQnrSnb1T3M4EtCybURI0O/uhviVwEQwfDqB0iYIO6ece
 FHi7yuqh5csKc9BH/9X0RPzxZVHjtaOc7b5+yI+yg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.29.2 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.29.1 (October 23rd 2020)

New Features

  * Comes with Git v2.29.2.

Bug Fixes

  * The recent regression where OpenSSH's copy-ssh-id failed to work
    correctly, was fixed.
  * A regression preventing /usr/bin/update-ca-trust from working was
    fixed.

Git-2.29.2-64-bit.exe | 0cec87c0d106579241b77073d6a6b639c6e40a466bac68b859c4dd037e6ea8d6
Git-2.29.2-32-bit.exe | e2734e2731c415bfaea2ae1da104ffc131e289dfc0d0a5d4dad03a061e0f925d
PortableGit-2.29.2-64-bit.7z.exe | 7d114e81a541536b025313efcdf6feea1e973323f2b8f53995721bfd511139bd
PortableGit-2.29.2-32-bit.7z.exe | 5e4dc60d3ee143585da03843613bc4d9032b1b6f4d3a2473ef6d9adc8e4c71c0
MinGit-2.29.2-64-bit.zip | cf910f49d75224237d19895fd98a900336b53e414d16b80903e2ba2a500d4ec4
MinGit-2.29.2-32-bit.zip | 99bc40b07dbc2bd72784fee4d2f0a5fa3fd37bd1e68d63219671c57f429c4f09
MinGit-2.29.2-busybox-64-bit.zip | daa29780b064f03563879ce48e94bab5e7ecf02eae80cf7191b7f47ccded205e
MinGit-2.29.2-busybox-32-bit.zip | 7e744368f4316b331df55a90632ef2140038553de79e1b68895c1ef1a97df8c6
Git-2.29.2-64-bit.tar.bz2 | 220464737ee8bb8bc1d42c281ed6d21e9b029679a3ba42186d2bd747605d7b8f
Git-2.29.2-32-bit.tar.bz2 | d09f6986300e38f326e3e0e8cc5d03ebb16780d62cd5d99a7bdcc3907e009c3c

Ciao,
Johannes
