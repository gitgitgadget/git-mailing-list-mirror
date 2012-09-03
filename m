From: Mark Hills <Mark.Hills@framestore.com>
Subject: Clone to an SSH destination
Date: Mon, 3 Sep 2012 11:21:43 +0100 (BST)
Message-ID: <alpine.LFD.2.01.1209031059480.4753@sys880.ldn.framestore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 13:08:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8UWM-00051W-Ec
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 13:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312Ab2ICLIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 07:08:39 -0400
Received: from mx4.framestore.com ([193.203.83.5]:46144 "EHLO
	mx4.framestore.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238Ab2ICLIj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 07:08:39 -0400
X-Greylist: delayed 2803 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Sep 2012 07:08:39 EDT
Received: from vm-zimbra.ldn.framestore.com ([172.16.73.68] helo=zimbra.framestore.com)
	by mx4.framestore.com with esmtp (Exim 4.72)
	(envelope-from <Mark.Hills@framestore.com>)
	id 1T8Tmu-0000Cb-D1
	for git@vger.kernel.org; Mon, 03 Sep 2012 11:21:53 +0100
Received: from sys880.ldn.framestore.com (sys880.ldn.framestore.com [172.16.84.100])
	by zimbra.framestore.com (Postfix) with ESMTPA id DC4E61FD85D9
	for <git@vger.kernel.org>; Mon,  3 Sep 2012 11:21:22 +0100 (BST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204685>

How do I clone a repo _to_ a new repo over SSH? I tried:

  cd xx
  git clone --bare . gitserver:/scm/xx.git
  git clone --bare . ssh://gitserver/scm/xx.git

This does not have the expected result, and instead a local path of the 
given name is created (eg. a 'gitserver:' directory)

This seems to be a FAQ, but the only answer I can find (Google) is to 
login to the server and create the repo, setup a remote and push to it.
 
This is quite cumbersome; we have a large team of devs who use a simple 
'git clone' to an NFS directory, but we wish to retire NFS access.

Is there a technical limiation preventing clone-to-ssh, or just something 
waiting to be implemented?

(Please keep me CC'd; I am currently reading the web archives)

Many thanks

-- 
Mark
