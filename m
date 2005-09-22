From: Petr Baudis <pasky@suse.cz>
Subject: Re: command to show diff of a commit
Date: Thu, 22 Sep 2005 12:04:58 +0200
Message-ID: <20050922100458.GF21019@pasky.or.cz>
References: <72499e3b05092202583f9a751d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 12:06:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EINwu-0008D4-Az
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 12:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbVIVKFA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 06:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbVIVKFA
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 06:05:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5249 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751462AbVIVKFA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 06:05:00 -0400
Received: (qmail 30436 invoked by uid 2001); 22 Sep 2005 12:04:58 +0200
To: Robert Watson <robert.oo.watson@gmail.com>
Content-Disposition: inline
In-Reply-To: <72499e3b05092202583f9a751d@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9105>

Dear diary, on Thu, Sep 22, 2005 at 11:58:32AM CEST, I got a letter
where Robert Watson <robert.oo.watson@gmail.com> told me that...
> Hi,

Hi,

> I am wondering what is the best way to show the change introduced by a
> commit. In the other words, is there a better way to do this:
> 
> git-diff b163512d4eb36ee946908b682c7863658c5a8db4^
> b163512d4eb36ee946908b682c7863658c5a8db4

with Cogito, you would say

	cg-diff -p -r b163512d4eb36ee946908b682c7863658c5a8db4

to see the diff against its parent. (You should still choose the parent
manually in case of merge commits.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
