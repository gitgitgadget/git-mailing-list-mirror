From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Tue, 20 Jun 2006 12:46:01 -0700
Message-ID: <7vpsh37gqu.fsf@assigned-by-dhcp.cox.net>
References: <e79921$u0e$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 21:46:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsmAp-0005aG-3C
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 21:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWFTTqE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 15:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWFTTqE
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 15:46:04 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:35816 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750764AbWFTTqD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 15:46:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060620194602.IUOP18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Jun 2006 15:46:02 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e79921$u0e$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
	20 Jun 2006 18:51:18 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22221>

Jakub Narebski <jnareb@gmail.com> writes:

> I am planning on copying features from xmms2's gitweb version 
> to git's gitweb, and introducing new ones.
>
> Which of those should be implemented first?

Clean-ups and obvious fixes without introducing new features
first please.

> * Add (of course optional, like blame support) snapshot support. There are
>   at least two different implementations. I'd prefer to do without second
>   CGI script, but perhaps this is better from the performance point of view.
>   gitweb-xmms2 has snapshot.cgi in Python: should it be rewritten in Perl?

Isn't it just the matter of spawning git-tar-tree?

> * gitweb-xmms2 has something called committags support: it means that
>   'BUG(n)', 'FEATURE(n)' and 'RELEASE: xx' in commit message are turned into
>   bugtracker (Mantis for xmms2) or wiki links. It is extension of turning
>   sha1-ids into references. Probably needs some extra configuration file,
>   and some per repository configuration. Of course we want to support not
>   only Mantis, but also e.g. Bugzilla (e.g. Linux kernel) and conventions
>   for marking bugs therein.

Yes, I found this quite nice.

BTW, are you in touch with xmms2 folks?
