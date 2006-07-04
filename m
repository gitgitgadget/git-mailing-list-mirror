From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fetch per-repository speed issues
Date: Tue, 04 Jul 2006 10:45:36 -0700
Message-ID: <7vk66tgt6n.fsf@assigned-by-dhcp.cox.net>
References: <1151949764.4723.51.camel@neko.keithp.com>
	<e8e28j$v8v$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 04 19:46:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxoxx-00053Z-ET
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 19:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWGDRpi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 13:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWGDRpi
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 13:45:38 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:24501 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932251AbWGDRph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 13:45:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704174537.NZJB12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 13:45:37 -0400
To: git@vger.kernel.org
In-Reply-To: <e8e28j$v8v$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
	04 Jul 2006 17:42:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23304>

Jakub Narebski <jnareb@gmail.com> writes:

> I wonder if the problem detected here is also responsible with results 
> of Jeremy Blosser benchmark comparing git with Mercurial
> http://lists.ibiblio.org/pipermail/sm-discuss/2006-May/014586.html
> where git wins for clone, status and log, but is slower for pull.

I had an impression, though the report does not talk about this
specific detail, that the extra time we are paying is because
the "git pull" test is done without suppressing the final
diffstat phase.
