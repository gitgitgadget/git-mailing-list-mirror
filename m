From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Ramifications of a git-sh-setup outside the
 PATH
Date: Fri, 27 Jun 2008 14:00:27 -0500 (CDT)
Message-ID: <20080627140027.BIA12244@m4500-01.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 21:08:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCJJR-0007uz-AI
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 21:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786AbYF0THx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 15:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755482AbYF0THx
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 15:07:53 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:40567 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbYF0THw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 15:07:52 -0400
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jun 2008 15:07:52 EDT
Received: from m4500-01.uchicago.edu (m4500-01.uchicago.edu [128.135.249.211])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m5RJ0UmZ029266
	for <git@vger.kernel.org>; Fri, 27 Jun 2008 14:00:31 -0500
Received: (from m4500-01.uchicago.edu [128.135.249.215])
	by m4500-01.uchicago.edu (MOS 3.8.5-GA)
	with HTTP/1.1 id BIA12244 (AUTH jrnieder@uchicago.edu);
	Fri, 27 Jun 2008 14:00:27 -0500 (CDT)
X-Mailer: Mirapoint Webmail Direct 3.8.5-GA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86625>

Hi gitsters,

I noticed in the release notes to Git 1.6.0 that dashed-form commands
are moving to a libexecdir outside the PATH. I have been using Git
with nd/dashless applied for about a month, and it does work well
(thanks!). There was one little glitch: to use hg-fast-export.sh from
fast-export.git (of repo.or.cz), I had to put git-sh-setup in the PATH.

I wanted to just change the ". git-sh-setup" line to ". git sh-setup",
but of course that will not work. Am I missing something?

hg-fast-export uses git-sh-setup to handle --help, to provide the
cd_to_toplevel function, and to set GIT_DIR. It would not take much
work to avoid using git-sh-setup, although for my needs it was easier
to put git-sh-setup in the PATH. But really, the use of git-sh-setup
does not seem strange to me at all. Is use of git-sh-setup in scripts
outside Git core discouraged?

The location of git-sh-setup was discussed before in the thread
<http://thread.gmane.org/gmane.comp.version-control.git/33708>.
Thanks for your time, and thank you for Git!

Sincerely,
Jonathan
