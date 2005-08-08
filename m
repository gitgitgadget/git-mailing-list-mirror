From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Making CFLAGS compilant with GNU Coding Standards
Date: Mon, 08 Aug 2005 13:53:24 -0700
Message-ID: <7vy87c2lrv.fsf@assigned-by-dhcp.cox.net>
References: <1123306575.7588.17.camel@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 22:54:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Ecl-0007iu-0F
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 22:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVHHUx1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 16:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVHHUx1
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 16:53:27 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:22675 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932220AbVHHUx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 16:53:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050808205326.FRIH3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 16:53:26 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1123306575.7588.17.camel@dv.roinet.com> (Pavel Roskin's message
	of "Sat, 06 Aug 2005 01:36:15 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pavel Roskin <proski@gnu.org> writes:

> Quoting GNU Coding Standards ("info standards"):
>
> "If there are C compiler options that _must_ be used for proper
> compilation of certain files, do not include them in `CFLAGS'.  Users
> expect to be able to specify `CFLAGS' freely themselves."

Quoting Documentation/CodingStyle:

    This is a short document describing the preferred coding style for the
    linux kernel.  Coding style is very personal, and I won't _force_ my
    views on anybody, but this is what goes for anything that I have to be
    able to maintain, and I'd prefer it for most other things too.  Please
    at least consider the points made here.

    First off, I'd suggest printing out a copy of the GNU coding
    standards, and NOT read it.  Burn them, it's a great symbolic
    gesture.

This was only a tongue-in-cheek comment ;-).

Seriously, I do not intend to discarded this patch, but I am
currently not taking Makefile patches unless they fix real
breakage.

I do want to revisit Makefile issues after 0.99.4, along with
the changes Pasky sent several days ago.  Please remind me about
them after Wednesday.
