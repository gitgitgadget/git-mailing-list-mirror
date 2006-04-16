From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Updated testcases for stgit pull with merge
Date: Sun, 16 Apr 2006 22:34:48 +0200
Message-ID: <20060416203448.10137.69093.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 22:38:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVE0e-00010X-CA
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 22:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWDPUiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 16:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWDPUiI
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 16:38:08 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:61672 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750782AbWDPUiI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 16:38:08 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1E1A09A9A5;
	Sun, 16 Apr 2006 22:38:07 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FVE9p-0005Dj-Ll; Sun, 16 Apr 2006 22:47:45 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18802>

[Sorry for the previous buggy post]

In the previous series, patch 7 mostly demonstrate that I have missed
the appearance of the --merged flag in stgit 0.9 push and pull
commands, so we could just amend this testcase with that flag.
However, it appears that common workflow of forgetting that flag, then
trying to undo the failed push, and re-pushing with the flag still shows
a problem, as hopefully shown by this updated testcase.

As for the testcase in patch 8, it still demonstrates a problem IMHO:
the push without the --merged flag should have failed in much the same
way this one does.  However, I have seen GNU patch showing a similar
behaviour, so it is maybe not stgit's fault.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
