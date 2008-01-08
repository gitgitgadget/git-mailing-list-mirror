From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Importing merges when converting repos from SVN to Git (fusing grafts in the Git history)
Date: Tue, 8 Jan 2008 15:48:47 +0100
Message-ID: <744EF0AD-4773-4A35-B772-94621E9ADA10@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 15:50:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCFmC-0001nc-5E
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 15:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbYAHOt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 09:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbYAHOt0
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 09:49:26 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:48319 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbYAHOt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 09:49:26 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1JCFlc-0006HT-25
	for git@vger.kernel.org; Tue, 08 Jan 2008 15:49:24 +0100
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69881>

Hi list,
I'm in the processing of converting the SVN repos of my company to  
Git.  We have been using scripts to handle the merge hell with SVN  
and these scripts always mentioned what was merged where in the  
commit message.  The first line is typically: merge -r FROM:TO  
https://svn.fake-company.com/svn/project/{trunk,branches/branch-name}
I'm going to import the repositories with `git-svn' and then I'd like  
to rewrite the entire history to take these merges in account in the  
Git repo, if possible.  This will probably help us merging the  
(former) SVN branches in our new Git repo.  I know I can simulate a  
merge with a graft and I think it will be fairly easy to write a  
small script that parses the log and generates the corresponding  
graft file.  Now the question is: how to make these grafts part of  
the *real* history so that we don't have to depend on the graft file  
anymore?

I know this issue has already been raised on the ML (the "how to  
include grafts are real merges in the history" thing) but I couldn't  
find the corresponding posts and can't remember the conclusion...

Thanks!

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory
