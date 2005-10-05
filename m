From: Junio C Hamano <junkio@cox.net>
Subject: Re: Confused as to the correct syntax
Date: Wed, 05 Oct 2005 16:16:01 -0700
Message-ID: <7v7jcrh7wu.fsf@assigned-by-dhcp.cox.net>
References: <200510052350.07217.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 01:16:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENIUa-0008Jk-03
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 01:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbVJEXQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 19:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbVJEXQE
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 19:16:04 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17046 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030426AbVJEXQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 19:16:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051005231603.TRMZ9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Oct 2005 19:16:03 -0400
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200510052350.07217.alan@chandlerfamily.org.uk> (Alan Chandler's
	message of "Wed, 5 Oct 2005 23:50:07 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9745>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> "A  suffix  ~<n>  to  a  revision parameter means the commit object that is 
> the <n>th generation grand-parent of the named commit object, following only 
> the first parent. I.e. rev~3 is equivalent to rev^ which is equivalent to 
> rev11^1."
>
> Why is rev~3 equivalent to rev^,  surely it is equivalent to rev^^^
>
> Why is rev~3 equivalent to rev11^1, should that not be rev^1^1^1

Sorry, for not knowing how to do that properly in Asciidoc ;-).

The source to the man page and HTML page reads like this:

* A suffix '~<n>' to a revision parameter means the commit
  object that is the <n>th generation grand-parent of the named
  commit object, following only the first parent.  I.e. rev~3 is
  equivalent to rev^^^ which is equivalent to rev^1^1^1.
