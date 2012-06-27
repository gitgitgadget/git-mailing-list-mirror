From: salmanmanekia <salmanmanekia@gmail.com>
Subject: Failed to lock refs/heads/master
Date: Wed, 27 Jun 2012 09:24:51 -0700 (PDT)
Message-ID: <1340814291538-7562253.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 18:25:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjv32-0005xf-4m
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 18:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814Ab2F0QYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 12:24:52 -0400
Received: from sam.nabble.com ([216.139.236.26]:42258 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520Ab2F0QYv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 12:24:51 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <salmanmanekia@gmail.com>)
	id 1Sjv2x-00044a-I0
	for git@vger.kernel.org; Wed, 27 Jun 2012 09:24:51 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200728>

I am relativly new to git and am facing this problem. The git push command
shows the error below. I will explain to you from the begining what i had
been trying to do . I created a submodule, commited and pushed it. The push
throws the error below.

http://git.661346.n2.nabble.com/file/n7562253/Git_Problem.png 

After that i tried some solutions but none of them worked. I will also
explain breifly what i have been trying

1 : From the bitbucket repo i noticed there are some danggling commits (the
red arrow in picture 2) so i gave the following commands to solve that git
gc and git prune.

2: I also tried commands like git revert HEAD and git push origin HEAD
--force but none seem to worked..

http://git.661346.n2.nabble.com/file/n7562253/Git_Problem_2.png 

--
View this message in context: http://git.661346.n2.nabble.com/Failed-to-lock-refs-heads-master-tp7562253.html
Sent from the git mailing list archive at Nabble.com.
