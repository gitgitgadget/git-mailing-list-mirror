From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/4] Add a testsuite to stgit (take 2)
Date: Thu, 13 Apr 2006 23:38:19 +0200
Message-ID: <20060413213819.8806.53300.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 23:42:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU9Zz-0001hd-KG
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 23:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWDMVmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 17:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWDMVmN
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 17:42:13 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:33682 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S964980AbWDMVmM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Apr 2006 17:42:12 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id CB7DF48D8D;
	Thu, 13 Apr 2006 23:42:11 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FU9iz-0008WN-Mh; Thu, 13 Apr 2006 23:51:37 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18671>

This is an update of the previous patch series, including minor improvements
to the way the test engine is adapted to stgit, as well as a new testsuite
demonstrating robustness issues on series creation, and proposed fixes for all
those bugs.  And hopefully more standard patches.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
