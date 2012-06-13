From: lancelyons <llyons2@cox.net>
Subject: Git rebase basics
Date: Wed, 13 Jun 2012 13:59:12 -0700 (PDT)
Message-ID: <1339621152946-7561468.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 22:59:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Seuet-000530-MU
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 22:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234Ab2FMU7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 16:59:14 -0400
Received: from sam.nabble.com ([216.139.236.26]:60056 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849Ab2FMU7N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 16:59:13 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <llyons2@cox.net>)
	id 1Seuem-0008Ip-V1
	for git@vger.kernel.org; Wed, 13 Jun 2012 13:59:12 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199944>

I am trying to learn git on my own.  I have setup our own server for git
using https and have cloned this repository and have done pushes and pulls
with no problem.

I am trying to learn more about rebase so i have cloned the central repo (I
call this origin)
and made changes to the cloned copy and pushed two commits to origin.

so I have the following.

origin -->  C1 --> C2

in my cloned copy which I consider a branch

I have made two more commits  C3 and C4

clone --> C3 -->  C4

I am able to easily pull from origin to get my clone to look like  clone -->
C3 --> C4 --> C1 --> C2

I was wanting to rebase the clone branch so that it shows    clone -> C1 -->
C2 --> C3 --> C4

I though the command to do this was   git rebase origin master but that
doesnt work.



Any ideas on what I am doing wrong?

thanks


--
View this message in context: http://git.661346.n2.nabble.com/Git-rebase-basics-tp7561468.html
Sent from the git mailing list archive at Nabble.com.
