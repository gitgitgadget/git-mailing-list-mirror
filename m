From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Minor clarifications in diffcore documentation
Date: Fri, 28 Oct 2005 22:15:41 -0700
Message-ID: <7v64rg3nuq.fsf@assigned-by-dhcp.cox.net>
References: <E1EVi8D-0002TT-Ik@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 07:17:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVj4O-0003lW-4s
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 07:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVJ2FPo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 01:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVJ2FPn
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 01:15:43 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:40153 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751324AbVJ2FPn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 01:15:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029051457.NHWE2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Oct 2005 01:14:57 -0400
To: c.shoemaker@cox.net
In-Reply-To: <E1EVi8D-0002TT-Ik@localhost> (c. shoemaker's message of "Sat, 29
	Oct 2005 00:15:49 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10795>

c.shoemaker@cox.net writes:

>  ------------------------------------------------
>  :100644 100644 0123456... 1234567... M fileY
> -:000000 100644 0000000... 0123456... A file0
> +:000000 100644 0000000... bcd3456... A file0
>  ------------------------------------------------
>  
>  the original contents of fileY and the resulting contents of
> @@ -154,14 +165,14 @@ changed to:
>  
>  ------------------------------------------------
>  :100644 100644 0123456... 1234567... M fileY
> -:100644 100644 0123456... 0123456... C100 fileY file0
> +:100644 100644 0123456... bcd3456... C100 fileY file0
>  ------------------------------------------------


I think with this change you wanted to say that a copy does not
have to be a literal copy but a copy-edit.  But if that is the
case, I suspect that the similarity index would be slightly less
than 100.

If I misunderstood the reason of this change please let me know.

All patches, including this one, look fine to me.  Thanks.
