From: Michel Jouvin <jouvin@lal.in2p3.fr>
Subject: git-svn dcommit ignores --username if there are cached credentials
Date: Tue, 12 Jan 2010 22:47:57 +0000 (UTC)
Message-ID: <loom.20100112T233835-324@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 23:50:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUpZ1-0005GG-71
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 23:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683Ab0ALWuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 17:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490Ab0ALWuJ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 17:50:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:51420 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944Ab0ALWuI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 17:50:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NUpYr-0005CY-U1
	for git@vger.kernel.org; Tue, 12 Jan 2010 23:50:06 +0100
Received: from APuteaux-153-1-43-64.w82-124.abo.wanadoo.fr ([82.124.7.64])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 23:50:05 +0100
Received: from jouvin by APuteaux-153-1-43-64.w82-124.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 23:50:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.124.7.64 (Opera/9.80 (Windows NT 6.0; U; fr) Presto/2.2.15 Version/10.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136760>

Hi,

I am new to Git and using 1.6.6. I'm very interested by using it to mirror SVN 
repositories. But I am running into troubles with the way git-svn handles SVN 
credentials. 

For one SVN I use I have some cached credentials that have only very restricted 
write access. With svn command, I am using --username for every commit and this 
cached credential is just ignored: I'm asked for a password.

With git-svn, I use --username at init/fetch but during dcommit --username is 
ignored becaused of the cached credential. I can see in SVN logs that the 
cached credential (which doesn't have the right to commit the mods I made) has 
been used instead of the one specified during fetch. If I removed the cached 
credential, the username specified with --username is taken into account (I'm 
asked a password for it and it works) and if I ommit the --username, the one 
specified at fetch time is used.

IMO, looks like a bug... Thanks in advance for any comment.

Cheers,

Michel
