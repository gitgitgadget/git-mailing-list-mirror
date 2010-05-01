From: pocmatos@gmail.com (Paulo J. Matos)
Subject: Import of svn rep has path issues
Date: Sat, 01 May 2010 14:45:00 +0100
Message-ID: <8439yblorn.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 19:15:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8GHb-0007go-9q
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 19:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab0EARPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 13:15:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:57902 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab0EARPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 13:15:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O8GHP-0007Z7-9N
	for git@vger.kernel.org; Sat, 01 May 2010 19:15:03 +0200
Received: from host86-146-157-21.range86-146.btcentralplus.com ([86.146.157.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 May 2010 19:15:03 +0200
Received: from pocmatos by host86-146-157-21.range86-146.btcentralplus.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 May 2010 19:15:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: host86-146-157-21.range86-146.btcentralplus.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:RayBFMkTrFawtdMB1YeC3YDIirU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146094>

Hi all,

I just tried to import a svn project into git using git-svnimport.
I followed:
http://weblog.redlinesoftware.com/2008/2/24/converting-subversion-repositories-to-git

The line was:
git-svnimport -C projname -r -v -A authors https://your-repo-host.com/projname

Interestingly some revisions resulted in a lot of errors with:
91: Unrecognized path: /main.cc

This seems to occur in the first revisions where I hadn't adopted a tree
format of /branches, /tags, /trunk. 
On the other hand, git-svnimport returned 0 to the environment, so I
would assume that those 'Unrecognized path' issues are just warnings and
everything went fine. I would like to have some confirmation of this if
possible and if these files were not imported into my new git rep, how
can I solve these issues?

Thanks,

-- 
PMatos
