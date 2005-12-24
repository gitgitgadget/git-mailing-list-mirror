From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] qgit: allow overriding CCFLAGS
Date: Sat, 24 Dec 2005 00:14:31 -0800
Message-ID: <7vu0cy3o9k.fsf@assigned-by-dhcp.cox.net>
References: <1135380226.18431.21.camel@dv> <43ACE80A.4070600@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 24 09:14:37 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eq4Y1-0003Rc-BR
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 09:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbVLXIOe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 03:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbVLXIOd
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 03:14:33 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:17399 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1422637AbVLXIOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 03:14:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051224081335.MFGS6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Dec 2005 03:13:35 -0500
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <43ACE80A.4070600@yahoo.it> (Marco Costalba's message of "Sat, 24
	Dec 2005 07:17:46 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14008>

Marco Costalba <mcostalba@yahoo.it> writes:

> Thanks for the patch.
>
> I had a git error while  applying:
> $ git-am -k -u --3way /home/marco/tmp/ccflags.txt
> tried to convert from latin-1 to ISO-8859-15, but your iconv does not work with it.
>
> It's more of a warning then en erorr because the process goes on an the patch 
> applies.

Yes, and that warning is coming from a stupid typo.  mailinfo.c
should say "latin1", not "latin-1".  The fix will be in 1.0.4,
which I am preparing right now.
