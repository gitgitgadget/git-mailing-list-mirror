From: esr@thyrsus.com (Eric Raymond)
Subject: Three issues from a Subversion-to-git migration
Date: Fri, 26 Mar 2010 08:09:06 -0400 (EDT)
Message-ID: <20100326120906.F03BB20CD21@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 13:17:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv8TV-0003IL-By
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 13:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab0CZMRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 08:17:10 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:49670
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab0CZMRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 08:17:09 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Mar 2010 08:17:09 EDT
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id F03BB20CD21; Fri, 26 Mar 2010 08:09:06 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143226>

I joined the git list a few hours ago because of experiences I had
while migrating one of my projects, GPSD, from Subversion to git.
GPSD haa a logical but unusual use case for distributed version
control; the best places to test GPS sensors are out-of-doors in cars
and other places where wire-line Internet is absent and one may well
be out of range of a WAP.

In the course of the migration, I encountered three issues which I
think could be addressed with a relatively small amount of work.

1. The git hook scripts for CIA.vc are broken (in a way that is,
fortunately, easy to fix) and generally seem to be in an unmaintained,
dusty state.

2. The git-svn migration logic does not handle unmodified SVN tag
trees well.

3. I'm prone to typos, so I quickly noticed that the existing
facilities for editing comments in commits (before they're pushed)
are clumsy and dangerous.

I will address these points in detail in separate mails.  Issues 1 and
3 I can fix with working code.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
