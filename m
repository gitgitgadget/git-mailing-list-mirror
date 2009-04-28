From: tom fogal <tfogal@alumni.unh.edu>
Subject: git-svn `Repository has moved' error
Date: Tue, 28 Apr 2009 12:47:31 -0600
Message-ID: <auto-000019246426@sci.utah.edu>
Reply-To: tfogal@sci.utah.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 21:17:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LysoO-0008DI-Rg
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 21:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbZD1TRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 15:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbZD1TRj
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 15:17:39 -0400
Received: from mail.sci.utah.edu ([155.98.58.79]:48495 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751223AbZD1TRj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 15:17:39 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Apr 2009 15:17:38 EDT
Received: from dummy.name; Tue, 28 Apr 2009 12:47:37 -0600
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117804>

We recently had a new subversion server replace an aging one, taking
over the same hostname / ip and adding in a sourceforge-like system.
Since then, I can't use git-svn to commit to the repo.  I get this
error message when trying to dcommit:

  Committing to https://code.sci.utah.edu/svn/Tuvok ...
  Repository has been moved: Repository moved temporarily to
  '/gf/project/?feedback=Page Not Found. Try searching for projects';

I've tried a fresh clone, and upgrading to 1.6.2.4 manually, with the
same results in both cases.  My subversion bindings are from version
svn 1.6.1.

I can update/commit from an svn-managed checkout without issue.  I've
tried a working copy I had lying around since before the move.

Any ideas / workarounds?

-tom
