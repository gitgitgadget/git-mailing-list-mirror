From: bdowning@lavos.net (Brian Downing)
Subject: Re: git archive ignores .gitignored files?
Date: Thu, 26 Jul 2007 12:54:07 -0500
Message-ID: <20070726175407.GT21692@lavos.net>
References: <20070726173206.GR21692@lavos.net> <20070726173635.GS21692@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 19:54:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE7Xa-00030d-Lr
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 19:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933457AbXGZRyS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 13:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbXGZRyS
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 13:54:18 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:6099 "EHLO
	asav02.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765052AbXGZRyR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 13:54:17 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav02.insightbb.com with ESMTP; 26 Jul 2007 13:54:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah5FAJ13qEZKhvbzRmdsb2JhbACBTYVpiCgBAQE1AQ
Received: by mail.lavos.net (Postfix, from userid 1000)
	id B9CC2309F31; Thu, 26 Jul 2007 12:54:07 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070726173635.GS21692@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53849>

On Thu, Jul 26, 2007 at 12:36:35PM -0500, Brian Downing wrote:
> On Thu, Jul 26, 2007 at 12:32:06PM -0500, Brian Downing wrote:
> > git archive seems to not output files marked in .gitignore.
> 
> Never mind; it is "git add" that ignored the file.  Oops.

For what it's worth, if I do (in the git tree):

mkdir foo
touch foo/file
mkdir foo/git-daemon
touch foo/git-daemon/file

"git add foo" does not produce any warnings that "foo/git-daemon" was
ignored.  If "foo/file" does not exist it warns that "foo" was not
added.

-bcd
