From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 0/4] stg-whatchanged improvements
Date: Tue, 24 Jul 2007 20:57:25 +0200
Message-ID: <20070724185535.17180.24577.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 20:58:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDPaV-0005qo-I6
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 20:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbXGXS6T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 14:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbXGXS6S
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 14:58:18 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45167 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836AbXGXS6R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 14:58:17 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 63C955A218;
	Tue, 24 Jul 2007 20:58:16 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 4B86A5A19B;
	Tue, 24 Jul 2007 20:58:16 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id A9D5F1F084;
	Tue, 24 Jul 2007 20:57:25 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53626>

The following series fixes a case where contrib/stg-whatchanged did
not work as expected, and makes it use contrib/stg-mdiff instead of
reimplementing the same logic.  Especially since stg-whatchanged had
already gained metadiff-related improvements that stg-mdiff did not
had :)

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
