From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] NO_PERL support
Date: Fri, 3 Apr 2009 08:59:38 -0700
Message-ID: <20090403T155623Z@curie.orbis-terrarum.net>
References: <20090403T065545Z@curie.orbis-terrarum.net> <20090403154608.GA27089@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 03 18:03:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LplrR-0002Je-FK
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 18:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935291AbZDCP7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 11:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935254AbZDCP7p
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 11:59:45 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:55722 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935296AbZDCP7o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 11:59:44 -0400
Received: (qmail 30476 invoked from network); 3 Apr 2009 15:59:41 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Fri, 03 Apr 2009 15:59:41 +0000
Received: (qmail 24602 invoked by uid 10000); 3 Apr 2009 08:59:38 -0700
Content-Disposition: inline
In-Reply-To: <20090403154608.GA27089@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115540>

On Fri, Apr 03, 2009 at 11:46:08AM -0400, Jeff King wrote:
> Also, a few meta-issues with this patch.
>
> One is that the usual practice is to send patches inline rather than
> attaching them.
I usually send as attachments, as the filename of the patch is important
as well, and the majority of places that I submit to want attachments.

> Another is that this text:
...
> should go with the patch as part of the commit message along with this:
The text was specifically describing it for the Git community.

...
> If you are using git to prepare your patch, then "git format-patch"
> should generate the right output.
This patch was generated with format-patch years ago, but has been
hand-tuned since.

> And finally, these two hunks:
> > diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
> > index 6a37f71..84a0d31 100755
> > --- a/t/t9400-git-cvsserver-server.sh
> > +++ b/t/t9400-git-cvsserver-server.sh
> > @@ -17,6 +17,12 @@ then
> > [...]
> > diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> > index 6ed10d0..d4580a4 100755
> > --- a/t/t9500-gitweb-standalone-no-errors.sh
> > +++ b/t/t9500-gitweb-standalone-no-errors.sh
> did not apply for me, to the current 'master' or 'next'. Furthermore,
> the blobs they are based on aren't even present in my repo, so a 3-way
> merge was impossible. What did you base this patch on?
The patch applies cleanly to the 1.6.2.* tarballs.

-- 
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
