From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] git-publish
Date: Sun, 13 Aug 2006 12:34:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608131158500.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Aug 13 18:35:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCIvP-00049f-06
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 18:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWHMQev (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 12:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWHMQev
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 12:34:51 -0400
Received: from iabervon.org ([66.92.72.58]:32017 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751305AbWHMQeu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Aug 2006 12:34:50 -0400
Received: (qmail 20336 invoked by uid 1000); 13 Aug 2006 12:34:49 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Aug 2006 12:34:49 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25284>

Like how "pull" is "fetch" + "merge", I think it would be useful to have a 
"commit" + "push". I have the general feeling that this is more like what 
users of other version control systems expect to have happen, and it's 
easy, when working on a non-network-accessible workstation, to commit and 
forget to do anything with the commit before leaving. So I'm considering a 
"git-publish" which is the trivial "git commit $* && git push".

My suspicion is that most people who run commit directly and have a 
default push location tend to want to push after every commit (or, at 
least, be fine with that, and really want to have pushed after the last of 
a batch). (Of course, there are plenty of users who don't want to push so 
often, but I bet they either mostly generate commits with git apply, git 
am, or such, or they don't have a push line and publicize their changes 
with format-patch.)

Actually, I'm also curious as to how other people generate the series of 
commits for a patch series, when they've actually got a working directory 
that contains the end result. I doubt that people actually do their 
modifications in patch order, committing each time, without writing 
and testing the end result.

	-Daniel
*This .sig left intentionally blank*
