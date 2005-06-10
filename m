From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 3/6] Make showdate use "Linus format"
Date: Sat, 11 Jun 2005 00:59:38 +0200
Message-ID: <20050610225938.GE22111@pasky.ji.cz>
References: <42A825C2.1060302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 00:56:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgsPn-00074U-Mb
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 00:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVFJW76 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 18:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVFJW76
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 18:59:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44190 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261319AbVFJW7l (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 18:59:41 -0400
Received: (qmail 983 invoked by uid 2001); 10 Jun 2005 22:59:38 -0000
To: Dan Holmsand <holmsand@gmail.com>
Content-Disposition: inline
In-Reply-To: <42A825C2.1060302@gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thanks, applied.

Dear diary, on Thu, Jun 09, 2005 at 01:19:30PM CEST, I got a letter
where Dan Holmsand <holmsand@gmail.com> told me that...
> This makes showdate use the same date format as
> git-rev-list --pretty, and gives some speedup. It might also
> be more portable.

I dropped the format change bit, because I really think the Linus' date
format is bad. The current standardized, international and most widely
used (even your mailer agent used it in your Date: header) date format
is RFC 822, so please let's stick with it. It's perfect for our use, and
better human-readable too. The date part isn't split all around but
concentrated in the first half while the second half is dedicated to
time.

> Note that this changes the calling convention: the previous
> version used seconds from $1, but timezone from the global
> variable $date. cg-mkpatch is modified to the new way.

You forgot to modify cg-log accordingly. (I fixed that.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
