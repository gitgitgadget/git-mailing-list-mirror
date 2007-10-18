From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: git push bug?
Date: Thu, 18 Oct 2007 16:50:40 +0200
Organization: Transmode AB
Message-ID: <1192719040.9433.5.camel@gentoo-jocke.transmode.se>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 16:51:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiWi8-00073R-9U
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 16:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762570AbXJROup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 10:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762146AbXJROup
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 10:50:45 -0400
Received: from mail.transmode.se ([83.241.175.147]:20355 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762108AbXJROun (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 10:50:43 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 18 Oct 2007 16:50:40 +0200
X-Mailer: Evolution 2.10.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61535>


I thougth I could create a new branch on the server using:

# > git push ssh://devsrv/var/git/os2kernel.git linus:refs/linus
Warning: No xauth data; using fake authentication data for X11 forwarding.
updating 'refs/linus' using 'refs/heads/linus'
 from 0000000000000000000000000000000000000000
 to bbf25010f1a6b761914430f5fca081ec8c7accd1
Generating pack...
Done counting 0 objects.
Writing 0 objects...
Total 0 (delta 0), reused 0 (delta 0)
error: refusing to create funny ref 'refs/linus' locally
ng refs/linus funny refname
error: failed to push to 'ssh://devsrv/var/git/os2kernel.git'

but that doesn't work. Am I doing this wrong?

git 1.5.3.4
 
   Jocke
