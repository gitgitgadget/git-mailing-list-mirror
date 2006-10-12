From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: cg-commit does not run pre-commit hook?
Date: Thu, 12 Oct 2006 19:02:14 +0200
Message-ID: <200610121902.14829.Josef.Weidendorfer@gmx.de>
References: <20061012155444.27391353BDE@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 19:05:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY3z3-0007fH-GS
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 19:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbWJLREe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 13:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbWJLREe
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 13:04:34 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:29354 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932704AbWJLREd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 13:04:33 -0400
Received: from a012.tum.vpn.lrz-muenchen.de (a012.tum.vpn.lrz-muenchen.de [129.187.51.12])
	by mail.in.tum.de (Postfix) with ESMTP id 7780C27F5;
	Thu, 12 Oct 2006 19:04:31 +0200 (MEST)
To: Wolfgang Denk <wd@denx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <20061012155444.27391353BDE@atlas.denx.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28790>

On Thursday 12 October 2006 17:54, Wolfgang Denk wrote:
> Yes, but only *after* doing the job. That's why  I'm  looking  for  a
> pre-commit hook.

pre-commit is not good either, as it runs *before* the editor pops up.
So it can not access the commit message.
You ask for a "pre-commit-post-edit" hook, which AFAIK currently
is not available in git.

> True, as long as you can work within the SCM. The changelog file  I'm
> talking  about is mostly for people who just work with exported trees
> (for example, when they download a tarball).

Can't you create the Changelog directly before preparing such an
tarball?

Usually when making a release/snapshot for a typical project, you
can not directly take the newest tree from the SCM, but need
to generate some files (like configure with automake/autoconf).

Josef

> 
> 
> Best regards,
> 
> Wolfgang Denk
> 
