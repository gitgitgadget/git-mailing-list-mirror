From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Git crashes on pull
Date: Tue, 15 Sep 2009 20:47:41 +0200 (CEST)
Message-ID: <alpine.LSU.2.01.0909152044450.10936@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 20:47:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnd4C-0006l3-Nd
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 20:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbZIOSro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 14:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755245AbZIOSrn
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 14:47:43 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40760 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755066AbZIOSrn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 14:47:43 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7FC476A5E5
	for <git@vger.kernel.org>; Tue, 15 Sep 2009 14:47:46 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 15 Sep 2009 14:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:subject:message-id:mime-version:content-type; s=smtpout; bh=lE8/lmBi2iwxJqG1auwRsGaNtx0=; b=e6DFNdRyilvdQmDG+7i5LM/08LAsLcjTVozruyZLj84kHLtJ42s6eNFLTfoYlzd18qRS1V0fy0fNnXGrGbIezGa0789/Ccvbta218QpavmeSf2tS0TqMlZXGIjcTPTqboDp3qpvTdxKN/MPDmKtFkxvAydjwFiNJS4/qsymPoyg=
X-Sasl-enc: qSYgNjQKBEyTDvwJDVtBnxvGhS+sEDiRm8Uqcc5XHCbW 1253040465
Received: from [192.168.2.101] (p549A6F05.dip.t-dialin.net [84.154.111.5])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C18AA8B88
	for <git@vger.kernel.org>; Tue, 15 Sep 2009 14:47:45 -0400 (EDT)
User-Agent: Alpine 2.01 (LSU 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128579>

Hi,

I have a clone of http://git.postgresql.org/git/postgresql.git where head 
is at commit 167501570c74390dfb7a5dd71e260ab3d4fd9904.

I'm using Git version 1.6.5.rc1.10.g20f34 (should be at commit 
20f34902d154f390ebaa7eed7f42ad14140b8acb from Mon Sep 14 10:49:01 2009 
+0200)

Now when I 'git pull' then Git crashes with

git pull 2>&1 > /tmp/git-error
*** glibc detected *** git-remote-curl: free(): invalid pointer: 
0xb7d19140 ***
======= Backtrace: =========
/lib/libc.so.6[0xb7c4f4b6]
/lib/libc.so.6(cfree+0x89)[0xb7c51179]
git-remote-curl[0x804d290]
git-remote-curl[0x804df04]
git-remote-curl[0x8065ea5]
git-remote-curl[0x804aac6]
/lib/libc.so.6(__libc_start_main+0xe0)[0xb7bfefe0]
git-remote-curl[0x804a991]
======= Memory map: ========
08048000-080a1000 r-xp 00000000 08:15 1658246 
/usr/local/libexec/git-core/git-remote-curl
080a1000-080a2000 r--p 00058000 08:15 1658246 
/usr/local/libexec/git-core/git-remote-curl
080a2000-080a3000 rw-p 00059000 08:15 1658246 
/usr/local/libexec/git-core/git-remote-curl
080a3000-08143000 rw-p 080a3000 00:00 0          [heap]
b4400000-b4421000 rw-p b4400000 00:00 0
b4421000-b4500000 ---p b4421000 00:00 0
b45ea000-b45f4000 r-xp 00000000 08:13 1097821    /lib/libgcc_s.so.1
b45f4000-b45f6000 rw-p 00009000 08:13 1097821    /lib/libgcc_s.so.1
...

Any idea what's causing this?

Please keep me on CC, as I'm not subscribed on list.

Regards

Guido
