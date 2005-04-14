From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Date handling.
Date: Thu, 14 Apr 2005 22:48:34 +0100
Message-ID: <1113515314.12012.235.camel@baythorne.infradead.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03457AE6@scsmsx401.amr.corp.intel.com>
	 <1113512078.12012.227.camel@baythorne.infradead.org>
	 <425EDA43.3040404@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Luck, Tony" <tony.luck@intel.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 23:46:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMC9t-00037q-Ge
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 23:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVDNVsy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 17:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVDNVsy
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 17:48:54 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:52623 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261392AbVDNVsn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 17:48:43 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DMCCR-0000w9-AX; Thu, 14 Apr 2005 22:48:35 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <425EDA43.3040404@zytor.com>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-14 at 14:01 -0700, H. Peter Anvin wrote:
> Both of these are metadata; they may not be directly relevant to the 
> filesystem, but are attributes relevant to the client thereof; 
> effectively an xattr.

Right. That's perfectly acceptable -- and that's the reason why I think
it's also fine to keep the timezone and the rename information in there
too. If we were being _really_ anal about auxiliary information being
separate, we'd stick it in a separate blob object and merely refer to it
from the commit object. I don't think there's really any call to take it
that far, though.

-- 
dwmw2


