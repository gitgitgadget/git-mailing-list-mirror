From: Chris Wright <chrisw@osdl.org>
Subject: Re: Allow "-u" flag to tag signing
Date: Thu, 6 Oct 2005 16:32:00 -0700
Message-ID: <20051006233200.GR8041@shell0.pdx.osdl.net>
References: <Pine.LNX.4.64.0510060952410.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 07 01:32:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENfDp-0004ji-Lz
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 01:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVJFXcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 19:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVJFXcI
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 19:32:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28903 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932072AbVJFXcG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2005 19:32:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j96NW04s027415
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 6 Oct 2005 16:32:01 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j96NW04Y028242;
	Thu, 6 Oct 2005 16:32:00 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j96NW0Af028241;
	Thu, 6 Oct 2005 16:32:00 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510060952410.31407@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.51__
X-MIMEDefang-Filter: osdl$Revision: 1.122 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9790>

* Linus Torvalds (torvalds@osdl.org) wrote:
> So rather than force my tagger ID to have to match the gpg key name, just 
> support the "-u" flag to "git tag" instead. It implicitly enables signing, 
> since it doesn't make any sense without it. Thus:
> 
> 	git tag -u <gpg-key-name> <tag-name> [<tagged-object>]
> 
> will use the named gpg key for signing.

Nice, I've had a hack something like this locally here as well, and been
meaning to cleanup and submit.

thanks,
-chris
