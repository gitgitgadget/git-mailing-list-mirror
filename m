From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 1/2] Avoid using the git wrapper in git-rebase.sh.
Date: Fri, 14 Jul 2006 18:10:48 +0200
Message-ID: <E1G1QFc-0006FY-KE@moooo.ath.cx>
References: <20060714044655.GA1982@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 18:12:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1QFt-0007xy-Df
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 18:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbWGNQKw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 12:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbWGNQKw
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 12:10:52 -0400
Received: from moooo.ath.cx ([85.116.203.178]:17556 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1161150AbWGNQKv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 12:10:51 -0400
To: Shawn Pearce <spearce@spearce.org>
Mail-Followup-To: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060714044655.GA1982@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23896>

Shawn Pearce <spearce@spearce.org> wrote:
> Ideally 'shipped' commands (e.g. git-rebase) should avoid calling
> the git wrapper when executing other commands to prevent the user
> from shadowing those commands with aliases and causing the shipped
> command behavior to differ unexpectedly.
How did you alias an existing command so that the alias gets executed?
That is what I get:
% git repo-config alias.am ls-tree
% GIT_TRACE=1 git am
trace: exec: '/home/matled/local/stow/git/bin/git-am'
