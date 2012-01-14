From: Abscissa <bus_nabble_git@semitwist.com>
Subject: Re: SVN -> Git *but* with special changes
Date: Fri, 13 Jan 2012 19:43:13 -0800 (PST)
Message-ID: <1326512593140-7186699.post@n2.nabble.com>
References: <1325999031923-7163706.post@n2.nabble.com> <20120108051051.GA10129@sigill.intra.peff.net> <1325999865995-7163737.post@n2.nabble.com> <1326000327637-7163752.post@n2.nabble.com> <20120108103303.GC2714@centaur.lab.cmartin.tk> <m2hb06mpwn.fsf@linux-m68k.org> <20120108120807.GA7360@angband.pl> <1326061722334-7165979.post@n2.nabble.com> <1326065910362-7166084.post@n2.nabble.com> <1326405138283-7181897.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 04:43:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RluWX-0005Ee-Gs
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 04:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454Ab2ANDnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 22:43:16 -0500
Received: from sam.nabble.com ([216.139.236.26]:34364 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754315Ab2ANDnP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 22:43:15 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bus_nabble_git@semitwist.com>)
	id 1RluWP-0005UI-51
	for git@vger.kernel.org; Fri, 13 Jan 2012 19:43:13 -0800
In-Reply-To: <1326405138283-7181897.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188545>

Someone on a different message board noticed that it seemed like it was
trying to strip and already-stripped path in git-svn.perl, so I went in
there, changed the "die" to "print", and after a "make && sudo make install"
it seems to work fine now. Probably not the proper way to fix it, but it
seems to work for me.

It does now fail to delete directories once they actually *are* deleted in
the SVN repo, which is kinda sloppy, but it doesn't hurt anything, so I can
live with that.


--
View this message in context: http://git.661346.n2.nabble.com/SVN-Git-but-with-special-changes-tp6840904p7186699.html
Sent from the git mailing list archive at Nabble.com.
