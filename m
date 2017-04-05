Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F95620966
	for <e@80x24.org>; Wed,  5 Apr 2017 16:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932942AbdDEQJm (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 12:09:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:60467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932517AbdDEQJl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 12:09:41 -0400
Received: from localhost.localdomain ([37.201.193.73]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MH5Sw-1crxjb1JvW-00Dn3K; Wed, 05 Apr 2017 18:09:33 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.12.2(2)
Date:   Wed,  5 Apr 2017 18:09:18 +0200
Message-Id: <20170405160918.6216-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.12.1.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:xISHSID+RgKCdSlDMpKbHzVOBlKYfJCV8HRRSJ9M1Gz9ovBtw8Q
 Vio+vFLlpbmWVTJFpazSCux0rN8kwmkk0HAYPceaxaS6NleoDJdzCYG2zBOhaeSwKn5HYTy
 9grr0YSPHMAvgBytygs9BGdOcBJ54TlTOLL+Eu8ljvoNtkxVPD0Qu2C3mUPjwKcwaoS7MdK
 ClKCztv7YPvo2TC08pSPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9L6/wCo/W6I=:BJCfZxiXgIYtHyz6iWmxxL
 9KmhsbBEz5cMKFk11XVioAErdeR47omXx3dKp+B5htXzqKvwVLmiJL2TEpkPiTdP372Qd90X9
 u4iJ6ctS0NkfZF6v/J1pxjKvMAEzCQsW5Vq4ZRlJmt2Yv5so5bsuTrK52Nt0wSMWOQP9LL8F0
 zsEpMYpKc+0LOgEbax9PjsMSxRGg8x1iUO3x/0EuQHONPC72boRDUrfiAG05F9GjEuZYLVwlF
 AZo4B7xiQ/ZnjNAFqNYPt68gzlBOJ4Q/jWJiDtChmjp9OkRAuUWvtNbZ6qiLU0Oeku3z3oj/n
 YJvbO4Ibvh0Vq19tZby0zeaJyseh35TgLK05gtuz4MMl1mD+XsTVEO0zqW476+Cx9UudhPpko
 gDR3cqjyVJCZlYTjumf+MMy/S5ihb5ZQW/O5Z392NARtZZdLiShI6SYSJyDTCPspSo09M8uPb
 /uFAAWx7NUN/5FEkt3ibFQ+BozPLrRawQNdL3TMAFqBaToqoaeVdDYF6hBjOBhe1BaVExL3aO
 Zwlv0ZEVzvb+xxmbFig7K1vlEbGStU6X6QQP2H6W8D2gqRrhqLiw6TTpnOKBb2MC/2JUMUJyR
 AaTYBIiRDHD1x38C+fm9Vmmt1soMk9hV2scb3nM4pNVQibWIM3K5Tnqy9h6r8kgHTnwQ0MTJG
 WHvCm17HKTYxU+7sDktpC3LyXxgjq0xeAjVczMoLHn4W++n206k1sLIfT8M6MzJJeiaROJ4Z6
 6L36PSAx24cfTZYeFGIio7ayDOxrTadPFwofZv4eYm6SUcsKBlkfotKUIIQrM2lclVExACe7Z
 NdRZTYv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.12.2(2) is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.12.2 (March 27th 2017)

New Features

  * Portable Git is now using a custom-built SFX that is based directly
    on 7-Zip's SFX.
  * Git LFS was upgraded to v2.0.2.
  * Updated the MSYS2 runtime to Cygwin 2.8.0.
  * Git LFS can now be disabled in the first installer page (users can
    still enable it manually, as before, of course).
  * Comes with Git Credential Manager v1.9.1.

Bug Fixes

  * A potential crash in git status with lots of files was fixed.
  * Git LFS now gets installed into the correct location.
  * Git LFS is now configured correctly out of the box (unless
    disabled).
  * The http.sslCAInfo config setting is now private to the Git for
    Windows installation that owns the file.
  * git difftool -d no longer crashes randomly.

Filename | SHA-256
-------- | -------
Git-2.12.2.2-64-bit.exe | 4e753b00595c0bb0d1bc50c2fea61a60a26b326d8a59aacdb79dfb087b4fc2a7
Git-2.12.2.2-32-bit.exe | cf26129a033fa6841ab3f29cdb5593d2defb172a6d29eff0c78696340397b514
PortableGit-2.12.2.2-64-bit.7z.exe | 4c0daba65feca2263923e3eb3f0a29b892d074712feb28a4570640d2d7f98694
PortableGit-2.12.2.2-32-bit.7z.exe | b9c8280a3ee7f305ebc1c4e6e1c322e4d706807b837feb23a5b1a9f0ea0fdcb5
MinGit-2.12.2.2-64-bit.zip | 3918cd9ab42c9a22aa3934463fdb536485c84e6876e9aaab74003deb43a08a36
MinGit-2.12.2.2-32-bit.zip | 69d88aca0d801c860a0d7c93e284d9d2283bda0bc760daf0ea010d6c42b6c8a8
Git-2.12.2.2-64-bit.tar.bz2 | f452d32b736468d8910acb35bbd937aa86cb2bb1691e4a8728e6360ba6ae1cbf
Git-2.12.2.2-32-bit.tar.bz2 | ef9431add3ddac9e9588ede74ad77678dff794cf6b328f30c421f4b7718985bf

Ciao,
Johannes
