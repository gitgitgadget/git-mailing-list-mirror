From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Tue, 01 Aug 2006 15:15:17 -0700
Message-ID: <7vfygg14sq.fsf@assigned-by-dhcp.cox.net>
References: <20060801211948.99497.qmail@web31804.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 00:15:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G82WN-0000C5-IC
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 00:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWHAWPX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 18:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWHAWPW
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 18:15:22 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:11007 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751199AbWHAWPT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 18:15:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060801221518.SZCQ25430.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Aug 2006 18:15:18 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060801211948.99497.qmail@web31804.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Tue, 1 Aug 2006 14:19:48 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24613>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Copy "Gitweb_customization.pm" to where your "gitweb.cgi" or
> its link lives.

I do not think this is a good idea -- there may not be any harm
done when http://site/cgi-bin/Gitweb_customization.pm is
accessed, but this _does_ pollute the cgi-bin/ namespace.
