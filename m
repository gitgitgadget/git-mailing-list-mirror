From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] user-manual: Use "git config --global" instead of editing ~/.gitconfig
Date: Thu, 10 May 2007 21:48:17 -0700
Message-ID: <7vejloezji.fsf@assigned-by-dhcp.cox.net>
References: <200705102353.31821.johan@herland.net>
	<20070510220253.GZ13719@fieldses.org>
	<20070510230045.GF4489@pasky.or.cz>
	<20070511034653.GB26896@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri May 11 06:48:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmN3L-0002IB-I2
	for gcvg-git@gmane.org; Fri, 11 May 2007 06:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbXEKEsU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 00:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbXEKEsT
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 00:48:19 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:63165 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbXEKEsT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 00:48:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511044819.VRNU1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 00:48:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xgoJ1W0031kojtg0000000; Fri, 11 May 2007 00:48:18 -0400
In-Reply-To: <20070511034653.GB26896@fieldses.org> (J. Bruce Fields's message
	of "Thu, 10 May 2007 23:46:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46936>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> So while I'm not convinced of the value of consistency here, if we have
> to have consistency, I'd rather standardize on config-file-editing.

I obviously agree with everything you said.

I do not think "consistency" should weigh too much in the
teaching and learning process, which is what a manual is about.
It is beneficial to make the readers aware, early in the
process, that there typically are more than one ways to do
things, one suitable for scripting and the other for interactive
use.  In the introductory part of the user-manual, I think it is
a very good idea to give a bit of glimpse of what is going on
under the hood, and config file is probably the easiest thing to
give that warm feeling of something they can understand is going
on to the readers.
