From: David Woodhouse <dwmw2@infradead.org>
Subject: RE: Date handling.
Date: Thu, 14 Apr 2005 21:54:38 +0100
Message-ID: <1113512078.12012.227.camel@baythorne.infradead.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03457AE6@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 22:51:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMBJ2-0004AY-7M
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 22:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVDNUyn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 16:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVDNUyn
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 16:54:43 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:47759 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261588AbVDNUym (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 16:54:42 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DMBMF-0000p8-57; Thu, 14 Apr 2005 21:54:39 +0100
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F03457AE6@scsmsx401.amr.corp.intel.com>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-14 at 12:42 -0700, Luck, Tony wrote:
> This is a very good point ... but this still has problems with the
> "git is a filesystem, not a SCM" mantra.  Timezone comments don't
> belong in the git inode.

Yeah, but really I'd want to see other serious users of it before I'd
accept that the timezone information _really_ needs to be stored
separately. After all, the committer and author information really
wouldn't be considered part of the _filesystem_ either.

-- 
dwmw2


