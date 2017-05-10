Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0E01FF34
	for <e@80x24.org>; Wed, 10 May 2017 08:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752930AbdEJI4z (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 04:56:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:56262 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752514AbdEJI4v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 04:56:51 -0400
Received: from localhost.localdomain ([37.201.192.198]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M7DVi-1dv6690L6E-00x3O9; Wed, 10 May 2017 10:56:43 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.13.0
Date:   Wed, 10 May 2017 10:56:27 +0200
Message-Id: <20170510085627.7604-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.12.1.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:anKCWMzb/WfyKfKn7vmIK9LY+N/8rqVeO9lXTbaCK9W5bblkZlp
 /f0+8SYKtuyTH1rdGbClnIYKDGblm7QTWDhaAkAJuywovyBQALjPpFl9dKiDtpZQlagOKRz
 GfTN+/RcMN7WUKR8TcVubXYsEAHDi/6Bpj+L1jMpESeSc7xg/kkG78E2TQ+lvTOpx6ge0Dt
 aKr+WtPujBSRnU5vNyuwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wXxOwhKv3f0=:dYYU7/8k0hJAAbsytMxpbi
 YKSj7/qj0K5JNSmwj0LbbuUI24nZV1/IDFTtl9b08nLc/7wAYdGSrKKVHwprC8u0sIHQc8aYt
 9jRkHZHyXOq7bgMDeEIDVwyr59ir77+qjXQM8UtPNcJIxmIckC3CP0zn3hgZHeevKMsdtE+nC
 CZ3rIvVSz5O9IjvT4QJlmwPEBG3ErMqSMTEmf7AvC5iy4utXPKVEB9168FpfYSU/WXaPYHwP0
 cmyVKJX/AlQSxlVYm5I6V20HFCXLgj945hMwL6RcPtvwip6yYgXxU0LJC7aN+cUcltx/o4a11
 AjXn7i8ZjoSUK3cWub/sl9KU6nw5SngQng1SAzPf+NoA3aYBEm7k1CMJsXEgDTILfRFKv1pdA
 pkm38UkD8P8It3CCo2kA9Ns6yWuUGwfE2xJsNwlkshmLcSH9x13eX1lMEWw0GNt7u9P5vJH7U
 h+y8nAx/d5obSiLLLPCyeYNXP/MSg96VSWxZVrQg6gZXdYBG/HwMWrUg9Zuiu8WElZC2bPqne
 wlI9DSkFsks5P+lnlfq71TZ+YQx/LQKPSRvjWTSTsRnHQI34cQLCgmg3hhFLb7gYgixO3bgmf
 GsPKGMLCy46eYyC1otQhwtEdbhsr5tR1OqRw0gSda3mn6RhYw9i8cHv/xXTfmHcEombFxdyNg
 WLnEU7jXAnYqxcCmpZCzKDSqhHDE2lR/YXjvFP3C0JMgZoU81TH7DnQTRPrtTe5zr53nmKq+l
 2yRspISftkO6/7XvjbQ4xiQn1DNVGMv68cdJ65IbBUXzRQTS7b+sGVb4f6tO7JQ3wh5OCTJGz
 96MjBmr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.13.0 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.12.2(2) (April 5th 2017)

New Features

  * Comes with Git v2.13.0.
  * Comes with cURL v7.54.0.
  * Comes with Git LFS v2.1.0.

Bug Fixes

  * As per Git LFS' convention, it is installed into the bin/ directory
    again.
  * Calling git add with an absolute path using different upper/lower
    case than recorded on disk will now work as expected instead of
    claiming that the paths are outside the repository.
  * Git for Windows no longer tries to determine the default printer.
  * When writing the Git index file, Git for Windows no longer has the
    wrong idea about the file's timestamp.
  * On Windows, absolute paths can start with a backslash (implicitly
    referring to the same drive as the current directory), and now git
    clone can use those paths, too.

Filename | SHA-256
-------- | -------
Git-2.13.0-64-bit.exe | 6b298c597ffe960bec84d52fc15438d0ff61a24ac9de1c17433878ef656d50c8
Git-2.13.0-32-bit.exe | a1b45272f2e30a3545b96086ccf5a56a4154a47898a7d1d6803d51440236b3b5
PortableGit-2.13.0-64-bit.7z.exe | 1d6008cb6fec817a302d4b59921423ba1f6db2677c6b519c20e9ca2cacc7c220
PortableGit-2.13.0-32-bit.7z.exe | 119c95b4416ca1100a4feee0d75ceaf3d41962b0038620c04a62dd787e80e5f2
MinGit-2.13.0-64-bit.zip | 20acda973eca1df056ad08bec6e05c3136f40a1b90e2a290260dfc36e9c2c800
MinGit-2.13.0-32-bit.zip | 64600a4158eb6a74087f901b6d56d4284f14c43a5075b8f7c947cad7cc667d1f
Git-2.13.0-64-bit.tar.bz2 | a1090222306dddaad076b431021be7ad99fce682823e38f15177e1ac230aea91
Git-2.13.0-32-bit.tar.bz2 | 7a90913ad80fc6a9c1591bb7829ce84b9c2c9800ea0d5abf96c642815ba1a193

Ciao,
Johannes
