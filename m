From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: fatal unresolved deltas error
Date: Wed, 5 Nov 2014 20:01:32 +0300
Message-ID: <20141105200132.1464d476d91ce4f32b085b6a@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Anjib Mulepati <anjibman@gmail.com>
To: flatworm@users.sourceforge.net
X-From: git-owner@vger.kernel.org Wed Nov 05 18:02:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xm3yq-00080U-Ec
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 18:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbaKERCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 12:02:45 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:54098 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305AbaKERCm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2014 12:02:42 -0500
Received: from tigra.domain007.com ([192.168.2.102])
	(authenticated bits=0)
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id sA5H2bjM017347
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 5 Nov 2014 20:02:39 +0300
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm posting on behalf of Anjib Mulepati (Cc'ed) whose mails have
troubles getting in here.  Originally posted to git-users [*] but the
problem appears to be too complicated for that list.

[*] https://groups.google.com/d/topic/git-users/fnU3JtRuwH8/discussion

Below is the original Anjib's message.

I am trying to do push but getting this error

$ git push
Counting objects: 83, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (16/16), done.
Writing objects: 100% (17/17), 1.32 KiB | 0 bytes/s, done.
Total 17 (delta 12), reused 0 (delta 0)
remote: fatal: unresolved deltas left after unpacking
error: unpack failed: unpack-objects abnormal exit
To //myserver/git/apps/myApp.git
! [remote rejected] master -> master (unpacker error)
error: failed to push some refs to '//myserver/git/apps/myApp.git'

1. When I do new clean of the repo in new directory (say \newRepoDir)
I am getting error

$ git clone //myserver/git/apps/myApp.git/
Cloning into 'MyApp'...
done.
fatal: unable to read tree 18295307f1270da3c09e3de91890652af4ff7ca8
warning: Clone succeeded, but checkout failed.
You can inspect what was checked out with 'git status'
and retry the checkout with 'git checkout -f HEAD'

2. When I do cat in  new directory I am getting fatal: ..bad file error

$ git cat-file -t 18295307f1270da3c09e3de91890652af4ff7ca8
fatal: git cat-file 18295307f1270da3c09e3de91890652af4ff7ca8: bad file

3. But if I do cat in my current working directory it can tell its tree

$ git cat-file -t 18295307f1270da3c09e3de91890652af4ff7ca8
tree

My git repo is in network share drive and its Windows 7 and I am
working on Windows 7 machine too.

As client tool I am using Git for Windows 1.9.2.msysgit.0.

At this point I am thinking I have to push this tree in repo but not
sure how to do it or really that a solution.

Let me know what I have to do and if any further information is needed.

Thanks.
