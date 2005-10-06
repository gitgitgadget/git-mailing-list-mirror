From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix usage of carets in git-rev-parse(1)
Date: Wed, 05 Oct 2005 17:06:22 -0700
Message-ID: <7vd5mjcxvl.fsf@assigned-by-dhcp.cox.net>
References: <200510052350.07217.alan@chandlerfamily.org.uk>
	<7v7jcrh7wu.fsf@assigned-by-dhcp.cox.net>
	<20051005234222.GA19292@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 02:08:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENJHi-0001Vg-Qd
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 02:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbVJFAGp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 20:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbVJFAGp
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 20:06:45 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:6585 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030454AbVJFAGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 20:06:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051006000618.YHVQ16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Oct 2005 20:06:18 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20051005234222.GA19292@diku.dk> (Jonas Fonseca's message of
	"Thu, 6 Oct 2005 01:42:23 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9752>

Jonas Fonseca <fonseca@diku.dk> writes:

> ... but using a {caret} attribute.
>
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

Thanks.  This seems to fix it.  Applied and pushed out (but not
in time for just released 0.99.8b).
