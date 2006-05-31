From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fixed Cygwin CR-munging problem in mailsplit
Date: Tue, 30 May 2006 21:49:32 -0700
Message-ID: <7virnmyf1f.fsf@assigned-by-dhcp.cox.net>
References: <E124AAE027DA384D8B919F93E4D8C70801EFFB52@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 06:49:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlIeH-0007vT-Gl
	for gcvg-git@gmane.org; Wed, 31 May 2006 06:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWEaEte (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 00:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbWEaEte
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 00:49:34 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:9366 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751693AbWEaEte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 00:49:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060531044933.WXKS24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 31 May 2006 00:49:33 -0400
To: "Zakirov, Salikh" <salikh.zakirov@intel.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21056>

"Zakirov, Salikh" <salikh.zakirov@intel.com> writes:

> However, I believe that the command sequence git-format-patch, git-am
> without any e-mail transfer in between and in the same repository
> should work perfectly regardless of the contents of the files, 
> no matter if they are binary, text, or "CRLF text" or even 
> "broken LF and CRLF text". This is a requirement from a nasty "real
> world".

OK, that's a very valid argument.  Thanks for straighten me out.
