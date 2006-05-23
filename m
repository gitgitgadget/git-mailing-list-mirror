From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make more commands builtin
Date: Tue, 23 May 2006 01:41:52 -0700
Message-ID: <7vac995e0f.fsf@assigned-by-dhcp.cox.net>
References: <35036.1277036884$1148372628@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 10:42:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiSSz-0003Nv-9j
	for gcvg-git@gmane.org; Tue, 23 May 2006 10:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWEWImJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 04:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWEWImJ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 04:42:09 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:20683 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932128AbWEWImI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 04:42:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060523084208.VFZD9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 May 2006 04:42:08 -0400
To: "Peter Eriksen" <s022018@student.dtu.dk>
In-Reply-To: <35036.1277036884$1148372628@news.gmane.org> (Peter Eriksen's
	message of "Tue, 23 May 2006 10:23:27 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20587>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

>  Makefile                               |   26 +++++++++++++++-----------
>  apply.c => builtin-apply.c             |    3 ++-
>  commit-tree.c => builtin-commit-tree.c |    3 ++-
>  diff-files.c => builtin-diff-files.c   |    3 ++-
>  diff-index.c => builtin-diff-index.c   |    3 ++-
>  diff-stages.c => builtin-diff-stages.c |    3 ++-
>  diff-tree.c => builtin-diff-tree.c     |    3 ++-
>  ls-files.c => builtin-ls-files.c       |    3 ++-
>  ls-tree.c => builtin-ls-tree.c         |    3 ++-
>  read-tree.c => builtin-read-tree.c     |    3 ++-
>  show-branch.c => builtin-show-branch.c |    3 ++-
>  tar-tree.c => builtin-tar-tree.c       |    3 ++-
>  builtin.h                              |   12 ++++++++++++
>  git.c                                  |   13 ++++++++++++-
>
> I've tried to follow the trend of making commands builtin.
> All patches have the same form.  This is my first use
> of git-send-email, so this might come out wrong.
>
> Peter Eriksen <s022018@student.dtu.dk>

Was this intentional?

	Reply-To: Patches/@bohr.gbar.dtu.dk
	Reply-To: Patches/0001-Builtin-git-ls-files.txt@bohr.gbar.dtu.dk

Otherwise the form looks OK, except that with this particular
series, I would have much preferred to see these with
"format-patch -M"; it is really hard to review otherwise.

BTW, I already have tar-tree built-in in "next" branch.

I'll go to bed now, so please expect review Ack/Nack until
evening my time (it is 01:40 here) from me.
