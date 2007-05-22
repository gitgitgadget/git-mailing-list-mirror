From: Petr Baudis <pasky@ucw.cz>
Subject: StGIT unhelpfulness
Date: Tue, 22 May 2007 13:16:03 +0200
Message-ID: <20070522111603.GH4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 13:16:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqSLZ-0006uV-96
	for gcvg-git@gmane.org; Tue, 22 May 2007 13:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758485AbXEVLQG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 07:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758790AbXEVLQG
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 07:16:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34235 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758485AbXEVLQF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 07:16:05 -0400
Received: (qmail 21680 invoked by uid 2001); 22 May 2007 13:16:03 +0200
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48093>

  Hi,

  I tried to stg pull to my git repository at repo.or.cz, but stg pull
only laconically announced

	stg pull: Rebasing would possibly lose data

and left me with a confused stare. The same with popping all the patches
first, so there is actually nothing _to_ rebase, but it still fails.

  Five minutes of peeking at the stgit code later, I think this is
because I sometimes do stg pull (now) and sometimes stg pop -a, cg
update, stg push -a when I'm feeling nostalgic. orig-base doesn't get
updated and stgit gets unhappy, but frankly, I don't even get _why_ does
it need to record and check orig-base - how does it matter?

  Besides, when it doesn't like it, it should give me some more helpful
error message than just the cryptic above...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
