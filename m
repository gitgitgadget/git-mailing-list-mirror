Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6CC8208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 20:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753329AbdHJUIH (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 16:08:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:64091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753318AbdHJUIG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 16:08:06 -0400
Received: from localhost.localdomain ([37.201.192.198]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LkxLZ-1d5jW53y2n-00aniz; Thu, 10 Aug 2017 22:08:05 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.14.1
Date:   Thu, 10 Aug 2017 22:07:47 +0200
Message-Id: <20170810200747.8180-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.12.1.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:bA2tXFKTB6ivd4c1ZqhsUCqW+2PxriZMWTloJWS8h7Lyo5GYxGR
 +fRobvgrP4qhDFJU2KbjzOQU3CnY78o9ORYzv4J1ckPiAd70Q8BBKaDmJNWTQMI1S/UsoBP
 byo07LZG1GOT6U/NOxGIu0sAaqOWHZdmY+0u9DZT31tWCx7/6nq3eQFjLUXnou8a4q44Llq
 4uz0y4E2O/EgMekD+IFNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rPspqi/XzQc=:L615rxQqPELiU0VUhxwz5D
 cIAKFqcLkfwS4+797qy34y/4cQ9IfgUNTlwOBPdzbHjO6r4yNkN84vPK4N5GCfzyASv3a23Bf
 44n3Pvkx3X8iH89sNjkbxD6B2BLkEJLbcB1HHQawQZdfA4du30vnPBZ8/u/bs4O1B380MQpiA
 tBiX8BCn2StDEO9C3BWM6Z8FGUsUqrPqMBZOTB9I3WUPqcNBDJEiRJiFxRubS/exNRAWmxjCD
 hghEk9eSxdygaj7NeeuJWAZdHVfEUBqCG+2mtilam02wkthFrRVXQkJXJoNxVvfbaWG2VM9JH
 e2ZEiklj00aWsk5gPclwIm/yGJg2cglljybaL6UNeRkvOvkS8Wldo2RDiaSfK+NSzOj8elZ/U
 w44FBEti6Xb0dwxvR1TDH3rYBvo+R62aB/IvroYVUtO6BpAWvm1qW5b2t80+gdcslSe2vVHhd
 VB/Bv3kOC1Dli1uWCjqIzPtOVO0k8IHFwkBR+lhr4/i6cqtmLYl2BuBkI88YJADLjwk+p7ME3
 NFggEZVv+C3kFlBACKo/qANrPBclAqczb6dBB8dKUh/gMHbPcPtuN8XzRXyPp+saoi0wKH/wk
 IBgc1Mr8Zqk11yCB5fmguIAFwBWuLse3T9HoQTn6U0QvT8rUL458tqJ0mjkIzW4imWATU+g+0
 qMJTm7WNBAYqCrh/7nCbeDS3dBxSgrLHI9mZ710dvVfxD5nEFqI9CSkdF7Tf3N4psqe4L46h7
 0YoO4f+XoMna36S4kG9/QHBdK9jJQ1ygBbkwh9tKgqpEyF3TJRAgL0HfTAY2l9TfYfKUCzWoB
 OCg/jZNmOo2JaTiMzI6J00P8cPiNkcdlINwJfawlmHc+IUUjvE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.14.1 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.14.0(2) (August 7th 2017)

Note: there have been MinGit-only releases v2.12.2(3) and v2.13.1(3)
with backports of the important bug fix in v2.14.1 as well as the
experimental --show-ignored-directory option of git status.

New Features

  * Comes with Git v2.14.1.
  * Comes with cURL v7.55.0.
  * The Git Bash Here context menu item is now also available in the
    special Libraries folders.

Filename | SHA-256
-------- | -------
Git-2.14.1-64-bit.exe | 0dc556503e3ce4699228fc910a8e4a8d81172635ac8e8e16a11be107254c4901
Git-2.14.1-32-bit.exe | 0129e21eaed8efa6d795f712656463ee4f90aa2b3b66168f29b0da98f74104f7
PortableGit-2.14.1-64-bit.7z.exe | 3c3270a9df5f3db1f7637d86b94fb54a96e9145ba43c98a3e993cdffb1a1842e
PortableGit-2.14.1-32-bit.7z.exe | df3f9b6c2dd2b12e5cb7035b9ca48d13b973d054a35b0939953aa6e7a00a0659
MinGit-2.14.1-64-bit.zip | 65c12e4959b8874187b68ec37e532fe7fc526e10f6f0f29e699fa1d2449e7d92
MinGit-2.14.1-32-bit.zip | 77b468e0ead1e7da4cb3a1cf35dabab5210bf10457b4142f5e9430318217cdef
MinGit-2.14.1-busybox-64-bit.zip | 7e72a78e0711d27d98f851ec81a6fe27b4159066d548c2013dd7ce57a1b8cd03
MinGit-2.14.1-busybox-32-bit.zip | 2f3a3ae26391e5e3487501b3b16ee1c6385259ebfdaafcbee9947d7513dc0a0f
Git-2.14.1-64-bit.tar.bz2 | 544615e2ef5e2040a67878ce7aac42cb103f948d52989239b3715dd6023b1007
Git-2.14.1-32-bit.tar.bz2 | 0aede42a7ec7a6351a3f273ab519679f95e9341cb63899c54be18a57819da6aa

Ciao,
Johannes
