From: Bill Lear <rael@zopyra.com>
Subject: Re: Dangers of working on a tracking branch
Date: Thu, 15 Feb 2007 15:33:10 -0600
Message-ID: <17876.53654.426022.454712@lisa.zopyra.com>
References: <17876.51013.561979.431717@lisa.zopyra.com>
	<Pine.LNX.4.64.0702151557410.1757@xanadu.home>
	<17876.52962.662946.582507@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 22:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHoEo-0004Gj-RY
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 22:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161404AbXBOVdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 16:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161413AbXBOVdM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 16:33:12 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60407 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161405AbXBOVdL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 16:33:11 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1FLXAY12609;
	Thu, 15 Feb 2007 15:33:10 -0600
In-Reply-To: <17876.52962.662946.582507@lisa.zopyra.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39851>

On Thursday, February 15, 2007 at 15:21:38 (-0600) Bill Lear writes:
>On Thursday, February 15, 2007 at 16:00:23 (-0500) Nicolas Pitre writes:
>>On Thu, 15 Feb 2007, Bill Lear wrote:
>>
>>> We are about to switch to git 1.5 from git 1.4.4.1.  I cannot remember
>>> if someone posted about this, but what is the danger of working on a
>>> tracking branch --- there are abundant cautions about doing this, but
>>> I can't recall and can't find the reason this is bad.
>>
>>A tracking branch is supposed to be a local mirror of what is available 
>>remotely.  If you commit local changes to it then you break that model.
>
>Ok, so I break the model, what is the harm in that?  Can I no longer
>pull from or push to the remote branch?  Do I corrupt something
>locally?  Does something else break?  I'm trying to formulate an
>explanation to our users why the 1.5 way is superior and I can't just
>say "if you do that you break the model".

BTW, my ignorant assumption is that for merging to take place, git
requires two branches, so 'git pull' will fetch into the tracking
branch and then merge onto your ... uh ... whatever the name of the
working version of your tracking branch is.

BTW, again, why does git clone not have an option to just create all
of the "working versions" (better name needed) of tracking branches?


Bill
