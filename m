From: Pekka Riikonen <priikone@iki.fi>
Subject: Repository specific config file
Date: Sun, 7 Oct 2007 10:37:07 +0200 (CEST)
Message-ID: <Pine.NEB.4.64.0710070956340.12867@otaku.Xtrmntr.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 07 10:56:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeRwO-000715-A9
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 10:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbXJGI4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 04:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbXJGI4h
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 04:56:37 -0400
Received: from sauna.silcnet.org ([147.175.66.205]:49529 "EHLO
	otaku.Xtrmntr.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbXJGI4g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 04:56:36 -0400
X-Greylist: delayed 1166 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Oct 2007 04:56:36 EDT
Received: by otaku.Xtrmntr.org (Postfix, from userid 201)
	id 2BD0B48E3; Sun,  7 Oct 2007 10:37:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by otaku.Xtrmntr.org (Postfix) with ESMTP id 2AB8C48B9
	for <git@vger.kernel.org>; Sun,  7 Oct 2007 10:37:08 +0200 (CEST)
X-X-Sender: priikone@otaku.Xtrmntr.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60172>

Hello,

Has there been any discussion or considerations adding a repository 
specific config file that would be delivered to all cloned repositories 
automatically?  This would allow the publisher of the repository to set up 
some default settings to all developers cloning the repository.  This 
could be useful to set up things like default aliases to ease up the work, 
to set that all remote branches are tracked, to list the configurations of 
submodules (so that people don't have to run submodule init), etc.

User should still be able to add configurations that overlap with the 
remote configuration and user should be able to ignore everything that 
came from the parent.  Using ~/.gitconfig and /etc/gitconfig doesn't 
always work well when the developers don't have access to the remote 
machine (other than to clone the repository).  Maybe the simplest solution 
would be to just add .gitconfig to the repository itself.

 	Pekka
________________________________________________________________________
  Pekka Riikonen                                 priikone at silcnet.org
  Secure Internet Live Conferencing (SILC)       http://silcnet.org/
