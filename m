From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH 3] Copy description of build configuration variables to configure.ac
Date: Sun, 09 Jul 2006 01:21:38 -0700
Message-ID: <7virm7nq7h.fsf@assigned-by-dhcp.cox.net>
References: <200607030156.50455.jnareb@gmail.com>
	<1152392835436-git-send-email-jnareb@gmail.com>
	<11523928361444-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 10:22:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzUY9-0005BB-VR
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 10:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWGIIVm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 04:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWGIIVm
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 04:21:42 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:52472 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030431AbWGIIVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 04:21:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060709082140.FUYZ985.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Jul 2006 04:21:40 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23532>

Jakub Narebski <jnareb@gmail.com> writes:

> Copy description of build configuration variables from the commentary
> in the top Makefile (from 'next' branch) to configure.ac, splitting
> them into "autoconf" sections.

I do not see much point in this -- they will become out of sync.

Eventually when all the --with-* and --enable-* stuff are
implemented, you can ask the generated configure what options
are supported, so I do not think this would help the end user
either.  In other words it is strictly for supporting
developers.  I think you are better off making a list of
supported and yet to be supported ones in the comment in
configure.ac, and when you want to see if the list got stale
over time, grep for '^# Define' from the Makefile and match them
up.
