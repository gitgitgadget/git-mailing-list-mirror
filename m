From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/7] StGIT, remotes, and parent
Date: Tue, 30 Jan 2007 00:05:19 +0100
Message-ID: <20070129230117.7102.64322.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 00:06:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBfa4-00053b-MA
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 00:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbXA2XGX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 18:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbXA2XGX
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 18:06:23 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:35407 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626AbXA2XGE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 18:06:04 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 51E719B5F2;
	Tue, 30 Jan 2007 00:06:01 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 1E55F1F07F;
	Tue, 30 Jan 2007 00:05:20 +0100 (CET)
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38108>

This new series should bring the first 5 patches into sufficiently
reasonable shape, so I'm presenting them for inclusion.  The last 2
ones are still there for context only.

This new revision of the series brings:

- Better use of stgit.config in subsequent patches, notably deported
the remaining call to repo-config into stgit.config:
config.sections_matching(regexp)

- Caching in stgit.config.  I implemented this as on-demand caching,
initially because it was straightforward, but it turns out that
sections_matching() naturally fits in this model, and i'm not sure how
we could have implemented this in the pre-caching model.

- The usual bunch of misc cleanups.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
