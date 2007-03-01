From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/8] My set of stgit helper scripts (update)
Date: Fri, 02 Mar 2007 00:03:34 +0100
Message-ID: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 00:03:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMuJR-0003pM-ID
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 00:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbXCAXDq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 18:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161200AbXCAXDq
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 18:03:46 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:49807 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161197AbXCAXDp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 18:03:45 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id EC37838DC;
	Fri,  2 Mar 2007 00:03:43 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id D7A831F084;
	Fri,  2 Mar 2007 00:03:34 +0100 (CET)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41142>

These are updated versions of the scripts already posted.  Minor
updates for most (notably some compatibility with 0.12), except for
stg-cvs which got a number of fixes, as well as a huge enumeration of
limitations (I'll probably rewrite it as a glue to get tailor called
from standard stgit commands).

This brings 2 new scripts:

- stg-mdiff to display diffs of diffs (very preliminar and naive
implementation, needs much work)

- sit-sink to bury one or more patch down the stack (eg. to commit
them but keep other patches under stgit control).  Catalin will love
to learn that this is a perl script ;).  I'll rewrite it as a standard
stgit command soon (with a slight difference as to how the --to
argument is interpreted), but others may want to use it or just
comment before that.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
