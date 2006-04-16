From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/9] Add a testsuite to stgit (take 3), and more
Date: Sun, 16 Apr 2006 12:41:44 +0200
Message-ID: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 12:50:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV4pd-0001Gt-UH
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 12:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWDPKuJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 06:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWDPKuJ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 06:50:09 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:46272 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750704AbWDPKuI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 06:50:08 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id F3F6220615;
	Sun, 16 Apr 2006 12:50:06 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FV4ym-0004AE-3f; Sun, 16 Apr 2006 12:59:44 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18777>

This new revision of my testsuite patches include:

- cleanup of the repo-initialization stuff in test-lib.sh: now
test_create_repo creates an empty commit to start with, so that HEAD
points to an existing master branch.  This makes test_stg_init
useless, rather let tests can "stg init" directly.

- steal the git t/README as well, and adapt it.  Proposes a numbering
convention for stgit testcases.

- activation and refining of the testcase which I had left commented
out in t1000, and a fix for the bug it shows

- fix for a nasty caching issue in stg clone, and associated test

- 2 testcases showing problems with detection of applied patches in
"push" after a pull when our patches were integrated upstream.  No fix
here, though, so you'll see t1200 and t1201 failing.


And not directly related to the testsuite:
- more bugs listed in TODO
- support for per-user templates for mail and export, in ~/.stgit/templates

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
