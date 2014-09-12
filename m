From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: [boinc_dev] (local ?) BOINC repo broken again -or- how to act
 on the CR/LF changes made upstream
Date: Fri, 12 Sep 2014 21:04:28 +0200
Message-ID: <541343BC.1050503@gmx.de>
References: <541336D6.3050803@gmx.de> <1BAFA9B4D550C347962F76F2E03B3BBB22C5F9@romw-mail.romwnet.org> <54133C3A.4080700@gmx.de> <1BAFA9B4D550C347962F76F2E03B3BBB22C5FA@romw-mail.romwnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: boinc_dev@ssl.berkeley.edu
To: Rom Walton <romw@romwnet.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 21:04:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSW96-0003xb-5L
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 21:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbaILTEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 15:04:32 -0400
Received: from mout.gmx.net ([212.227.15.15]:56342 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222AbaILTEb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 15:04:31 -0400
Received: from [192.168.178.21] ([78.54.159.21]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0Le5bY-1Y9cFF38Rg-00pxMn; Fri, 12 Sep 2014 21:04:29
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <1BAFA9B4D550C347962F76F2E03B3BBB22C5FA@romw-mail.romwnet.org>
X-Provags-ID: V03:K0:fKRc2TxqMj4KcsuTNH3+JOCx/2UvBFUGve5nEut+Y86hvb5p5P3
 CNUeL/Zi/Cf8mT3Q/FsRZNs3NvDJonceqkonXyx87LdiTZ/jYFz9Ye906PzA0aiT55NzO3F
 dd64oXIG00tnZm2oujcEoQDIigKhFZhnDZMaSPtO5W9TJQT6hlUx1LIv9W7SxMsiE6yJ7rY
 XuHHWukgW8+q1sGJQd4oQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256941>

On 09/12/2014 08:55 PM, Rom Walton wrote:
> Crud...
> 
> Well, personally, I would delete the locale directory and the two translation files in html.
> 
> Do the 'git pull', and then switch between master and some other branch.
> 
> like:
> git checkout -f client_release/7/7.4
> git checkout -f master
> 
> It is round about, but it should get the job done.

Re-cloning seems to be the only way, b/c :

tfoerste@n22 ~/devel/boinc-v2 $ git checkout -f client_release/7/7.4
Branch client_release/7/7.4 set up to track remote branch client_release/7/7.4 from origin.
Switched to a new branch 'client_release/7/7.4'

tfoerste@n22 ~/devel/boinc-v2 $ git checkout -f master
Checking out files: 100% (234/234), done.
Switched to branch 'master'
Your branch is behind 'origin/master' by 7 commits, and can be fast-forwarded.
  (use "git pull" to update your local branch)

tfoerste@n22 ~/devel/boinc-v2 $ git pull
Updating ce97e85..d2e5582
error: Your local changes to the following files would be overwritten by merge:
...
<same picture as before>

-- 
Toralf
pgp key: 0076 E94E
