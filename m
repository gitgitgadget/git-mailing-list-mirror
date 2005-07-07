From: Chris Wright <chrisw@osdl.org>
Subject: Re: BUG:  "rpmbuild -ta cogito-0.12.tar.gz" fails
Date: Wed, 6 Jul 2005 23:20:19 -0700
Message-ID: <20050707062019.GL5324@shell0.pdx.osdl.net>
References: <dah8i2$c8v$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 08:20:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqPkQ-0007BZ-Av
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 08:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVGGGUZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 02:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVGGGUY
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 02:20:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261172AbVGGGUW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 02:20:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j676KJjA007686
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Jul 2005 23:20:20 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j676KJCt017726;
	Wed, 6 Jul 2005 23:20:19 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j676KJlL017725;
	Wed, 6 Jul 2005 23:20:19 -0700
To: John Ellson <ellson@research.att.com>
Content-Disposition: inline
In-Reply-To: <dah8i2$c8v$1@sea.gmane.org>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* John Ellson (ellson@research.att.com) wrote:
> "rpmbuild -ta cogito-0.12.tar.gz" fails because cogito.spec.in refers to
> ".bz2" in its "Source:" line, instead of to ".gz".

Just grab the .bz2, or the SRPM http://kernel.org/pub/software/scm/cogito/RPMS
(still mirroring, I just uploaded it a bit ago)

> This is obviously a trivial patch.  Do I need prior approval to send 
> patches to this group?     What is the the significance of 
> "Signed-off-by:"     Is there a FAQ I should read?

No approval needed.  Signed-off-by is in reference to the Developer's
Certificate of Origin 1.1 (see item 11 in the Linux kernel's source file
Documentation/SubmittingPatches).
