Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3844201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 16:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbdBYQ4K (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 11:56:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:58174 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751428AbdBYQ4A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 11:56:00 -0500
Received: from localhost.localdomain ([37.201.192.48]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MI5JG-1clWS52usg-003tl7; Sat, 25 Feb 2017 17:55:55 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.12.0
Date:   Sat, 25 Feb 2017 17:55:44 +0100
Message-Id: <20170225165544.3956-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.11.0.windows.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:9eDtfDlMHk4Dj/GZpkGFM5Q/X5eSlZW6vYRNRa68y9j+2H4c6Rx
 Sa+/JD2InKAsmLxuBM4iNl1FEBtZqt7X4Y0Flj7MD51i+1ZM+2MrduBmGteU9jhU3Ug64My
 PcYI6/VdrswWs0v+wUCc4m5DxcMk0LAsU9EEkLlUkCWyI5K5zIMqkU7HxXJUOX6q8Xd7po7
 RsowgSyYndLRnk287jvMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s8RoViB53Ls=:RKlBz4PiFwv1wYLMaUmaw6
 AUsBkI0MpZ/IKgLRKqJr+mSrGKNdGdBTikJnply+KJcYyIBxJLCOpsYCCeLc5G23YTH6xtleM
 XKuv8p9XSVc9dzjmpwOfjY/XAZvSRU+NKjDo5Kf2sox7jMtz3unN8chhUeFQvNiYp6Kk9EsXy
 3ugR9F4GhYbEgN3Beimn4g3a1pasGoOgfyKeFfIpa44imhNcV16K2KOKr6PM3Z+pHMydu3dSo
 cmtv89iLFymupq3k6qNb4uy2NEtPX1HB21eiPYO0pKXLphvvQr9sMMIVQ1YVoswIIO1yie/yS
 uQ/mzIbOI3QuvK14QmzUlNaYuyXtOl8pVvo7K1hIoOGxXnXoqJbSKvfGIYXEv6iD1TJeXQnj6
 lq9l6eCPygYNRtyUSxZnffOE1f02/sXui1ELTveFdfMQyHa6y1hWues6a95S1WTUb/63V+Ify
 9Zp2BGBk8wmvNtcJRrFGqK2OIT8ZKFVy9wLkHfZBBWToJoGD7aKVVxgvsBEZvpL9X5dVOcRip
 QZoxVO1T9ETmwKSyca9pG8Y9spy+BJbvm+1jR27A0xHRu4sAq43Yu87fr6Fa26UmPXy+gYp4L
 A8u4aeHD1PYcw4sJCkrEugP+UdQ64XQ5RSrsIwT/JjG2RQILDacmZiiaq2gsAL0GXL76NDbal
 2dtx6JsTmhvupmeqy14BZm6p8DFZ9HBg+t1jq2R8umA8LU33QA2HSK8gLVSLC0U6Z4/BvGmdb
 RPKdMf3uuV62DwZ/eRMYMdSOnUfcATYJ/PeDFfJHSprmdmhvdnxPfBVkV6+Ddfft1d9kkmVIJ
 Ab3F6ux
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MIME-Version: 1.0

Fcc: Sent

Dear Git users,

It is my pleasure to announce that Git for Windows 2.12.0 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.11.1 (February 3rd 2017)

New Features

  • Comes with Git v2.12.0.
  • The builtin difftool is no longer opt-in, as it graduated to be
    officially adopted by the Git project.
  • Comes with v2.7.0 of the POSIX emulation layer based on the Cygwin
    runtime.
  • Includes cURL 7.53.1.
  • The Portable Git now defaults to using the included Git Credential
    Manager.

Bug Fixes

  • The stderr output is unbuffered again, i.e. errors are displayed
    immediately (this was reported on the Git mailing list as well as
    issues #1064, #1064, #1068).
  • Git can clone again from paths containing non-ASCII characters.
  • We no longer ship two different versions of curl.exe.
  • Hitting Ctrl+T in Git GUI even after all files have been (un)staged
    no longer throws an exception.
  • A couple of Git GUI bugs regarding the list of recent repositories
    have been fixed.
  • The git-bash.exe helper now waits again for the terminal to be
    closed before returning.
  • Git for Windows no longer attempts to send empty credentials to
    HTTP(S) servers that handle only Basic and/or Digest authentication
    .
Filename | SHA-256
-------- | -------
Git-2.12.0-64-bit.exe | 0224c1cf4ff48535fdfc2555175be9a06c6d8b67fbf208b1c524f01252f8b13b
Git-2.12.0-32-bit.exe | de7f69bd6313bf7b427b02687a0ee930012a32d40aed2bb96f428699c936180d
PortableGit-2.12.0-64-bit.7z.exe | 5bebd0ee21e5cf3976bc71826a28b2663c7a0c9b5c98f4ab46ff03c3c0d3556f
PortableGit-2.12.0-32-bit.7z.exe | 0375ba0a05f9cd501cc8089b9af6f2adf8904a5efb1e5b9421e6561bd9f8c817
MinGit-2.12.0-64-bit.zip | 6238f65c4d8412b993cb092efde4954f8cb7da4def54d0c1533835f00e83fdad
MinGit-2.12.0-32-bit.zip | 5a118ff8a8f859866d6874261fc8ec685848a2ccf9fa0858417c98e21f5c0ec3
Git-2.12.0-64-bit.tar.bz2 | b512fb28ceeddb6a6cdf15e6c936aea15fd2b1b3c8154f72101f8c9060549f90
Git-2.12.0-32-bit.tar.bz2 | a6c0b5b36c19a70f2c9ffd8fbfeb57bedbb7a9a2207672ac38c5bc5a38ae320a
Ciao,
Johannes














