From: deanhiller <dhiller@ghx.com>
Subject: Re: the standard hotfix from production scenario not working for me
 in git...
Date: Thu, 28 Jul 2011 12:25:45 -0700 (PDT)
Message-ID: <1311881145388-6631009.post@n2.nabble.com>
References: <1311874508381-6630648.post@n2.nabble.com> <4E31B51D.2080208@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 21:25:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmWDP-0007mD-J0
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 21:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab1G1TZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 15:25:47 -0400
Received: from sam.nabble.com ([216.139.236.26]:54081 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755515Ab1G1TZq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 15:25:46 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <dhiller@ghx.com>)
	id 1QmWDJ-0002Fl-Dp
	for git@vger.kernel.org; Thu, 28 Jul 2011 12:25:45 -0700
In-Reply-To: <4E31B51D.2080208@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178108>

/Can you just do 'git checkout -b newHitfix145 master' ?/

Coooooool, one less step!!!!! I think I remember reading that at somepoint,
but forgot about it.

/0. Would it help to use 'git status' to make sure that you don't have 
untracked flies kicking around?/

Not really, I know that I have untracked files lying around(and frequently
do git status currently anyways)

/Personally I would try to avoid having untracked files around, but maybe 
that's just me.  I usually find I only have a few untracked files at any
given time 
(after all, how fast can most people create new code?) so just keeping 
them tracked isn't a problem. Then 'git commit -a' will do the right 
thing won't it?/

On a prototype project, the rate of file creation is pretty high so I
frequently have untracked files....and I 99% of the time never have an
untracked file that I won't be checking in eventually(excluding the
.gitignore files of course), so having to do a specific step with them is
quite annoying.

Also, having to rm each file is "very" annoying...anyway to just do a git
commit ALL(which includes untracked files(except for .gitignore specified
ones), deleted files, modified files...I think that is the whole list).  

If I could do a git commit ALL, and then when I get back to that branch,
maybe there is a way to do a git reset HEAD BUT restore the committed files
to the filesystem as untracked/unstaged, etc. etc????

Today, I just copied the whole repository since I was having so much trouble
so then it is easier to do what I want, but the fact that I have to do that
feels like I am back in svn again where I did that as well so I would just
switch between directories when working on a hotfix...feels like there
should be a way in git as I thought git was avoiding that situation.

thanks,
Dean

Luke
--
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
View this message in context: http://git.661346.n2.nabble.com/the-standard-hotfix-from-production-scenario-not-working-for-me-in-git-tp6630648p6631009.html
Sent from the git mailing list archive at Nabble.com.
