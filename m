Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 992311F404
	for <e@80x24.org>; Tue, 20 Feb 2018 12:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbeBTMdJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 07:33:09 -0500
Received: from mout.gmx.net ([212.227.15.15]:45899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbeBTMdI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 07:33:08 -0500
Received: from localhost.localdomain ([65.55.188.220]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lq9oW-1eJR3a1YP2-00dqBv; Tue, 20 Feb 2018 13:33:06 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.16.2
Date:   Tue, 20 Feb 2018 12:32:59 +0000
Message-Id: <20180220123259.7628-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.16.2.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:qY6BGH45LoN1FS3/i5a9VcZwyGJSnXVjZeET+Sm5H9aHYpiULzy
 ADafnJToSztYoOxOyG5mzCkm2xsRG0Rg/HGpqYLctNEIkMLpee6HRIhXS903qzJe7XiWg7s
 KxQ1K9SuCf+zToIqoRwp2qSWROJGRg3BF7BD9mTQqmXx7QFp9zsg2Wx1RdVpphXk6FPS3ZT
 aouAxv7VQvQftYqn+wxlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i7xZH6qeSLI=:0TMe27p77FyMOZJhtlZhs/
 YHnxltqcAjZdFYgy//HbNScH+vuuUqzqjA5dpt1MBke3LobEfckN/I96O6VbKdmklTL21SyOV
 ZZZUfkjEik1zvee2ixn5R5dUE623Jr/tsBXZmaAYFfCoJfvxJ6o/jlr+tBlYd5brzHqaRaJpv
 jO5XIgPPzHzx5ZQPktrkS9FHeYi5mEFQco5J6KnPKcnXHRCoCPoF03lNxa+iwgQoQIEOOSq7/
 vcMHxnrasDglcZFieqrwK3FyKHFkMsdEkVQHmhLoOsC3b+zLAd84mU1hfrKKh29mQRLGUJ5rr
 H3wZwwMnT+HwwM5g+W5T3RR8s7Y6UZsl9RG4gJUXKu9Df+Fd4o/wOdKRaBnnRjEC+hvjPfPLV
 B5AGOadAfCf8y74KT97z4LgAabBnk+62nI7ZjCVsBeFtFdrVUy+YHqN8qp/vPi/PGsE41vpk3
 fg9WTJgrJNai514Ij/uBDN4lNNE0NO7fQja15bp53r8VM2MGR5aHbmPcmbd/AQBXuD88asflj
 8pyiw1Na3VzrxntjIqf6qk4VSKLYhBUNguz8FfgqXHi2/YLFQLGTefa/do+xBLNcLfgCu1oxB
 FLpMACl7cLjYzVHAKs8z3H/+L4xJHtz/HxykX96exSQQrN6HJZDH9qO/XJ1YQjsxbwCawoPPE
 iPzCbQMVptpxJtaHiaJwOsFuKqVhxgmunrfdYmRXl6yCEPW2SyvYs0J8lJSWoXrLkQT3O6293
 vbUHPXXtQioJBDcAUUdTXryoTc6nBg2i6Xqproq2TyusHicxGibxqcPQxDgz3YS5Z13TTa7Nb
 cSi5Ac8N97xujgNxsh8a4ATWOY3eC8uBPM4rpFdpBKOxwaZAqA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.16.2 is available from:

	https://gitforwindows.org/

Changes since Git for Windows v2.16.1(4) (February 7th 2018)

New Features

  * Comes with Git v2.16.2.
  * For every new Git for Windows version, .zip archives containing
    .pdb files for some of Git for Windows' components are now
    published alongside the new version.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    2.10.0; This required rebuilding OpenSSH, Perl (and some Perl
    modules) and Subversion.
  * Comes with Bash v4.4 patchlevel 019 .

Bug Fixes

  * The Perl upgrade in Git for Windows v2.16.1(4) broke interactive
    authentication of git svn, which was fixed.
  * When configuring HTTPS transport to use Secure Channel, we now
    refrain from configuring http.sslCAInfo. This also helps Git LFS
    (which uses Git for Windows' private http.sslCAInfo setting) to use
    the same credentials as git fetch and git push.

Filename | SHA-256
-------- | -------
Git-2.16.2-64-bit.exe | 07e82be14e29d4f0c08ab0fbc06fcc8eb0fe01aa75dee7bf6afa37784e0ecb3c
Git-2.16.2-32-bit.exe | c7fa0a06385114b695b604490b444133899e4322bd416bd035007fab122128c4
PortableGit-2.16.2-64-bit.7z.exe | f51853689ad8a9e30759fb263a31bcd59753b3a97272b0e76a4210528a8631a1
PortableGit-2.16.2-32-bit.7z.exe | b5a91978956ac14f59ccdbc70c9c8d2f105e730e81ae8316a59791d33f3d6a87
MinGit-2.16.2-64-bit.zip | f4ac4e7d53d599d515e905824240cc2b82f3e2c294a872bb650e44b7e89cae8c
MinGit-2.16.2-32-bit.zip | 322c727e482aa97522c64a5ac68bdda3780111e8670bcfb532beac8e11ece5da
MinGit-2.16.2-busybox-64-bit.zip | de698bd1f6ca240be8f27b63f027674cf1df20e168b03359af7a57e47b85537a
MinGit-2.16.2-busybox-32-bit.zip | 08f469810ed5ecc497fc46fade03cbdf4d6539b702fd0560396b4c34c9efffde
Git-2.16.2-64-bit.tar.bz2 | 23a493244ffc5facb264a32c0cc6cfa98378fb2ba61ec2928f0b2fa7ec156b06
Git-2.16.2-32-bit.tar.bz2 | 7dcb4f29937ca2d744e9de53ad9f5ed4cbddf973901c756b92c7874473991bf0
pdbs-for-git-64-bit-2.16.2.1.e1848984d1-1.zip | 8835317db3f63fdbdd636fde179b411574b3a6018607ad53322525e23f2b2463
pdbs-for-git-32-bit-2.16.2.1.e1848984d1-1.zip | add00cdd87a9d73ac5f45042272fc32f507addf6ef0e72cd299190412c35f690

Ciao,
Johannes
