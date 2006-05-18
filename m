From: Junio C Hamano <junkio@cox.net>
Subject: Re: Shipping man pages?
Date: Thu, 18 May 2006 01:06:09 -0700
Message-ID: <7vac9f69la.fsf@assigned-by-dhcp.cox.net>
References: <20060518074630.GA2994@code-monkey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 10:06:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgdWS-0003Hf-Nz
	for gcvg-git@gmane.org; Thu, 18 May 2006 10:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWERIGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 04:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWERIGM
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 04:06:12 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:33711 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751168AbWERIGK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 04:06:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060518080610.FSBK27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 04:06:10 -0400
To: Tilman Sauerbeck <tilman@code-monkey.de>
In-Reply-To: <20060518074630.GA2994@code-monkey.de> (Tilman Sauerbeck's
	message of "Thu, 18 May 2006 09:46:32 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20271>

Tilman Sauerbeck <tilman@code-monkey.de> writes:

> atm, the git release tarballs don't contain man pages.

I ship *source* tarball.

I also happen to do RPM for people who do not want to build from
the source (btw, I do that from pure inertia). In addition,
preformatted manual pages and html docs are available from man
and html branches of the git.git repository.

If you are building from the source, please build from the
source.  Everything you need is right there.

If you don't build from the source, please use whatever binary
distribution available out there.  RPM happens to be available
from kernel.org.  If you are on Debian/Ubuntu/Gentoo/others,
please ask your distribution packager to include the manpages
and html docs, if they don't already.

Why does this have to come up so often, and everybody who asks
for them never supplies the patch to do so?

> Or maybe offer them in a separate tarball?

Things that are buildable from the source do not belong in the
source tarball.  If somebody wants to do this as a patch, I can
be talked into accepting it, but the build procedure should
build a separate tarball (or two; one for man and another for
woman^Whtml).
