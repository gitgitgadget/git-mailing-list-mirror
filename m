From: Junio C Hamano <junkio@cox.net>
Subject: Re: Hard-linked trees with git?
Date: Tue, 18 Oct 2005 13:52:18 -0700
Message-ID: <7vpsq2pmyl.fsf@assigned-by-dhcp.cox.net>
References: <m3vezufujo.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 22:52:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERyRb-0007Vm-JE
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 22:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVJRUwU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 16:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbVJRUwU
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 16:52:20 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:41444 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932098AbVJRUwU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 16:52:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051018205147.GGRI24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Oct 2005 16:51:47 -0400
To: Krzysztof Halasa <khc@pm.waw.pl>
In-Reply-To: <m3vezufujo.fsf@defiant.localdomain> (Krzysztof Halasa's message
	of "Tue, 18 Oct 2005 22:18:35 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10231>

Krzysztof Halasa <khc@pm.waw.pl> writes:

> Or: is it possible to have some constant file timestamps, so that
> changing the HEAD to something and returning to the old HEAD
> (say, with hard resets) restores the old timestamps?

That would screw up 'make'.
