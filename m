From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-feed-mail-list.sh
Date: Mon, 08 May 2006 19:41:31 -0700
Message-ID: <7vwtcvc42s.fsf@assigned-by-dhcp.cox.net>
References: <1146678513.20773.45.camel@pmac.infradead.org>
	<7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
	<1147131877.2694.37.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
	<4fb292fa0605081755m22e8239cjda0b1ac74b84c0d9@mail.gmail.com>
	<7vac9sc8m3.fsf@assigned-by-dhcp.cox.net>
	<4fb292fa0605081809r6aa76baai5eac9823183fc3fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 04:41:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdIAO-0000KZ-4w
	for gcvg-git@gmane.org; Tue, 09 May 2006 04:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWEICle (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 22:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWEICle
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 22:41:34 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:38122 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751349AbWEICld (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 22:41:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509024132.ICNU18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 May 2006 22:41:32 -0400
To: "Bertrand Jacquin" <beber.mailing@gmail.com>
In-Reply-To: <4fb292fa0605081809r6aa76baai5eac9823183fc3fc@mail.gmail.com>
	(Bertrand Jacquin's message of "Tue, 9 May 2006 03:09:36 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19809>

"Bertrand Jacquin" <beber.mailing@gmail.com> writes:

> But I would like to send an email after merge to inform people that:
>
> o tree ``a'' and ``b'' have been merged.
> o made by John Doe at a time
> o show a diffstat.
> o show a --short-log=oneline from merge base.

Forgetting about a fast-forward merge,  (1) and (2) are
available in the commit header and the commit log, so is (4) if
you enable merge.summary configuration like Linus does in his
kernel repository.

The comment on diffstat Linus already made applies to (3), but
if you want you could do "git diff --stat HEAD^..HEAD" to see
what happened to that branch by merging the other branch into
it.
