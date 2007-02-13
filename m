From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: re-map repository URLs and UUIDs on SVK mirror paths
Date: Tue, 13 Feb 2007 14:21:02 -0800
Message-ID: <20070213222102.GA25092@localdomain>
References: <20070210233750.A333013A384@magnus.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 23:21:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH61N-0004jo-W0
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 23:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbXBMWVG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 17:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbXBMWVF
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 17:21:05 -0500
Received: from hand.yhbt.net ([66.150.188.102]:57430 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbXBMWVE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 17:21:04 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C148E7DC094;
	Tue, 13 Feb 2007 14:21:02 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Feb 2007 14:21:02 -0800
Content-Disposition: inline
In-Reply-To: <20070210233750.A333013A384@magnus.utsl.gen.nz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39590>

Sam Vilain <sam@vilain.net> wrote:
> If an SVN revision has a property, "svm:headrev", it is likely that
> the revision was created by SVN::Mirror (a part of SVK).  The property
> contains a repository UUID and a revision.  We want to make it look
> like we are mirroring the original URL, so introduce a helper function
> that returns the original identity URL and UUID, and use it when
> generating commit messages.

If somebody is using these options with git-svn and wants to dcommit,
they should only be committing to the svm:source repository and not to
the repository managed by SVN::Mirror, right?

-- 
Eric Wong
