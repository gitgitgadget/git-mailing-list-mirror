From: Bill Lear <rael@zopyra.com>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 13:27:19 -0600
Message-ID: <17855.39959.848058.957592@lisa.zopyra.com>
References: <17855.35058.967318.546726@lisa.zopyra.com>
	<epo1tn$9sl$1@sea.gmane.org>
	<17855.35845.922009.364704@lisa.zopyra.com>
	<20070130182237.GC26415@spearce.org>
	<17855.36470.309129.391271@lisa.zopyra.com>
	<Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org>
	<17855.38543.761930.929267@lisa.zopyra.com>
	<20070130190907.GE26415@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 20:27:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBydo-00051e-Ew
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 20:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbXA3T11 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 14:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbXA3T11
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 14:27:27 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60275 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700AbXA3T10 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 14:27:26 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0UJRM303785;
	Tue, 30 Jan 2007 13:27:22 -0600
In-Reply-To: <20070130190907.GE26415@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38194>

On Tuesday, January 30, 2007 at 14:09:07 (-0500) Shawn O. Pearce writes:
>...
>You did not ask for a tracking branch to be created.  So the
>result of your fetch is in FETCH_HEAD only.  Try instead:
>
>GIT_DIR=. git fetch git://source/public/project topic:refs/heads/master

Ok, then when I clone this my master branch in my cloned repo will
actually be pointing to the topic branch of the remote repo?

[recreate dir, re-init, fetch as above, clone; now, cd into cloned repo]
% cd project
% git branch
* master
  origin

This makes me really nervous, like a nervousness-inducing cloaking
device would.  I'm not enough of a git master to just "use the force".
When I go into my cloned repo, I want to see "topic" for my branch
name, not master...

BTW, I note also that the clone seems to have taken GOBS more time
this time around.  Am I seeing things or would this be a result of the
fetch gymnastics above?


Bill
