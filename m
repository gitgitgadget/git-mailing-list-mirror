From: Gelonida <gelonida@gmail.com>
Subject: is there a trick to run commands on a remote repository
Date: Fri, 18 Jun 2010 23:54:08 +0200
Message-ID: <hvgpu0$rbh$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 18 23:54:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPjWE-0006Ai-Sb
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 23:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab0FRVy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 17:54:26 -0400
Received: from lo.gmane.org ([80.91.229.12]:34133 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489Ab0FRVyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 17:54:25 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OPjVz-00064s-6b
	for git@vger.kernel.org; Fri, 18 Jun 2010 23:54:19 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 23:54:19 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 23:54:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149367>

Hi,


I'd like to get information from a remote git repository.

Example:
git branch -v

If the remote repository were remotehost:/a/long/path/repo.git m then I
could type

ssh remotehost "cd a/long/path/repo.git ; git branch -v"

If the remote repository were file://a/long/path/repo.git , then I had
to type
( cd /a/long/path/repo.git ; git branch -v )


I could write a script, which parses the repository name and executes
then the correct command.

I just wondered, whether git has already some bult in tricks, which
would help me avoiding to implement my own potentially faulty script.

I'm interested in executing 'read only' commands like

git branch
git log


thanks in advance for any suggestions
