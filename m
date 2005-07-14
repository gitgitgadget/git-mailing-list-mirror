From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] stgit: allow spaces in filenames (second try)
Date: Thu, 14 Jul 2005 11:22:30 +0100
Message-ID: <tnxu0ixn0ux.fsf@arm.com>
References: <20050714062733.21779.33599.sendpatchset@bryan-larsens-ibook-g4.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bryan.larsen@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 12:26:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dt0s7-0005c7-5K
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 12:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbVGNKXG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 06:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbVGNKXG
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 06:23:06 -0400
Received: from fw-nat.cambridge.arm.com ([193.131.176.54]:23942 "EHLO
	ZIPPY.Emea.Arm.com") by vger.kernel.org with ESMTP id S262979AbVGNKW7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 06:22:59 -0400
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 14 Jul 2005 11:22:56 +0100
To: Bryan Larsen <bryanlarsen@yahoo.com>
In-Reply-To: <20050714062733.21779.33599.sendpatchset@bryan-larsens-ibook-g4.local> (Bryan
 Larsen's message of "Thu, 14 Jul 2005 02:27:38 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 14 Jul 2005 10:22:56.0234 (UTC) FILETIME=[003EB4A0:01C5885E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Bryan Larsen <bryanlarsen@yahoo.com> wrote:
> The current version of stgit does not allow whitespace in filenames.  This patch fixes that.  It also speeds up operations on large filesets considerably.
>
> Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>

Applied. It will be visible tonight via the ftp mirror.

One note about patch description. I would prefer to have the
convention of the Linux kernel patches:

---
Short description line

Longer
description

Signed-off-by: ...
---

A future export command with support for sendpatcheset will take the
short description line and use it as a subject. Also, it would be nice
for the longer description to be wrapped somewhere before column 80
(~72 would be OK).

-- 
Catalin
