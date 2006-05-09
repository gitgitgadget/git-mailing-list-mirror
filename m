From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/2] Support for "set -e" in cogito script, and assertion in rewritehist
Date: Wed, 10 May 2006 00:27:38 +0200
Message-ID: <20060509222738.20814.57282.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 00:29:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdahP-0003gT-Fq
	for gcvg-git@gmane.org; Wed, 10 May 2006 00:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWEIW25 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 18:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWEIW24
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 18:28:56 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:35756 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751256AbWEIW24 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 18:28:56 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 52BF526563;
	Wed, 10 May 2006 00:28:55 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FdasG-0007GL-32; Wed, 10 May 2006 00:40:12 +0200
To: Petr Baudis <pasky@suse.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19856>

The first patch is an updated version of the one posted on Apr 17th, which makes
cg-Xlib compatible with "set -e" for safer scripts, and converts cg-admin-rewritehist
to "set -e" mode.  The second ones makes the latter robust on one backquoted command,
for which "set -e" is not sufficient.  Let the devil bring shell programming into hell,
asap.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
