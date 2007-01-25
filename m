From: Yann Dirson <ydirson@altern.org>
Subject: StGIT and repo-config
Date: Thu, 25 Jan 2007 23:55:12 +0100
Message-ID: <20070125225512.GF4083@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 25 23:56:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HADW3-0007sq-9d
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 23:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965582AbXAYW4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 17:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965578AbXAYW4R
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 17:56:17 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:41287 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965582AbXAYW4R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 17:56:17 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id C206827A1B;
	Thu, 25 Jan 2007 23:56:14 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id BB5E91F07B; Thu, 25 Jan 2007 23:55:12 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37774>

I'm trying to get StGIT to work with git's config information.
Currently, the stgit.config stuff uses a generic ConfigParser, which
I'm not sure is adequate for the work:

- it requires to forge section names like 'branch "foo"'
- it is only a reader and I'm not sure it is easy to turn it to a
writer.  It has a set() method, but it appears to only act on
in-memory stuff.
- since it parses the file at startup, it would not see any change
done from stgit by calling repo-config.
- the canonical way to access the info is git-repo-config.

I'd think this would be sufficient to rewrite stgit.config.
No objection ?

Best regards,
-- 
Yann.
