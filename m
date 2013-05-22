From: Kendall Shaw <kshaw@kendallshaw.com>
Subject: Remote branch can not be resolved as commit?
Date: Wed, 22 May 2013 07:29:14 -0700
Message-ID: <519CD63A.20802@kendallshaw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 22 17:54:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfBMw-0000x9-T6
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 17:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970Ab3EVPyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 11:54:22 -0400
Received: from b.mail.sonic.net ([64.142.19.5]:57473 "EHLO b.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755539Ab3EVPyW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 11:54:22 -0400
X-Greylist: delayed 5106 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 May 2013 11:54:22 EDT
Received: from nekobasu.localdomain (c-67-161-38-155.hsd1.ca.comcast.net [67.161.38.155])
	(authenticated bits=0)
	by b.mail.sonic.net (8.13.8.Beta0-Sonic/8.13.7) with ESMTP id r4METEnc023051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 22 May 2013 07:29:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225170>

I am trying to setup a repository for use inside the LAN, but I have 
been unable to checkout any branch so far. I am very new to git.

The repository is being served from gitblit over https. I have 
GIT_SSL_NO_VERIFY=true. The repository was created from git svn.

git ls-remote

shows the remote branches, e.g.:

... refs/remotes/2.0.3
... refs/remotes/trunk

git branch -r

shows none of the remote branches.

git checkout -b new-2.0.3 origin/2.0.3

produces:

fatal: git checkout: updating paths is incompatible with switching branches.
Did you intend to checkout 'origin/2.0.3' which can not be resolved as 
commit?

What does that mean?

I get the same result after each of these:

git fetch

git remote update
git fetch

git add remote stage-repo https://example.com:8443/git/blah-tools.git
git fetch stage-repo
git checkout -b new-2.0.3 stage-repo/2.0.3

Can you explain what the error message means, and what I am doing wrong?

Kendall
