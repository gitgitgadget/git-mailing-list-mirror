From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Refactoring git-rebase.sh and git-rebase--interactive.sh
Date: Wed, 3 Nov 2010 04:24:32 +0100
Message-ID: <201011030424.33093.chriscool@tuxfamily.org>
References: <AANLkTimeWDbJPor9PnKgW5sD7DLjqrm-vTzEtnARvP3M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	christian.couder@gmail.com, trast@student.ethz.ch
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 04:24:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDTxz-0004f3-JB
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 04:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab0KCDYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 23:24:43 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:41519 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876Ab0KCDYm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 23:24:42 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 974A6A61C6;
	Wed,  3 Nov 2010 04:24:34 +0100 (CET)
User-Agent: KMail/1.13.2 (Linux/2.6.32-25-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <AANLkTimeWDbJPor9PnKgW5sD7DLjqrm-vTzEtnARvP3M@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160571>

On Tuesday 02 November 2010 13:33:07 Martin von Zweigbergk wrote:
> (Resending as plain text. Sorry about the spam to the guys on the CC list.)
> 
> Hi,
> 
> I have now been using Git for something like 18 months, and I think it's
> about time that I try to contribute.

Great!

> So, after adding some features to git-rebase.sh (which I will send
> separate mails about), I realized I would have to add them to
> git-rebase--interactive.sh as well. Rather than doing that, I would
> prefer to first extract the common parts of these scripts and add the
> features in only one place. Since this is the first time I do anything
> on Git, I will need a lot of advice.
> 
> My main goal is to extract the commonalities in command line parsing and
> interpretation as well as validation (of command line and repository
> state, and running the pre-rebase hook).
> 
> First of all, do you agree that this should be done and is now a good
> time to do it (I'm thinking mostly about conflicts with other ongoing
> efforts)? While at GitTogether, I talked briefly to Thomas Rast about
> doing this, and he mentioned that resurrecting the git sequencer might
> be a better idea. However, I *think* much of what I was thinking about
> doing involves code that is run before the git sequencer is called. I
> wouldn't mind working on the git sequencer afterwards, unless Christian
> Couder or someone else is currently working on it.

Now that GTAC (http://www.gtac.biz) is over, I plan to work on options 
--continue, --abort and --skip for git cherry-pick/revert. After that I hope 
to be able to refactor the code so that in the end common code is used by 
cherry-pick/revert and rebase.

And I agree that what you want to do does not conflict with my plan. On the 
contrary it might help in the end. Go for it!

Thanks,
Christian.
