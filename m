From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: How to restore "svn mirror generator"?
Date: Sat, 21 Jan 2012 16:45:10 +0100
Message-ID: <jfemrc$t1j$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 16:50:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RodDI-00064y-Lz
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 16:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab2AUPuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 10:50:20 -0500
Received: from lo.gmane.org ([80.91.229.12]:33159 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914Ab2AUPuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 10:50:18 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RodCq-0005ni-RO
	for git@vger.kernel.org; Sat, 21 Jan 2012 16:50:16 +0100
Received: from p4fd18303.dip0.t-ipconnect.de ([79.209.131.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jan 2012 16:50:16 +0100
Received: from Manuel.Spam by p4fd18303.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jan 2012 16:50:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4fd18303.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0.1) Gecko/20111221 Firefox/9.0.1 SeaMonkey/2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188923>

Hello,

I want to create a GIT mirror of a SVN repository.

I plan to mirror a SVN server to GIT. I don't want to fetch the full history but 
all future commits should be mirrored.

I plan to do this in the following way:

git svn clone -r $REVISION_TO_START_WITH http://domain.tld/path/to/svn
git remote add origin ssh://user@gitserver.tld/mirror.git
git push

Now, from time to time, I want to update with

git svn rebase
git push

I hope, so far I'm on the right way.

But what happens if, for some reason, my local repository gets lost?

How to reconnect GIT and SVN so I'm able to mirror, again?

Is the first step to clone the GIT repository and then, somehow, get the SVN 
connected, again, or do I have to do it the other way around?

Yours

Manuel
