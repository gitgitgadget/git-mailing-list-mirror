From: Rich Pixley <rich.pixley@palm.com>
Subject: merging confusion and question
Date: Tue, 07 Aug 2012 17:25:49 -0700
Message-ID: <5021B20D.2030702@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 02:35:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyuFd-0004V1-On
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 02:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab2HHAfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 20:35:48 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:26666 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab2HHAfr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 20:35:47 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Aug 2012 20:35:47 EDT
X-IronPort-AV: E=Sophos;i="4.77,730,1336374000"; 
   d="scan'208";a="15186721"
Received: from unknown (HELO ushqusdns3.palm.com) ([148.92.223.90])
  by smtp-relay2.palm.com with ESMTP; 07 Aug 2012 17:25:52 -0700
Received: from fuji-land.noir.com ([10.100.2.9])
	by ushqusdns3.palm.com (8.14.4/8.14.4) with ESMTP id q780PnF1019179;
	Tue, 7 Aug 2012 17:25:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:15.0) Gecko/20120731 Thunderbird/15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203058>

I'm confused.

What is the intended work flow here?  Ie, aside from trashing my 
repository and starting over, what does one do to recover?

rich@cobra> git clone /home/rich/repos/webos webos
Cloning into 'webos'...
done.
rich@cobra> cd webos
rich@cobra> git remote add central git@github.com:openwebos/webos.git
rich@cobra> git co master
Already on 'master'
rich@cobra> git pull central master
X11 forwarding request failed on channel 0
remote: Counting objects: 22, done.
remote: Compressing objects: 100% (19/19), done.
remote: Total 21 (delta 12), reused 11 (delta 2)
Unpacking objects: 100% (21/21), done.
 From github.com:openwebos/webos
  * branch            master     -> FETCH_HEAD
warning: Failed to merge submodule meta-webos (not checked out)
Auto-merging meta-webos
CONFLICT (submodule): Merge conflict in meta-webos
Auto-merging README.md
Automatic merge failed; fix conflicts and then commit the result.
rich@cobra> git commit -a
error: unable to index file meta-webos
fatal: updating files failed
rich@cobra> git add meta-webos
error: unable to index file meta-webos
fatal: updating files failed
rich@cobra> git rm meta-webos
meta-webos: needs merge
rm 'meta-webos'
fatal: git rm: 'meta-webos': Is a directory
rich@cobra> git merge meta-webos
error: 'merge' is not possible because you have unmerged files.
hint: Fix them up in the work tree,
hint: and then use 'git add/rm <file>' as
hint: appropriate to mark resolution and make a commit,
hint: or use 'git commit -a'.
fatal: Exiting because of an unresolved conflict.

--rich
