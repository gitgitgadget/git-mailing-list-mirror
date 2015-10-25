From: John Smith <johsmi9933@inbox.com>
Subject: Why are submodules not automatically handled by default or at
  least configurable to do so?
Date: Sun, 25 Oct 2015 15:10:07 -0800
Message-ID: <D4E5E890658.000004DCjohsmi9933@inbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 00:20:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqUan-00041x-Gi
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 00:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbbJYXU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 19:20:28 -0400
Received: from wm44.inbox.com ([64.135.83.44]:4324 "HELO WM44.inbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752185AbbJYXU1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2015 19:20:27 -0400
X-Greylist: delayed 618 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Oct 2015 19:20:27 EDT
Received: from inbox.com (127.0.0.1:25)
	by inbox.com with [InBox.Com SMTP Server]
	id <1510251510016.WM44> for <git@vger.kernel.org> from <johsmi9933@inbox.com>;
	Sun, 25 Oct 2015 15:10:07 -0800
DomainKey-Signature: q=dns; a=rsa-sha1; c=nofws;
 d=inbox.com; s=s1;
 h=mime-version:date:message-id:from:subject:to:content-type;
 b=mPFa3peJkkIPJE1ZzJnhxLS11JOXPYoHvdfqG0PSmOYnRFYCQoh2rloTDagu9/442GKC
 pvvawldONA+2y+HZ7j+NJmUJT6PLDI617hlLKnAk8xHV+VG0+COTzd7PQ5fM32q5+L9JRY
 DiJu1TKvLVWVF0InZZvSRtz3YkJRmZO6Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; q=dns/txt;
 d=inbox.com; s=s1;
 h=mime-version:date:message-id:subject:from:to:content-type;
 bh=4fos9kH48x6q8W+8k0U1GEEOrO7aQN4YYXtd9Uq7lfA=;
 b=qpAoINdLBhDsGJDA1QC8Oj8bXOAR19v66P6SzEXtaDGf/mMop1ynfrOvlcUR6W3/2ibC
 Kexv+JNeMEO0meVzthTbM0IYuFMFJCMdrhzJ+bIcbP3LY++simkbioXq7r+nx7BWtbg4TS
 dbQ2g0fNFKFB7IgX9bBLu7kd9pGDmoJJY=
X-Mailer: INBOX.COM
X-Originating-IP: 87.115.206.222
X-IWM-ACU: xpyIi19hUFjrJBQJpvn7QV9b_dFJIQNUsMvizu3FlQkA3uMHg6cXagxaC2M7
  eSYY33oYgNcqMu6lqXIyYsuQppcot-erdB4Z-I6QP5FUbCvxrebxR0k09rir
  7JpIpRN12jyEDuU3Eu8d6-Q@@
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280166>

I found that I use submodules much, much more often in my git projects than I used externals
in Subversion and the reason is that git encourages/forces to organize large projects into
smaller repositories, one reason for this being that subversion allows to check out parts of 
a repository while git does not.

But when I clone a git repository with subprojects, I (and everyone else) has to remember to
add the --recursive option. When switching between branches with different versions/commits of the 
submodules everyone has to remember to update the submodules. When updating a submodule 
everyone has to remember to recurse there too. 

Basically, everything with submodules has to be done manually every time and there seems 
to be no way to change that default.

Why is that? Basically all the time I use submodules I would want automatic handling of 
submodules to happen and I cannot  remember having had a single situation where I would 
not have wanted it to happen. So  why does git default to doing nothing? 
Why does it not provide a way to enable automatic
pulling/updating of submodules e.g. when cloning or switching branches?
When would people routinely check out a branch and want to stay with the submodules as 
the have been checked out for the old branch?

I honestly do not understand it. 

John

____________________________________________________________
Can't remember your password? Do you need a strong and secure password?
Use Password manager! It stores your passwords & protects your account.
Check it out at http://mysecurelogon.com/manager
