From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/5] stgit rebasing fixes
Date: Tue, 20 Feb 2007 01:13:58 +0100
Message-ID: <20070220000908.31139.36841.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:51:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJJE0-0000P4-BX
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965817AbXBTAuk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965815AbXBTAuk
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:50:40 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:43624 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965814AbXBTAuj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:50:39 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C5E3059073;
	Tue, 20 Feb 2007 01:15:37 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 8A6FA1F084;
	Tue, 20 Feb 2007 01:13:58 +0100 (CET)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40184>

The following series stores a backup of the stack-base to detect when
it is safe to rebase or not (by "stg rebase" or "stg pull" in
fetch+rebase mode).

The final patch in the series is the one implementing this, but is not
tested enough for 0.12.1.

The previous ones, however, may be good to have in 0.12.1.  Especially
the patch that adds tracking of the orig-base parameter, since that
will make things safer for more people when the final patch gets
shipped (if no orig-base is found, rebasing is currently done without
checking, to stay backwards-compatible).

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
