Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2963D1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 21:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeBBVUe (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 16:20:34 -0500
Received: from mout.gmx.net ([212.227.15.15]:54524 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751857AbeBBVUd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 16:20:33 -0500
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lck9X-1f7jia1n7v-00k7iK; Fri, 02
 Feb 2018 22:20:31 +0100
Date:   Fri, 2 Feb 2018 22:20:30 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.16.1(2)
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <0MFuWk-1eTyyv270g-00EthZ@mail.gmx.com>
X-Provags-ID: V03:K0:eBE6fpK8NT4oDkVE/l0EryOBTJJwjYVr1W6w+3XxeUs8GDXjSC1
 oETw+s5Grlu8LBmN/Grwc2XBk2IltgdJgc++uqiYJuQ+wmSODJUcyuy7Vw0xxHzv4Jm7kst
 BHcT/2w54CrnZ84ZgJrf9FTW8eVpmPHykV/2cuCukuTn1WioHrX0dEL6oE6TvDzGqm8ANh5
 ERzsa840bDEFUKioE7FuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:77+al59HA1A=:GxQVM1R35VUqN+ppSyH0nT
 DBwkqTt6iIFcedfGeTlTUHAss+3Myg+N5lADPEqsNr0lTPHGCQCmmry9YOjC8Ozke3Pp2DWHl
 HFGEmcfUPMbQIfdbos39+G07uUtT2P/lkXdQ1axDkaK7W/TU30Mi5e1HYzK1lqGHBMEeLOpUM
 7Txan4IVdif3NwwcVzqrZmc9CIK8NXFoAuu69atn00z53S6UQ5AJthr4r9EOhKB1ghTwgQ1lD
 oPbbkd0p+F6evIxf+lGT2frSB6e+itHOSlMGC0OCcSI662vIOd7pxewxMKUCCz+bPM1BV8Y4I
 61Qwszk9A1aR6PJwoBl5xjYvThDwA8fcy6oUThbI+Qjjcs7xFimj2tBIBwA5d2d2+wwQUoRt+
 ZH9rTTjPves5tUlyKJOddbYJO5oBj4fZBCeIiojTsNmY0DK3cxCRnjRb4rCvRN26Xs6D0s10V
 UNc7HFInqxASKmEzfrzLKEbTXDD1egrlX+dHpymfza5Tnkt5caSKo0VYROtDHXUXYRBCWE6Jt
 wFsz6GQxOgfp8+QJbeqYEbSmea1RqaMKgftM7oT3/B1UxSCRmMMcOzQKjbAFyAgiJ3FJIcjy3
 Y+FVaaHv2tzIQcav983TyVJLdw/9fEoaihsM6ZnLqIJ6Y+3xgnlIIcCRAkWtLR2vPNdy8OXeV
 5mEPJmcyK7Gt030G7mZ9V0sylFKYAlzgI3YdxEZpeNcTyMWjl/Imi1UPy6eGgxiHNXd2l3347
 uVOO7HMIrKk16wptcuK9h8Gb9YjbLYt64wKa4c3cP9kA8B+V5Z3k0lCRPgWv0P3TLaBZIaewr
 XjIetRzsWNp7IpqETfj07JMSemNak6tn8Wb/gcwaD2uGxWz9FqbenO48OiAkPhs3inl8efl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.16.1(2) is available from:

        https://git-for-windows.github.io/

The main purpose of this out-of-band release is to update the BusyBox, cURL,
Perl and Heimdal components to newer versions.

Changes since Git for Windows v2.16.1 (January 22nd 2018)

New Features

  * Comes with Heimdal v7.5.0.
  * Comes with cURL v7.58.0.
  * Comes with Perl v5.26.1.
  * When using GNU nano as Git's default editor, it is now colorful
    (shows syntax-highlighting).
  * Comes with tig v2.3.3.
  * When using Secure Channel as HTTPS transport behind a proxy, it may
    be necessary to disable revocation checks, which is now possible.
  * Comes with BusyBox v1.28.0pre.16550.0b3cdd76c.

Bug Fixes

  * When Git spawns processes, now only the necessary file handles are
    inherited from the parent process, possibly preventing file locking
    issues.
  * The git update command has been renamed to git
    update-git-for-windows to avoid confusion where users may think
    that git update updates their local repository or worktree.

Filename | SHA-256
-------- | -------
Git-2.16.1.2-64-bit.exe | 033939d276775edb17233c7f52cc5d53dcf23351eb9c5ebe0d95f13805ac6aa1
Git-2.16.1.2-32-bit.exe | 564c8c71da3d0888e8fb153556c1e747b2fe4f4ec94d38963ae7766f61fb5cfd
PortableGit-2.16.1.2-64-bit.7z.exe | 82009aa70ede01da69cd2ea4ad297aeb1f58c7dd8ddddc1d85425d5246ebdf20
PortableGit-2.16.1.2-32-bit.7z.exe | 5886321e9d6c619c67116b23c6428afc83f2e63f4eee60f6cafa5b37364ebf04
MinGit-2.16.1.2-64-bit.zip | 172f4ac31280895867e8ffa35f31f4aa590eef115de4cefcedef5f39cecd75b6
MinGit-2.16.1.2-32-bit.zip | 17657f7e8c562a299cc0d854e43f348a4d7721ec6e16e24d12f0366d9a7e00fc
MinGit-2.16.1.2-busybox-64-bit.zip | 58609edfd1ea0135c9247b89ad9fafd8270caa307a5f8d8fdccaf0456b8c8dd0
MinGit-2.16.1.2-busybox-32-bit.zip | c7721df06fee403b340ff8083c2334dd450b929341645364c6807fdca6c6e74b
Git-2.16.1.2-64-bit.tar.bz2 | 949271e375c90f1c4a15d2cc19717d5c01cf58b66f1a06bb3de7c5f19ebba5c7
Git-2.16.1.2-32-bit.tar.bz2 | 41940a0c5eff47612b891241aa2f2edb82e8ed5d32a7f4bde79e720fcd83a960

Ciao,
Johannes
