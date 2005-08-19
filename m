From: Johnny Stenback <jst@jstenback.com>
Subject: git commit (or git-commit-script) question
Date: Fri, 19 Aug 2005 10:06:36 -0700
Message-ID: <4306119C.8000600@jstenback.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 19 19:08:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6AKV-00011G-BQ
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 19:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbVHSRGw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 13:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbVHSRGu
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 13:06:50 -0400
Received: from pippin.dreamhost.com ([66.33.211.27]:17134 "EHLO
	pippin.dreamhost.com") by vger.kernel.org with ESMTP
	id S932683AbVHSRGt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 13:06:49 -0400
Received: from [192.168.0.100] (dpc674551026.direcpc.com [67.45.51.26])
	by pippin.dreamhost.com (Postfix) with ESMTP id 809A016D2B3
	for <git@vger.kernel.org>; Fri, 19 Aug 2005 10:06:41 -0700 (PDT)
User-Agent: Mail/News 1.6a1 (X11/20050816)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hey all,

git-commit-script --help says:

git commit [-a]  [-m <message>] [-F <logfile>] [(-C|-c) <commit>] 
[<path>...]

That made me assume that if I do:

   git-commit-script somedir

it would *only* commit the changes I've made in "somedir", but it 
appears to commit *all* files that have changed (and shows all files in 
the list of changed files in the commit message it displays in the 
editor), as if it's completely ignoring the <path> argument.

Known problem? I got this using git that I pulled from kernel.org 
earlier this morning.

-- 
jst
