From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/3] "stg cp", and StGIT doc updates
Date: Sat, 10 Mar 2007 00:18:32 +0100
Message-ID: <20070309231444.30705.72292.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 00:19:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPoMp-0008M9-PH
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 00:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767636AbXCIXTB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 18:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767638AbXCIXTA
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 18:19:00 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:44226 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767636AbXCIXS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 18:18:59 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A957438B1;
	Sat, 10 Mar 2007 00:18:57 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 10E6F1F095;
	Sat, 10 Mar 2007 00:18:33 +0100 (CET)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41819>

"stg cp" comes to complement "add" and "rm".  I originally thought to
complement the whole with "stg mv", but I wonder whether the all 4 of
them eally have a place in StGIT.  Shouldn't we just use git/cogito
for such operations ?  In this case, this patch should indeed be
retargetted to be a git-cp command (it has anyway no real dependency
on StGIT, and the feature would be more generally useful).

The 2 other patches just try to improve the docs.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
