From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: My first git success
Date: 13 Jan 2006 10:57:04 -0800
Message-ID: <86y81kvtvj.fsf@blue.stonehenge.com>
References: <dq8epd$k28$1@sea.gmane.org>
	<Pine.LNX.4.64.0601130909290.3535@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 19:57:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExU7J-0006Vz-0t
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 19:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422826AbWAMS5L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 13:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422824AbWAMS5L
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 13:57:11 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:57709 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1422826AbWAMS5J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 13:57:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id A7A378F2CC;
	Fri, 13 Jan 2006 10:57:04 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 22769-01-31; Fri, 13 Jan 2006 10:57:04 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 3BF108F2F8; Fri, 13 Jan 2006 10:57:04 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
x-mayan-date: Long count = 12.19.12.17.6; tzolkin = 5 Cimi; haab = 4 Muan
In-Reply-To: <Pine.LNX.4.64.0601130909290.3535@g5.osdl.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14636>

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> I still hope the exchanges will result in more docs, or at least other 
Linus> lurkers on the list also learning a new trick or two..

I've also enjoyed a bit of success putting a website under git.  I started
working on AJAX-ing some of the code, but I needed to do maintainence on the
live site, so I've just simply done "git-checkout master" to work on that, and
"git-checkout ajax; git-pull . master" when I want to continue work on the
ajax upgrades.

However, before I bug-fix, I have to "snapshot" any working changes in the
ajax branch or I would lose them on "git-checkout master", which gives me
commits that look like "snapshot".  Am I doing that wrong?  Is there a better
way to do parallel development of a "live vs upgrade" branch, and make commits
only when I make progress?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
