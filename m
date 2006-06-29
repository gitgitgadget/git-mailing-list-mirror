From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow INSTALL, bindir, mandir to be set in main Makefile
Date: Thu, 29 Jun 2006 11:23:21 -0700
Message-ID: <7vy7vfrfc6.fsf@assigned-by-dhcp.cox.net>
References: <200606290301.51657.jnareb@gmail.com>
	<200606291536.18667.jnareb@gmail.com>
	<200606291704.27677.jnareb@gmail.com>
	<200606291835.53788.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 20:23:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw1Ao-0008CN-UD
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 20:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWF2SXX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 14:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWF2SXX
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 14:23:23 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:43227 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751243AbWF2SXW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 14:23:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629182322.OLUS12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 14:23:22 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22882>

Jakub Narebski <jnareb@gmail.com> writes:

> Part of autoconf series, but independent.

I'd like to take something like this, independently from
"optionally managing config.mak with autoconf" series.

> Should probably be split into two patches:
>  * first with export + '?='
>  * second renaming man1 and man7 to man1dir and man7dir

And I think it is probably a good idea to somehow keep people's
configurations that have been overriding man1 and man7 if
possible.  Otherwise things would regress for them.
