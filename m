From: Junio C Hamano <junkio@cox.net>
Subject: Re: remove perl from git-commit.sh
Date: Wed, 12 Jul 2006 21:38:56 -0700
Message-ID: <7v3bd6xgnz.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0607120415g243f2160tf42c40e52b8bc9ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 06:39:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0syf-0004AX-HF
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 06:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWGMEjA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 00:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWGMEjA
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 00:39:00 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:34468 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932493AbWGMEjA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 00:39:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060713043859.LZEQ12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Jul 2006 00:38:59 -0400
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0607120415g243f2160tf42c40e52b8bc9ac@mail.gmail.com>
	(Alex Riesen's message of "Wed, 12 Jul 2006 13:15:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23809>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> It is really annoying when the essentials do not work.
> I think we could improve at  least them, by minimizing
> their dependencies to external tools.
>
> ---
>
> git-commit.sh has only ohne place where perl is used
> and it can actually quite trivially be done in sh.
> git-ls-files without "-z" produces quoted output, even if
> is different from that produced by perl code it could be
> enough. Otherwise I'd better suggest to add another
> quoting style (replacing only \t, \n and backslash) than
> having to constantly patch git-commit.sh for binmode
> or perl path (Windows has no stable tool set, and perl
> for instance often resides "somewhere").

(1) Sign-off?

(2) I think the cover letter comment talks more apporpirate
    things than your proposed commit message.  The commit log is
    not a place to vent your frustration.  It's where you
    justify why that change was needed for people who will want
    to figure out why your patch broke their workflow later.

I do not think anybody parses git-status output to figure out
the list of paths that are touched/untracked/etc., so I am not
opposed to this change itself.
