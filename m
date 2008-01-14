From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Mon, 14 Jan 2008 03:14:08 +0300
Message-ID: <20080114001408.GV2963@dpotapov.dyndns.org>
References: <200712101357.49325.jnareb@gmail.com> <200801071057.27710.shlomif@iglu.org.il> <200801130144.14574.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shlomi Fish <shlomif@iglu.org.il>, git@vger.kernel.org,
	Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	David Kastrup <dak@gnu.org>, Florian Weimer <fw@deneb.enyo.de>,
	Chris Shoemaker <c.shoemaker@cox.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 01:14:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JECyP-0000cz-Ga
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 01:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbYANAOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 19:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754651AbYANAON
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 19:14:13 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:51557 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920AbYANAOM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 19:14:12 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id 5C837187105F;
	Mon, 14 Jan 2008 03:14:09 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-140-170-195.pppoe.mtu-net.ru [85.140.170.195])
	by smtp03.mtu.ru (Postfix) with ESMTP id 6620B1871058;
	Mon, 14 Jan 2008 03:14:08 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JECxs-0004eM-7x; Mon, 14 Jan 2008 03:14:08 +0300
Content-Disposition: inline
In-Reply-To: <200801130144.14574.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70427>

On Sun, Jan 13, 2008 at 01:44:10AM +0100, Jakub Narebski wrote:
> 
> What does "Renames Support" mean? 

Accordingly to the clarification provided there, it means retaining the
history of the file when its name changed. So I would write like this:

Yes. Git can automatically detects renames and show history together,
however being content oriented rather than file oriented, the notion of
"retaining the history of the file" can not exactly applied to it.

> Because the answer,
> especially in the case of git which is a bit different in that it does
> rename detection and not rename tracking (using inodes / file-ids),
> depends on that...

Git is different in that it tracks the content as the whole rather than
tracking a set of files. When you look at some source code, what you
really want to know who and why wrote *this*, and usually it does not
matter to you whether it was written in this file or another one. CVS
is really bad at that, because if you renamed a file, it would be very
difficult to go back to history and find that. Many file-ids based SCMs
have solved this problem, however, they do not do any better than CVS
in another very common case -- when your code is moved around as result
of refactoring, but Git addresses both problems, not just one!

So, it is not as much about explicit renaming vs automatic, but about
different design goals. After finishing reading this questionnaire,
it seems to me that a more proper title for it would be "Better CVS
Initiative", so it is not surprisingly that Git does not fit into it
well. It is like trying to put characteristics of your LCD into a
questionnaire for CRT monitors -- some does not make sense, other
misleading, and most important ones are not mentioned anyway...


Dmitry
