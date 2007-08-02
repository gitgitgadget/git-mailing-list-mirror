From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 0/6] Various contrib/ updates
Date: Thu, 02 Aug 2007 22:18:10 +0200
Message-ID: <20070802200704.16614.57993.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:19:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGh8j-00076r-2s
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 22:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759399AbXHBUTQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 16:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758184AbXHBUTQ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 16:19:16 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:54997 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029AbXHBUTP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 16:19:15 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 4813A8B3A;
	Thu,  2 Aug 2007 22:19:14 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 2C74838F2;
	Thu,  2 Aug 2007 22:19:14 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id C9EAB1F06F;
	Thu,  2 Aug 2007 22:18:10 +0200 (CEST)
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54592>

This series, asside from small fixes, enhance the bash completion to
be aware of file status (notably, makes it much more comfortable to
refresh only selective files), and introduces 2 new contrib scripts:

- whereas stg-fold-files-from was designed to merge in the current
patch changes from several other patches, stg-dispatch makes life
easier to split a given patch into several other ones (ie. making a
split series out of a monolithic patch).

- stg-show is a RFC/proof-of-concept for a redesign of "stg show",
which calls git-show much more transparently.  This allows to harness
the full power of the git-show command-line without duplicating the
logic in stgit.


I already made heavy use of the scripts in the last days, and I rate
them as good candidates for 0.13.1.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
