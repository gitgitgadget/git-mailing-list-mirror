From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/6] gitopt: a new command-line option parser for git
Date: Tue, 09 May 2006 13:35:01 -0700
Message-ID: <7vlktb2ayy.fsf@assigned-by-dhcp.cox.net>
References: <1147151209168-git-send-email-normalperson@yhbt.net>
	<11471512103526-git-send-email-normalperson@yhbt.net>
	<20060509120809.4d9494b9.tihirvon@gmail.com>
	<20060509191803.GA3676@localdomain>
	<20060509231031.b62576da.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 09 22:35:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdYvD-0000LT-PD
	for gcvg-git@gmane.org; Tue, 09 May 2006 22:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWEIUfE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 16:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWEIUfE
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 16:35:04 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:2765 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751132AbWEIUfD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 16:35:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509203503.XQJQ17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 May 2006 16:35:03 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060509231031.b62576da.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Tue, 9 May 2006 23:10:31 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19849>

Timo Hirvonen <tihirvon@gmail.com> writes:

> I think optional arguments are still confusing.  We could support both
> -C (no args) and -C=20 syntax.

Actually, optional numeric arguments are the norm not exception.
Think of "diff -u" vs "diff -u20" for example.  Also I think it
is conventional not to use = for single-letter single-dash
options, so -C (no args -- use the default number of the
implementation whatever it is) and -C20 (the same behaviour in
principle as -C, but use my number instead of the default) are
sane, while -C=20 _is_ odd.

Having said that, I think abbreviating -u20 -n -r to -u20nr
going too far (-nru20 would be palatable perhaps), even if the
implementation allows such, unless you are entering "obfusucated
command line parameters" contest.
