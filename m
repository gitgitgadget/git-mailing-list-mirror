From: kiranpyati <kiran.pyati@infobeans.com>
Subject: Sync production with Git
Date: Wed, 8 Aug 2012 06:11:24 -0700 (PDT)
Message-ID: <1344431484059-7564617.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 15:11:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz62s-0004gm-Kv
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 15:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758217Ab2HHNLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 09:11:25 -0400
Received: from sam.nabble.com ([216.139.236.26]:59068 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758065Ab2HHNLY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 09:11:24 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <kiran.pyati@infobeans.com>)
	id 1Sz62m-0000hY-2n
	for git@vger.kernel.org; Wed, 08 Aug 2012 06:11:24 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203091>

I am new to github,

Earlier we used to manually upload files on the production through FTP
although git was present on the production. Due to this now git status shows
many modified and untrack files.

To sync that with git we have downloaded all files from production and
committed to git. Now git has all files same as production.

We have not pulled on production since last 6 months and because of this it
shows modified and untracked files.

Now if we pull on the production there any 100% chances of the conflict
happened on all modified files. As there are hundreds of modified files
since last since month. Git pull will show conflict to all those files. In
that case site will get down and we can not afford this.

We want a way to seamlessly sync production and Git.

Can anybody please help me on this?

Thanks in advance..!!



--
View this message in context: http://git.661346.n2.nabble.com/Sync-production-with-Git-tp7564617.html
Sent from the git mailing list archive at Nabble.com.
