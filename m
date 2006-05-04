From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Add a few more words to the glossary.
Date: Wed, 03 May 2006 22:58:01 -0700
Message-ID: <7vu0868h7a.fsf@assigned-by-dhcp.cox.net>
References: <E1FbVJi-0004UJ-59@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 07:58:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbWrE-0001SD-Vl
	for gcvg-git@gmane.org; Thu, 04 May 2006 07:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWEDF6E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 01:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWEDF6E
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 01:58:04 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:34204 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751266AbWEDF6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 01:58:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060504055802.ZJNG9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 May 2006 01:58:02 -0400
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1FbVJi-0004UJ-59@jdl.com> (Jon Loeliger's message of "Wed, 03
	May 2006 23:19:54 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19553>

Jon Loeliger <jdl@jdl.com> writes:

>  ref::
> -	A 40-byte hex representation of a SHA1 pointing to a particular
> -	object. These may be stored in `$GIT_DIR/refs/`.
> +	A 40-byte hex representation of a SHA1 or a name that denotes
> +	a particular object. These may be stored in `$GIT_DIR/refs/`.
>  
> +symbolic ref::
> +	See "ref".

Uum.  Not very clear.  Do we use that word that often?

I think I used that term to differenciate between HEAD symlink
pointing at refs/heads/master and HEAD being a regular file that
stores a line "ref: refs/heads/master\n"; the latter is the
modern style "textual symref", so in that context it is not
about 40-byte hex at all.  And at that level it is really a
jargon to talk about one small implementation detail of HEAD, so
I am not sure it deserves to be in the glossary.

>  tracking branch::
> -	A regular git branch that is used to follow changes from
> +	A regular git branch that is used to follow changes frompointing
>  	another repository.  A tracking branch should not contain

I think this is a typo?
