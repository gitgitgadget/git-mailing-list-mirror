From: Johannes Schneider <mailings@cedarsoft.com>
Subject: Commit to other branch
Date: Mon, 31 May 2010 17:46:09 +0200
Message-ID: <4C03D9C1.1060404@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 31 18:12:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ7bI-0004va-2G
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 18:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756489Ab0EaQMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 12:12:22 -0400
Received: from hosting.cedarsoft.com ([188.40.238.168]:35837 "EHLO
	cedarsoft.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756183Ab0EaQMW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 12:12:22 -0400
X-Greylist: delayed 1571 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 May 2010 12:12:21 EDT
Received: from [192.168.0.36] (HSI-KBW-109-193-057-134.hsi7.kabel-badenwuerttemberg.de [109.193.57.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by cedarsoft.eu (Postfix) with ESMTP id 6733412E6002
	for <git@vger.kernel.org>; Mon, 31 May 2010 17:48:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Lightning/1.0b2pre Thunderbird/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148049>

Hi guys,

I often run in that scenario:
I see a small bugfix/typo/missing documentation. Of course I just add a
bit of code to fix that issue...
Then I'd like to commit that change as own commit. And most of the time
this is possible without any problems (git commit <file>).
But as I am *always* working on a topic branch, it takes some work to
commit that change to another branch.

I tried to "git stash "
But then *all* changes are stashed (including my changes)...

So at the moment I do that:

git commit <file> (on wrong branch)
git stash
git checkout pu
git cherry-pick
git checkout my-topic
git reset --hard
git stash apply

And that is much to much work. I just want to do something like that:

git commit <file> -b pu

But I don't think that is possible at the moment... Any hints, how I
could solve that? How do you do that?


Thanks,

Johannes

-- 
Johannes Schneider - blog.cedarsoft.com
