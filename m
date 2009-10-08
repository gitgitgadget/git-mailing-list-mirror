From: =?UTF-8?Q?Daniel?= <mjucde@o2.pl>
Subject: =?UTF-8?Q?git_log_-S_not_finding_all_commits=3F?=
Date: Thu, 08 Oct 2009 10:21:09 +0200
Message-ID: <7ae12651.522df17b.4acda0f5.21a31@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 10:23:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvoHe-0002Mj-4o
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 10:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847AbZJHIVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 04:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755793AbZJHIVv
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 04:21:51 -0400
Received: from mailout1.go2.pl ([193.17.41.11]:38245 "EHLO mailout1.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755379AbZJHIVr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2009 04:21:47 -0400
Received: from mailout1.go2.pl (unknown [10.0.0.105])
	by mailout1.go2.pl (Postfix) with ESMTP id 3F40E5F0006
	for <git@vger.kernel.org>; Thu,  8 Oct 2009 10:21:10 +0200 (CEST)
Received: from o2.pl (unknown [10.0.0.76])
	by mailout1.go2.pl (Postfix) with SMTP
	for <git@vger.kernel.org>; Thu,  8 Oct 2009 10:21:10 +0200 (CEST)
X-Originator: 153.19.128.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129683>

Hi,

I did:

$ git version
git version 1.6.4.4
$ mkdir a && cd a && git init
$ echo "Free data" > a
$ git add a
$ git commit -m1
$ echo "Free data allocated by other function" > a
$ git commit -a -m2
$ PAGER=cat git log -S'Free' --oneline
2f34241 1

I would expect "git log" to show both 1 and 2 commit, but it prints only 1.

Is it the correct behavior?

-- 
Daniel
