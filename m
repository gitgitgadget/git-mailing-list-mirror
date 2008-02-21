From: Jon Loeliger <jdl@jdl.com>
Subject: Git and Web Content Tricks?
Date: Thu, 21 Feb 2008 10:00:07 -0600
Message-ID: <E1JSDqB-00050w-75@jdl.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 17:32:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSEKm-0005Hi-7I
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 17:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760751AbYBUQbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 11:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758905AbYBUQbH
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 11:31:07 -0500
Received: from jdl.com ([208.123.74.7]:49172 "EHLO jdl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758021AbYBUQbG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 11:31:06 -0500
X-Greylist: delayed 1855 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Feb 2008 11:31:06 EST
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>)
	id 1JSDqB-00050w-75
	for git@vger.kernel.org; Thu, 21 Feb 2008 10:00:08 -0600
X-Spam-Score: -2.6 (--)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74630>

Folks,

I am interested in hearing about any tricks or
scripts you have that help you manage your website
content on a daily basis.

While I am aware of the post-update hooks that assure
a properly checked-out content after a push, I'm also
wondering if anyone has dealt with this issue in the
face of either beta-test site pre-testing requirements or
additional support files such as database files as well.

Specifically, if you had web content that needed to be
published only after it has gone through a qual cycle
on a beta test platform, how do you account for any minor
changes in content before converting it to your production
site?  Do you run a separate branch for beta differences
and merge them up or down to a production branch?  Do you
run a post- or pre- hook to alter or create config files
during the {beta,production} install?

If you had content in your complete git repository that
included stuff that wasn't to be deployed to your HTDOC
root, how do you account for only a "partial" or subset
deployment of your files?  For example, if you kept a
copy of your backend database scehmas as well as your
actual web pages under two separate directories of the
same repository, how do you deploy just the web pages
and not the schema files?  Do you checkout with path
limiters?  Do you run a Manifest install file and script?
Do you rely on some Makefile target scheme?

Any tips or tricks here for the weary?

Thanks!
jdl
