From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] .gitignore git-rerere and config.mak
Date: Tue, 07 Feb 2006 10:20:54 -0800
Message-ID: <7vk6c7uj21.fsf@assigned-by-dhcp.cox.net>
References: <20060207172234.41A975BF02@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 19:23:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6XSV-0004Nz-GH
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 19:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWBGSU4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 13:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWBGSU4
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 13:20:56 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:13761 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751029AbWBGSU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 13:20:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060207181929.JIRV6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Feb 2006 13:19:29 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <20060207172234.41A975BF02@nox.op5.se> (Andreas Ericsson's
	message of "Tue, 7 Feb 2006 17:23:12 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15703>

Andreas Ericsson <ae@op5.se> writes:

> --- a/.gitignore
> +++ b/.gitignore
> @@ -123,3 +124,4 @@ git-core.spec
>  libgit.a
>  *.o
>  *.py[co]
> +config.mak

I am not sure about this part.  It is plausible that somebody
who privately uses config.mak has it in _his_ repository under
version control.  Should we list it in .gitignore?
