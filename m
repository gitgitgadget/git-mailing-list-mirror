From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: tree view: hash_base and hash are now context sensitive
Date: Tue, 26 Sep 2006 23:48:42 -0700
Message-ID: <7v1wpxhkj9.fsf@assigned-by-dhcp.cox.net>
References: <efc2t8$eti$3@sea.gmane.org>
	<20060926211720.21355.qmail@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ltuikov@yahoo.com
X-From: git-owner@vger.kernel.org Wed Sep 27 08:48:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSTDs-0001IF-7C
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 08:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965393AbWI0Gso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 02:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965394AbWI0Gso
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 02:48:44 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:53633 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S965393AbWI0Gso (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 02:48:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927064843.SMJC6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Wed, 27 Sep 2006 02:48:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TJog1V0021kojtg0000000
	Wed, 27 Sep 2006 02:48:40 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <20060926211720.21355.qmail@web31808.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Tue, 26 Sep 2006 14:17:20 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27881>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Jakub Narebski <jnareb@gmail.com> wrote:
>> I think that this need some thinking over. For blob we have two
>> "base" objects: tree which have specified blob, and commit which
>> have tree which have specified blob. We might want to specify
>> that all hash*base are to the commit-ish.
>
> Agreed, we should always refer to the commit-ish, for obvious
> reasons.
>
> This patch doesn't make this decision though.  It simply
> sets hash_base to HEAD if not defined.
>
> Now, since "git-ls-tree" works on both commit-ish and
> tree-ish, we are ok.

I think so, too.  Jakub?
