From: Junio C Hamano <junkio@cox.net>
Subject: Re: disable the compile-flags-changed check
Date: Thu, 13 Jul 2006 23:06:04 -0700
Message-ID: <7v7j2gsotv.fsf@assigned-by-dhcp.cox.net>
References: <E1G1GVy-00007o-PM@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 08:06:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1GoW-0002lA-8C
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 08:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161272AbWGNGGH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 02:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161273AbWGNGGH
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 02:06:07 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:53453 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1161272AbWGNGGG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 02:06:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060714060605.QWIY8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Jul 2006 02:06:05 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G1GVy-00007o-PM@moooo.ath.cx> (Matthias Lederhofer's message
	of "Fri, 14 Jul 2006 07:47:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23878>

Matthias Lederhofer <matled@gmx.net> writes:

> Is there any way to disable the "the compile flags have changed,
> recompile everything" check?  I want to built with another prefix than
> installing to create a tarball I copy to other machines.  Is there any
> way to do this?

Perhaps

	DESTDIR=/var/tmp/ make prefix=/usr install

is what you are looking for?
