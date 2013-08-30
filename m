From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH] check-ignore: Add option to ignore index contents
Date: Fri, 30 Aug 2013 01:10:54 +0100
Message-ID: <20130830001054.GA3691@pacific.linksys.moosehall>
References: <20130829224652.GA13621@opensourcesolutions.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Williams <dave@opensourcesolutions.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 02:19:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFCQx-0006pY-8s
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 02:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085Ab3H3ATV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 20:19:21 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:41538 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007Ab3H3ATU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 20:19:20 -0400
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2013 20:19:20 EDT
Received: from localhost (c.0.0.0.1.c.a.c.2.8.4.2.9.c.5.f.0.d.3.7.6.a.1.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:11a6:73d0:f5c9:2482:cac1:c])
	by coral.adamspiers.org (Postfix) with ESMTPSA id C573A2E342;
	Fri, 30 Aug 2013 02:00:54 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130829224652.GA13621@opensourcesolutions.co.uk>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233382>

On Thu, Aug 29, 2013 at 11:46:52PM +0100, Dave Williams wrote:
> check-ignore currently shows how .gitignore rules would treat untracked
> paths. Tracked paths do not generate useful output.  This prevents
> debugging of why a path became tracked unexpectedly unless that path is
> first removed from the index with git rm --cached <path>
> 
> This option (-i, --ignore-index) simply by-passes the check for the path
> being in the index and hence allows tracked path to be checked too.
> 
> Whilst this behaviour deviates from the characteristics of git add and
> git status its use case is unlikely to cause any user confusion.
> 
> Signed-off-by: Dave Williams <dave@opensourcesolutions.co.uk>

[snipped]

Sounds like a great idea to me, and the code changes look reasonable;
however you forgot to add corresponding tests :-)  Please can you
expand the patch to include them?

But I'm in favour in principle - thanks a lot for working on this!
