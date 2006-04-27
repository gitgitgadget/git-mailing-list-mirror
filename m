From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: Two gitweb feature requests
Date: Thu, 27 Apr 2006 15:35:18 +0200
Message-ID: <E1FZ6eM-0000qC-HH@moooo.ath.cx>
References: <1146144425.11909.450.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 27 15:36:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZ6ei-00024h-Nl
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 15:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbWD0Nfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 09:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWD0Nfa
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 09:35:30 -0400
Received: from moooo.ath.cx ([85.116.203.178]:12262 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S965043AbWD0Nf3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 09:35:29 -0400
To: David Woodhouse <dwmw2@infradead.org>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1146144425.11909.450.camel@pmac.infradead.org>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19232>

> First... When publishing trees, I currently give both the git:// URL for
> people who want to pull the tree, and the http:// URL to gitweb for
> those who just want to browse.
> 
> It would be useful if I could get away with giving just one URL --
> probably the http:// one to gitweb. If gitweb were to have a mode in
> which it gave a referral to the git:// URL, and if the git tools would
> use that, then that would work well.

An easy way to do this is to put the git repository on the webserver
and tell the webserver to redirect to gitweb if the directory is
accessed directly, not a file in the git directory.
