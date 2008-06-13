From: Mirko Stocker <m1stocke@hsr.ch>
Subject: Re: Working with Git and CVS in a team.
Date: Fri, 13 Jun 2008 22:47:03 +0200
Message-ID: <200806132247.03947.m1stocke@hsr.ch>
References: <200806131633.34980.mirko.stocker@hsr.ch> <20080613160911.GB3140@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 22:54:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7GID-0000b6-GS
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 22:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbYFMUxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 16:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbYFMUxs
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 16:53:48 -0400
Received: from luc80-74-131-252.ch-meta.net ([80.74.131.252]:36688 "EHLO
	lucius.metanet.ch" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753317AbYFMUxr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 16:53:47 -0400
Received: (qmail 7760 invoked from network); 13 Jun 2008 22:47:04 +0200
Received: from 77-57-13-126.dclient.hispeed.ch (HELO pluto7) (77.57.13.126)
  by luc80-74-131-153.ch-meta.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 13 Jun 2008 22:47:04 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080613160911.GB3140@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84942>

On Friday 13 June 2008 18:09:11 Jeff King wrote:
> On Fri, Jun 13, 2008 at 04:33:34PM +0200, Mirko Stocker wrote:
> > 1) I use git-cvsimport to update the repository every night. /git-proj
> >    is a "clone --bare" of the /from-cvs repository.
> >
> > 2) After the import, I push the changes from CVS to /git-proj using
> >    'git push /git-proj origin'.
>
> You could simplify this by just cvsimporting to an 'upstream' branch in
> git-proj.

Hm, I've tried that, but it doesnt seem to work.. git-proj is a bare 
repository, and git-cvsimport always creates a new .git in it. I'm using 
the -C option to specify the target. Is anything else needed?

Regards

Mirko
