From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Tue, 26 Sep 2006 23:42:13 -0700
Message-ID: <7v64f9hku2.fsf@assigned-by-dhcp.cox.net>
References: <efc2no$eti$2@sea.gmane.org>
	<20060926213236.79160.qmail@web31815.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 08:42:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GST7f-0000An-6s
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 08:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965392AbWI0GmU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 02:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965377AbWI0GmU
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 02:42:20 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:18817 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965392AbWI0GmT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 02:42:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927064218.UQCP21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Wed, 27 Sep 2006 02:42:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TJiF1V00P1kojtg0000000
	Wed, 27 Sep 2006 02:42:16 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060926213236.79160.qmail@web31815.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Tue, 26 Sep 2006 14:32:36 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27880>

Luben Tuikov <ltuikov@yahoo.com> writes:

>> And "invisible links" _especially_ if the link is not convenience only
>> (i.e. it is not provided clearly as link somewhere else) is so called
>> "mystery meat navigation" and is one of the most common mistakes in
>> web development.
>> 
>> And is not as if "plain |" takes much space...
>
> I think you would agree that gitweb is quite different than what is
> commonly defined as "mystery meat navigation".
>
> Gitweb is very well thought out interface, and self-contained.
> There isn't much pondering about what and where to click, have newbies
> too.
>
> Think about the removal of the redundant "blob" and "tree" as database
> schema normalization if you will.
>...
> Either that or you can think of it as "shortening" the line.

Very well put.  I think this and removal of redundant "tree"
would be worthy changes -- it unclutters things.

If the only objection is that it is harder to realize that the
remaining one (the other one that did not get removed by this
redundancy elimination) is clickable, maybe that is what needs
to be fixed.
