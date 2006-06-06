From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Cleanup git-send-email.perl:extract_valid_email
Date: Tue, 06 Jun 2006 14:39:06 -0700
Message-ID: <7vlksanev9.fsf@assigned-by-dhcp.cox.net>
References: <junkio@cox.net>
	<200606062124.k56LOroI007738@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 23:39:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnjGc-0003fX-N3
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 23:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWFFVjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 17:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWFFVjL
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 17:39:11 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:49544 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750956AbWFFVjK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 17:39:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606213908.IBRC27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 17:39:08 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200606062124.k56LOroI007738@laptop11.inf.utfsm.cl> (Horst von
	Brand's message of "Tue, 06 Jun 2006 17:24:53 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21405>

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

>> > OK, but be careful as this (?:...) is an extended regexp (needs /x on
>> > match).
>
>> Are you sure about /x?
>
> The manual (perlop(1)) says you need /x to match extended regexps, and
> (?...) is the marker for such (perlre(1)).

I always had the impression that eXtended in the context to talk
about /x was about ignoring whitespaces and forcing people to
write \s (or perhaps \040) when they mean a whitespace and had
nothing to do with (?...) stuff.  Let me look up the fine
manual.
