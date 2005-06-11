From: Junio C Hamano <junkio@cox.net>
Subject: Re: do people use the 'git' command?
Date: Sat, 11 Jun 2005 00:02:20 -0700
Message-ID: <7vpsutz88z.fsf@assigned-by-dhcp.cox.net>
References: <E1DgodI-0003ov-Fl@highlab.com>
	<7vy89h4m9r.fsf@assigned-by-dhcp.cox.net>
	<E1DgyW0-0004PE-Ct@highlab.com>
	<2cfc403205061023346c03a25b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Kuzminsky <seb@highlab.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 08:58:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgzwY-00065J-UC
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 08:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVFKHC1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 03:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVFKHC1
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 03:02:27 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:19624 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261620AbVFKHCW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 03:02:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050611070222.LEM23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Jun 2005 03:02:22 -0400
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc403205061023346c03a25b@mail.gmail.com> (Jon Seymour's
 message of "Sat, 11 Jun 2005 16:34:36 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JS" == Jon Seymour <jon.seymour@gmail.com> writes:

JS> Sebastian,
JS> What is the justification for removing it?

JS> As it stands, git serves a useful function in that it provides a
JS> single point through which access to all git-*-scripts is channeled,
JS> yet still allows each script to be maintained as a separate entity,
JS> coherent entity.

If I understand him correctly, Sebastian's point was that it
channels only to git-*-scripts without channelling to any of the
git-* binaries.

But the real point of "git" wrapper is merely to present CVS and
SVN refugees the structure they are familiar with: a single
command having a set of subcommands.

It is just an "introductory" thing and there is no compelling
reason to expose the low level core GIT commands.  When the
refugees are comfortable with how GIT does things, they will
either use Porcelain and not touch the Plumbing, or they will
learn to use git-* commands themselves.  In the former case, not
having access to core GIT commands through "git" wrapper is not
an issue.  In the latter case, they will learn to type
git-*-script in no time, and at that point "git" wrapper will be
just a short-hand; again not having access to core GIT commands
through "git" wrapper is not an issue either.

Personally I think removal of "git" script is a bad idea.

