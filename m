From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Rename safe_strncpy() to strlcpy().
Date: Sat, 24 Jun 2006 22:29:30 -0700
Message-ID: <7vd5cxzttx.fsf@assigned-by-dhcp.cox.net>
References: <20060624140124.GA1323@ebar092.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 07:29:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuNBi-0003PB-KB
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 07:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWFYF3c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 01:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWFYF3c
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 01:29:32 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:21168 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751397AbWFYF3b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 01:29:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625052931.VCWF554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Jun 2006 01:29:31 -0400
To: "Peter Eriksen" <s022018@student.dtu.dk>
In-Reply-To: <20060624140124.GA1323@ebar092.ebar.dtu.dk> (Peter Eriksen's
	message of "Sat, 24 Jun 2006 16:01:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22590>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

> This cleans up the use of safe_strncpy() even more.  Since it has the
> same semantics as strlcpy() use this name instead.
> ---
>
> I've introduced a NO_STRLCPY variable in the Makefile.  What do
> you think about this?

No strong preference -- I can go with either name.  But people
with more BSD exposure than I am are probably used to see this
function as strlcpy(), so if that is the case let's use this
patch.

Thanks.
