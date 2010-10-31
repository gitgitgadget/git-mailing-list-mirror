From: Maaartin <grajcar1@seznam.cz>
Subject: Pushing everything
Date: Sun, 31 Oct 2010 05:47:38 +0000 (UTC)
Message-ID: <loom.20101031T064406-734@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 31 06:55:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCQtF-0007xo-Gs
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 06:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412Ab0JaFrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 01:47:51 -0400
Received: from lo.gmane.org ([80.91.229.12]:47939 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab0JaFru (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 01:47:50 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PCQlg-0005qW-LI
	for git@vger.kernel.org; Sun, 31 Oct 2010 06:47:48 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 06:47:48 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 06:47:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.63)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160416>

I'd like to push all my branches and tags to the server, but for whatever reason 
"--all" ignores tags and is incompatible with "--tags". I could imagine there's 
a reason I'm not experienced enough to see?

It seems to me that "--mirror" is quite unusable, since it force-overwrites the 
remote repo and even deletes refs not locally present. Obviously, a mirror can't 
be shared, and it doesn't seem to me to be the ideal backup solution for a 
single person.

However, even if "git push -all -tags"  worked, I'm not sure it's a good idea 
for project with more collaborators. There may be conflicts or other problems 
and quite often the pushing occurs just before leaving so it's no good time to 
start resolving conflicts. Can a shared repo be used as a sort of backup as 
well? I'd like a possibility to backup all my work there anytime without needing 
to care about anything. This could work by creating sort of private refs in case 
of any problems, or whatever. Is there something like this, or am I thinking 
astray? I'd suppose, something like this could be very useful for a company 
where it'd provide a simple backup solution for everybody.
