From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Mon, 19 Jun 2006 00:34:17 -0700
Message-ID: <7vy7vta9ae.fsf@assigned-by-dhcp.cox.net>
References: <7vpsh75lx1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606181417090.26803@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060618130837.GN2609@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 09:34:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsEH7-0002wS-Ub
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 09:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWFSHeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 03:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWFSHeT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 03:34:19 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:23460 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932221AbWFSHeS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 03:34:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060619073418.SXAV23482.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Jun 2006 03:34:18 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22117>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Sun, Jun 18, 2006 at 02:26:14PM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
>
>> Note that this issue is orthogonal to the need for a user-specific config 
>> file. I still think that this one should go in.
>
> I agree as well.

OK, let's have it then.

Johannes, this makes your earlier ~/.gitconfig and --no-local
patches no longer applicable, so I'd drop them from "pu" for
now.  But I suspect we do want to have per user configuration
that is used as a fallback for per repo configuration, right?

I think we should mark what we have in "next" tonight, plus a
few others, as v1.4.1 sometime this coming week and continue
from there.
