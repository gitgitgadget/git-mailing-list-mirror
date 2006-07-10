From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC+PATCH 1/1] Move SCM interoperability tools into scm/
Date: Sun, 09 Jul 2006 17:39:47 -0700
Message-ID: <7vsllae1ik.fsf@assigned-by-dhcp.cox.net>
References: <11524258261798-git-send-email-ryan@michonline.com>
	<46a038f90607091426u5a6ea328h2090a876e51725ce@mail.gmail.com>
	<20060709221326.GU29115@pasky.or.cz>
	<20060709222308.GA4153@h4x0r5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 02:39:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzjoW-0007KL-T0
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 02:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161283AbWGJAju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 20:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161284AbWGJAju
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 20:39:50 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:61824 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1161283AbWGJAjt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 20:39:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060710003948.FKOH6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Jul 2006 20:39:48 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060709222308.GA4153@h4x0r5.com> (Ryan Anderson's message of
	"Sun, 9 Jul 2006 15:23:09 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23579>

Ryan Anderson <ryan@michonline.com> writes:

> Comments on a way to make the Makefile less repetitive would be
> appreciated, though.

One obvious way would be not to have scm/Makefile but have the
dependencies in the main Makefile to say (the moral equivalent
of):

	git-archimport.perl: scm/git-archimport.perl
