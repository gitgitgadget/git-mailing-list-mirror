From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Patch] Using 'perl' in *.sh
Date: Sat, 08 Jul 2006 11:27:37 -0700
Message-ID: <7v3bdcq7dy.fsf@assigned-by-dhcp.cox.net>
References: <200607081732.04273.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 20:27:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzHWo-0002BP-7M
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 20:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWGHS1j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 14:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWGHS1j
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 14:27:39 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:60297 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964938AbWGHS1i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jul 2006 14:27:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060708182738.QXXP6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Jul 2006 14:27:38 -0400
To: Michal Rokos <michal.rokos@nextsoft.cz>
In-Reply-To: <200607081732.04273.michal.rokos@nextsoft.cz> (Michal Rokos's
	message of "Sat, 8 Jul 2006 17:32:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23493>

Michal Rokos <michal.rokos@nextsoft.cz> writes:

> Hi,
>
> some GIT's shell script are using bare 'perl' for perl invocation. It's 
> causing me problems... I compile git with PERL_PATH set and I'd suggest to 
> use it everywhere.
>
> So @@PERL@@ would be replaced with PERL_PATH_SQ instead.
>
> What do you think?

Absolutely.

I think it was just sloppiness that we did not do so already.
Thanks.
