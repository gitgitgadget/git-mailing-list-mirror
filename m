From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Parametrize asciidoc and add --unsafe
Date: Tue, 24 Jan 2006 18:08:42 -0800
Message-ID: <7vzmll2h5h.fsf@assigned-by-dhcp.cox.net>
References: <1138140946.19065.2.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 03:09:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1a5h-00020P-Cr
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 03:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWAYCIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 21:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWAYCIy
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 21:08:54 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:19928 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750856AbWAYCIx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 21:08:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125020726.FDWK6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 Jan 2006 21:07:26 -0500
To: Pavel Roskin <proski@gnu.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15113>

Pavel Roskin <proski@gnu.org> writes:

> Including files from the parent directory is considered unsafe by
> asciidoc 7.1.0.  This is used in git.txt, which includes ../README.

Is copying/linking README down when we build documentation a
more conservative option, I wonder?

Does asciidoc prior to 7.1.0 do sensible thing given an --unsafe
option?  If not, how does one override ASCIIDOC from the command
line to the toplevel "make"?
