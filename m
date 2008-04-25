From: Bill Lear <rael@zopyra.com>
Subject: Re: Branch "ahead of tracked remote branch"
Date: Fri, 25 Apr 2008 11:39:40 -0500
Message-ID: <18450.2380.655635.387709@lisa.zopyra.com>
References: <18449.15334.88706.45152@lisa.zopyra.com>
	<alpine.LNX.1.00.0804242349460.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Apr 25 18:40:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpQyU-00072X-AH
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 18:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763649AbYDYQjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 12:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758830AbYDYQjs
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 12:39:48 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60171 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763432AbYDYQjq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 12:39:46 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m3PGdit22075;
	Fri, 25 Apr 2008 10:39:44 -0600
In-Reply-To: <alpine.LNX.1.00.0804242349460.19665@iabervon.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80339>

On Thursday, April 24, 2008 at 23:59:44 (-0400) Daniel Barkalow writes:
>On Thu, 24 Apr 2008, Bill Lear wrote:
>
>> I had some work in master, I decided to move to a branch to complete,
>> so:
>> 
>> % git checkout -b branch
>> % git commit -a -m "Insightful message"
>> 
>> Then, I decided this was not such a good idea, so I did a git reset
>> --soft HEAD^, then git reset HEAD for each file I committed, thinking
>> that this was a complete "undo".  I then switched to branch master
>> and got this:
>> 
>> Switched to branch "master"
>> Your branch is ahead of the tracked remote branch 'origin/master' by 1 commit.
>> 
>> I'm not sure this is accurate.  Does this seem correct?
>
>It's certainly possible. It looks like you committed once on your own 
>master branch before you did any of the things mentioned in this message. 
>Then you created a new branch, made a commit on it, undid the commit, and 
>switched back to "master". "git log origin/master..master" will show you 
>the 1 commit that you have on master.

Ah, ok, now I think I understand --- if I do a fetch (or pull) on
master, switch over to the other branch, and then back, I see no such
message.  Thanks.


Bill
