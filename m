From: Petr Baudis <pasky@suse.cz>
Subject: Re: Perl gurus: why do we need Scalar::Util?
Date: Mon, 10 Jul 2006 16:29:16 +0200
Message-ID: <20060710142916.GX29115@pasky.or.cz>
References: <Pine.LNX.4.63.0607101343060.29667@wbgn013.biozentrum.uni-wuerzburg.de> <86k66lsi5q.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 16:30:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzwlI-0008An-Ha
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 16:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbWGJO3S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 10:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422636AbWGJO3S
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 10:29:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10914 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422635AbWGJO3S (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 10:29:18 -0400
Received: (qmail 16811 invoked by uid 2001); 10 Jul 2006 16:29:16 +0200
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86k66lsi5q.fsf@blue.stonehenge.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23623>

Dear diary, on Mon, Jul 10, 2006 at 03:28:49PM CEST, I got a letter
where "Randal L. Schwartz" <merlyn@stonehenge.com> said that...
> While that syntax looks like it would make things easier in theory, in
> practice it is a source of leak-after-leak because it creates a closure for
> the two blocks, and that can easily lead to a circular reference for
> long-running tools.

Care to elaborate, please? All I've found are several mentions that the
problem is there, but not what the problem actually is and it doesn't
occur to me why is it a problem.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
