From: Georg Lohrer <pacco@tropezien.de>
Subject: How to use git-svnimport without trunk, tags and branches?
Date: Sun, 11 Mar 2007 12:38:31 +0100
Message-ID: <45F3EA37.2080502@tropezien.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 13:08:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQMqb-0002Ai-Bv
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 13:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933267AbXCKMIQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 08:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933271AbXCKMIQ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 08:08:16 -0400
Received: from www18.your-server.de ([213.133.104.18]:3527 "EHLO
	www18.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933267AbXCKMIP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 08:08:15 -0400
X-Greylist: delayed 1775 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Mar 2007 08:08:15 EDT
Received: from [91.23.156.88] (helo=[192.168.100.70])
	by www18.your-server.de with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.50)
	id 1HQMNq-000577-UB
	for git@vger.kernel.org; Sun, 11 Mar 2007 12:38:39 +0100
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
X-Authenticated-Sender: pacco@tropezien.de
X-Virus-Scanned: Clear (ClamAV 0.88.4/2690/Thu Mar  1 12:11:27 2007)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41918>

Hi,

I have searched the archive but did not found any hint for my problem.
Perhaps I did not have the right search pattern, but see yourself:

The most important thing prior of using git was to import my subversion
repositories. It seems to be quite easy if the SVN-repositories are of
common structure using the trunk, tags and branches structure.

But times ago I have had the idea of not using the traditional structure
of subversion for some of my repositories but using the repository
directly as single directory - no trunk, no tags, no branches. That was
because I thought only a geek would have the "complicated" way for only
a few files without any need for tags and branches.
And now the git-svnimport does not seem to be able to handle a SVN-repos
structure like mine:

~/svnrepos/
      |------- projectA
                  |---- foo.cpp
                  |---- foo.h

I want to import projectA into git _with_ the commit-history (there are
of course no tags and no branches).
Is there a way to do that with git-svnimport? Or do I have to throw away
all the details, checkout projectA and reimport it as initial version
with git?

Any hints are warmly appreciated.

Ciao, Georg
