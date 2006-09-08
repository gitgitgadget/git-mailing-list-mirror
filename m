From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Thu, 07 Sep 2006 18:16:11 -0700
Message-ID: <7vzmdbp38k.fsf@assigned-by-dhcp.cox.net>
References: <200609021817.09296.jnareb@gmail.com> <edqeco$ums$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 03:16:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLUyP-0004X5-LH
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 03:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbWIHBPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 21:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbWIHBPz
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 21:15:55 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:54777 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1752021AbWIHBPy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 21:15:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060908011554.FBMT26416.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 21:15:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KdFl1V0071kojtg0000000
	Thu, 07 Sep 2006 21:15:46 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <edqeco$ums$1@sea.gmane.org> (Jakub Narebski's message of "Fri,
	08 Sep 2006 02:44:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26671>

Jakub Narebski <jnareb@gmail.com> writes:

> I have very preliminary work, where gitweb uses @enabled_committags as list
> of committags to use, and %committags_info for actual committags info.
> Examples of committags includes current linking of commit sha1,
> gitweb-xmms2 linking of BUG(n) and FEATURE(n) to site-wide based URL
> (Mantis), and RELEASE x.y.z to site-wide based URL (Wiki); perhaps "bug n"
> to site-wide/project-wide URL (Bugzilla)... any other ideas?

Use a regexp as %committags key and its value to be whatever
that takes the matched string and munge it into a URL form
perhaps?  A site that does not have commit tags do not have any
element in that hash.
