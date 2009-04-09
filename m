From: =?ISO-8859-1?Q?Yoann_Herv=E9?= <yoann.herve.ext@makina-corpus.com>
Subject: Delete branch start with "-"
Date: Thu, 09 Apr 2009 14:28:48 +0200
Message-ID: <49DDEA00.9090003@makina-corpus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 15:00:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrtrb-00073j-Pu
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 15:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933798AbZDIM6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 08:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbZDIM6l
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 08:58:41 -0400
Received: from mx.makina-corpus.com ([195.144.11.144]:39354 "EHLO
	mx.makina-corpus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933275AbZDIM6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 08:58:40 -0400
X-Greylist: delayed 1787 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Apr 2009 08:58:40 EDT
Received: from mx.makina-corpus.com (phpnet3.makina-corpus.net [127.0.0.1])
	by mx.makina-corpus.com (Postfix) with ESMTP id AD0C5171C289
	for <git@vger.kernel.org>; Thu,  9 Apr 2009 14:28:50 +0200 (CEST)
Received: from [192.168.168.199] (mail2.makina-corpus.com [88.163.79.96])
	by mx.makina-corpus.com (Postfix) with ESMTP id 7A8FD171C281
	for <git@vger.kernel.org>; Thu,  9 Apr 2009 14:28:50 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116166>

Hello,
by mistake I have created a branch with a "-" at the beginning of his 
name, and now I can't delete it.

 git branch -d -f
 error: unknown switch `s'
 usage: git-branch [options] [-r | -a] [--merged | --no-merged]
    or: git-branch [options] [-l] [-f] <branchname> [<start-point>]
    or: git-branch [options] [-r] (-d | -D) <branchname>
    or: git-branch [options] (-m | -M) [<oldbranch>] <newbranch>

 Generic options
     -v, --verbose         be verbose
     --track               set up tracking mode (see git-pull(1))
     --color               use colored output
     -r                    act on remote-tracking branches
     --contains <commit>   print only branches that contain the commit
     --abbrev[=<n>]        use <n> digits to display SHA-1s

 Specific git-branch actions:
     -a                    list both remote-tracking and local branches
     -d                    delete fully merged branch
     -D                    delete branch (even if not merged)
     -m                    move/rename a branch and its reflog
     -M                    move/rename a branch, even if target exists
     -l                    create the branch's reflog
     -f                    force creation (when already exists)
     --merged              list only merged branches

How can I delete it ?

Thanks,
Yoann
