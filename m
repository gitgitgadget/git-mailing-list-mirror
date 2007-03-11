From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/2] Fixes for recent stgit issues
Date: Sun, 11 Mar 2007 22:44:06 +0100
Message-ID: <20070311214133.3142.11407.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 22:44:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQVqU-0006GL-LS
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 22:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808AbXCKVop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 17:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932830AbXCKVoo
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 17:44:44 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:58268 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932808AbXCKVoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 17:44:44 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D4FA38390;
	Sun, 11 Mar 2007 22:44:42 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 10C8C1F083;
	Sun, 11 Mar 2007 22:44:07 +0100 (CET)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41991>

The initial "stg cp" implementation was known to be inconsistent wrt
clobbering, this makes the unsafe case safe.  Also, a copy of the
policy=fetch-rebase testsuite crept as a fake policy=rebase one, so
here is a real one.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
